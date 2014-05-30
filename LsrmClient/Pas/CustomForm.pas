{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit CustomForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, DBGridEh, Grids, ComCtrls, ActnList, CheckLst,
	Menus, DBActns, ExtCtrls,  Printers, DBClient, PrnDbgeh, AddActions, ConstList,
  DBGridEhGrouping, ToolCtrlsEh, GridsEh, RightType, RecordEdit, DlgExecute, CustomDlg,
  FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, pFIBStoredProc, DlgParams, ToolBarSetup;

{$I Lsrm.inc}

type
  TDialogEdit = class of TfrRecordEdit;

  TfrCustomForm = class(TForm)
    A_AutoWidth: TAction;
    A_Centr: TAction;
    A_Close: TAction;
    A_FiltrClear: TAction;
    A_First: TDataSetFirst;
    A_Font: TAction;
    A_Frozen: TAction;
    A_Help: TAction;
    A_Last: TDataSetLast;
    A_Left: TAction;
    A_Next: TDataSetNext;
    A_Print: TAction;
		A_Prior: TDataSetPrior;
		A_Refresh: TAction;
		A_RefreshFull: TAction;
		A_Right: TAction;
		A_HostGridSetup: TAction;
    ActList: TActionList;
    FontD: TFontDialog;
    SB: TStatusBar;
    A_DsLocation: TPopMenuAction;
    A_Align: TPopMenuAction;
    A_ExcelExport: TAction;
    SleepTM: TTimer;
    A_FontOfList: TPopMenuAction;
    A_GridAllFont: TAction;
    A_Filtr: TFiltrActList;
    TmEnabled: TTimer;
    PrintDBG: TPrintDBGridEh;
    A_ShowOfStart: TAction;
    A_ToolBarSetup: TAction;

    procedure A_AutoWidthExecute(Sender: TObject);
    procedure A_CentrExecute(Sender: TObject);
    procedure A_CloseExecute(Sender: TObject);
    procedure A_FontExecute(Sender: TObject);
    procedure A_FrozenExecute(Sender: TObject);
    procedure A_LeftExecute(Sender: TObject);
    procedure A_RightExecute(Sender: TObject);
    function  CurrentGrid: TDBGridEh;
    procedure FontDApply(Sender: TObject; Wnd: HWND);
    Procedure SetFontToDBEditList( NewFont: TFont ); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
		procedure FormDeactivate(Sender: TObject); virtual;
    procedure FormShow(Sender: TObject);
    procedure GetCurrentField;
    procedure GridCellClick(Column: TColumnEh);
    procedure GridColEnter(Sender: TObject);
    procedure DbGridEnter(Sender: TObject);
    procedure DataSetAfterScroll( DataSet: TDataSet );
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
                                 DataCol: Integer; Column: TColumnEh; State: TGridDrawState ); virtual;
    procedure AddColumnsGrid( DBG: TDBGridEh; FName, FTitle: String; FWidth: Integer; IsCheck, IsVisible: Boolean;
                              var Ind: Integer; const Image: TImageList = nil; HintTitle: String = '';
                              Orient: TTextOrientationEh = tohHorizontal  );
    procedure A_AutoWidthUpdate(Sender: TObject);
    procedure FindPopupMenuBtn(TB: TToolBar; PopupAction: TAction;BtnPM: TPopupMenu);
    procedure FormActivate(Sender: TObject); virtual;
    procedure GridSetup( CurrGrid: TDBGridEh );
    procedure A_PrintExecute(Sender: TObject);
    procedure A_PrintUpdate(Sender: TObject);
		function  GetSelectionList(DBG: TDBGridEh; const PrKeyName: String;  var SelectFiltr: String): Boolean;
		procedure A_HostGridSetupExecute(Sender: TObject);
		procedure A_RefreshUpdate(Sender: TObject);
		procedure A_RefreshFullUpdate(Sender: TObject);
    procedure A_RefreshExecute(Sender: TObject);
    procedure A_RefreshFullExecute(Sender: TObject);

    procedure A_FontUpdate(Sender: TObject);
    procedure A_HelpExecute(Sender: TObject);
    procedure ExportGridToExcel( CurrGrid: TDBGridEh );
    procedure SetAccessRight( const ActName: String  ); virtual;
    function SetAccessRightOfRows(DS: TpFIBDataSet; Const ConditionValue: String ): Boolean; virtual;
    procedure A_FiltrClearExecute(Sender: TObject);
    procedure A_FiltrExecute(Sender: TObject);
    procedure A_FiltrAfterExecFiltr(Sender: TObject; const DialogIdent: Integer);
    procedure TmEnabledTimer(Sender: TObject);
    procedure PrintGrid(DBG: TDbGridEh; Title: String);
    procedure SleepTMTimer(Sender: TObject);
    procedure StopTimerBeforeScroll(DataSet: TDataSet);
    procedure A_GridAllFontExecute(Sender: TObject);
    procedure A_GridAllFontUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function FindItemsInCurrFiltr( DS: TDataSet; const ScanData: String): Boolean;
    procedure FormDestroy(Sender: TObject);
    /// Сохранение парамметров грида в базу
    Procedure DBGridToBase( Grid: TDBGridEh; const FormClass, GridName: String );
    /// Чтение параметров грида из базы
    Procedure BaseToDBGrid( Grid: TDBGridEh; const FormClass, GridName: String );
    procedure A_FiltrShowParam( Dlg: TObject; DlgID: Integer );
    function GetLandSpravValue(ID: Integer): String;
    function GetMailTemplateSpravValue(ID: Integer): String;
    procedure GridSortMarkingChanged(Sender: TObject);
    procedure A_ShowOfStartExecute(Sender: TObject);
    procedure OpenDataSetOfStartForm;
    procedure A_ToolBarSetupExecute(Sender: TObject);
    procedure SetFirmDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
    procedure SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
	private
    { Private declarations }
    procedure SelfRecordCount(RecNo, RecCount: Integer);
    procedure GridFontAssign(Grid: TDBGridEh; Font: TFont);
    function SaveGridParamsToBase(UserID, RowHeight, Frozen: Integer; const FormClass, GridName, GridValue: String): Boolean;
    procedure SetRightOfUpdate(Query: TpFIBDataSet; CheckIsSelf: TOnCheckIsSelfRecord);
    function LoadGridParamsFromBase(UserID: Integer; const FormClass, GridName: String; var RowHeight, Frozen: Integer;
      var GridValue: String): Boolean;
    function GetShowFiltr( DlgID: Integer; Act: TAction ): Boolean;
    procedure SetActionEnabled( var Message: TMessage ); message CM_SetActionEnabled;
	public
		{ Public declarations }
    IsScroll: Boolean;
		UserRightType: TUserRightTypes;
    LastFiltrParam: TRowsList;
    FiltrCaption: String;
		FormCaption: String;
		IsWriteRight: Boolean;
		CurrentField: String;
		HostSqlText: String;
    CurrDlgAct: TAction;

    function ShowEditDialog( Sender: TObject; DialogEdit: TDialogEdit; Query: TpFIBDataSet; const PrKeyName: string; DlgID, ID: Integer; DlgType: TStateDlg; Act: TAction;
                              DlgEvent: TOnEditDialogEvent; InputParams: array of TVarRec ): Boolean;
    function DeleteRecord(Sender: TForm; DS: TpFIBDataSet; ProcName, QuestTitle, ErrorTitle: String; KeyName,
      KeyValue: array of const): Boolean;
		procedure SB_RecordNumber(Grid: TDBGridEh);
		procedure ShowFormCaption;
		procedure CurrentDataSource(CurrGrid: TDBGridEh);
		procedure CurrentDSRecCount(CurrGrid: TDBGridEh; RecCount: Integer);
    procedure GetHistoryParams(var HistPrKey, UpdHistory, NewObjectCaption: string; var MaxParamLength: Integer ); virtual;
    function  SkipHistoryParams( const ParamName: string ): Boolean; virtual;
    function SetRelativePath(const HtmlText: String): String;
	end;

  procedure ReOpenDataSet( DS: TDataSet );

implementation

uses
  Prima, DBCtrlsEh, StdCtrls, Procs, Math,DBCtrls, HelpIntfs, ClientDM, SaveGridParam,
  FiltrDlg, GridSetup, SqlTools, RegSmartDlg, CustomSprav, ImportFromWWW, GridDlg,
  ClientsList, FirmList;

{$R *.dfm}

  {  функции  }
procedure ReOpenDataSet( DS: TDataSet );
var
Curr: TBookmark;
begin
  If not DS.Active then
    DS.Open
  else begin
		DS.DisableControls;
		Curr := DS.GetBookmark;
		try
			DS.Close;
			DS.Open;
			If Assigned( Curr ) and DS.BookmarkValid( Curr ) then
				 DS.GotoBookmark( Curr );
		finally
			If Assigned( Curr ) then
				 DS.FreeBookmark( Curr );
     DS.EnableControls;
		end;
  end;
end;

  { TFrMoldForm }

procedure TfrCustomForm.A_CloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrCustomForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormDeactivate(Self);

  if Self.FormStyle = fsNormal then
    if frPrima.MDIChildCount > 0 then
      TfrCustomForm( frPrima.ActiveMDIChild ).FormActivate( nil );

  If Self.FormStyle = fsMDIChild then
    Action := caFree
  else
    Action := caHide;
end;

procedure TfrCustomForm.DataSetAfterScroll( DataSet: TDataSet );
var
DS: TpFIBDataSet;
begin
  if not ( ActiveControl is TDBGridEh ) then
    Exit;
  DS := TpFIBDataSet(( ActiveControl as TDBGridEh ).DataSource.DataSet );
  If not DS.Active then
    Exit;
  frPrima.SBRecordCount( DS.RecNo, 0 );
end;

procedure TfrCustomForm.dbGridEnter(Sender: TObject);
var
DS: TDataSet;
begin
  if not ( Sender is TDBGridEh ) then
    Exit;
  DS := ( Sender as TDBGridEh ).DataSource.DataSet;
  If not DS.Active then
    Exit;
	Self.CurrentDataSource( Sender as TDBGridEh );
	Screen.Cursor := crDefault;
end;

procedure TfrCustomForm.A_AutoWidthExecute(Sender: TObject);
var
CurrGrid: TDBGridEh;
begin
  CurrGrid := CurrentGrid;
  If ( CurrentGrid = nil ) then
    Exit;
  CurrGrid.DisableAlign;
  try
    CurrGrid.AutoFitColWidths := not A_AutoWidth.Checked;
  finally
    CurrGrid.EnableAlign;
  end;
end;

procedure TfrCustomForm.A_AutoWidthUpdate(Sender: TObject);
var
CurrGrid: TDBGridEh;
begin
  CurrGrid := CurrentGrid;
  If Assigned( CurrGrid ) then
     A_AutoWidth.Checked := CurrGrid.AutoFitColWidths;
end;

procedure TfrCustomForm.A_LeftExecute(Sender: TObject);
begin
  If ( CurrentField = '' ) then
    GetCurrentField;
  If ( CurrentGrid <> nil ) and ( CurrentField <> '' ) then begin
    CurrentGrid[ CurrentField ].Alignment := taLeftJustify;
    GridCellClick( CurrentGrid[ CurrentField ] );
  end;
end;

procedure TfrCustomForm.A_RightExecute(Sender: TObject);
begin
  If ( CurrentField = '' ) then
    GetCurrentField;
  If ( CurrentGrid <> nil ) and ( CurrentField <> '' ) then begin
    CurrentGrid[ CurrentField ].Alignment := taRightJustify;
    GridCellClick( CurrentGrid[ CurrentField ] );
  end;
end;

function TfrCustomForm.LoadGridParamsFromBase(UserID: Integer; const FormClass, GridName: String; var RowHeight, Frozen: Integer; var GridValue: String ): Boolean;
const
sqlGrid =
'select' + #13#10 +
'  GRID_VALUE, FROZEN_COLS, ROW_HEIGHT' + #13#10 +
'from GRID_PARAMS' + #13#10 +
'where' + #13#10 +
'  USER_LIST_ID = :USER_LIST_ID and' + #13#10 +
'  FORM_CLASS = :FORM_CLASS and' + #13#10 +
'  GRID_NAME = :GRID_NAME';

var
Query: TNewQuery;
begin
  Result := False;
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := sqlGrid;
    If not Query.Prepared then
      Query.Prepare;

    Query.ParamByName( 'USER_LIST_ID' ).AsInteger := UserID;
    Query.ParamByName( 'FORM_CLASS' ).AsString := FormClass;
    Query.ParamByName( 'GRID_NAME' ).AsString := GridName;

    try
      Query.ExecQuery;
    except
      Raise;
    end;

    Result := not ( Query.Bof and Query.Eof );

    Frozen := Query.FieldByName( 'FROZEN_COLS' ).AsInteger;
    RowHeight := Query.FieldByName( 'ROW_HEIGHT' ).AsInteger;
    GridValue := Query.FieldByName( 'GRID_VALUE' ).AsString;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomForm.BaseToDBGrid(Grid: TDBGridEh; const FormClass, GridName: String);
var
ParValue: TStringStream;
GridValue: String;
RowHeight, Frozen: Integer;
begin
  ParValue := TStringStream.Create;
  try
    If not LoadGridParamsFromBase( CurrentUserID, FormClass, GridName, RowHeight, Frozen, GridValue ) then
      Exit;;

    Grid.FrozenCols := Frozen;
    Grid.RowHeight := RowHeight;

    ParValue.WriteString( GridValue );
    StreemToDBGrid( Grid, ParValue );
  finally
    ParValue.Free;
  end;
end;

function TfrCustomForm.SaveGridParamsToBase(UserID, RowHeight, Frozen: Integer; const FormClass, GridName, GridValue: String): Boolean;
const
sqlGrid =
'update or insert into GRID_PARAMS (' + #13#10 +
'    USER_LIST_ID, FORM_CLASS, GRID_NAME, GRID_VALUE, FROZEN_COLS, ROW_HEIGHT )' + #13#10 +
'  values (' + #13#10 +
'    :USER_LIST_ID, :FORM_CLASS, :GRID_NAME, :GRID_VALUE, :FROZEN_COLS, :ROW_HEIGHT )' + #13#10 +
'  matching (' + #13#10 +
'    USER_LIST_ID, FORM_CLASS, GRID_NAME )';

var
Query: TNewQuery;
begin
  Result := False;
  Query := TNewQuery.CreateNew( Self, frDM.IBTrGridSave );
  try
    Query.SQL.Text := sqlGrid;

      Query.ParamByName( 'USER_LIST_ID' ).AsInteger := UserID;
      Query.ParamByName( 'FORM_CLASS' ).AsString := FormClass;
      Query.ParamByName( 'GRID_NAME' ).AsString := GridName;
      Query.ParamByName( 'ROW_HEIGHT' ).AsInteger := RowHeight;
      Query.ParamByName( 'FROZEN_COLS' ).AsInteger := Frozen;
      Query.ParamByName( 'GRID_VALUE' ).AsString := GridValue;
    try
      Query.ExecQuery;
      Result := True;
    except
      Raise;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomForm.DBGridToBase(Grid: TDBGridEh; const FormClass, GridName: String);
var
ParValue: TStringStream;
RowHeight, Frozen: Integer;
begin
  ParValue := TStringStream.Create;
  try
    DBGridToStreem( Grid, ParValue, RowHeight, Frozen );

    SaveGridParamsToBase(
      CurrentUserID, RowHeight, Frozen, FormClass, GridName, ParValue.DataString );
  finally
    ParValue.Free;
  end;
end;

procedure TfrCustomForm.A_CentrExecute(Sender: TObject);
var
CurrGrid: TDBGridEh;
begin
  If ( CurrentField = '' ) then
    GetCurrentField;
  CurrGrid := CurrentGrid;

  If Assigned( CurrGrid ) and ( CurrentField <> '' ) then begin
    CurrGrid[ CurrentField ].Alignment := taCenter;
    GridCellClick( CurrGrid[ CurrentField ] );
  end;   
end;

procedure TfrCustomForm.A_FiltrClearExecute(Sender: TObject);
begin
  if not Assigned( A_Filtr.FiltredQuery ) then
    Exit;
  try
    A_Filtr.FiltrClear := True;
    try
      With TpFIBDataSet( A_Filtr.FiltredQuery ) do begin
        Close;
        SelectSQL.Clear;
        SelectSQL.Text := HostSqlText;
      end;
      LastFiltrParam.Clear;
    finally
      FiltrCaption := '';
      ShowFormCaption;
  		A_FiltrExecute( A_Filtr );
      A_FiltrClear.Enabled := False;
    end;
  finally
    A_Filtr.FiltrClear := False;
  end;
end;

procedure TfrCustomForm.TmEnabledTimer(Sender: TObject);
begin
  TmEnabled.Enabled := False;

  CurrDlgAct.Enabled := True;
  CurrDlgAct.Tag := 0;
end;

procedure TfrCustomForm.A_FiltrExecute(Sender: TObject);
var
FormDLG: TFrFiltrDlg;
begin
  if not ( A_Filtr.Enabled and A_Filtr.Visible and ( A_Filtr.Tag = 0 )) then
    Exit;

  A_Filtr.Enabled := False;
  A_Filtr.Tag := -1;
	FormDLG := TFrFiltrDlg.Create( Self );
  try
    With FormDLG do
      try
        OwnerForm := Self;
        FormDLG.SmartDlg.TypeDialog := isFiltr;
        dlgFillRows.OnFilterGetHistory := A_FiltrShowParam;
        dlgFillRows.DlgIdent := A_Filtr.DlgIdent;
        dlgFillRows.PrimaryKeyValue := -1;

        FiltrDataSet := TpFIBDataSet( A_Filtr.FiltredQuery );

        if Assigned( A_Filtr.OnBeforeFillParams ) then
          A_Filtr.OnBeforeFillParams( FormDLG, A_Filtr.DlgIdent );
        F_Caption := Self.FormCaption;

        dlgFillRows.FillDlgParams( A_Filtr.DlgIdent, [ -1, -1, -1, -1 ] );

        SQL_FiltrText := Self.HostSqlText;
        F_Caption := Self.FormCaption;

        if Assigned( A_Filtr.OnSetDefaultValue ) then
          A_Filtr.OnSetDefaultValue( FormDLG );

        If ( A_Filtr.ShowDlg ) and
           ( not A_Filtr.FiltrClear ) then
          ShowModal
        else
          A_SaveExecute( FormDLG );

      finally
        FormDLG.Close;
        FormDLG.Release;
      end;
    if A_Filtr.SortingResult and
       Assigned( A_Filtr.DbGrid ) then
      GridSortMarkingChanged( A_Filtr.DbGrid );
  finally
    Application.ProcessMessages;
    PostMessage( Self.Handle, CM_SetActionEnabled, Integer( Pointer( A_Filtr )), 0 );
  end;
end;

procedure TfrCustomForm.A_FiltrShowParam( Dlg: TObject; DlgID: Integer );
var
CurrDlg: TSmartDlg;
FindProp, CurrProp: TPropertyItem;
N: Integer;

  procedure AddBetweenParam( Value: TPropertyItem; Ind: Integer );
  begin
    With CurrDlg.RowsList.Insert( Ind ) do begin
      Title := Value.Title;
      Style := Value.Style;
      TabsID := Value.TabsID;
      FieldName := Value.FieldName;
      RowValue := Value.RowValue;
      OldValue := Value.RowValue;
      RowValueID := Value.RowValueID;
      CheckListID := Value.CheckListID;
      IsBetweenFiltr := Value.IsBetweenFiltr;
      NoBetweenFiltr := Value.NoBetweenFiltr;
      ShowAsReadOnly := Value.ShowAsReadOnly;
      SheetID := CurrProp.SheetID;
      SheetTitle := CurrProp.SheetTitle;
    end;
  end;

  procedure AssignLastFiltrParam( NewProp: TPropertyItem );
  begin
    FindProp.Title := NewProp.Title;
    FindProp.Style := NewProp.Style;
    FindProp.TabsID := NewProp.TabsID;
    FindProp.FieldName := NewProp.FieldName;
    FindProp.RowValue := NewProp.RowValue;
    FindProp.OldValue := NewProp.RowValue;
    FindProp.RowValueID := NewProp.RowValueID;
    FindProp.CheckListID := NewProp.CheckListID;
    FindProp.IsBetweenFiltr := NewProp.IsBetweenFiltr;
    FindProp.NoBetweenFiltr := NewProp.NoBetweenFiltr;
    FindProp.ShowAsReadOnly := NewProp.ShowAsReadOnly;
    FindProp.SheetID := NewProp.SheetID;
    FindProp.SheetTitle := NewProp.SheetTitle;

    if FindProp.IsBetweenFiltr then begin
      AddBetweenParam( LastFiltrParam.Items[ N + 1 ], FindProp.Index + 1 );
      AddBetweenParam( LastFiltrParam.Items[ N + 2 ], FindProp.Index + 2 );
    end;
  end;

begin
  if not ( Dlg is TSmartDlg ) then
    Exit;
  CurrDlg := Dlg as TSmartDlg;

  for N := 0 to LastFiltrParam.Count - 1 do begin
    CurrProp := LastFiltrParam.Items[ N ];
    if CurrProp.FieldName = '' then
      Continue;

    FindProp := CurrDlg.RowsList.PropByHostFieldName( CurrProp.FieldName );

    if Assigned( FindProp ) then begin
      AssignLastFiltrParam( CurrProp );
    end;
  end;

  CurrDlg.RowsRefresh;
end;

procedure TfrCustomForm.A_FiltrAfterExecFiltr(Sender: TObject; const DialogIdent: Integer);
  procedure AddToFiltrParam( Value: TPropertyItem );
  begin
    With LastFiltrParam.Add do begin
      Title := Value.Title;
      Style := Value.Style;
      TabsID := Value.TabsID;
      FieldName := Value.FieldName;
      RowValue := Value.RowValue;
      OldValue := Value.RowValue;
      RowValueID := Value.RowValueID;
      CheckListID := Value.CheckListID;
      IsBetweenFiltr := Value.IsBetweenFiltr;
      NoBetweenFiltr := Value.NoBetweenFiltr;
      ShowAsReadOnly := Value.ShowAsReadOnly;
      SheetID := Value.SheetID;
      SheetTitle := Value.SheetTitle;
    end;
  end;

var
N: Integer;
Prop: TPropertyItem;
begin
 //  Сохранение последних значений фильтра
  With TfrFiltrDlg( Sender ) do begin
    Self.LastFiltrParam.Clear;

    for N := 0 to SmartDlg.RowsList.Count - 1 do begin
      Prop := SmartDlg.RowsList.Items[ N ];

      If (( Prop.Style = psHeader ) and ( not Prop.IsBetweenFiltr )) or
         ( Prop.FieldName = '' ) then
        Continue;

      if Prop.IsBetweenFiltr then begin
        AddToFiltrParam( Prop );
        AddToFiltrParam( SmartDlg.RowsList.Items[ N + 1 ] );
        AddToFiltrParam( SmartDlg.RowsList.Items[ N + 2 ] );
      end
      else
      if Prop.RowValue <> '' then begin
        AddToFiltrParam( Prop );
      end;
    end;
  end;
end;

procedure TfrCustomForm.GridSortMarkingChanged(Sender: TObject);
var
FieldList: TStringList;
DS: TpFIBDataSet;
SortGrid: TDBGridEh;
ArrOrding: array of boolean;
N: Integer;
Sort: Boolean;
F_Name: String;
begin
  If Sender is TDBGridEh then
     SortGrid := TDBGridEh( Sender )
  else
     SortGrid := CurrentGrid;

  If ( SortGrid = nil ) then
    Exit;
  Sort := False;
  FieldList := TStringList.Create;
  try
    For N := 0 to SortGrid.SortMarkedColumns.Count - 1 do begin
      Case SortGrid.SortMarkedColumns[ N ].Title.SortMarker of
        smUpEh:
          Sort := True;
        smDownEh:
          Sort := False;
      end;

      SetLength( ArrOrding, N + 1 );
      F_Name := SortGrid.SortMarkedColumns[ N ].FieldName;
      FieldList.Append( F_Name );
      ArrOrding[ N ] := Sort;
    end;
    DS := TpFIBDataSet(SortGrid.DataSource.DataSet);
    If Assigned( DS ) then
      try
        If not DS.Active then
          Exit;
        Screen.Cursor := crSQLWait;
        DS.DisableControls;
        If FieldList.Count > 0 then
          DS.DoSortEx( FieldList, ArrOrding );
      finally
        Screen.Cursor := crDefault;
        DS.EnableControls;
      end;
  finally
    FieldList.Free;
  end;
end;

procedure TfrCustomForm.GridFontAssign( Grid: TDBGridEh; Font: TFont );
var
N: Integer;
begin
  if not Assigned( Grid ) then
                            Exit;
  Grid.Font := Font;
  for N := 0 to Grid.Columns.Count - 1 do
    Grid.Columns[ N ].Font := Font;
end;

procedure TfrCustomForm.A_FontExecute(Sender: TObject);
var
CurrGrid: TDBGridEh;
begin
  FontD.Tag := 100;
  CurrGrid := CurrentGrid;

  If Assigned( CurrGrid ) and ( CurrentField <> '' ) and
     Assigned( CurrGrid[ CurrentField ] ) then begin
    FontD.Font := CurrGrid[ CurrentField ].Font;
    if FontD.Execute then
      CurrGrid[ CurrentField ].Font := FontD.Font;
  end;
end;

procedure TfrCustomForm.A_FontUpdate(Sender: TObject);
begin
  A_Font.Enabled := ( ActiveControl is TDBGridEh );
end;

procedure TfrCustomForm.FontDApply(Sender: TObject; Wnd: HWND);
begin
  if not ( ActiveControl is TDBGridEh ) then
    Exit;
  if not ( Sender is TFontDialog ) then
    Exit;
  case TFontDialog( Sender ).Tag of
    100: If ( CurrentGrid <> nil ) and ( CurrentField <> '' )  then
           CurrentGrid[ CurrentField ].Font := FontD.Font;
    200: If ( CurrentGrid <> nil ) then
           GridFontAssign( CurrentGrid, FontD.Font );
  end;                                  
end;

procedure TfrCustomForm.SetAccessRight(const ActName: String);
begin
  UserRightType := [];
  With frDM do begin
    UserRightType := SetFuncWriteRight;
    SetFuncRightAccess( Self, ActName );  // права на объекты и их изменение
  end;
end;

function TfrCustomForm.SetAccessRightOfRows( DS: TpFIBDataSet; Const ConditionValue: String ): Boolean;
begin
  Result := True;
  if not DS.Prepared then
    DS.Prepare;

  DS.Conditions.Clear;
  DS.Conditions.Apply;
  if isAllShow in UserRightType then
    Exit;
  if ( isSelfShow in UserRightType ) then begin
    If ( ConditionValue <> '' ) then begin
      DS.Conditions.AddCondition( 'IsSelfShow', ConditionValue, True );
      DS.Conditions.Apply;
    end;
  end
  else begin
    MessageBox( Self.Handle, 'Нет прав на доступ к данным!', 'Доступ к данным',
                MB_APPLMODAL or MB_OK or MB_ICONINFORMATION );
    Result := False;
  end;
end;

procedure TfrCustomForm.SetActionEnabled(var Message: TMessage);
var
Act, ExecAct: TAction;
begin
  Act := TAction( Pointer( Message.WParam ));
  if Assigned( Act ) then begin
    Act.Tag := 0;
    Act.Enabled := True;
  end;

  Application.ProcessMessages;

  if Message.LParam <> 0 then begin
    ExecAct := TAction( Pointer( Message.LParam ));
    if Assigned( ExecAct ) and
       Assigned( ExecAct.OnExecute ) then begin
      ExecAct.OnExecute( ExecAct );
    end;
  end;
end;

procedure TfrCustomForm.SetFontToDBEditList( NewFont: TFont );
var
N: Integer;
begin
  For N := 0 to Self.ComponentCount - 1 do
    If Self.Components[ N ] is TDBEditEh then
      ( Self.Components[ N ] as TDBEditEh ).Font.Assign( NewFont );
end;

procedure TfrCustomForm.GridCellClick(Column: TColumnEh);
  function GetAlignColumn: Boolean;
  begin
    Result := False;
    If not Column.Grid.DataSource.DataSet.Active then
      Exit;
    If Column.Grid.DataSource.DataSet.IsEmpty then
      Exit;

    try
      Case Column.Alignment of
        taLeftJustify: begin
         A_Left.Checked := True;
         A_Right.Checked := False;
         A_Centr.Checked := False;
        end;
        taRightJustify: begin
         A_Left.Checked := False;
         A_Right.Checked := True;
         A_Centr.Checked := False;
        end;
        taCenter: begin
         A_Left.Checked := False;
         A_Right.Checked := False;
         A_Centr.Checked := True;
        end;
      end;
      Result := True;
    except
       A_Left.Checked := True;
       A_Right.Checked := False;
       A_Centr.Checked := False;
    end;
  end;
begin
  If not Assigned( Column ) then
    Exit;
  CurrentField := Column.FieldName;
  If ( CurrentGrid <> nil ) and ( CurrentField > '' ) then begin
    A_Left.Enabled := True;
    A_Right.Enabled := True;
    A_Centr.Enabled := True;
    A_Font.Enabled := True;
    A_Frozen.Enabled := True;
    A_Frozen.Checked := CurrentGrid.FrozenCols > 0;
    A_AutoWidth.Enabled := True;

    If GetAlignColumn then
      FrPrima.SB.Panels[ 2 ].Text := Column.Title.Caption
    else
      FrPrima.SB.Panels[ 2 ].Text := '';
  end
  else begin
    A_Left.Enabled := False;
    A_Right.Enabled := False;
    A_Centr.Enabled := False;
    A_Font.Enabled := False;
    A_Frozen.Enabled := False;
    A_AutoWidth.Enabled := False;
    FrPrima.SB.Panels[ 2 ].Text := '';
  end;
end;

procedure TfrCustomForm.GetCurrentField;
begin
  try
    If ( CurrentGrid <> nil ) and ( CurrentGrid.Columns.Count > 0 ) then
      GridCellClick( CurrentGrid.Columns[ 0 ] )
    else
      CurrentField := '';
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrCustomForm.GetHistoryParams(var HistPrKey, UpdHistory, NewObjectCaption: string; var MaxParamLength: Integer );
begin
  HistPrKey  := '';
  UpdHistory := '';
  NewObjectCaption := 'Новый объект';
  MaxParamLength := -1;
end;

Function TfrCustomForm.CurrentGrid: TDBGridEh;
begin
  try
    Result := nil;
    If ( Self.ActiveControl is TDBGridEh ) then
      Result := TDBGridEh( Self.ActiveControl )
    else
      Result := nil;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrCustomForm.ExportGridToExcel(CurrGrid: TDBGridEh );
//var
//Excel : TExcelLink;
//N: Integer;
begin
//	Excel := TExcelLink.Create( Self );
//	try
//		Excel.DataSet := TpFIBClientDataSet( CurrGrid.DataSource.DataSet );
//		For N := 0 to CurrGrid.VisibleColumns.Count - 1 do begin
//			If AnsiSameText( CurrGrid.VisibleColumns.Items[ N ].FieldName, 'OBJECT_STATUS' ) then
//																																													Continue;
//			With Excel.Columns.Add do begin
//				Field_Name := CurrGrid.VisibleColumns.Items[ N ].FieldName;
//				Field_Caption := CurrGrid.VisibleColumns.Items[ N ].Title.Caption;
//
//				If CurrGrid.VisibleColumns.Items[ N ].Checkboxes then
//					DateTypeColumn := xl_Boolean
//																												 else
//					case CurrGrid.FieldColumns[ Field_Name ].Field.DataType of
//						ftSmallint, ftInteger:
//							DateTypeColumn := xl_Integer;
//						ftFloat, ftCurrency, ftBCD:
//							case TpFIBClientBCDField( CurrGrid.FieldColumns[ Field_Name ].Field ).AsBCD.Precision of
//								2:  DateTypeColumn := xl_NumericScale2;
//								else
//										DateTypeColumn := xl_NumericScale4;
//							end;
//						ftDate:
//							DateTypeColumn := xl_ShortDate;
//						ftDateTime:
//							DateTypeColumn := xl_DateTime;
//						ftTime:
//							DateTypeColumn := xl_ShortTime;
//						else
//							DateTypeColumn := xl_Public;
//					end;
//
//				case DateTypeColumn of
//					xl_NumericScale4, xl_NumericScale2, xl_Integer, xl_ShortDate, xl_DateTime, xl_ShortTime:
//						Field_Size := 10;
//					else
//						Field_Size := 50;
//				end;
//
//				ShowSumm := DateTypeColumn in [ xl_NumericScale4, xl_NumericScale2, xl_Integer ];
//			end;
//		end;
//		Excel.ExportExecute;
//	finally
//		Excel.Free;
//	end;
end;

procedure TfrCustomForm.A_FrozenExecute(Sender: TObject);
var
DBG: TDBGridEh;
CurrRec: TBookmark;
IndField: Integer;
begin
  try
    DBG := CurrentGrid;
    If ( DBG = nil ) or ( CurrentField = '' ) then
      Exit;
    DBG.DataSource.DataSet.DisableControls;
    CurrRec := DBG.DataSource.DataSet.GetBookmark;
  except
    raise;
    DBG.DataSource.DataSet.FreeBookmark( CurrRec );
  end;
  try
    If ( not A_Frozen.Checked ) and
       ( CurrentField > '' ) and
       ( DBG[ CurrentField ].Index > -1 ) then begin
      IndField := DBG[ CurrentField ].Index;
      
      If IndField + 1 >= DBG.VisibleColumns.Count then
        raise exception.Create( 'Нельзя фиксировать столько много!!!' );

      try
        DBG.FrozenCols := IndField + 1;
      except
        DBG.FrozenCols := 0;
        raise;
      end;
      A_Frozen.Checked := not A_Frozen.Checked;
      A_Frozen.Hint := 'Закреплено поле: "' + DBG[ CurrentField ].Title.Caption + '"';
    end
                                               else
      If A_Frozen.Checked then begin
        DBG.FrozenCols := 0;
        A_Frozen.Checked := not A_Frozen.Checked;
        A_Frozen.Hint := 'Закрепить текущую колонку';
      end;
    If DBG.DataSource.DataSet.BookmarkValid( CurrRec ) then
       DBG.DataSource.DataSet.GotoBookmark( CurrRec );
  finally
    Application.ProcessMessages;
    DBG.SelectedField := DBG[ CurrentField ].Field;
    DBG.SetFocus;
    DBG.DataSource.DataSet.Prior;
    DBG.DataSource.DataSet.Next;
    DBG.DataSource.DataSet.FreeBookmark( CurrRec );
    DBG.DataSource.DataSet.EnableControls;
  end;
end;

procedure TfrCustomForm.A_GridAllFontExecute(Sender: TObject);
begin
  FontD.Tag := 200;
  If ( CurrentGrid <> nil ) and
    FontD.Execute then
      GridFontAssign( CurrentGrid, FontD.Font );
end;

procedure TfrCustomForm.A_GridAllFontUpdate(Sender: TObject);
begin
  A_GridAllFont.Enabled := ( ActiveControl is TDBGridEh );
end;

procedure TfrCustomForm.GridColEnter(Sender: TObject);
var
Gr: TDBGridEh;
begin
  If Sender is TDBGridEh then begin
    Gr := Sender as TDBGridEh;
    If ( Gr = nil ) or
       ( Gr.Columns.Count = 0 ) or
       ( Gr.SelectedField = nil ) then begin
      CurrentField := '';
      FrPrima.SB.Panels[ 2 ].Text := '';
      Exit;
    end;
    CurrentField := Gr.SelectedField.FieldName;
    GridCellClick( Gr[ CurrentField ]);
  end;
end;

procedure TfrCustomForm.GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol:
                                                       Integer; Column: TColumnEh; State: TGridDrawState);
var
Gr: TDBGridEh;
begin
  Gr := Column.Grid as TDBGridEh;
  If ( Gr.FrozenCols > DataCol ) then
    Column.Color := FrozedDefColor
  else
    Column.Color := clWindow;
  Gr.DefaultDrawColumnCell( Rect, DataCol, Column, State );
end;

procedure TfrCustomForm.AddColumnsGrid( DBG: TDBGridEh; FName, FTitle: String; FWidth: Integer; IsCheck, IsVisible: Boolean;
                                            var Ind: Integer; const Image: TImageList = nil; HintTitle: String = '';
                                            Orient: TTextOrientationEh = tohHorizontal );
var
IsImage: Boolean;
N: Integer;
Col: TColumnEh;
begin
  IsImage := Assigned( Image );
  Col := DBG.Columns.Add;

  Col.Width := FWidth;
  Col.Fieldname := FName;
  Col.Title.Caption := FTitle;
  Col.Title.Hint := HintTitle;
  Col.Checkboxes := IsCheck;
  If Col.Checkboxes then begin
    Col.KeyList.Clear;
    Col.KeyList.Append( '1' );
    Col.KeyList.Append( '0' );
    Col.PickList.Clear;
    Col.PickList.Append( '1' );
    Col.PickList.Append( '0' );
  end;
  If IsImage then begin
    Col.ImageList := Image;
    Col.KeyList.Clear;
    For N := 0 to Image.Count do
      Col.KeyList.Append( IntToStr( N ));
  end;

  Col.Title.TitleButton := True;
  Col.Title.ToolTips := True;
  Col.Title.EndEllipsis := True;
  Col.Title.Orientation := Orient;
  Col.ToolTips := True;
  Col.EndEllipsis := True;
  Col.Visible := IsVisible;

  Col.Index := Ind;

  DBG.Invalidate;
  Inc( Ind );
end;

procedure TfrCustomForm.FormShow(Sender: TObject);
begin
  GridColEnter( Self );
  If Self.FormStyle = fsNormal then
    With Application do begin
      Self.Height := ( MainForm.ClientHeight div 3 ) * 2;
      Self.Width  := ( MainForm.ClientWidth div 3 ) * 2;
    end;
end;

procedure TfrCustomForm.FormDeactivate(Sender: TObject);
begin
  If ( Self.FormStyle = fsMDIChild ) then
    FrPrima.ChildFormDeactivate( self );
end;

procedure TfrCustomForm.FormDestroy(Sender: TObject);
begin
  try
    if Assigned( LastFiltrParam ) then begin
      LastFiltrParam.Clear;
      LastFiltrParam.Free;
    end;
  except
    //
  end;
end;

procedure TfrCustomForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//
end;

procedure TfrCustomForm.FormCreate(Sender: TObject);
begin
  Self.Icon := Application.Icon;
  UserRightType := [];

  LastFiltrParam := TRowsList.Create( nil, TPropertyItem );
  LastFiltrParam.Clear;

  A_Help.Tag := 0;
  IsScroll := False;

  With Application do begin
    Self.Constraints.MinHeight := MainForm.ClientHeight div 3;
    Self.Constraints.MinWidth  := MainForm.ClientWidth div 3;
  end;  

	A_DsLocation.SetMenuArray( [ A_First, A_Prior, A_Next, A_Last ] );
	A_Align.SetMenuArray( [ A_FontOfList, FrPrima.A_Sp, A_Left, A_Centr, A_Right ]);
  A_FontOfList.SetMenuArray([ A_Font, A_GridAllFont ]);
end;

procedure TfrCustomForm.SB_RecordNumber( Grid: TDBGridEh );
var
DS: TDataSet;
begin
  SleepTM.Enabled := False;
  try
    Screen.Cursor := crSQLWait;
    If Assigned( Grid ) then begin
      DS := Grid.DataSource.DataSet;
      If not DS.Active then
        Exit;
      If fsModal in Self.FormState  then
        try
          SelfRecordCount( DS.RecNo, DS.RecordCount );
        except
          SelfRecordCount( 0, 0 );
        end
      else
        try
          FrPrima.SBRecordCount( DS.RecNo, DS.RecordCount );
        except
          FrPrima.SBRecordCount( 0, 0 );
        end;
    end
    else begin
      FrPrima.SBRecordCount( 0, 0 );
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrCustomForm.SelfRecordCount( RecNo, RecCount: Integer );
var
Ind: Integer;
begin
   If SB.Panels.Count < 2 then begin
     SB.Panels.Add.Width := 150;
     With SB.Panels.Add do begin
       Ind := Index;
       Alignment := taCenter;
     end;
   end
   else
     Ind := 1;

   If ( RecNo > 0 ) and ( RecCount = 0 ) then
     SB.Panels[ Ind ].Text := Format( '   %D', [ IntToStr( RecNo ) ])
   else
     SB.Panels[ Ind ].Text := Format( '   %D из %D записей', [ RecNo, RecCount ]);
end;

procedure TfrCustomForm.FindPopupMenuBtn(TB: TToolBar; PopupAction: TAction; BtnPM: TPopupMenu);
var
N: integer;
begin
  PopupAction.Visible := BtnPM.Items.Count > 0;
  If not PopupAction.Visible then
    Exit;
  For N := 0 to TB.ButtonCount - 1 do
    If TB.Buttons[ N ].Action = PopupAction then begin
      TB.Buttons[ N ].DropdownMenu := BtnPM;
      Break;
    end;
end;

procedure TfrCustomForm.ShowFormCaption;
begin
  With A_Filtr do
    If FiltrCaption > '' then
      Self.Caption := FormCaption + ' (' + FiltrCaption + ')'
    else begin
      Self.Caption := FormCaption;
    end;
end;

function TfrCustomForm.SkipHistoryParams( const ParamName: string ): Boolean;
begin
  Result := False;
end;

procedure TfrCustomForm.SleepTMTimer(Sender: TObject);
begin
  SB_RecordNumber( CurrentGrid );
end;

procedure TfrCustomForm.StopTimerBeforeScroll(DataSet: TDataSet);
begin
  inherited;
  If not ( DataSet.Bof or DataSet.Eof ) then
    SleepTM.Enabled := False;
end;

Procedure TfrCustomForm.CurrentDataSource( CurrGrid: TDBGridEh );
begin
  if not Assigned( CurrGrid ) then
    Exit;

  A_First.DataSource := CurrGrid.DataSource;
  A_Prior.DataSource := CurrGrid.DataSource;
  A_Next.DataSource := CurrGrid.DataSource;
  A_Last.DataSource := CurrGrid.DataSource;
  GridColEnter( CurrGrid );
  SB_RecordNumber( CurrGrid );
end;

Procedure TfrCustomForm.CurrentDSRecCount( CurrGrid: TDBGridEh; RecCount: Integer );
begin
  A_First.DataSource := CurrGrid.DataSource;
  A_Prior.DataSource := CurrGrid.DataSource;
  A_Next.DataSource := CurrGrid.DataSource;
  A_Last.DataSource := CurrGrid.DataSource;
  GridColEnter( CurrGrid );
  SB_RecordNumber( CurrGrid );
end;

procedure TfrCustomForm.GridSetup( CurrGrid: TDBGridEh );
begin
  If Assigned( CurrGrid ) then
    TFrGridSetup.ShowGridSetup( Self, CurrGrid );
end;

procedure TfrCustomForm.FormActivate(Sender: TObject);
begin
  // Is Empty
end;

procedure TfrCustomForm.A_PrintExecute(Sender: TObject);
begin
	PrintGrid( CurrentGrid, Self.Caption );
end;

procedure TfrCustomForm.A_PrintUpdate(Sender: TObject);
begin
  A_Print.Enabled := Self.ActiveControl is TDBGridEh;
end;

function TfrCustomForm.GetSelectionList(DBG: TDBGridEh; const PrKeyName: String; var SelectFiltr: String ): Boolean;
var
N: Integer;
DS: TDataSet;
BM: TBookmark;

  procedure ApendSelectFiltr( Value: String );
  begin
    If Value = '' then
      Exit;
    If SelectFiltr <> '' then
      SelectFiltr := SelectFiltr + ',';
    SelectFiltr := SelectFiltr + Value;
  end;

begin
  Result := False;
  SelectFiltr := '';
  If DBG.Selection.SelectionType in [ gstNon, gstColumns, gstAll ] then
    Exit;
  DS := DBG.DataSource.DataSet;
  If not DS.Active then
    Exit;
  DS.DisableControls;
  BM := DS.Bookmark;
  try
    case DBG.Selection.SelectionType of
      gstRecordBookmarks:
        For N := 0 to DBG.Selection.Rows.Count - 1 do begin
          DS.Bookmark := DBG.Selection.Rows[ N ];
          ApendSelectFiltr( DS.FieldByName( PrKeyName ).AsString );
        end;
      gstRectangle: begin
        DS.Bookmark := DBG.Selection.Rect.TopRow;
        While True do begin
          ApendSelectFiltr( DS.FieldByName( PrKeyName ).AsString );
          N := DS.CompareBookmarks( Pointer( DBG.Selection.Rect.BottomRow ), Pointer( DS.Bookmark ));
          If N = 0 then
            Break;
          DS.Next;
          if DS.Eof then
            Break;
          Application.ProcessMessages;
        end;

      end;
    end;
    If SelectFiltr > '' then begin
       SelectFiltr := Concat( '(', PrKeyName, ' in (', SelectFiltr, ')) ' );
       Result := True;
    end;
  finally
    DS.Bookmark := BM;
    DS.EnableControls;
    DBG.Selection.Clear;
  end;
end;

procedure TfrCustomForm.A_HelpExecute(Sender: TObject);
begin
  If ( Application.HelpFile = '' ) or ( Self.A_Help.Tag = 0 ) then
    Exit;
  WinHelp( Handle, PChar( Application.HelpFile ), HELP_CONTEXT, Self.A_Help.Tag );
end;

procedure TfrCustomForm.A_HostGridSetupExecute(Sender: TObject);
begin
  GridSetup( CurrentGrid );
end;

procedure TfrCustomForm.A_RefreshUpdate(Sender: TObject);
var
IsActive: Boolean;
begin
	IsActive := ActiveControl is TDBGridEh;
  If IsActive then
    IsActive :=
      ( CurrentGrid.DataSource.DataSet.Active ) and
      ( not CurrentGrid.DataSource.DataSet.IsEmpty );

  A_Refresh.Enabled := IsActive;
end;

procedure TfrCustomForm.A_RefreshExecute(Sender: TObject);
var
DS: TDataSet;
begin
  If not ( A_Refresh.Enabled and A_Refresh.Visible ) then
    Exit;
  DS := CurrentGrid.DataSource.DataSet;
  try
    if DS.Active then
      DS.Refresh;
  except
    A_RefreshFullExecute( Sender );
  end;
end;

procedure TfrCustomForm.A_RefreshFullExecute(Sender: TObject);
var
DS: TDataSet;
begin
  If not ( A_RefreshFull.Enabled and A_RefreshFull.Visible ) then
    Exit;
  DS := CurrentGrid.DataSource.DataSet;
  TpFIBDataSet( DS ).FullRefresh;
end;

procedure TfrCustomForm.A_RefreshFullUpdate(Sender: TObject);
begin
	A_RefreshFull.Enabled := ActiveControl is TDBGridEh;
end;

function TfrCustomForm.DeleteRecord( Sender: TForm; DS: TpFIBDataSet; ProcName, QuestTitle, ErrorTitle: String;
                        KeyName, KeyValue: array of const ): Boolean;
var
SP: TpFIBStoredProc;
Curr: TBookmark;
N: Integer;
CurrKeyName: String;
begin
  Result := False;
  Curr := nil;

  If High( KeyName ) <> High( KeyValue ) then begin
    raise Exception.Create( 'Ошибка в количестве параметров' );
    Exit;
  end;

  If ( QuestTitle > '' ) and ( MessageBox( Sender.Handle, PChar( QuestTitle ),
       PChar( Sender.Caption ), MB_YESNO or 4096 or MB_DEFBUTTON2 or  MB_ICONQUESTION) = IDNO ) then
    Exit;
  Screen.Cursor := crSQLWait;
  If Assigned( DS ) then begin
    DS.DisableControls;
    Curr := DS.GetBookmark;
  end;

  SP := TpFIBStoredProc.Create( nil );
  try
    If not frDM.IBTrWrite.InTransaction then
      frDM.IBTrWrite.StartTransaction;
    SP.Database := frDM.IBDB;
    SP.Transaction := frDM.IBTrWrite;
    SP.StoredProcName := ProcName;
    If not SP.Prepared then
      SP.Prepare;
    SP.ParamByName( 'ACTION_TYPE' ).AsString := 'DEL';
		For N := 0 to High( KeyValue ) do begin
      CurrKeyName := String( PChar( KeyName[ N ].VUnicodeString ));
			Case KeyValue[ N ].VType of
				vtString, vtAnsiString:
          SP.ParamByName( CurrKeyName ).AsString := String( PChar( KeyValue[ N ].VUnicodeString ));
				vtInteger:
          SP.ParamByName( CurrKeyName ).AsInteger := KeyValue[ N ].VInteger;
				vtVariant:
          SP.ParamByName( CurrKeyName ).Value :=  KeyValue[ N ].vVariant^;
				else
					SP.ParamByName( String( KeyName[ N ].VPChar )).Value :=  KeyValue[ N ].vVariant^;
			end;
    end;

		try
      SP.ExecProc;
    except
      On E: Exception do
        If ( ErrorTitle <> '' ) and ( PosCase( 'of FOREIGN KEY constraint', E.Message, True ) > 0 ) then
          raise Exception.Create( ErrorTitle )
        else
          Raise;
		end;

		If frDM.IBTrWrite.InTransaction then
      frDM.IBTrWrite.Commit;
    Result := True;
    If Assigned( DS ) then begin
			If DS.Active then begin
			  If Assigned( Curr ) and DS.BookmarkValid( Curr ) then
				  DS.GotoBookmark( Curr );
        DS.CacheDelete;
      end;
		end;
  finally
    Screen.Cursor := crDefault;
    SP.Free;
    If Assigned( DS ) then begin
      DS.EnableControls;
      If Assigned( Curr ) then
        DS.FreeBookmark( Curr );
    end;
  end;
end;

function TfrCustomForm.FindItemsInCurrFiltr( DS: TDataSet; const ScanData: String ): Boolean;
var
Curr: TBookmark;
begin
  DS.DisableControls;
  Screen.Cursor := crSQLWait;
  try
    Curr := DS.GetBookmark;
    try
      DS.First;
      Result := DS.Locate( 'BAR_CODE', ScanData, []);
      if not Result then
        If Assigned( Curr ) and DS.BookmarkValid( Curr ) then
				  DS.GotoBookmark( Curr );
    finally
      If Assigned( Curr ) then
        DS.FreeBookmark( Curr );
    end;
  finally
    DS.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrCustomForm.PrintGrid(DBG: TDbGridEh; Title: String);
begin
  if Printer.Printers.Count = 0 then begin
    ShowMessage( 'Нет доступных принтеров' );
    Exit;
  end;
  try
    DBG.DataSource.DataSet.DisableControls;
		Screen.Cursor := crSQLWait;
    try
      PrintDBG.DBGridEh := DBG;
      PrintDBG.SetSubstitutes(['%[Today]', DateToStr(Now)]);
      PrintDBG.Title.Text := Title;
      If PrintDBG.PrinterSetupDialog then
        PrintDBG.Preview;
    except
      Raise;
    end;
  finally
    DBG.DataSource.DataSet.EnableControls;
    Screen.Cursor := crDefault;
	end;
end;

function TfrCustomForm.ShowEditDialog( Sender: TObject; DialogEdit: TDialogEdit; Query: TpFIBDataSet; const PrKeyName: string; DlgID, ID: Integer; DlgType: TStateDlg; Act: TAction;
                                        DlgEvent: TOnEditDialogEvent; InputParams: array of TVarRec ): Boolean;

var
IndList: TArrayInteger;
ValueList: TArrayVariant;
N: Integer;
begin
  Result := False;
  if not ( Act.Visible and Act.Enabled and ( Act.Tag = 0 )) then
    Exit;

  if Assigned( Query ) then
  	Query.Refresh;
  Act.Enabled := False;
  Act.Tag := -1;
  N := 0;
  while IsScroll do begin
    Inc( N );
    Sleep( 30 );
    Application.ProcessMessages;
    if N > 100 then
      Break;
  end;

  try
    try
      SetRightOfUpdate( Query, DlgEvent.OnCheckIsSelf );

      With DialogEdit.Create( TCustomForm( Sender )) do
        try
          OwnerForm := TForm( Sender );
          SetButtonActive( False, False );
          dlgFillRows.ActionType := DlgType;
          DlgIdent := DlgID;
          IsSpravEditor := Self is TFormIsSprav;

          SetEditAccess( '', IsWriteRight );

          Caption := Act.Caption;
          dlgFillRows.PrimaryKeyValue := ID;

          OnAddStoredParam := DlgEvent.OnAddStoredParam;
          OnAfterFillRow := DlgEvent.OnAfterFillRow;
          OnSmartDlgSetEditText := DlgEvent.OnSmartDlgSetEditText;
          OnFillAddDialogMenu := DlgEvent.OnFillAddDialogMenu;
          A_AddAction.OnExecute := DlgEvent.OnAddActionExecute;
          A_AddAction.Visible := Assigned( DlgEvent.OnAddActionExecute );
          A_AddAction_1.OnExecute := DlgEvent.OnAddActionExecute;
          A_AddAction_1.Visible := Assigned( DlgEvent.OnAddActionExecute );
          OnGetLookupFieldValue := DlgEvent.OnGetLookupFieldValue;
          OnSaveResult := DlgEvent.OnSaveResult;

          dlgFillRows.FillDlgParams( DlgIdent, InputParams );

          case DlgIdent of
            dlgClientsList, dlgFirmList: begin
              if not frPrima.A_RightRegInfo.Visible then begin
                SmartDlg.RowsList.PropByHostFieldNameAsReadOnly( 'DATE_REGISTR' );
                SmartDlg.RowsList.PropByHostFieldNameAsReadOnly( 'PERSONAL_TITLE' );
              end;
            end;
          end;

          ID := -1;
          If ShowModal = mrOK then begin
            try
              DlgType := dlgFillRows.ActionType;
              ID := IfThen( ResultID <> -1, ResultID, -10 );
              Application.ProcessMessages;
              if ( DlgType <> sdEdit ) and Assigned( Query ) then
                NewDataCacheInsert( Query, IndList, ValueList );
            finally
              Result := True;
            end;
          end;
        finally
          Release;
        end;
    finally
      Self.FormActivate( nil );
    end;

    if Assigned( Query ) then begin
      If ID <> -1 then begin
        Case DlgType of
          sdInsert, sdCopy:
            try
              Query.CacheInsert( IndList, ValueList );
            finally
              Query.Refresh;
            end;
          else
            Query.Refresh;
        end;
      end
      else
        Query.Refresh;
    end;
  finally
    Application.ProcessMessages;
    PostMessage( Self.Handle, CM_SetActionEnabled,
      Integer( Pointer( Act )), IfThen( Result and Assigned( DlgEvent.ExecActionAfterThis ),
        Integer( Pointer( DlgEvent.ExecActionAfterThis )), 0 ));
  end;
end;

procedure TfrCustomForm.SetRightOfUpdate( Query: TpFIBDataSet; CheckIsSelf: TOnCheckIsSelfRecord );
begin
  IsWriteRight := False;
  If isReadOnly in UserRightType then
    Exit
  else
  if isAllEdit in UserRightType then
    IsWriteRight := True
  else
  if isSelfEdit in UserRightType then begin
    if Assigned( CheckIsSelf ) then
      IsWriteRight := CheckIsSelf( Self, Query )
    else
      IsWriteRight := True;
  end;
end;

function TfrCustomForm.GetShowFiltr(DlgID: Integer; Act: TAction ): Boolean;
const
sqlShow =
'select' + #13#10 +
'  D.SHOW_SPRAV_FILTR, iif( S.SHOW_FILTR is null, 1, 0 ) as NO_RECORD, ' + #13#10 +
'  iif( D.SHOW_SPRAV_FILTR = 1 and coalesce( S.SHOW_FILTR, 0 ) = 1, 1, 0 ) as IS_SHOW' + #13#10 +
'from DIALOG D' + #13#10 +
'  left join SHOW_FILTR_OF_START S    on ( S.DIALOG_ID    = D.DIALOG_ID ) and' + #13#10 +
'                                        ( S.USER_LIST_ID = :USER_LIST_ID )' + #13#10 +
'where' + #13#10 +
'  D.DIALOG_ID = :DIALOG_ID';

var
Query: TNewQuery;
begin
  Result := False;
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := sqlShow;
    Query.ParamByName( 'DIALOG_ID' ).AsInteger := DlgID;
    Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
    try
      Query.ExecQuery;
      Result := ( Query.FieldByName( 'SHOW_SPRAV_FILTR' ).AsInteger = 1 ) and
                (( Query.FieldByName( 'IS_SHOW' ).AsInteger = 1 ) or ( Query.FieldByName( 'NO_RECORD' ).AsInteger = 1 ));
      if Assigned( Act ) then begin
        Act.Visible := Query.FieldByName( 'SHOW_SPRAV_FILTR' ).AsInteger = 1;
        Act.Checked := Result;
      end;
    except
      Raise;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomForm.OpenDataSetOfStartForm;
begin
  if GetShowFiltr( A_Filtr.DlgIdent, A_ShowOfStart ) then
    A_FiltrExecute( A_Filtr )
  else
    ReOpenDataSet( TpFIBDataSet( A_Filtr.FiltredQuery ));
end;

procedure TfrCustomForm.A_ShowOfStartExecute(Sender: TObject);
const
sqlShowUpdate =
'update or insert into SHOW_FILTR_OF_START (' + #13#10 +
'    DIALOG_ID, USER_LIST_ID, SHOW_FILTR)' + #13#10 +
'  values (:DIALOG_ID, :USER_LIST_ID, :SHOW_FILTR )' + #13#10 +
'  matching (' + #13#10 +
'    DIALOG_ID, USER_LIST_ID )';
var
Query: TNewQuery;
begin
  Query := TNewQuery.CreateNew( Self, frDM.IBTrWrite );
  try
    Query.SQL.Text := sqlShowUpdate;
    Query.ParamByName( 'DIALOG_ID' ).AsInteger := Self.A_Filtr.DlgIdent;
    Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
    Query.ParamByName( 'SHOW_FILTR' ).AsInteger := Integer( A_ShowOfStart.Checked );
    try
      Query.ExecQuery;
    except
      Raise;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrCustomForm.A_ToolBarSetupExecute(Sender: TObject);
begin
  if not ( A_ToolBarSetup.Visible and A_ToolBarSetup.Enabled ) then
    Exit;

  With frPrima do
    TfrToolBarSetup.ShowToolBarSetup( A_ToolBarSetup, Self, aTbTransact.Caption, ShowAssignToolBar( aTbTransact, True ));
end;

function TfrCustomForm.GetLandSpravValue( ID: Integer ): String;
const
sqlLand =
'select LAND_TITLE from LAND where LAND_ID = :ID';
var
Query: TNewQuery;
begin
  Result := '';
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := sqlLand;
    Query.ParamByName( 'ID' ).AsInteger := ID;
    try
      Query.ExecQuery;
      Result := Query.FieldByName( 'LAND_TITLE' ).AsString;
    except
      Raise;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

function TfrCustomForm.GetMailTemplateSpravValue( ID: Integer ): String;
const
sqlTemlate =
'select MAIL_TEMPLATE_TITLE from MAIL_TEMPLATE where MAIL_TEMPLATE_ID = :ID';
var
Query: TNewQuery;
begin
  Result := '';
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := sqlTemlate;
    Query.ParamByName( 'ID' ).AsInteger := ID;
    try
      Query.ExecQuery;
      Result := Query.FieldByName( 'MAIL_TEMPLATE_TITLE' ).AsString;
    except
      Raise;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

function TfrCustomForm.SetRelativePath( const HtmlText: String ): String;
var
Value, SubStr: String;
StartInd, EndInd: Integer;
begin
  Result := HtmlText;
  StartInd := 1;
  EndInd := 0;

  repeat
    Value := Copy( Result, StartInd, Length( Result ));
    StartInd := PosCase( 'file:///', Value, True );

    if StartInd = 0 then
      Break
    else
      EndInd := PosCase( 'images/', Copy( Value, StartInd, Length( Value )), True );

    if ( StartInd > 0 ) and ( EndInd > 0 ) then begin
      SubStr := Copy( Value, StartInd, EndInd - 1 );

      Result := StringReplace( Result, SubStr, '', [ rfReplaceAll, rfIgnoreCase ]);
    end;
  until ( StartInd = 0 );
end;

procedure TfrCustomForm.SmartDlgSetEditText( Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean );
var
NoPostProp, LegalProp, PostProp: TPropertyItem;
SmDlg: TCustomSmartDlg;
begin
  SmDlg := TCustomSmartDlg( Dlg );
  if AnsiSameText( CurrItem.FieldName, 'LEGAL_ADDRESS' ) then begin
    NoPostProp := SmDlg.RowsList.PropByHostFieldName( 'POST_ADDRESS_IS_LEGAL' );
    PostProp := SmDlg.RowsList.PropByHostFieldName( 'POST_ADDRESS' );
    if Assigned( NoPostProp ) and Assigned( PostProp ) then begin
      if NoPostProp.RowValueID = 1 then begin
        PostProp.RowValue := CurrItem.RowValue;
        PostProp.ShowAsReadOnly := True;
      end
      else begin
        PostProp.RowValue := PostProp.OldValue;
        PostProp.ShowAsReadOnly := False;
      end;
    end;
  end;

  if AnsiSameText( CurrItem.FieldName, 'POST_ADDRESS_IS_LEGAL' ) then begin
    LegalProp := SmDlg.RowsList.PropByHostFieldName( 'LEGAL_ADDRESS' );
    PostProp := SmDlg.RowsList.PropByHostFieldName( 'POST_ADDRESS' );
    if Assigned( PostProp ) and Assigned( LegalProp ) then begin
      if CurrItem.RowValueID = 1 then begin
        PostProp.RowValue := LegalProp.RowValue;
        PostProp.ShowAsReadOnly := True;
      end
      else begin
        PostProp.RowValue := PostProp.OldValue;
        PostProp.ShowAsReadOnly := False;
      end;
    end;
  end;
end;

procedure TfrCustomForm.SetFirmDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  With TfrRecordEdit( Sender ) do begin
    if dlgFillRows.ActionType <> sdInsert then
      Exit;
    case IndexOfStrArray( Item.FieldName, [ 'LAND_TITLE', 'DATE_REGISTR', 'PERSONAL_TITLE', 'POST_ADDRESS_IS_LEGAL' ]) of
      0: begin
        Item.RowValue := GetLandSpravValue( spLandRusValue );
        Item.RowValueID := spLandRusValue;  // Россия
      end;
      1: begin
        Item.RowValue := FormatDateTime( 'dd.mm.yyyy', Date );
        Item.RowValueID := -1;
      end;
      2: begin
        Item.RowValue := CurrentManagerTitle;
        Item.RowValueID := -1;
      end;
      3: begin
        SmartDlgSetEditText( SmartDlg, Item, True );
      end;
    end;
  end;
end;



end.


