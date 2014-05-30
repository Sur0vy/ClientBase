{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit CustomSprav;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSimpleForm, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet,
  pFIBDataSet, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls,
  DlgParams, DlgExecute, RightType, CustomForm, CustomDlg, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TfrCustomSprav = class(TfrCustomSimpleForm)
    A_SpravNew: TAction;
    A_SpravEdit: TAction;
    A_SpravDelete: TAction;
    A_SpravAddCopy: TAction;
    A_ShowDelete: TAction;
    A_UpdateSysdba: TAction;
    aTbSprav: TActionToolBar;
    procedure A_SpravNewExecute(Sender: TObject);
    procedure A_SpravEditExecute(Sender: TObject);
    procedure A_SpravDeleteExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    procedure ShowSpravDlg(ID: Integer; DlgType: TStateDlg; Act: TAction); virtual;
    procedure SetIsUseDefaultValue(Sender: TObject; var Item: TPropertyItem); virtual;
    procedure FormCreate(Sender: TObject);
    procedure FillHostSqlText( var HostSQL: String; const QuerySQL: String ); virtual;
    procedure A_SpravAddCopyExecute(Sender: TObject);
    procedure A_ShowDeleteExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState); override;
    procedure A_UpdateSysdbaExecute(Sender: TObject);
    procedure Q_HostBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    HostTableName: String;
    ExecProcName: String;
    RightEditValue: Integer;
    procedure IsTableParams( RightValue: Integer; var ShowFiltr: Boolean );
    procedure SetConditionIsDelete;
    procedure UpdateSysdbaPass(const OldPass, NewPass: String);
    procedure UpdateSqlWithIsDelete;
  public
    { Public declarations }
    PrKeyName: String;
    DlgClass: TDialogEdit;
    procedure FillHostMenu; override;
    class procedure ShowSprav( const Title: String; IdentID, RightValue: Integer; IsMdi: Boolean = True );
  end;

  TFormIsSprav = class of TfrCustomSprav;


implementation

{$R *.dfm}

uses
  Prima, ConstList, Procs, RecordEdit, SqlTxtRtns, SqlTools, XmlRowsParam, Tools, ClientDM, pFIBProps;

const
  dlNameCondition = 'IS_DELETE_SHOW';

{ TfrCustomSprav }

procedure TfrCustomSprav.A_SpravDeleteExecute(Sender: TObject);
begin
  if not ( A_SpravDelete.Visible and A_SpravDelete.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Host, ExecProcName, 'Удалить текущую запись?', '',
                [ PrKeyName ], [ Q_Host.FieldByName( PrKeyName ).AsInteger ] );
end;

procedure TfrCustomSprav.A_SpravEditExecute(Sender: TObject);
begin
  if not ( A_SpravEdit.Visible and A_SpravEdit.Enabled ) then
    Exit;

  ShowSpravDlg( Q_Host.FieldByName( PrKeyName ).AsInteger, sdEdit, A_SpravEdit );
end;

procedure TfrCustomSprav.A_SpravNewExecute(Sender: TObject);
begin
  if not ( A_SpravNew.Visible and A_SpravNew.Enabled ) then
    Exit;

  ShowSpravDlg( -1, sdInsert, A_SpravNew );
end;

procedure TfrCustomSprav.A_UpdateSysdbaExecute(Sender: TObject);
var
Dlg: TfrCustomDlg;
begin
  inherited;
  if not ( A_UpdateSysdba.Enabled and A_UpdateSysdba.Visible ) then
    Exit;
  if Self.Tag <> sprUserList then
    Exit;

  Dlg := TfrCustomDlg.Create( Application.MainForm );
  try
    Dlg.Caption := A_UpdateSysdba.Caption;
    Dlg.OwnerForm := Self;
    Dlg.OnBeforeSaveExecute := Dlg.EmptySaveExecute;

    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Действующий пароль для логина SYSDBA';
      RowValue := '';
      RowValueID := -1;
      FieldName := 'PassSysdba';
      Style := psPassword;
      IsEmpty := ftNotEmpty;
      SetLang := 1;
    end;
    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Новый пароль';
      RowValue := '';
      RowValueID := -1;
      FieldName := 'PassNew';
      Style := psSimpleText;
      IsEmpty := ftNotEmpty;
      SetLang := 1;
    end;

    Dlg.SmartDlg.FillVisibleRows;

    If Dlg.ShowModal = mrOK then begin
      UpdateSysdbaPass( Dlg.SmartDlg.RowsList.PropByHostFieldName( 'PassSysdba' ).RowValue, Dlg.SmartDlg.RowsList.PropByHostFieldName( 'PassNew' ).RowValue );
    end;
  finally
    Dlg.Release;
  end;
end;

procedure TfrCustomSprav.UpdateSysdbaPass( const OldPass, NewPass: String );
const
sqlNewPass =
'execute block(' + #13#10 +
'  OLD_PASS varchar(32) = ?OLD_PASS,' + #13#10 +
'  NEW_PASS varchar(32) = ?NEW_PASS )' + #13#10 +
'as' + #13#10 +
'begin' + #13#10 +
'  execute statement' + #13#10 +
'    ''alter user SYSDBA password '''''' || :NEW_PASS || '''''' lastname '''' ADMINISTRATOR ''''''' + #13#10 +
'      as user ''SYSDBA'' password '''' || :OLD_PASS || '''';' + #13#10 +
' ' + #13#10 +
'  update HOST_IDENT H' + #13#10 +
'    set' + #13#10 +
'      H.USER_ADD = :NEW_PASS' + #13#10 +
'    where' + #13#10 +
'      H.HOST_IDENT_ID = 1;' + #13#10 +
'end';

begin
  try
    If ExecuteQuery( sqlNewPass, [ OldPass, NewPass ], frDM.IBTrWrite ) then
      ShowMessage( 'Пароль успешно изменен!' );
  except
    on E: Exception do begin
      if Poscase( 'Your user name and password are not defined', E.Message, True ) > 0 then
        ShowMessage( 'Неверно указано текущий пароль администратора!' +#13#10 + E.Message )
      else
        ShowMessage( E.Message );
    end;
  end;
end;

procedure TfrCustomSprav.A_ShowDeleteExecute(Sender: TObject);
begin
  inherited;
  Q_Host.Close;
  try
    A_ShowDelete.Checked := not A_ShowDelete.Checked;
    UpdateSqlWithIsDelete;
  finally
    Q_Host.CloseOpen( True );
  end;
end;

procedure TfrCustomSprav.UpdateSqlWithIsDelete;
var
CondDelete: Tcondition;
begin
  if Q_Host.Active then
    Exit;

  CondDelete := Q_Host.Conditions.FindCondition( dlNameCondition );
  if not Assigned( CondDelete ) then
    Exit;

  try
    CondDelete.Enabled := not A_ShowDelete.Checked;
  finally
    Q_Host.Conditions.Apply;
  end;
end;

procedure TfrCustomSprav.A_SpravAddCopyExecute(Sender: TObject);
begin
  if not ( A_SpravAddCopy.Visible and A_SpravAddCopy.Enabled ) then
    Exit;

  ShowSpravDlg( Q_Host.FieldByName( PrKeyName ).AsInteger, sdCopy, A_SpravAddCopy );
end;

procedure TfrCustomSprav.dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    case Key of
      VK_RETURN:
        A_SpravEditExecute( A_SpravEdit );
      VK_ESCAPE:
        if Self.FormStyle = fsNormal then
          A_CloseExecute( A_Close );
    end;
end;

procedure TfrCustomSprav.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBGridToBase( dbgHost, Self.ClassName + '_' + IntToStr( Self.Tag ), dbgHost.Name );
  Self.Q_Host.Close;
  inherited;
end;

procedure TfrCustomSprav.FormCreate(Sender: TObject);
begin
  inherited;
  DlgClass := TfrRecordEdit;
end;

procedure TfrCustomSprav.GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  If A_ShowDelete.Visible and
     Assigned( Q_Host.FindField( 'IS_DELETE' )) and
    ( Q_Host.FieldByName( 'IS_DELETE' ).AsInteger < 0 ) then   //Удаленная запись
    dbgHost.Canvas.Brush.Color := clFuchsia;

	inherited GridDrawColumnCell( Sender, Rect, DataCol, Column, State );
end;

procedure TfrCustomSprav.FillHostSqlText( var HostSQL: String; const QuerySQL: String );
begin
  HostSQL := QuerySQL;
end;

procedure TfrCustomSprav.SetConditionIsDelete;
var
Query: TNewQuery;
begin
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text :=
      AddToWhereClause( HostSqlText, '(' + PrKeyName + ' = -1000 )' );
    try
      Query.ExecQuery;
    except
      raise;
    end;
    if Assigned( Query.FindField( 'IS_DELETE' )) then begin
      try
        Q_Host.Conditions.AddCondition( dlNameCondition, '( IS_DELETE > 0 )', True );
        Q_Host.Conditions.Apply;
      finally
        //
      end;
    end
    else
      A_ShowDelete.Visible := False;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomSprav.IsTableParams(RightValue: Integer; var ShowFiltr: Boolean);
const
SSpravForm =
	'SELECT * FROM GET_DIALOG_PARAMS( %D, 3 ) ORDER BY ORDER_BY ASC';
sqlHostParam =
  'SELECT * FROM DIALOG WHERE DIALOG_ID = %D';
var
Query: TNewQuery;
Ind: Integer;

  function DeleteOrderClause( SqlText: String ): String;
  var
  StartPos, EndPos: Integer;
  begin
    try
      OrderStringTxt( SqlText, StartPos, EndPos );
      if StartPos > 0 then begin
        Delete( SqlText, StartPos, EndPos - StartPos + 1 );
      end;
    finally
      Result := SqlText;
    end;
  end;

  function GetColumnLength: Integer;
  var
  St: TStringStream;
  Xml: IXMLDlgParamType;
  begin
    St := TStringStream.Create;
    try
      Query.FieldByName( 'XML_DATA' ).SaveToStream( St );
      St.Position := 0;
      Xml := LoadDlgParamStreem( St );
      Result := Xml.ColumnLength;
    finally
      ST.Free;
      Xml := nil;
    end;
  end;

begin
	ShowFormCaption;
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := Format( sqlHostParam, [ Self.Tag ]);
    try
      Query.ExecQuery;
    except
      raise;
    end;

    FillHostSqlText( HostSqlText, Query.FieldByName( 'SQL_TEXT' ).AsString );
    PrKeyName := Query.FieldByName( 'PRIMARY_KEY_NAME' ).AsString;
    HostTableName := Query.FieldByName( 'HOST_TABLE_NAME' ).AsString;
    ExecProcName := Query.FieldByName( 'EXEC_NAME' ).AsString;
    ShowFiltr := Query.FieldByName( 'SHOW_SPRAV_FILTR' ).AsInteger = 1;

    Q_Host.SQLs.SelectSQL.Text := HostSqlText;
    Q_Host.SQLs.RefreshSQL.Text :=
        AddToWhereClause( DeleteOrderClause( HostSqlText ),
                          Concat( '(', PrKeyName, ' = :OLD_', PrKeyName, ') ' ));

    If not Q_Host.Prepared then
      Q_Host.Prepare;

    SetConditionIsDelete;

    Query.Close;

    dbgHost.Columns.Clear;

    Query.SQL.Text := Format( SSpravForm, [ Self.Tag ]);

    try
      Query.ExecQuery;
    except
      raise;
    end;

    Ind := 0;
    dbgHost.Columns.Clear;
    While not Query.Eof do begin
      if Query.FieldByName( 'NO_SHOW_IN_GRID' ).AsInteger = 0 then
        AddColumnsGrid(
          dbgHost,
          Query.FieldByName( 'FIELD_NAME' ).AsString,
          Query.FieldByName( 'PARAM_TITLE' ).AsString,
          GetColumnLength,
          StringToPropertyStyle( Query.FieldByName( 'STYLE_TYPE' ).AsString ) = psBoolean,
          True, Ind );
      Query.Next;
    end;
  finally
    try
      Query.Free;
    except
      Raise;
    end;
  end;

  BaseToDBGrid( dbgHost, Self.ClassName + '_' + IntToStr( Self.Tag ), dbgHost.Name );

  try
    Q_Host.AllowedUpdateKinds := [];
    A_SpravNew.Visible     := ( Self.RightEditValue and binSpravInsert ) = binSpravInsert;
    A_SpravAddCopy.Visible := A_SpravNew.Visible;
    A_SpravEdit.Visible    := ( Self.RightEditValue and binSpravEdit ) = binSpravEdit;
    A_SpravDelete.Visible  := ( Self.RightEditValue and binSpravDelete ) = binSpravDelete;
    A_UpdateSysdba.Visible := ( Self.Tag = sprUserList ) and A_SpravEdit.Visible;
  except
    raise;
  end;
end;

procedure TfrCustomSprav.Q_HostAfterScroll(DataSet: TDataSet);
var
Cond: TCondition;
begin
  inherited;
  A_SpravEdit.Enabled := not Q_Host.IsEmpty;
  A_SpravDelete.Enabled := A_SpravEdit.Enabled;
  A_ShowDelete.Visible := A_SpravEdit.Visible;

  Cond := Q_Host.Conditions.FindCondition( dlNameCondition );
  A_ShowDelete.Enabled := Assigned( Cond );
  A_ShowDelete.Visible := Assigned( Cond );

  if Assigned( Cond ) then
    A_ShowDelete.Checked := not Cond.Enabled
  else
    A_ShowDelete.Checked := False;

  Application.ProcessMessages;
end;

procedure TfrCustomSprav.Q_HostBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  UpdateSqlWithIsDelete;
end;

procedure TfrCustomSprav.SetIsUseDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  With TfrRecordEdit( Sender ) do begin
    if dlgFillRows.ActionType <> sdInsert then
      Exit;
    case IndexOfStrArray( Item.FieldName, [ 'IS_USE', 'IS_WORK', 'LAND_TITLE', 'DATE_REGISTR', 'PERSONAL_TITLE' ]) of
      0, 1: begin
        Item.RowValue := BoolTitle[ 1 ];
        Item.RowValueID := 1;
      end;
      2: If not AnsiSameText( HostTableName, 'LAND' ) then begin
        Item.RowValue := GetLandSpravValue( spLandRusValue );
        Item.RowValueID := spLandRusValue;  // Россия
      end;
      3: begin
        Item.RowValue := FormatDateTime( 'dd.mm.yyyy', Date );
        Item.RowValueID := -1;
      end;
      4: begin
        if Item.Style = psReadOnlyText then begin
          Item.RowValue := CurrentManagerTitle;
          Item.RowValueID := -1;
        end;
      end;
    end;

    if ( dlgFillRows.ActionType = sdInsert ) and
       ( DlgIdent <> sprUserList ) and
       AnsiSameText( Item.FieldName, 'PERSONAL_TITLE' ) then begin
        Item.RowValue := CurrentManagerTitle;
        Item.RowValueID := CurrentUserID;
    end;
  end;
end;

procedure TfrCustomSprav.ShowSpravDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAfterFillRow := SetIsUseDefaultValue;

  ShowEditDialog( Self, DlgClass, Q_Host, PrKeyName, Self.Tag, ID, DlgType, Act, CurrDlgEvent, [ ID ] );

  if Self.Tag = sprSubscribInput then
    Q_Host.CloseOpen( True );
end;

class procedure TfrCustomSprav.ShowSprav(const Title: String; IdentID, RightValue: Integer; IsMdi: Boolean);
var
ShowFiltr: Boolean;
begin
  With Self.Create( Application ) do
    try
      Tag := IdentID;
      Caption := Title;
      FormCaption := Title;
      RightEditValue := RightValue;
      UserRightType := frDM.SetFuncWriteRight;
      A_Filtr.DlgIdent := IdentID;
      aTbSprav.Visible := not IsMDI;
      Case IsMDI of
        True: begin
          FormStyle := fsMDIChild;
          WindowState := wsMaximized;
          BorderIcons := [biSystemMenu,biMinimize,biMaximize];
        end;
        else begin
          FormStyle := fsNormal;
          WindowState := wsNormal;
          BorderIcons := [biSystemMenu];
          Visible := False;
        end;
      end;

      IsTableParams( RightValue, ShowFiltr );

      OpenDataSetOfStartForm;

      If not Q_Host.Active then begin
        Close;
        Exit;
      end;

      Q_Host.First;
      if not IsMDI then
        ShowModal;
    finally
      if not IsMDI then
        Release;
    end;
end;

procedure TfrCustomSprav.FillHostMenu;
  function GetToolBar: TActionToolBar;
  begin
    case Self.FormStyle of
      fsNormal:
        Result := aTbSprav;
      else
        Result := frPrima.aTbTransact;
    end;
  end;

begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_SpravAddCopy, A_Sp, A_SpravNew, A_SpravEdit, A_SpravDelete, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp, A_ShowDelete, A_UpdateSysdba, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, GetToolBar, 'Справочники',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_SpravNew, A_SpravEdit, A_SpravDelete, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp, A_ShowDelete, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;



end.
