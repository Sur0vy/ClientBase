{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit RecordEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SqlTools,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomDlg, DlgExecute, RegSmartDlg, Vcl.ActnList, Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, Vcl.ComCtrls, Vcl.ToolWin, GridDlg, FIB,
  DlgParams, Vcl.ExtCtrls, ConstList, DB, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, pFIBStoredProc, AddActions,
  pFIBDataSet, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TOnAddStoredParam = procedure( Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc ) of object;
  TOnAfterExecuteProc = procedure( Sender: TObject; DlgType: TStateDlg; ResultID: Integer; SP: TpFIBStoredProc; var NoClose: Boolean ) of object;
  TOnSmartDlgSetEditText = procedure (Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean) of object;
  TOnCheckIsSelfRecord = function( Sender: TObject; DS: TpFIBDataSet ): Boolean of Object;
  TOnSaveResultExecute = procedure( Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc ) of object;

  TOnEditDialogEvent = record
    OnAddStoredParam: TOnAddStoredParam;
    OnAfterFillRow: TOnAfterFillRow;
    OnCheckIsSelf: TOnCheckIsSelfRecord;
    OnSmartDlgSetEditText: TOnSmartDlgSetEditText;
    OnFillAddDialogMenu: TOnFillAddDialogMenu;
    OnAddActionExecute: TOnAddActionExecute;
    OnAddAction_1Execute: TOnAddActionExecute;
    OnGetLookupFieldValue: TOnGetLookupFieldValue;
    ExecActionAfterThis: TAction;
    OnSaveResult: TOnSaveResultExecute;
  end;

  TfrRecordEdit = class(TfrCustomDlg)
    SpEdit: TpFIBStoredProc;
    IBTrWrite: TpFIBTransaction;
    procedure A_SaveExecute(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
    procedure FormShow(Sender: TObject);
    function  NewDataCacheInsert(DS: TpFIBDataSet; var IndList: TArrayInteger; var ValueList: TArrayVariant): Boolean;
    function CheckUpdateOtherUser(out Ind: Integer): Boolean;
    procedure SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
    function dlgFillRowsGetLookupFieldValue(Sender: TObject; DialogID: Integer; const FieldName: string; var ResValue: Variant): Boolean;
  private
    { Private declarations }
    function IsNotAction: Boolean;
    function SetLockRecord(Value: Integer): Boolean;

    procedure SetActionType(SP: TpFIBStoredProc);
    procedure SetStoredProcParams( var IsMultySelect, NoClose: Boolean );
    procedure MultiSelectListForSave;
    procedure SaveAddFieldMultySelect(HostFieldName, LinkFieldName, CheckList, LinkTable, FieldOrderBy,
      AddField: String; HostIDValue, AddFieldValue: Integer);
    procedure SetSpravMenu(const SpravLink: String);
    procedure ShowSpravForm(Sender: TObject);
  public
    { Public declarations }
    ResultID: Integer;
    IsRepeat: Boolean;  // Не проверять при редактировании наличие изменений в диалоге
    MessCaption: String;
    HostBarCode: String;
    OnAddStoredParam: TOnAddStoredParam;
    OnAfterExecuteProc: TOnAfterExecuteProc;
    OnSmartDlgSetEditText: TOnSmartDlgSetEditText;
    OnGetLookupFieldValue: TOnGetLookupFieldValue;
    OnSaveResult: TOnSaveResultExecute;
    procedure FillDialogMenu; override;
  end;

const
  EditDldEventIsNil: TOnEditDialogEvent = (
    OnAddStoredParam: nil;
    OnAfterFillRow: nil;
    OnCheckIsSelf: nil;
    OnSmartDlgSetEditText: nil;
    OnFillAddDialogMenu: nil;
    OnAddActionExecute: nil;
    OnAddAction_1Execute: nil;
    OnGetLookupFieldValue: nil;
    ExecActionAfterThis: nil;
    OnSaveResult: nil );


implementation

uses
  Tools, Math, Procs, IB_ErrorCodes, ClientDM, System.TypInfo, Prima, CustomSprav, MailTemplate, SpravFileImages,
  GroupSuscribeSprav;

{$R *.dfm}



procedure TFrRecordEdit.SetActionType(SP: TpFIBStoredProc);
const
TypeName: array [ TStateDlg ] of String =
  ( '', 'UPD', 'INS', 'DEL', 'INS' );
//  sdNo, sdEdit, sdInsert, sdDelete, sdCopy
var
KeyName: String;
begin
  KeyName := dlgFillRows.HeaderDlg.PrimaryKeyName;

  if Assigned( SP.FindParam( KeyName )) then
    SP.ParamByName( KeyName ).AsInteger :=
      IfThen( dlgFillRows.ActionType = sdInsert, -1, dlgFillRows.PrimaryKeyValue );
  SP.ParamByName( 'ACTION_TYPE' ).AsString := TypeName[ dlgFillRows.ActionType ];
end;

function TfrRecordEdit.SetLockRecord( Value: Integer ): Boolean;
const
sqlLock = 'SELECT %S FROM %S WHERE %S = %D WITH LOCK';
var
Query: TNewQuery;
begin
  Result := True;
  if not SpEdit.Transaction.InTransaction then
    SpEdit.Transaction.StartTransaction;
  Query := TNewQuery.CreateNew( Self, SpEdit.Transaction );
  try
    Query.SQL.Text :=
      Format( sqlLock,
        [ dlgFillRows.HeaderDlg.PrimaryKeyName, dlgFillRows.HeaderDlg.HostTableName, dlgFillRows.HeaderDlg.PrimaryKeyName,
          Value ]);
    try
      try
        Query.ExecQuery;
      except
        on E: Exception do begin
          case EFIBError( E ).IBErrorCode of
            isc_lock_conflict:
              raise exception.Create( 'Данные редактируются другим пользователем.' );
            else
              raise;
          end;
        end;
      end;
    except
      on E: Exception do begin
        Result := False;
        raise;
      end;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

function TfrRecordEdit.CheckUpdateOtherUser( out Ind: Integer ): Boolean;
var
Query: TNewQuery;
N: Integer;
Prop: TPropertyItem;
CurrOldValue, CurrValue, StrValue, CheckListID: String;

  function FieldToObInspString( Value: TFIBXSQLVAR; Scale: Smallint ): String;
  begin
    If Value.IsNull then
      Result := ''
    else
      Result := FloatToStrF( Value.AsDouble, ffNumber, 18, Scale );
  end;

  procedure FillStrValue( Style: TPropertyStyle );
  begin
    CheckListID := '';
    StrValue := '';

    Case Style of
      psMultySelect: begin;
        GetMultySelectParams( Prop, dlgFillRows.PrimaryKeyValue, StrValue, CheckListID );
      end;
      psNumeric:
        StrValue :=
          FieldToObInspString( Query.FieldByName( Prop.FieldName ), Prop.NumericScale );
      psInteger:
        StrValue :=
          FieldToObInspString( Query.FieldByName( Prop.FieldName ), 0 );
      psBoolean:
        Case Query.FieldByName( Prop.FieldName ).IsNull of
          True:
            StrValue := '';
          False:
            StrValue :=
              BoolTitle[ Query.FieldByName( Prop.FieldName ).AsInteger ];
        end;
      psComboBox:
        Case Query.FieldByName( Prop.FieldName ).IsNull of
          True:
            StrValue := '';
          False:
            StrValue :=
              GetComboBoxValue( Prop.SQL.SqlText, Query.FieldByName( Prop.FieldName ).AsInteger );
        end;
      else
        StrValue := Query.FieldByName( Prop.FieldName ).AsString;
    end;
  end;

begin
  Result := False;
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := dlgFillRows.HeaderDlg.FillSqlText;
    try
      Query.ExecQuery;
    except
      Raise;
    end;
    If not Query.Open then begin
       Result := False;
       Exit;
    end;

    for N := 0 to SmartDlg.RowsList.Count - 1 do begin
      Prop := SmartDlg.RowsList.Items[ N ];
      if not Prop.Visible then
        Continue;

      If ( Prop.FieldName = '' ) or
         ( Prop.Style in [ psHeader, psReadOnlyText ]) then
        Continue;

      case Prop.Style of
        psPickList: begin
          If not Assigned( Query.FindField( Prop.SQL.KeyID )) then
            Continue;
          If not Assigned( Query.FindField( Prop.FieldName )) then
            Continue;
          If not Assigned( SpEdit.FindParam( Prop.SQL.KeyID )) then
            Continue;
        end;
        else begin
          If not Assigned( Query.FindField( Prop.FieldName )) then
            Continue;
          If not Assigned( SpEdit.FindParam( Prop.FieldName )) then
            Continue;
        end;
      end;

      FillStrValue( Prop.Style );
      CurrOldValue := Prop.OldValue;
      CurrValue := Prop.RowValue;

      If ( Prop.OldValue <> StrValue ) then begin
        If ( Prop.OldValue <> Prop.RowValue ) then begin
          If SpEdit.Transaction.InTransaction then
            SpEdit.Transaction.Commit;
          MessageBox( Application.Handle,
               PChar( 'Значение поля "' + Prop.Title + '" изменено другим пользователем на "' +
                      StrValue + '".'),
               PChar( 'Совместный доступ' ),
               MB_OK or MB_DEFBUTTON1 or  MB_ICONINFORMATION);

          case Prop.Style of
            psSimpleText, psMemoText:
              Prop.RowValue := StrValue + #13 + CurrValue;
            psMultySelect: begin
              Prop.RowValue := StrValue;
              Prop.CheckListID := CheckListID;
            end;
            psPickList: begin
              If ( Prop.SQL.KeyID <> '' ) and
                 ( Assigned( Query.FindField( Prop.SQL.KeyID ))) then
                Prop.RowValueID := Query.FieldByName( Prop.SQL.KeyID ).AsInteger;
              Prop.RowValue := StrValue;
            end;
            psFileOpen: begin
              // IsEmpty
            end;
            else
              Prop.RowValue := StrValue;
          end;
          Prop.OldValue := StrValue;

          Ind := N;
          Result := True;
          Screen.Cursor := crDefault;
          Break;
        end  // Prop.OldValue <> StrValue
        else begin
          Prop.RowValue := StrValue;
          Prop.OldValue := StrValue;
          If ( Prop.SQL.KeyID <> '' ) and
             ( Assigned( Query.FindField( Prop.SQL.KeyID ))) then
             Prop.RowValueID := Query.FieldByName( Prop.SQL.KeyID ).AsInteger;
        end;
      end;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

function TfrRecordEdit.dlgFillRowsGetLookupFieldValue(Sender: TObject; DialogID: Integer; const FieldName: string;
  var ResValue: Variant): Boolean;
begin
  Result := False;
  if Assigned( OnGetLookupFieldValue ) then
    Result := OnGetLookupFieldValue( Sender, DialogID, FieldName, ResValue );
end;

procedure TFrRecordEdit.SetStoredProcParams( var IsMultySelect, NoClose: Boolean );
var
N: Integer;
Prop: TPropertyItem;
begin
  For N := 0 to SmartDlg.RowsList.Count - 1 do begin
    Prop := SmartDlg.RowsList.Items[ N ];
    If ( Prop.FieldName = '' ) or
       ( Prop.Style = psHeader ) or
       ( not Prop.Visible ) or
       ( Prop.Style = psReadOnlyText )  then
      Continue;

    If Prop.Style in [ psPickList ] then begin
      If not Assigned( SpEdit.FindParam( Prop.SQL.KeyID )) then
        Continue;
    end
    else
    If Prop.Style in [ psDialog ] then begin
      If not ( Assigned( SpEdit.FindParam( Prop.SQL.KeyID )) or
               Assigned( SpEdit.FindParam( Prop.FieldName ))) then
        Continue;
    end
    else
    If not ( Assigned( SpEdit.FindParam( Prop.FieldName )) or
             Assigned( SpEdit.FindField( Prop.FieldName )) ) then
      Continue;

    Prop.RowValue := Trim( Prop.RowValue );

    try
      Case Prop.Style of
        psPickList: begin
          If ( Prop.RowValueID <> -1 ) and ( Prop.RowValue <> '' ) then
            SpEdit.ParamByName( Prop.SQL.KeyID ).AsInteger := Prop.RowValueID
          else
            SpEdit.ParamByName( Prop.SQL.KeyID ).Clear;
        end;
        psDialog: begin
          if Prop.SQL.KeyID <> '' then begin
            If ( Prop.RowValueID <> -1 ) and ( Prop.RowValue <> '' ) then
              SpEdit.ParamByName( Prop.SQL.KeyID ).AsInteger := Prop.RowValueID
            else
              SpEdit.ParamByName( Prop.SQL.KeyID ).Clear;
          end
          else begin
            If ( Prop.RowValue <> '' ) then
              SpEdit.ParamByName( Prop.FieldName ).AsString := Prop.RowValue
            else
              SpEdit.ParamByName( Prop.FieldName ).Clear;
          end;
        end;
        psMultySelect:
          IsMultySelect := True;
        psFileOpen: begin
          If Prop.RowValue <> '' then
            NoClose := SaveFileToBlob( Prop.RowValue, Prop.FieldName, TpFIBStoredProc( SpEdit ), Prop.NumericScale )
          else
            SpEdit.ParamByName( Prop.FieldName ).Clear;
        end;

        psDateValue:
          If Prop.RowValue = '' then
            SpEdit.ParamByName( Prop.FieldName ).Clear
          else begin
            If StrToDateTime( Prop.RowValue ) < StrToDateTime( '01.01.1900' ) then
              raise Exception.Create( 'Слишком маленькое значение даты!!!' )
            else
              SpEdit.ParamByName( Prop.FieldName ).AsDateTime := StrToDateTime( Prop.RowValue );
          end;

        psComboBox:
          If Prop.RowValue = '' then
            SpEdit.ParamByName( Prop.FieldName ).Clear
          else
            SpEdit.ParamByName( Prop.FieldName ).AsInteger :=
                                    GetComboBoxIndex( Prop.SQL.SqlText, Prop.RowValue );
        psNumeric:
          If Prop.RowValue = '' then
            SpEdit.ParamByName( Prop.FieldName ).Clear
          else
            SpEdit.ParamByName( Prop.FieldName ).AsDouble :=
                                         StrToFloat( StrSeparatorDelete( Prop.RowValue ));

        psInteger:
          If Prop.RowValue = '' then
            SpEdit.ParamByName( Prop.FieldName ).Clear
          else
            SpEdit.ParamByName( Prop.FieldName ).AsInteger :=
                                         StrToIntDef( StrSeparatorDelete( Prop.RowValue ), 0);

        psBoolean:
          Case Prop.RowValueID of
            -1: SpEdit.ParamByName( Prop.FieldName ).Clear
            else
                SpEdit.ParamByName( Prop.FieldName ).AsInteger := Prop.RowValueID;
          end;
        psColor:
          If Prop.RowValue = '' then
            SpEdit.ParamByName( Prop.FieldName ).AsInteger := 0
          else
            SpEdit.ParamByName( Prop.FieldName ).AsInteger := StringToColor( Prop.RowValue );
        else
          If Prop.RowValue = '' then
            SpEdit.ParamByName( Prop.FieldName ).Clear
          else
            SpEdit.ParamByName( Prop.FieldName ).AsString := Prop.RowValue;
      end;
    except
      on E: Exception do begin
        NoClose := True;
        Raise;
      end;
    end;
    if NoClose then
      Exit;
  end;
  NoClose := False;
end;

procedure TfrRecordEdit.SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
begin
  inherited;
  if Assigned( OnSmartDlgSetEditText ) then
    OnSmartDlgSetEditText( Dlg, CurrItem, IsChange );
end;

procedure TFrRecordEdit.MultiSelectListForSave;
var
N, MultySelResult: Integer;
Prop: TPropertyItem;
begin
  for N := 0 to SmartDlg.RowsList.Count - 1 do begin
    Prop := SmartDlg.RowsList.Items[ N ];
    if not ( Prop.Style in [ psMultySelect ]) then
      Continue;
    try
      if Prop.NumericScale = 0 then
        MultySelResult := ResultID
      else
        MultySelResult := SpEdit.Fields[ Prop.NumericScale ].AsInteger;

      SaveAddFieldMultySelect( Prop.FieldName, Prop.SQL.KeyID, Prop.CheckListID,
                               Prop.SQL.CheckLinkTable, Prop.SQL.FieldOrderBy, '',
                               MultySelResult, -1 );
    except
      on E: Exception do
      begin
        ShowMessage('Ошибка записи по полю "' + Prop.SQL.KeyID + '"' + ''#13''#10'' + E.Message);
        Continue;
      end;
    end;
  end;
end;

procedure TFrRecordEdit.SaveAddFieldMultySelect(HostFieldName, LinkFieldName, CheckList, LinkTable, FieldOrderBy, AddField: String; HostIDValue, AddFieldValue: Integer);
var
Query: TNewQuery;
N, Old_N, L, Order_By: Integer;
StrID: String;
IsSorting: Boolean;

  function GetDeleteSQL: String;
  const
  sqlDelete = 'DELETE FROM %S where %S';
  var
  StrValue: String;
  begin
    try
      StrValue := Format( HostFieldName + ' = %D ', [ HostIDValue ]);

      If CheckList <> '' then
        StrValue := StrValue + Format( ' and (' + LinkFieldName + ' not in ( %S ))', [ CheckList ]);

    finally
      Result := Format( sqlDelete, [ LinkTable, StrValue ]);
    end;
  end;

  function GetInsertSQL: String;
  const
  sqlInsert = 'update or insert into %S ( %S ) values ( %S ) MATCHING ( %S )';
  var
  FieldList, ParamList, PK: String;
  begin
    try
      FieldList := HostFieldName + ',' + LinkFieldName;
      ParamList := Format( '%D, %S ', [ HostIDValue, ':LINK_ID' ]);

      if AddField <> '' then begin
        FieldList := FieldList + ',' + AddField;
        ParamList := ParamList + ', ' + IntToStr( AddFieldvalue );
      end;

      if IsSorting then begin
        FieldList := FieldList + ',' + FieldOrderBy;
        ParamList := ParamList + ', :ORDER_BY';
      end;

      PK := GetConstrFieldList( LinkTable, 'PRIMARY KEY' );
      if PosCase( HostFieldName, PK, True ) = 0 then
        PK := GetConstrFieldList( LinkTable, 'UNIQUE' );
    finally
      Result := Format( sqlInsert, [ LinkTable, FieldList, ParamList, PK ]);
    end;
  end;

begin
	If not Self.SpEdit.Transaction.InTransaction then
		Exit;

	Order_By := 1;
	IsSorting := FieldOrderBy <> '';

  Query := TNewQuery.CreateNew( Self,  SpEdit.Transaction );
  try
    Query.SQL.Text := GetDeleteSQL;
    try
      Query.ExecQuery;
    except
      Raise;
    end;
    Query.Close;
    Query.SQL.Clear;

    Query.SQL.Text := GetInsertSQL;

    L := Length( CheckList );
    Old_N := 1;
    For N := 1 to L do begin
      If ( CheckList[ N ] = ',' ) or ( N = L ) then begin
        Case N = L of
          False:  StrID := Copy( CheckList, Old_N, N - Old_N );
          True :  StrID := Copy( CheckList, Old_N, L - Old_N + 1 );
        end;
        StrID := Trim( StrID );

				try
          Query.Close;
					Query.ParamByName( 'LINK_ID' ).AsInteger := StrToInt( StrID );
          If IsSorting then
					  Query.ParamByName( 'ORDER_BY' ).AsInteger := Order_By;

          Query.ExecQuery;

          Inc( Order_By );
				except
					Raise;
				end;
        Old_N := N + 1;
      end;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrRecordEdit.SetSpravMenu( const SpravLink: String );
const
sqlLink =
'select' + #13#10 +
'  DIALOG_ID, DIALOG_CAPTION, RIGHT_VALUE' + #13#10 +
'from GET_SPRAV_LIST( -1, :USER_LIST_ID )' + #13#10 +
'where' + #13#10 +
'  DIALOG_ID in ( %S )' + #13#10 +
'order by' + #13#10 +
'  DIALOG_CAPTION';

var
Query: TNewQuery;
ItemList: array of TAction;
L: Integer;
begin
  A_Between.ClearAndFree;
  If SpravLink = '' then
    Exit;

  L := 0;
  SetLength( ItemList, L );

  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text :=
                Format( sqlLink, [ SpravLink ] );
    Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
    try
      Query.ExecQuery;
    except
      Raise;
    end;
    While not Query.Eof do begin
      Inc( L );
      Setlength( ItemList, L );
      ItemList[ L - 1 ] := TAction.Create( Self );
      ItemList[ L - 1 ].Caption := Query.FieldByName( 'DIALOG_CAPTION' ).AsString;
      ItemList[ L - 1 ].Name :=
         'RV' + Query.FieldByName( 'DIALOG_ID' ).AsString + '__' +
               Query.FieldByName( 'RIGHT_VALUE' ).AsString;
      ItemList[ L - 1 ].Tag := Query.FieldByName( 'DIALOG_ID' ).AsInteger;

      ItemList[ L - 1 ].OnExecute := ShowSpravForm;

      Query.Next;
    end;
  finally
    Query.Close;
    Query.FreeAndCommit;
    A_Between.SetMenuArray( ItemList );
    A_Between.Visible := Length( ItemList ) > 0;
    A_Between.Enabled := Length( ItemList ) > 0;
  end;
end;

procedure TfrRecordEdit.ShowSpravForm( Sender: TObject );
var
Act: TAction;
RightValue, N: Integer;
begin
  Act := TAction( Sender );
  N := Pos( '__', Act.Name );
  if N = 0 then
    Exit;

  RightValue := StrToIntDef( Copy( Act.Name, N + 2, 10 ), 0 );

  case Act.Tag of
    sprMailTemplate:
      TfrMailTemplate.ShowSprav( Act.Caption, Act.Tag, RightValue, False );
    sprFileImages:
      TfrSpravFileImages.ShowSprav( Act.Caption, Act.Tag, RightValue, False );
    sprGroupSubscribe:
      TfrGroupSuscribeSprav.ShowSprav( Act.Caption, Act.Tag, RightValue, False );
    else
      TfrCustomSprav.ShowSprav( Act.Caption, Act.Tag, RightValue, False );
  end;
end;

procedure TfrRecordEdit.A_SaveExecute(Sender: TObject);
  procedure OtherUserVerify( var NoClose: Boolean );
//  var
//  Ind: Integer;
  begin
    Case dlgFillRows.ActionType of
      sdEdit: begin
        If ( dlgFillRows.HeaderDlg.HostTableName <> '' ) and
           ( not SetLockRecord( dlgFillRows.PrimaryKeyValue )) then
          Exit;

//        If CheckUpdateOtherUser( Ind ) then begin
//          if Ind <> -1 then begin
//            if SmartDlg.TabSet.Tabs.Count > 0 then begin
//              SmartDlg.TabSet.TabIndex :=
//                SmartDlg.TabSet.Tabs.IndexOfObject( TObject( SmartDlg.RowsList.Items[ Ind ].SheetID ));
//              SmartDlg.SetRowSelected( SmartDlg.RowsList.Items[ Ind ].FieldName );
//            end;
//            NoClose := True;
//
//          end;
//        end;
			end;
    end;
  end;

var
NoClose, IsMultySelect: Boolean;
begin
  if not ( A_Save.Enabled and A_Save.Visible ) then
    Exit;

	If ( MessCaption <> '' ) and
     ( MessageBox(Handle, PChar( MessCaption  ), PChar( Caption ),
       MB_YESNO or 4096 or MB_DEFBUTTON2 or  MB_ICONQUESTION) = IDNO ) then
    Exit;

  inherited;
  SmartDlg.UpdateEditText;
  IsMultySelect := False;
  try
    Screen.Cursor := crSQLWait;

    NoClose := not IsNotAction;
    If NoClose then begin
      NoClose := False;
      Self.Close;
      Exit;
    end;
    NoClose := CheckIsNoEmpty;
    If NoClose then
      Exit;

    If not SpEdit.Transaction.InTransaction then
      SpEdit.Transaction.StartTransaction;

    SpEdit.StoredProcName := dlgFillRows.HeaderDlg.ExecName;
    If ( not SpEdit.Prepared ) and
       ( SpEdit.StoredProcName <> '' ) then
      SpEdit.Prepare;

    OtherUserVerify( NoClose );
    If NoClose then
      Exit;

    SetActionType( SpEdit );

    SetStoredProcParams( IsMultySelect, NoClose );
    If NoClose then
      Exit;

    try
      If Assigned( @OnAddStoredParam ) then
        OnAddStoredParam( Self, dlgFillRows.ActionType, SpEdit );
    except
      on E: Exception do begin
        NoClose := True;
        If SpEdit.Transaction.InTransaction then
          SpEdit.Transaction.Rollback;
        raise Exception.Create( E.Message );
      end;
    end;
    If NoClose then
      Exit;

    try
      SpEdit.ExecProc;
      ResultID := -1;
      If SpEdit.FieldCount > 0 then
        ResultID := SpEdit.Fields[ 0 ].AsInteger;

      If IsMultySelect then
        MultiSelectListForSave;
      if Assigned( OnSaveResult ) then
        OnSaveResult( Self, dlgFillRows.ActionType, SpEdit );
    except
      on E: EFibError do begin
        If SpEdit.Transaction.InTransaction then
          SpEdit.Transaction.Rollback;
        NoClose := True;
        raise;
      end;
    end;

    try
			If Assigned( @OnAfterExecuteProc ) then
				OnAfterExecuteProc( Self, dlgFillRows.ActionType, ResultID, SpEdit, NoClose );
		except
      on E: Exception do begin
        NoClose := True;
        If SpEdit.Transaction.InTransaction then
          SpEdit.Transaction.Rollback;
        raise Exception.Create( E.Message );
      end;
		end;
	finally
		Screen.Cursor := crDefault;

    If SpEdit.Transaction.InTransaction then
      case NoClose of
        True: SpEdit.Transaction.Rollback;
        else  SpEdit.Transaction.Commit;
      end;

    case NoClose of
      True: begin
        Self.ModalResult := mrNone;
        SetButtonActive( True, False );
        TmSave.Enabled := True;
      end
      else
        Self.ModalResult := mrOK;
    end;

    Application.ProcessMessages;
  end;
end;

procedure TfrRecordEdit.FillDialogMenu;
begin
  inherited;
  With frPrima do
    AddActListInBar( aTbSmartDLG, A_SetBetween, [ A_Between ]);

end;

procedure TfrRecordEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SmartDlg.UpdateEditText;

	If A_Save.Visible and
     ( Self.ModalResult <> mrOK ) and
     IsNotAction then begin
    If ( MessageBox(Handle, 'Данные были изменены.' + #13#10 + 'Сохранить изменения?',
         PChar( Caption ),
         MB_YESNO or 4096 or MB_DEFBUTTON1 or  MB_ICONQUESTION) = IDYES ) then
       A_SaveExecute( Self );
  end;

  inherited;
end;

procedure TfrRecordEdit.FormCreate(Sender: TObject);
begin
  inherited;
  MessCaption := '';
  HostBarCode := '';
  ResultID := -1;
end;

procedure TfrRecordEdit.FormShow(Sender: TObject);
begin
  SetSpravMenu( dlgFillRows.HeaderDlg.SpravLink );
  inherited;
end;

function TFrRecordEdit.IsNotAction: Boolean;
var
N: Integer;
begin
  Result := True;
  If IsRepeat or
    ( dlgFillRows.ActionType <> sdEdit ) then
    Exit;

  Result := False;
  For N := 0 to SmartDlg.RowsList.Count - 1 do begin
    try
      Result := ( SmartDlg.RowsList.Items[ N ].RowValue <> SmartDlg.RowsList.Items[ N ].OldValue );
    except
      Result := False;
    end;
    If Result then
      Exit;
  end;
end;

function TFrRecordEdit.NewDataCacheInsert( DS: TpFIBDataSet; var IndList: TArrayInteger; var ValueList: TArrayVariant ): Boolean;
const
sqlPrKeyList =
'select ' + #13#10 +
'  S.RDB$FIELD_NAME as PR_KEY_FIELD_NAME ' + #13#10 +
'from RDB$RELATION_CONSTRAINTS C, RDB$INDEX_SEGMENTS S ' + #13#10 +
'where ' + #13#10 +
'(C.RDB$RELATION_NAME = :TABLE_NAME) and' + #13#10 +
'(C.RDB$INDEX_NAME = S.RDB$INDEX_NAME) and' + #13#10 +
'(C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' )';

var
Query: TNewQuery;
L, N: Integer;
F_Name: String;
begin
  Result := False;
  Query := TNewQuery.CreateNew( frDM, frDM.IBTrRead );
  try
    Query.SQL.Text := sqlPrKeyList;
    If not Query.Prepared then
      Query.Prepare;
    Query.ParamByName( 'TABLE_NAME' ).AsString := dlgFillRows.HeaderDlg.HostTableName;
    try
      Query.ExecQuery;
      Result := not ( Query.Bof and Query.Eof );
    except
      Raise;
    end;

    L := 0;
    SetLength( IndList, L );
    SetLength( ValueList, L );

    if Assigned( DS.FindField( 'IS_DELETE' )) then begin
      Inc ( L );
      SetLength( IndList, L );
      SetLength( ValueList, L );
      IndList[ L - 1 ] := DS.FieldByName( 'IS_DELETE' ).Index;
      ValueList[ L - 1 ] := ResultID;
    end;

    for N := 0 to DS.ParamCount - 1 do begin
      F_Name := DS.ParamName( N );
      if Assigned( DS.FindField( F_Name )) and
         Assigned( SpEdit.FindParam( F_Name )) then begin
        Inc ( L );
        SetLength( IndList, L );
        SetLength( ValueList, L );
        IndList[ L - 1 ] := DS.FieldByName( F_Name ).Index;
        ValueList[ L - 1 ] := SpEdit.ParamByName( F_Name ).AsVariant;
      end;
    end;

    while not Query.Eof do begin
      Inc ( L );
      SetLength( IndList, L );
      SetLength( ValueList, L );
      F_Name := Trim( Query.FieldByName( 'PR_KEY_FIELD_NAME' ).AsString );

      IndList[ L - 1 ] := DS.FieldByName( F_Name ).Index;
      if AnsiSameText( F_Name, dlgFillRows.HeaderDlg.PrimaryKeyName ) then
        ValueList[ L - 1 ] := ResultID
      else
        ValueList[ L - 1 ] := SpEdit.ParamByName( F_Name ).AsVariant;

      Query.Next;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

end.

