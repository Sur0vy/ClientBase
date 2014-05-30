{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit CustomDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnList, Vcl.ActnMan, Vcl.ToolWin,
  Vcl.ActnCtrls, Vcl.Menus, Vcl.ActnPopup, Vcl.ComCtrls, GridDlg, RegSmartDlg, DlgExecute, XmlRowsParam,
  DlgParams, Data.DB,
  Vcl.ExtCtrls, Data.DBXJSON, SqlTools, AddActions;

type
  TOnBeforeSaveExecute = procedure( Sender: TObject ) of Object;
  TOnAfterFillRow = procedure( Sender: TObject; var Item: TPropertyItem ) of object;
  TOnSaveExecute = procedure( Sender: TObject; Dlg: TSmartDlg ) of object;
  TOnAfterFormShow = procedure( Sender: TObject ) of Object;
  TOnFillAddDialogMenu = procedure( Sender: TObject ) of Object;
  TOnAddActionExecute = procedure( Sender: TObject ) of Object;

  TfrCustomDlg = class(TForm)
    SB: TStatusBar;
    FontD: TFontDialog;
    SmartDlg: TSmartDlg;
    ActListDialog: TActionList;
    A_Save: TAction;
    A_Close: TAction;
    A_ClearAll: TAction;
    A_Clear: TAction;
    A_Font: TAction;
    dlgFillRows: TFillRows;
    TmSave: TTimer;
    A_Between: TPopMenuAction;
    aTbSmartDLG: TActionToolBar;
    ppDialog: TPopupActionBar;
    A_SetBetween: TAction;
    A_AddAction: TAction;
    A_AddAction_1: TAction;
    procedure FormResize(Sender: TObject);
    procedure A_SaveExecute(Sender: TObject); virtual;
    procedure A_CloseExecute(Sender: TObject); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); virtual;
    procedure A_ClearExecute(Sender: TObject);
    procedure A_ClearAllExecute(Sender: TObject);
    procedure A_FontExecute(Sender: TObject);
    procedure FontDApply(Sender: TObject; Wnd: HWND);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dlgFillRowsGetDataBaseParam(Sender: TObject; DlgID: Integer; var Header: THeaderDlg);
    procedure SmartDlgGetLookupList(Sender: TObject; const SQL, Title, ID: string; Values: TVariantArray; Ind: Integer; var Items: TStrings);
    procedure SmartDlgChangeRow(Sender: TObject; NewRow: Integer);
    procedure dlgFillRowsGetRowsListParam(Sender: TObject; DlgID: Integer; InputParams: array of TVarRec; Rows: TRowsList);
    procedure WhereSQLAppendAnd(var Sql: String);
    procedure SetButtonActive( IsActive, CloseEnabled: Boolean);
    function CheckIsNoEmpty: Boolean;
    procedure SmartDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure CMDialogKey(var AMessage: TCMDialogKey); message CM_DIALOGKEY;
    procedure TmSaveTimer(Sender: TObject);
    procedure EmptySaveExecute(Sender: TObject);
    procedure SetEditAccess(const ActionName: String; IsWriteRight: Boolean ); virtual;
    procedure SetDlgReadOnly;
    procedure GetMultySelectParams(Prop: TPropertyItem; ValueID: Integer; var RowValue, CheckListID: String);
    procedure A_BetweenExecute(Sender: TObject);
    procedure A_SetBetweenExecute(Sender: TObject);
  private
    { Private declarations }
    function GetDlgHeaderParams(DlgID: Integer; var Title, SqlText, ExecName, HostTableName, SpravLink, PrimaryKeyName: String;
          var ShowSpravFiltr: Boolean): Boolean;
    procedure GetFieldValue(var Prop: TPropertyItem; Query: TDSQuery);
    procedure GetSizeValue(var Prop: TPropertyItem; Query: TDSQuery);
  public
    { Public declarations }
    OwnerForm: TForm;
    DlgIdent: Integer;
    IsSpravEditor: Boolean;   // редактирование справочника

    OnBeforeSaveExecute: TOnBeforeSaveExecute;
    OnAfterFillRow: TOnAfterFillRow;
    OnSaveExecute: TOnSaveExecute;
    OnAfterFormShow: TOnAfterFormShow;
    OnFillAddDialogMenu: TOnFillAddDialogMenu;
    OnAddActionExecute: TOnAddActionExecute;
    procedure FillDialogMenu; virtual;
  end;


implementation

{$R *.dfm}

uses
  Procs, Prima, Tools, SqlTxtRtns, System.Math, ClientDM, ConstList, pFIBDataSet, FIBDataSet, CustomSprav, CustomForm;


procedure TfrCustomDlg.FillDialogMenu;
begin
  try
    with frPrima do begin
      SetMainMenuList( nil, ppDialog,
              [ A_Save, A_Sp, A_ClearAll, A_Clear, A_Sp, A_Between, A_Sp,
                A_EditCut, A_EditCopy, A_EditPaste, A_Sp, A_EditSelectAll, A_EditUndo, A_Sp,
                A_Close ] );
      SetFillActListInBar( aTbSmartDLG,
              [ A_Save, A_Sp, A_ClearAll, A_Clear, A_Sp, A_SetBetween, A_Sp,
                A_EditCut, A_EditCopy, A_EditPaste, {A_Sp, A_EditSelectAll, A_EditUndo, A_Sp,}
                A_Close ] );
    end;
    if Assigned( OnFillAddDialogMenu ) then
      OnFillAddDialogMenu( Self );
  finally
    SmartDlg.Refresh;
  end;
end;

procedure TfrCustomDlg.A_BetweenExecute(Sender: TObject);
begin
// IsEmpty
end;

procedure TfrCustomDlg.A_ClearAllExecute(Sender: TObject);
var
N: Integer;
begin
  for N := 0 to SmartDlg.RowsList.Count - 1 do begin
    With SmartDlg.RowsList.Items[ N ] do begin
      if ( Style = psReadOnlyText ) then
        Continue;
      if ShowAsReadOnly then
        Continue;
      RowValue := '';
      RowValueID := -1;
      CheckListID := '';
    end;
  end;

  SmartDlg.RefreshEditText;
  SmartDlg.Refresh;
end;

procedure TfrCustomDlg.A_ClearExecute(Sender: TObject);
var
Prop: TPropertyItem;
begin
  Prop := SmartDlg.SelectedInfo;
  if ( Prop.Style = psReadOnlyText ) then
    Exit;
  if Prop.ShowAsReadOnly then
    Exit;

  Prop.RowValue := '';
  Prop.RowValueID := -1;
  Prop.CheckListID := '';

  SmartDlg.RefreshEditText;
  SmartDlg.Refresh;
end;

procedure TfrCustomDlg.A_CloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrCustomDlg.A_FontExecute(Sender: TObject);
begin
  FontD.Font := SmartDlg.Font;
  if FontD.Execute then
    SmartDlg.Font := FontD.Font;
end;

procedure TfrCustomDlg.FontDApply(Sender: TObject; Wnd: HWND);
begin
  SmartDlg.Font := FontD.Font;
end;

procedure TfrCustomDlg.A_SaveExecute(Sender: TObject);
begin
  SmartDlg.UpdateEditText;
  SetButtonActive( False, False );
  If Assigned( OnBeforeSaveExecute ) then
    OnBeforeSaveExecute( Self );
  if Assigned( OnSaveExecute ) then
    OnSaveExecute( Self, SmartDlg );
end;

procedure TfrCustomDlg.A_SetBetweenExecute(Sender: TObject);
begin
  // Is Empty
end;

procedure TfrCustomDlg.EmptySaveExecute( Sender: TObject );
begin
  ModalResult := mrOK;
end;

procedure TfrCustomDlg.dlgFillRowsGetDataBaseParam(Sender: TObject; DlgID: Integer; var Header: THeaderDlg);
begin
  GetDlgHeaderParams(
      DlgID, Header.Caption, Header.SqlText, Header.ExecName, Header.HostTableName, Header.SpravLink, Header.PrimaryKeyName,
      Header.ShowFiltr );
end;

function TfrCustomDlg.GetDlgHeaderParams(
  DlgID: Integer; var Title, SqlText, ExecName, HostTableName, SpravLink, PrimaryKeyName: String; var ShowSpravFiltr: Boolean ): Boolean;
const
sqlDialog =
'select * from DIALOG where DIALOG_ID = :ID';
var
Query: TNewQuery;
begin
  Result := False;
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := sqlDialog;
    If not Query.Prepared then
      Query.Prepare;

    try
      Query.ParamByName( 'ID' ).AsInteger := DlgID;

      Query.ExecQuery;
    except
      raise;
    end;
    Result := not ( Query.Eof and Query.Bof );
    if not Result  then
      Exit;


    Title           := Query.FieldByName( 'DIALOG_CAPTION' ).AsString;
    SqlText         := Query.FieldByName( 'SQL_TEXT' ).AsString;
    ExecName        := Query.FieldByName( 'EXEC_NAME' ).AsString;
    HostTableName   := Query.FieldByName( 'HOST_TABLE_NAME' ).AsString;
    SpravLink       := Query.FieldByName( 'SPRAV_LINK' ).AsString;
    PrimaryKeyName  := Query.FieldByName( 'PRIMARY_KEY_NAME' ).AsString;
    ShowSpravFiltr  := Query.FieldByName( 'SHOW_SPRAV_FILTR' ).AsInteger = 1;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomDlg.dlgFillRowsGetRowsListParam(Sender: TObject; DlgID: Integer; InputParams: array of TVarRec; Rows: TRowsList);

  function GetSqlOfSprav: String;
  begin
    case IsSpravEditor of
      True:
        Result :=
          AddToWhereClause( dlgFillRows.HeaderDlg.SqlText,
                            '(' + dlgFillRows.HeaderDlg.PrimaryKeyName + ' = %D)' );
      else
        Result := dlgFillRows.HeaderDlg.SqlText;
    end;

  end;

const
sqlRows =
'select * from GET_DIALOG_PARAMS( :ID, :DLG_TYPE )';
sqlRowsReport =
'select * from GET_REPORT_PARAMS( :ID, :USER_ID )';

var
Query: TNewQuery;
DataQuery: TDSQuery;
Prop: TPropertyItem;
St: TStringStream;
HeaderDlg: THeaderDlg;
begin
  if not Assigned( Self.SmartDlg ) then
    Exit;

  Rows.Clear;

  Query := TNewQuery.CreateNew( Self, nil );
  DataQuery := TDSQuery.CreateNew( Self, nil );
  St := TStringStream.Create;
  try
    case SmartDlg.TypeDialog of
      isNo:
        Exit;
      isFiltr, isEditor, isGridColumns: begin
        HeaderDlg := dlgFillRows.HeaderDlg;
        try
          HeaderDlg.FillSqlText := Format( GetSqlOfSprav, InputParams );
        finally
          dlgFillRows.HeaderDlg := HeaderDlg;
          DataQuery.SelectSQL.Text := dlgFillRows.HeaderDlg.FillSqlText;
        end;
        if not DataQuery.Prepared then
          DataQuery.Prepare;
      end;
      isReport:
        DataQuery.SelectSQL.Text := '';
    end;

    try
      case SmartDlg.TypeDialog of
        isEditor, isFiltr:
          DataQuery.Open;
      end;
    except
      raise;
    end;

    try
      case SmartDlg.TypeDialog of
        isNo:
          Exit;
        isFiltr, isEditor, isGridColumns:
          Query.SQL.Text := sqlRows;
        isReport:
          Query.SQL.Text := sqlRowsReport;
      end;

      If not Query.Prepared then
        Query.Prepare;

      try
        Query.ParamByName( 'ID' ).AsInteger := DlgID;
        case SmartDlg.TypeDialog of
          isFiltr, isEditor, isGridColumns:
            Query.ParamByName( 'DLG_TYPE' ).AsInteger := Integer( Self.SmartDlg.TypeDialog );
          isReport:
            Query.ParamByName( 'USER_ID' ).AsInteger := CurrentUserID;
        end;

        Query.ExecQuery;
      except
        raise;
      end;
      While not Query.Eof do begin
        Prop := Rows.Add;
        Prop.Title    := Query.FieldByName( 'PARAM_TITLE' ).AsString;
        Prop.StrStyle := Query.FieldByName( 'STYLE_TYPE' ).AsString;
        Prop.PrKeyID  := Query.FieldByName( 'ORDER_BY' ).AsInteger;
        Prop.FieldName := Query.FieldByName( 'FIELD_NAME' ).AsString;
        Prop.SheetID  := Query.FieldByName( 'SHEET_CAPTION_ID' ).AsInteger;
        Prop.SheetTitle := Query.FieldByName( 'SHEET_CAPTION_TITLE' ).AsString;

        St.Clear;
        Query.FieldByName( 'XML_DATA' ).SaveToStream( St );
        St.Position := 0;
        dlgFillRows.GetXmlParams( LoadDlgParamStreem( St ), Prop );

        case SmartDlg.TypeDialog of
          isFiltr: begin
            Prop.RowValue := '';
            Prop.CheckListID := '';
            Prop.RowValueID := -1;
            GetSizeValue( Prop, DataQuery );
          end;
          isEditor: begin
            GetFieldValue( Prop, DataQuery );
            GetSizeValue( Prop, DataQuery );
          end;
          isReport: begin
            Prop.RowValue := Query.FieldByName( 'ROW_VALUE' ).AsString;
            Prop.CheckListID := Query.FieldByName( 'CHECK_LIST' ).AsString;
            Prop.RowValueID := Query.FieldByName( 'ROW_VALUE_ID' ).AsInteger;
          end;
        end;

        if Assigned( @OnAfterFillRow ) then
          OnAfterFillRow( Self, Prop );

        Query.Next;
      end;
    finally
      Query.FreeAndCommit;
      St.Free;
    end;
  finally
    DataQuery.FreeAndCommit;
  end;
end;

procedure TfrCustomDlg.GetSizeValue( var Prop: TPropertyItem; Query: TDSQuery );
begin
  if not Assigned( Query.FindField( Prop.FieldName )) then begin
    Exit;
  end;

  case Prop.Style of
    psSimpleText, psReadOnlyText, psPassword, psMemoText, psPickListInput:
      if Assigned( Query.FindField( Prop.FieldName ))  then
        if ( Query.FieldByName( Prop.FieldName ) is TFIBMemoField ) or
           ( Query.FieldByName( Prop.FieldName ) is TFIBBlobField ) then
          Prop.MaxWidth := 0
        else
          Prop.MaxWidth := Query.FieldByName( Prop.FieldName ).Size;
    psNumeric:
      if Prop.MaxWidth <= 0 then
        Prop.MaxWidth := 18;
    psInteger:
      if Prop.MaxWidth <= 0 then
        Prop.MaxWidth := 9;
    psLengthText, psNumberLengthText:
      Prop.MaxWidth := Prop.NumericScale;
    psDateValue: begin
      Prop.SetLang := 2;
      if Prop.MaxWidth <= 0 then
        Prop.MaxWidth := 10;
    end;
  end;
end;

procedure TfrCustomDlg.GetFieldValue( var Prop: TPropertyItem; Query: TDSQuery );
  procedure SetEmptyValue;
  begin
    Prop.RowValue := '';
    Prop.CheckListID := '';
    Prop.RowValueID := -1;
  end;

  procedure FillMultySelectItem( KeyValueID: Integer );
  var
  RowValue, CheckListID: String;
  begin
    GetMultySelectParams( Prop, KeyValueID, RowValue, CheckListID );
    Prop.RowValue := RowValue;
    Prop.CheckListID := CheckListID;
    Prop.RowValueID := KeyValueID;
  end;

var
frtValue: String;
CurrField: TField;
begin
  SetEmptyValue;
  if not Assigned( Query.FindField( Prop.FieldName )) then
    Exit;

  case Prop.Style of
    psNo:
      Exit;
    psHeader:
      SetEmptyValue;
    psSimpleText, psReadOnlyText, psPassword, psMemoText, psPickListInput: begin
      Prop.RowValue := Query.FieldByName( Prop.FieldName ).AsString;
      Prop.MaxWidth := Query.FieldByName( Prop.FieldName ).Size;
    end;
    psLengthText, psNumberLengthText: begin
      Prop.RowValue := Query.FieldByName( Prop.FieldName ).AsString;
      Prop.MaxWidth := Prop.NumericScale;
    end;
    psPickList: begin
      Prop.RowValue := Query.FieldByName( Prop.FieldName ).AsString;
      if not Assigned( Query.FindField( Prop.SQL.KeyID )) then
        Prop.RowValueID := -1
      else
        Prop.RowValueID := Query.FieldByName( Prop.SQL.KeyID ).AsInteger;
    end;
    psComboBox, psBoolean: begin
      Prop.RowValueID := Query.FieldByName( Prop.FieldName ).AsInteger;
      Prop.RowValue := GetComboBoxValue( Prop.SQL.SqlText, Query.FieldByName( Prop.FieldName ).AsInteger );
    end;
    psMultySelect:
      FillMultySelectItem( Query.FieldByName( Prop.FieldName ).AsInteger );
    psDateValue: begin
      CurrField := Query.FieldByName( Prop.FieldName );
      if CurrField.IsNull then
        Prop.RowValue := ''
      else begin
        With FormatSettings do
          frtValue := 'dd' + DateSeparator + 'mm' + DateSeparator + 'yyyy';
        Prop.RowValue := FormatDateTime( frtValue, CurrField.AsDateTime, FormatSettings );
      end;
    end;
    psNumeric: begin
      Prop.RowValue := FormatFloat( Prop.FloatFormat, Query.FieldByName( Prop.FieldName ).AsFloat );
      Prop.MaxWidth := 18;
    end;
    psInteger: begin
      Prop.RowValue := FormatFloat( '#,0', Query.FieldByName( Prop.FieldName ).AsFloat );
      Prop.MaxWidth := 9;
    end;
    psFileOpen: begin
      Prop.RowValue := '';
      Prop.RowValueID := -1;
      Prop.CheckListID := '';
    end;
    psDialog: ;
    psColor: ;
  end;

  Prop.OldValue := Prop.RowValue;
end;

procedure TfrCustomDlg.GetMultySelectParams( Prop: TPropertyItem; ValueID: Integer; var RowValue, CheckListID: String );
  function AddString( Str: String; IsCheck: Boolean ): String;
  const
  DelimStr: array [ Boolean ] of String = ( #44#160, #44 );
  begin
    Result := '';
    If Str <> '' then
      Result := Concat( Str, DelimStr[ IsCheck ] );
  end;

var
Query: TNewQuery;
begin
  If Prop.SQL.SqlCheck = '' then
    Exit;

  RowValue := '';
  CheckListID := '';

  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := Format( Prop.SQL.SqlCheck, [ ValueID ]);
    Prop.RowValueID := ValueID;

    try
      Query.ExecQuery;
    except
      Raise;
    end;
    while not Query.Eof do begin
      RowValue := AddString( RowValue, False );
      CheckListID := AddString( CheckListID, True );
      RowValue := RowValue + Query.FieldByName( Prop.SQL.Title ).AsString;
      CheckListID := CheckListID + Query.FieldByName( Prop.SQL.KeyID ).AsString;
      Query.Next;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
	Screen.Cursor := crDefault;
  SetLanguage( LANG_RUSSIAN );
end;

procedure TfrCustomDlg.FormCreate(Sender: TObject);
begin
  dlgFillRows.DlgIdent := -1;
  IsSpravEditor := False;
end;

procedure TfrCustomDlg.FormResize(Sender: TObject);
var
L, N: Integer;
begin
  L := Self.ClientWidth div 3;
  for N := 0 to SB.Panels.Count -1 do
    SB.Panels.Items[ N ].Width := L;
end;

procedure TfrCustomDlg.FormShow(Sender: TObject);
begin
  if OwnerForm.FormStyle in [ fsMDIForm, fsMDIChild ] then begin
    Self.Width := ( OwnerForm.ClientWidth * 2 ) div 3;
  end
  else
  if OwnerForm.FormStyle = fsNormal then begin
    Self.Width := ( OwnerForm.ClientWidth * 8 ) div 10;
    Self.Top := OwnerForm.Top + 10;
    Self.Left := OwnerForm.Left + 10;
  end;
  FillDialogMenu;
  try
    SmartDlg.DividerPosition := ( SmartDlg.ClientWidth div 5 ) * 2;
  finally
    //
  end;

  SetButtonActive( A_Save.Visible, False );

  if Assigned( OnAfterFormShow ) then
    OnAfterFormShow( Self );
end;

procedure TfrCustomDlg.SmartDlgChangeRow(Sender: TObject; NewRow: Integer);
begin
  if SmartDlg.SelectedInfo.SetLang = -1 then
    Exit;

  SetLanguage( ifThen( SmartDlg.SelectedInfo.SetLang = 1, LANG_ENGLISH, LANG_RUSSIAN ));
end;

procedure TfrCustomDlg.SmartDlgGetLookupList(Sender: TObject; const SQL, Title, ID: string; Values: TVariantArray;
  Ind: Integer; var Items: TStrings);

var
Query: TNewQuery;
N: Integer;
begin
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := SQL;
    If not Query.Prepared then
      Query.Prepare;

    try
      if ( Query.Params.Count > 0 ) and
         ( Query.Params.Count = Length( Values )) then
        for N := 0 to High( Values ) do
          Query.Params[ N ].Value := Values[ N ];

      Query.ExecQuery;
    except
      raise;
    end;
    While not Query.Eof do begin
      Items.AddObject( Query.FieldByName( Title ).AsString,
                       TObject( Query.FieldByName( ID ).AsInteger ));
      Query.Next;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomDlg.SmartDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  procedure ClearListRow;
  var
  Prop: TPropertyItem;
  begin
    Prop := SmartDlg.SelectedInfo;
    if not Assigned( Prop ) then
      Exit;
    if not Prop.IsNeedReadOnly then
      Exit;
    A_ClearExecute( A_Clear );
  end;

begin
  if Shift = [] then
    case Key of
      VK_RETURN:
        case A_Save.Enabled of
          True: A_SaveExecute( A_Save );
          else  A_CloseExecute( A_Close );
        end;

      VK_DELETE, VK_BACK: begin
        ClearListRow;
      end;

      VK_ESCAPE:
        A_CloseExecute( A_Close );
    end;
end;

procedure TfrCustomDlg.TmSaveTimer(Sender: TObject);
begin
  TmSave.Enabled := False;
  SetButtonActive( True, False );
end;

procedure TfrCustomDlg.WhereSQLAppendAnd( var Sql: String );
begin
  If Sql > '' then
     Sql := Sql + ' and ';
end;

procedure TfrCustomDlg.SetButtonActive( IsActive, CloseEnabled: Boolean );
var
N: Integer;
Act: TAction;
Bar: TActionBarItem;
begin
  Bar := frPrima.ShowAssignToolBar( aTbSmartDLG, True );
  if not Assigned( Bar ) then
    Exit;

  for N := 0 to Bar.Items.Count - 1 do begin
    if Bar.Items[ N ].Separator then
      Continue;
    Act := TAction( Bar.Items[ N ].Action );
    if Assigned( Act ) then
      case IsActive of
        True: begin
          if Act.Tag = 0 then
            Act.Enabled := True;
          Act.Tag := 0;
        end;

        else begin
          if not Act.Enabled then
            Act.Tag := -1;
          Act.Enabled := False;
        end;
      end;
  end;

  if CloseEnabled then
    A_Close.Enabled := True;

  Application.ProcessMessages;
end;

procedure TfrCustomDlg.SetDlgReadOnly;
begin
  A_Save.Visible := False;
  A_Save.Enabled := False;
  A_Clear.Enabled := False;
  A_ClearAll.Enabled := False;
end;

function TfrCustomDlg.CheckIsNoEmpty: Boolean;
var
N: Integer;
Prop: TPropertyItem;
begin
  Result := False;

  For N := 0 to SmartDlg.RowsList.Count - 1 do begin
    Prop := SmartDlg.RowsList.Items[ N ];
    if Prop.Style in [ psNumberLengthText, psLengthText ] then begin
      if (( Prop.IsEmpty = ftNo ) and ( Prop.RowValue = '' )) or
         ( Prop.FieldName = '' ) or
         ( not Prop.Visible ) then
        Continue;
      if ( Length( Trim( Prop.RowValue )) <> Prop.NumericScale ) then begin
        ShowMessageFmt( 'Длина строки параметра "%S" должна быть %D символов. ', [ Prop.Title, Prop.NumericScale ]);
        Result := True;
      end;
    end
    else begin
      if ( Prop.IsEmpty = ftNo ) or
         ( Prop.Style = psHeader ) or
         ( Prop.FieldName = '' ) or
         ( not Prop.Visible ) or
         ( Prop.Style = psReadOnlyText ) then
        Continue;

      if ( Trim( Prop.RowValue ) = '' ) or
         (( Prop.Style in [ psNumberLengthText, psLengthText ]) and
          ( Length( Trim( Prop.RowValue )) <> Prop.NumericScale )) or
         (( Prop.Style in [ psInteger, psNumeric ]) and
          ( StrToFloatDef( StrSeparatorDelete( Prop.RowValue ), -1 ) = 0 ))  then begin
        ShowMessage( Concat( 'Поле "', Prop.Title, '" обязательно для заполнения!' ));
        Result := True;
      end;
    end;

    If Result then begin
      if SmartDlg.TabSet.Tabs.Count > 0 then begin
        SmartDlg.TabSet.TabIndex := SmartDlg.TabSet.Tabs.IndexOfObject( TObject( Prop.SheetID ));
        SmartDlg.SetRowSelected( Prop.FieldName );
      end;

      Exit;
    end;
  end;
end;

procedure TfrCustomDlg.CMDialogKey(var AMessage: TCMDialogKey);
begin
  if AMessage.CharCode <> VK_TAB then
    inherited;
end;

procedure TfrCustomDlg.SetEditAccess( const ActionName: String; IsWriteRight: Boolean );
begin
  A_Save.Enabled := False;
  A_Save.Tag := -1;

  try
    if not IsWriteRight then
      Exit;

    If ( ActionName = '' )  then
      A_Save.Enabled := True
    else
    If OwnerForm is TfrCustomSprav then
      A_Save.Enabled := True
    else begin
      A_Save.Visible := False;
      frDM.SetFuncRightAccess( Self, ActionName );
      A_Save.Enabled := A_Save.Visible;
      A_Save.Visible := True;
    end;
  finally

    SmartDlg.ReadOnly := not A_Save.Enabled;
    if A_Save.Enabled then
      A_Save.Tag := 0;
  end;

  if SmartDlg.ReadOnly then
    SetButtonActive( False, False );
end;

end.
