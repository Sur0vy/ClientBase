{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit DlgSubscribeEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, mshtml,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RecordEdit, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, pFIBStoredProc,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ActnPopup, Vcl.ExtCtrls, DlgExecute, RegSmartDlg, AddActions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, GridDlg, Vcl.ComCtrls, DlgParams, Vcl.OleCtrls,
  SHDocVw, Vcl.StdCtrls, ConstList;

type
  TOnSaveHtmlTextToBase = procedure( IBTr: TpFIBTransaction; FileName, TextBody: String; PrKeyValue: Integer ) of Object;
  TOnImagesToBase = procedure( FileName: String; ImageID: Integer ) of Object;
  TOnSaveTemplateToTemp = procedure( var FileName: String; TempID: Integer ) of Object;

  TfrDlgSubscribeEdit = class(TfrRecordEdit)
    SpHtmlDlg: TSplitter;
    pnlHtml: TPanel;
    ActListHtml: TActionList;
    A_WbIsEdit: TAction;
    A_SaveToFile: TAction;
    A_OpenFromFile: TAction;
    A_FindOfPage: TAction;
    A_CutFromWB: TAction;
    A_CopyFromWB: TAction;
    A_PasteToWB: TAction;
    A_EditUndo: TAction;
    A_EditRedo: TAction;
    A_FontBold: TAction;
    A_FontItalic: TAction;
    A_FontStrike: TAction;
    A_FontUnderLine: TAction;
    A_Parleft: TAction;
    A_ParCenter: TAction;
    A_ParRight: TAction;
    A_ParJustifyFull: TAction;
    A_SimpleList: TAction;
    A_SmartList: TAction;
    A_Identleft: TAction;
    A_IdentRigth: TAction;
    A_CreateLink: TAction;
    A_InsertLine: TAction;
    A_InsertImage: TAction;
    A_FontBackColor: TAction;
    A_FontColor: TAction;
    A_InsBaseLabel: TAction;
    TmRefresh: TTimer;
    ppBaseLabel: TPopupMenu;
    ControlB: TControlBar;
    tlbSaveOpen: TToolBar;
    tbWbIsEdit: TToolButton;
    tbSpEdit: TToolButton;
    tbSaveToFile: TToolButton;
    tbSpFind: TToolButton;
    tbFindOfPage: TToolButton;
    tbSpCopyPaste: TToolButton;
    tbEditCut: TToolButton;
    tbEditCopy: TToolButton;
    tbEditPaste: TToolButton;
    tbSpUndo: TToolButton;
    tbEditUndo: TToolButton;
    tbEditRedo: TToolButton;
    tbSpLink: TToolButton;
    tbCreateLink: TToolButton;
    tbInsertLine: TToolButton;
    tbInsertImage: TToolButton;
    tbFontBackColor: TToolButton;
    tbFontColor: TToolButton;
    tbSpColor: TToolButton;
    cbFontSize: TComboBox;
    tlbFont: TToolBar;
    tbFontBold: TToolButton;
    tbFontItalic: TToolButton;
    tbFontStrike: TToolButton;
    tbFontUnderLine: TToolButton;
    tbSpFont: TToolButton;
    tbParleft: TToolButton;
    tbParCenter: TToolButton;
    tbParRight: TToolButton;
    tbParJustifyFull: TToolButton;
    tbParLocation: TToolButton;
    tbSimpleList: TToolButton;
    tbSmartList: TToolButton;
    tbList: TToolButton;
    tbIdentleft: TToolButton;
    tbIdentRight: TToolButton;
    tbSpIdent: TToolButton;
    cbParFormat: TComboBox;
    tbSpInsLabel: TToolButton;
    tbInsBaseLabel: TToolButton;
    WB: TWebBrowser;
    tbSpFontColor: TToolButton;
    A_AddAttach: TAction;
    ppMMBrowser: TPopupMenu;
    Web1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    bxAttach: TListBox;
    tbOpenFile: TToolButton;
    A_InsertHtmlImage: TAction;
    tbInsertHtmlImage: TToolButton;
    procedure SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
    procedure FormShow(Sender: TObject);
    procedure WBBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WBDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure A_CutFromWBExecute(Sender: TObject);
    procedure A_PasteToWBExecute(Sender: TObject);
    procedure A_EditUndoExecute(Sender: TObject);
    procedure A_CopyFromWBExecute(Sender: TObject);
    procedure A_ParleftExecute(Sender: TObject);
    procedure A_ParCenterExecute(Sender: TObject);
    procedure A_ParRightExecute(Sender: TObject);
    procedure A_ParJustifyFullExecute(Sender: TObject);
    procedure A_CreateLinkExecute(Sender: TObject);
    procedure A_InsertLineExecute(Sender: TObject);
    procedure A_InsertImageExecute(Sender: TObject);
    procedure A_InsBaseLabelExecute(Sender: TObject);
    procedure A_WbIsEditExecute(Sender: TObject);
    procedure A_SaveToFileExecute(Sender: TObject);
    procedure A_OpenFromFileExecute(Sender: TObject);
    procedure A_FindOfPageExecute(Sender: TObject);
    procedure A_SimpleListExecute(Sender: TObject);
    procedure A_SmartListExecute(Sender: TObject);
    procedure A_IdentleftExecute(Sender: TObject);
    procedure A_IdentRigthExecute(Sender: TObject);
    procedure A_FontBoldExecute(Sender: TObject);
    procedure A_FontItalicExecute(Sender: TObject);
    procedure A_FontStrikeExecute(Sender: TObject);
    procedure A_FontUnderLineExecute(Sender: TObject);
    procedure A_FontBackColorExecute(Sender: TObject);
    procedure A_FontColorExecute(Sender: TObject);
    procedure A_CopyFromWBUpdate(Sender: TObject);
    procedure A_CutFromWBUpdate(Sender: TObject);
    procedure A_EditRedoExecute(Sender: TObject);
    procedure A_EditRedoUpdate(Sender: TObject);
    procedure A_EditUndoUpdate(Sender: TObject);
    procedure A_FontBoldUpdate(Sender: TObject);
    procedure A_FontItalicUpdate(Sender: TObject);
    procedure A_FontStrikeUpdate(Sender: TObject);
    procedure A_FontUnderLineUpdate(Sender: TObject);
    procedure A_ParCenterUpdate(Sender: TObject);
    procedure A_ParJustifyFullUpdate(Sender: TObject);
    procedure A_ParRightUpdate(Sender: TObject);
    procedure A_PasteToWBUpdate(Sender: TObject);
    procedure A_SimpleListUpdate(Sender: TObject);
    procedure A_SmartListUpdate(Sender: TObject);
    procedure cbFontSizeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbFontSizeSelect(Sender: TObject);
    procedure cbParFormatSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ppInsBaseLabelClick(Sender: TObject);
    procedure TmRefreshTimer(Sender: TObject);
    procedure A_ParleftUpdate(Sender: TObject);
    procedure dlgFillRowsGetRowsListParam(Dlg: TObject; DlgID: Integer; InputParams: array of TVarRec; Rows: TRowsList);
    procedure SetEditAccess(const ActionName: String; IsWriteRight: Boolean ); override;
    procedure A_AddAttachExecute(Sender: TObject);
    procedure WMMouseActivate(var Msg: TMessage); message WM_MOUSEACTIVATE;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlHtmlMouseActivate(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
    procedure bxAttachKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure A_SaveExecute(Sender: TObject);override;
    procedure A_InsertHtmlImageExecute(Sender: TObject);
  private
    { Private declarations }
    IsOK: Boolean;
    AttachList: TStringList;
    procedure ButtonEnable(iDoc: IHtmlDocument2);
    function CanCopy: Boolean;
    function CanCut: Boolean;
    function CanPaste: Boolean;
    function CanRedo: Boolean;
    function CanUndo: Boolean;
    function CheckFontParam(const PropValue: String): Boolean;
    function ConvertColorToHtml(AColor: TColor): string;
    procedure ExecCommandInsertImages(Sender: TObject; Dlg: TSmartDlg);
    function GetControlRange: IHTMLControlRange;
    function GetTxtRange: IHTMLTxtRange;
    procedure SaveToHtmlFile(const FileName: String);
    procedure SetExecCommand(const ExecName: String; Value: OleVariant; const UserSetup: Boolean = False );
    procedure SetParFormat;
    procedure WaitIsBusy;
    procedure WBEditCaption;
    procedure FillBaseLabelList;
    procedure SaveHtmlToBase( Sender: TObject; DlgType: TStateDlg; ResultID: Integer; SP: TpFIBStoredProc; var NoClose: Boolean );
    procedure RefreshImagesList;
    procedure FillTemplateImagesList(ValueID: Integer; const sqlCheck, fldHostName, fldKeyName, fldTitleName: String );
    procedure FillTemplate( CurrItem: TPropertyItem );
    procedure SetWebBrowserIsEdit;
    procedure ClearClientList(CurrItem: TPropertyItem);
    procedure FillSubscribeSend(Sender: TObject; DlgType: TStateDlg; ResultID: Integer; SP: TpFIBStoredProc; var NoClose: Boolean);
    procedure LinkAttachmentFilesInMail( Sender: TObject; ResultID: Integer; Tr: TpFIBTransaction; var NoClose: Boolean );
    procedure InsertImagesInHtml( IsHtml: Boolean );
    procedure ExecCommandInsertHtmlImages(Sender: TObject; Dlg: TSmartDlg);
    procedure DlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
  public
    { Public declarations }
    hFileName: String;
    BodyText: String;
    OnSaveHtmlTextToBase: TOnSaveHtmlTextToBase;
    OnImagesToBase: TOnImagesToBase;
    OnSaveTemplateToTemp: TOnSaveTemplateToTemp;
  end;



implementation

{$R *.dfm}

uses
  Prima, ActiveX, CustomDlg, Procs, SubscribeJournal, SqlTools, ClientDM, Math;

const
sqlTempImageCheck =
'select' + #13#10 +
'  G.FILE_IMAGES_NAME, G.FILE_IMAGES_ID' + #13#10 +
'from FILE_IMAGES G, FILE_IMAGES_TEMPLATE_LINK L' + #13#10 +
'where' + #13#10 +
'  L.FILE_IMAGES_ID = G.FILE_IMAGES_ID and' + #13#10 +
'  L.MAIL_TEMPLATE_ID = :TEMPLATE_ID' + #13#10 +
'order by' + #13#10 +
'  1';

sqlEmailListCheck =
'select' + #13#10 +
'  G.E_MAIL, L.CLIENTS_MAIL_LIST_ID' + #13#10 +
'from SUBSCRIBE_GROUP_MAIL_LINK L, V_CLIENTS_MAIL_LIST G' + #13#10 +
'where' + #13#10 +
'  G.CLIENTS_MAIL_LIST_ID = L.CLIENTS_MAIL_LIST_ID and' + #13#10 +
'  L.SUBSCRIBE_GROUP_ID = :SUBSCRIBE_GROUP_ID' + #13#10 +
'order by' + #13#10 +
'  L.ORDER_BY';

function AddString( Str: String; IsCheck: Boolean ): String;
const
DelimStr: array [ Boolean ] of String = ( #44#160, #44 );
begin
  Result := '';
  If Str <> '' then
    Result := Concat( Str, DelimStr[ IsCheck ] );
end;

procedure TfrDlgSubscribeEdit.FillBaseLabelList;
const
sqlLabel =
'select' + #13#10 +
'  MAIL_BASE_LABEL_TITLE, MAIL_BASE_LABEL_NAME, MAIL_BASE_LABEL_ID' + #13#10 +
'from MAIL_BASE_LABEL' + #13#10 +
'where' + #13#10 +
'  IS_DELETE > 0 and IS_USE = 1' + #13#10 +
'order by' + #13#10 +
'  ORDER_BY';

var
Query: TNewQuery;
MItem: TMenuItem;
begin
  ppBaseLabel.Items.Clear;
  Screen.Cursor := crSQLWait;
  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := sqlLabel;
    if not Query.Prepared then
      Query.Prepare;
    try
      Query.ExecQuery;
    except
      raise;
    end;

    While not Query.Eof do begin
      MItem := TMenuItem.Create( Self );
      MItem.Name := 'mm' + Query.FieldByName( 'MAIL_BASE_LABEL_NAME' ).AsString;
      MItem.Caption := Query.FieldByName( 'MAIL_BASE_LABEL_TITLE' ).AsString;
      MItem.Tag := Query.FieldByName( 'MAIL_BASE_LABEL_ID' ).AsInteger;
      MItem.OnClick := ppInsBaseLabelClick;
      ppBaseLabel.Items.Add( MItem );

      Query.Next;
    end;
  finally
    Screen.Cursor := crDefault;
    Query.FreeAndCommit;
  end;
end;

procedure TfrDlgSubscribeEdit.pnlHtmlMouseActivate(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y,
  HitTest: Integer; var MouseActivate: TMouseActivate);
begin
  inherited;
  Self.ActiveControl := WB;
end;

procedure TfrDlgSubscribeEdit.ppInsBaseLabelClick(Sender: TObject);
var
Range: IHTMLTxtRange;
StrLabel: String;
begin
  Range := GetTxtRange;
  if not Assigned( Range ) then
    Exit;

  StrLabel := TMenuItem( Sender ).Name;
  StrLabel := Format( '####%S###', [ Copy( StrLabel, 3, Length( StrLabel ))]);
  Range.pasteHTML( StrLabel );
end;

procedure TfrDlgSubscribeEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned( AttachList ) then
    AttachList.Free;
end;

procedure TfrDlgSubscribeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  IsRepeat := True;
  IsOK := True;
  WB.Align := alClient;
  AttachList := TStringList.Create;
  AttachList.Clear;
  WBEditCaption;
  OnAfterExecuteProc := SaveHtmlToBase;
end;

procedure TfrDlgSubscribeEdit.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ( Shift = [ ssShift ]) and ( Key = VK_F10 ) then
    Key := 0;
end;

procedure TfrDlgSubscribeEdit.FormResize(Sender: TObject);
begin
  inherited;
  bxAttach.Width := ( Self.ClientWidth - tlbSaveOpen.Width ) div 2;
  bxAttach.Left := Self.ClientWidth - bxAttach.Width;
end;

procedure TfrDlgSubscribeEdit.FormShow(Sender: TObject);
var
Prop: TPropertyItem;
begin
  inherited;
  try
    Self.Height := ( Self.OwnerForm.ClientHeight div 10 ) * 8;
    SmartDlg.SetFormHeight( True );
    FillBaseLabelList;
    A_AddAttach.Visible := ( Self.OwnerForm is TfrSubscribeJournal ) and
                            A_Save.Visible;
    With frPrima do begin
      AddInMainMenu( nil, ppDialog, A_Save, [ A_Sp, A_AddAttach ]);
      AddActListInBar( aTbSmartDLG, A_Save, [ A_Sp, A_AddAttach ]);
    end;
    WB.Navigate2( hFileName );
    SetWebBrowserIsEdit;
  finally
    if dlgFillRows.ActionType = sdInsert then begin
      Prop := SmartDlg.RowsList.PropByName( 'MAIL_TEMPLATE_TITLE' );
      if Assigned( Prop ) then
        FillTemplate( Prop );
    end;
  end;
end;

procedure TfrDlgSubscribeEdit.SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
begin
  inherited;
  if not IsChange then
    Exit;
  FillTemplate( CurrItem );
  ClearClientList( CurrItem );
end;

procedure TfrDlgSubscribeEdit.FillTemplate( CurrItem: TPropertyItem );
begin
  if ( CurrItem.Style = psPickList ) and
       AnsiSameText(CurrItem.FieldName, 'MAIL_TEMPLATE_TITLE') then begin
    if Assigned( OnSaveTemplateToTemp ) then
      try
        if A_WbIsEdit.Checked then
          A_WbIsEditExecute( A_WbIsEdit );
        OnSaveTemplateToTemp( hFileName, CurrItem.RowValueID );
        FillTemplateImagesList( CurrItem.RowValueID, sqlTempImageCheck, 'TEMPLATE_ID', 'FILE_IMAGES_ID', 'FILE_IMAGES_NAME' );
        WB.Navigate2( hFileName );
      finally
        SetWebBrowserIsEdit;
      end;
  end;
end;

procedure TfrDlgSubscribeEdit.ClearClientList( CurrItem: TPropertyItem );
var
Prop: TPropertyItem;
Ind: Integer;
begin
  if ( CurrItem.Style = psPickListInput ) and
       AnsiSameText(CurrItem.FieldName, 'SUBSCRIBE_GROUP_TITLE') then begin
    Ind := SmartDlg.Editor.ListBox.Items.IndexOf( CurrItem.RowValue );

    if Ind = -1 then begin
      Prop := SmartDlg.RowsList.PropByName( 'CLIENTS_MAIL_LIST_ID' );
      if Assigned( Prop ) then begin
        Prop.RowValue := '';
        Prop.CheckListID := '';
        Prop.RowValueID := -1;
      end;
    end
    else
      FillTemplateImagesList( CurrItem.RowValueID, sqlEmailListCheck, 'SUBSCRIBE_GROUP_ID', 'CLIENTS_MAIL_LIST_ID', 'E_MAIL' );
  end;
end;

procedure TfrDlgSubscribeEdit.SetWebBrowserIsEdit;
var
iDoc: IHTMLDocument2;
begin
  iDoc := nil;
  while not (Assigned( iDoc ) and Assigned( iDoc.body )) do begin
    if not Assigned( WB.ControlInterface.Document ) then
      Exit;
    WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );
    Application.ProcessMessages;
  end;

  A_WbIsEdit.Checked := AnsiSameText( iDoc.designMode, 'on' );
  if not A_WbIsEdit.Checked then
    A_WbIsEditExecute( A_WbIsEdit );
end;

procedure TfrDlgSubscribeEdit.FillTemplateImagesList( ValueID: Integer; const sqlCheck, fldHostName, fldKeyName, fldTitleName: String );
var
Query: TNewQuery;
RowValue, CheckListID: String;
Prop: TPropertyItem;
begin
  RowValue := '';
  CheckListID := '';
  Prop := SmartDlg.RowsList.PropByNameStyle( fldKeyName, psMultySelect );
  if not Assigned( Prop ) then
    Exit;

  Query := TNewQuery.CreateNew( Self, nil );
  try
    Query.SQL.Text := sqlCheck;
    if not Query.Prepared then
      Query.Prepare;

    Query.ParamByName( fldHostName ).AsInteger := ValueID;

    try
      Query.ExecQuery;
    except
      Raise;
    end;
    while not Query.Eof do begin
      RowValue := AddString( RowValue, False );
      CheckListID := AddString( CheckListID, True );
      RowValue := RowValue + Query.FieldByName( fldTitleName ).AsString;
      CheckListID := CheckListID + Query.FieldByName( fldKeyName ).AsString;
      Query.Next;
    end;
  finally
    Query.FreeAndCommit;
  end;

  try
    Prop.RowValue := RowValue;
    Prop.CheckListID := CheckListID;
    Prop.RowValueID := ValueID;
  finally
    SmartDlg.Refresh;
  end;
end;

procedure TfrDlgSubscribeEdit.SetEditAccess(const ActionName: String; IsWriteRight: Boolean);
begin
  inherited;
  if ( DlgIdent = dlgSubscribeJournal ) and
     ( Self.OwnerForm is TfrSubscribeJournal ) and
     ( dlgFillRows.ActionType = sdEdit ) then begin
    A_Save.Visible := TfrSubscribeJournal( Self.OwnerForm ).Q_Host.FBN( 'IS_SEND' ).AsInteger = 0;

    A_WbIsEdit.Enabled := A_Save.Visible;
    A_OpenFromFile.Enabled := A_Save.Visible;
    SmartDlg.ReadOnly := not ( A_Save.Visible and A_Save.Enabled );
  end;

  if SmartDlg.ReadOnly then
  SetButtonActive( False, False );
end;

procedure TfrDlgSubscribeEdit.SetExecCommand( const ExecName: String; Value: OleVariant; const UserSetup: Boolean );
var
Range: IHTMLTxtRange;
begin
  Range := GetTxtRange;
  if not Assigned( Range ) then
    Exit;

  Range.execCommand( ExecName, UserSetup, emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_AddAttachExecute(Sender: TObject);
var
opdOpen: TOpenDialog;
begin
  inherited;
  if not ( A_AddAttach.Visible and A_AddAttach.Enabled ) then
    Exit;

  opdOpen := TOpenDialog.Create( Self );
  try
    opdOpen.Filter := 'Все файлы|*.*';
    If opdOpen.Execute then begin
      AttachList.Append( opdOpen.FileName );
      bxAttach.Items.Append( ExtractFileName( opdOpen.FileName ));
      bxAttach.Visible := True;
    end;
  finally
    opdOpen.Free;
  end;
end;

procedure TfrDlgSubscribeEdit.A_CopyFromWBExecute(Sender: TObject);
begin
  SetExecCommand( 'copy', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_CopyFromWBUpdate(Sender: TObject);
begin
  A_CopyFromWB.Enabled := CanCopy;
end;

procedure TfrDlgSubscribeEdit.A_CreateLinkExecute(Sender: TObject);
const
InsStr = ' target=_blank';
var
Range: IHTMLTxtRange;
LinkText: String;
StartInd, N: Integer;
begin
  Range := GetTxtRange;
  if not Assigned( Range ) then
    Exit;
  if Range.text = '' then
    Exit;

  Range.execCommand( 'CreateLink', True, EmptyParam );
  LinkText := range.htmlText;           //'<A href="http://www.*****.ru">текст ссылки</A>'
  try
    StartInd := PosCase( 'href="', LinkText, True );
    if StartInd <> 0 then begin
      for N := StartInd + 6 to Length( LinkText ) do
        if LinkText[ N ] = '>' then begin
          Insert( InsStr, LinkText, N );
          Break;
        end;
    end;
  finally
    Range.pasteHTML( LinkText );
  end;
end;

procedure TfrDlgSubscribeEdit.A_CutFromWBExecute(Sender: TObject);
begin
  SetExecCommand( 'cut', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_CutFromWBUpdate(Sender: TObject);
begin
  A_CutFromWB.Enabled := CanCut;
end;

procedure TfrDlgSubscribeEdit.A_EditRedoExecute(Sender: TObject);
begin
  WB.ExecWB( OLECMDID_REDO, OLECMDEXECOPT_DONTPROMPTUSER );
end;

procedure TfrDlgSubscribeEdit.A_EditRedoUpdate(Sender: TObject);
begin
  A_EditRedo.Enabled := CanRedo;
end;

function TfrDlgSubscribeEdit.CanCopy: Boolean;
begin
  Result := WB.QueryStatusWB( OLECMDID_COPY ) <> 1;
end;

function TfrDlgSubscribeEdit.CanCut: Boolean;
begin
  Result := WB.QueryStatusWB(OLECMDID_CUT) <> 1;
end;

function TfrDlgSubscribeEdit.CanPaste: Boolean;
begin
  Result := WB.QueryStatusWB(OLECMDID_PASTE) <> 1;
end;

procedure TfrDlgSubscribeEdit.A_EditUndoExecute(Sender: TObject);
begin
  Wb.ExecWB(OLECMDID_UNDO, OLECMDEXECOPT_DONTPROMPTUSER);
end;

procedure TfrDlgSubscribeEdit.A_EditUndoUpdate(Sender: TObject);
begin
  A_EditUndo.Enabled := CanUndo;
end;

function TfrDlgSubscribeEdit.CanUndo: Boolean;
var
I: OLECMDF;
begin
  I := WB.QueryStatusWB(OLECMDID_UNDO);
  Result := not (I in [0, 1]);
end;

function TfrDlgSubscribeEdit.GetControlRange: IHTMLControlRange;
var
SelType: string;
iDoc: IHtmlDocument2;
begin
  Result := nil;
  try
    WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );
    if Assigned( iDoc ) then begin
      SelType := iDoc.selection.type_; // None / Text / Control
      if SelType = 'Control' then
        Result := ( iDoc.selection.createRange as IHTMLControlRange );
    end;
  except
    //
  end;
end;

function TfrDlgSubscribeEdit.GetTxtRange: IHTMLTxtRange;
var
iDoc: IHtmlDocument2;
begin
  Result := nil;

  try
    WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );
    if Assigned( iDoc ) then
      if not AnsiSameText( iDoc.selection.type_, 'control' ) then
        Result := iDoc.selection.createRange as IHTMLTxtRange;
  except
    //
  end;
end;

procedure TfrDlgSubscribeEdit.LinkAttachmentFilesInMail(Sender: TObject; ResultID: Integer; Tr: TpFIBTransaction; var NoClose: Boolean);
const
sqlAttach =
'update or insert into MAIL_ATTACHMENT (' + #13#10 +
'    SUBSCRIBE_LIST_ID, FILE_NAME, FILE_DATA )' + #13#10 +
'  values (' + #13#10 +
'    :SUBSCRIBE_LIST_ID, :FILE_NAME, :FILE_DATA )' + #13#10 +
'  matching (' + #13#10 +
'    SUBSCRIBE_LIST_ID, FILE_NAME )';
var
N: Integer;
Query: TNewQuery;
begin
  Query := TNewQuery.CreateNew( Self, Tr );
  try
    Query.SQL.Text := sqlAttach;
    If not Query.Prepared then
      Query.Prepare;

    For N := 0 to AttachList.Count - 1 do begin
      try
        Query.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := ResultID;
        Query.ParamByName( 'FILE_NAME' ).AsString := ExtractFileName( AttachList.Strings[ N ]);
        Query.ParamByName( 'FILE_DATA' ).LoadFromFile( AttachList.Strings[ N ]);

        Query.ExecQuery;
      except
        raise;
      end;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrDlgSubscribeEdit.cbFontSizeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    TComboBox(Sender).OnSelect(Sender);
end;

procedure TfrDlgSubscribeEdit.cbFontSizeSelect(Sender: TObject);
var
V: OleVariant;
Index: Integer;
Range: IHTMLTxtRange;
begin
  Range := GetTxtRange;
  if not Assigned( Range ) then
    Exit;

  Index := TComboBox(Sender).ItemIndex + 1;
  if Index > 7 then
    V := 'error'
  else
    V := IntToStr( Index );
  try
    Range.execCommand( 'FontSize', false, V );
  except
    //
  end;
end;

procedure TfrDlgSubscribeEdit.cbParFormatSelect(Sender: TObject);
var
Elem: IHTMLElement;
S, ATag, AText: string;
Index: Integer;
iDoc: IHtmlDocument2;
Range: IHTMLTxtRange;
begin
  WaitIsBusy;
  if not Assigned( WB.ControlInterface.Document ) then
      Exit;
  WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );
  if Assigned( iDoc ) then
    if not AnsiSameText( iDoc.selection.type_, 'control' ) then
      Range := iDoc.selection.createRange as IHTMLTxtRange;

  if Assigned( Range ) then
    Elem := Range.parentElement
  else
  if GetControlRange <> nil then
    Elem := GetControlRange.commonParentElement
  else
    Exit;

  while Elem <> nil do begin
    ATag := UpperCase(Elem.tagName);
    if (ATag = 'TD') or (ATag = 'TR') or (ATag = 'TH') or (ATag = 'TABLE') then
      Break; // Прекращаем удаление тэгов
    if (ATag = 'P') or (ATag = 'PRE') or ((Length(ATag) = 2) and
      (ATag[1] = 'H') and CharInSet(ATag[2], ['1'..'6'])) then
      Elem.outerHTML := Elem.innerHTML;
    Elem := Elem.parentElement;
  end;

  if Assigned( Range ) then
    Elem := Range.parentElement
  else
  if GetControlRange <> nil then
    Elem := GetControlRange.commonParentElement
  else
    Exit;

  Index := cbParFormat.ItemIndex;
  case Index of
    0:
      begin

      end;
    1:
      begin
        ATag := 'P';
        AText := 'НовыйАбзац';
      end;

    2..7:
      begin
        ATag := 'H' + IntToStr(Index - 1);
        AText := 'НовыйЗаголовок' + IntToStr(Index - 1);
      end;

    8:
      begin
        ATag := 'PRE';
        AText := 'БезФорматирования';
      end;
  end;

  if Index > 0 then
  begin
    if Range <> nil then
      S := Range.Text
    else
      S := '';

    // Если текст не выделен...
    if (Trim(S) = '') or (ATag = 'P') then
    begin
      if (Trim(Elem.innerText) <> '') then
        S := Elem.innerHTML
      else
        S := AText;

      if Range <> nil then
        Elem.innerHTML := '<'+ATag+'>' + S + '</'+ATag+'>'
      else  // Не работает!!!!!!!
        Elem.parentElement.innerHTML := '<'+ATag+'>' + Elem.parentElement.innerHTML + '</'+ATag+'>'
    end
    else begin // Заменяем выделенный текст (с этим много проблем!!!)
      Range.pasteHTML('<'+ATag+'>' + Range.htmlText + '</'+ATag+'>');
    end;
  end;

  WB.SetFocus;
//  SetPanCursorPos;
end;

procedure TfrDlgSubscribeEdit.SetParFormat;
var
Elem: IHTMLElement;
iDoc: IHtmlDocument2;
TextRange: IHTMLTxtRange;
Index: Integer;
ATag: string;
//IsNoBr: Boolean;
begin
  if cbParFormat.Focused then
    Exit;
  WaitIsBusy;
  if not Assigned( WB.ControlInterface.Document ) then
      Exit;
  WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );
  if Assigned( iDoc ) then
    if not AnsiSameText( iDoc.selection.type_, 'control' ) then
      try
        TextRange := iDoc.selection.createRange as IHTMLTxtRange
      except
        //
      end
    else
      Exit;

  if not Assigned( TextRange ) then
    Exit;

  try
    Index := 0;
//    IsNoBr := False;

    Elem := TextRange.parentElement;

    while Assigned( Elem ) do begin
      ATag := UpperCase(Elem.tagName);

      if ATag = 'NOBR' then
      begin
//        IsNoBr := True;
      end
      else
      if ATag = 'P' then
        Index := 1
      else if ((Length(ATag) = 2) and
        (ATag[1] = 'H') and CharInSet(ATag[2], ['1'..'6'])) then
        Index := StrToInt(ATag[2]) + 1
      else if ATag = 'PRE' then
        Index := 8
      else if ATag = 'BODY' then
        Break;

      Elem := Elem.parentElement;
    end;

    //    acNOBRString.Checked := IsNoBr;
    cbParFormat.ItemIndex := Index;

  except
    //
  end;
end;

procedure TfrDlgSubscribeEdit.TmRefreshTimer(Sender: TObject);
begin
  SetParFormat;
end;

function TfrDlgSubscribeEdit.CanRedo: Boolean;
begin
  Result := WB.QueryStatusWB(OLECMDID_REDO) <> 1;
end;

procedure TfrDlgSubscribeEdit.A_ParCenterExecute(Sender: TObject);
begin
  SetExecCommand( 'JustifyCenter', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_ParCenterUpdate(Sender: TObject);
begin
  A_ParCenter.Checked := CheckFontParam( 'JustifyCenter' );
end;

procedure TfrDlgSubscribeEdit.A_ParJustifyFullExecute(Sender: TObject);
begin
  SetExecCommand( 'JustifyFull', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_ParJustifyFullUpdate(Sender: TObject);
begin
  A_ParJustifyFull.Checked := CheckFontParam( 'JustifyFull' );
end;

procedure TfrDlgSubscribeEdit.A_ParleftExecute(Sender: TObject);
begin
  SetExecCommand( 'JustifyLeft', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_ParleftUpdate(Sender: TObject);
begin
  inherited;
  A_Parleft.Checked := CheckFontParam( 'JustifyLeft' );
end;

procedure TfrDlgSubscribeEdit.A_ParRightExecute(Sender: TObject);
begin
  SetExecCommand( 'JustifyRight', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_ParRightUpdate(Sender: TObject);
begin
  A_ParRight.Checked := CheckFontParam( 'JustifyRight' );
end;

procedure TfrDlgSubscribeEdit.A_PasteToWBExecute(Sender: TObject);
begin
  SetExecCommand( 'paste', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_PasteToWBUpdate(Sender: TObject);
begin
  A_PasteToWB.Enabled := CanPaste;
end;

procedure TfrDlgSubscribeEdit.A_FindOfPageExecute(Sender: TObject);
const
CGID_WebBrowser: TGUID = '{ED016940-BD5B-11cf-BA4E-00C04FD70816}';
HTMLID_FIND       = 1;

var
CmdTarget : IOleCommandTarget;
vaIn, vaOut: OleVariant;
PtrGUID: PGUID;
iDoc: IHtmlDocument2;
begin
  New(PtrGUID);
  PtrGUID^ := CGID_WebBrowser;
  WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );

  if Assigned( iDoc ) then
    try
      iDoc.QueryInterface(IOleCommandTarget, CmdTarget);
      if Assigned( CmdTarget ) then
        try
          CmdTarget.Exec( PtrGUID, HTMLID_FIND, 0, vaIn, vaOut);
        finally
          CmdTarget._Release;
        end;
    except
      // nothing
    end;
  Dispose(PtrGUID);
end;

procedure TfrDlgSubscribeEdit.A_FontBackColorExecute(Sender: TObject);
var
V: OleVariant;
CD: TColorDialog;
Range: IHTMLTxtRange;
begin
  CD := TColorDialog.Create( Self );

  try
    Range := GetTxtRange;
    if Assigned( Range ) then begin
      if CD.Execute then begin
        V := ConvertColorToHtml( CD.Color );
        Range.execCommand( 'BackColor', false, V );
      end;
    end;
  finally
    CD.Free;
  end;
end;

procedure TfrDlgSubscribeEdit.A_FontBoldExecute(Sender: TObject);
begin
  SetExecCommand( 'bold', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_FontBoldUpdate(Sender: TObject);
begin
  A_FontBold.Checked := CheckFontParam( 'bold' );
end;

procedure TfrDlgSubscribeEdit.A_FontColorExecute(Sender: TObject);
var
V: OleVariant;
CD: TColorDialog;
Range: IHTMLTxtRange;
begin
  CD := TColorDialog.Create( Self );

  try
    Range := GetTxtRange;
    if Assigned( Range ) then begin
      if CD.Execute then begin
        V := ConvertColorToHtml( CD.Color );
        Range.execCommand( 'ForeColor', false, V );
      end;
    end;
  finally
    CD.Free;
  end;
end;

procedure TfrDlgSubscribeEdit.A_FontItalicExecute(Sender: TObject);
begin
  SetExecCommand( 'italic', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_FontItalicUpdate(Sender: TObject);
begin
  A_FontItalic.Checked := CheckFontParam( 'italic' );
end;

procedure TfrDlgSubscribeEdit.A_FontStrikeExecute(Sender: TObject);
begin
  SetExecCommand( 'StrikeThrough', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_FontStrikeUpdate(Sender: TObject);
begin
  A_FontStrike.Checked := CheckFontParam( 'StrikeThrough' );
end;

procedure TfrDlgSubscribeEdit.A_FontUnderLineExecute(Sender: TObject);
begin
  SetExecCommand( 'UnderLine', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_FontUnderLineUpdate(Sender: TObject);
begin
  A_FontUnderLine.Checked := CheckFontParam( 'UnderLine' );
end;

procedure TfrDlgSubscribeEdit.A_IdentleftExecute(Sender: TObject);
begin
  SetExecCommand( 'Outdent', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_IdentRigthExecute(Sender: TObject);
begin
  SetExecCommand( 'Indent', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_InsBaseLabelExecute(Sender: TObject);
begin
  // Is Empty
end;

procedure TfrDlgSubscribeEdit.A_InsertHtmlImageExecute(Sender: TObject);
begin
  InsertImagesInHtml( True );
end;

procedure TfrDlgSubscribeEdit.A_InsertImageExecute(Sender: TObject);
begin
  InsertImagesInHtml( False );
end;

procedure TfrDlgSubscribeEdit.DlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
const
sqlFiles =
'select' + #13#10 +
'  F.FILE_IMAGES_NAME, F.FILE_IMAGES_ID' + #13#10 +
'from FILE_IMAGES F' + #13#10 +
'where' + #13#10 +
'  F.IS_USE = 1 and F.IS_DELETE > 0 and' + #13#10 +
'  F.FILE_IMAGES_BODY is not null' + #13#10 +
'order by' + #13#10 +
'  F.FILE_IMAGES_NAME';

var
CurrDlg: TSmartDlg;
Item: TPropertyItem;
PropSQL: TSqlParams;
begin
  if not IsChange then
    Exit;
  if not AnsiSameText( CurrItem.FieldName, 'source' ) then
    Exit;
  CurrDlg := TSmartDlg( Dlg );
  try
    Item := CurrDlg.RowsList.PropByHostFieldName( 'src' );
    if not Assigned( Item ) then
      Exit;
    PropSQL := Item.SQL;
    case CurrItem.RowValueID of
      0: begin
        Item.Title := 'Выбор файла из списка';
        Item.Style := psPickList;
        PropSQL.SqlText := sqlFiles;
        PropSQL.KeyID := 'FILE_IMAGES_ID';
        PropSQL.Title := 'FILE_IMAGES_NAME';
      end;
      1: begin
        Item.Title := 'Путь к файлу с картинкой для вставки';
        Item.Style := psFileOpen;
      end;
    end;
    Item.SQL := PropSQL;
  finally
    CurrDlg.Refresh;
  end;
end;

procedure TfrDlgSubscribeEdit.InsertImagesInHtml( IsHtml: Boolean );
const
AlignList: array [0..5] of String = ( 'Left', 'Right', 'Center', 'Bottom', 'Top', 'Middle' );
SourceList: array[0..1] of String = ( 'Из справочника', 'Загрузка с диска' );

sqlFiles =
'select' + #13#10 +
'  F.FILE_IMAGES_NAME, F.FILE_IMAGES_ID' + #13#10 +
'from FILE_IMAGES F' + #13#10 +
'where' + #13#10 +
'  F.IS_USE = 1 and F.IS_DELETE > 0 and' + #13#10 +
'  F.HTML_LINK is not null' + #13#10 +
'order by' + #13#10 +
'  F.FILE_IMAGES_NAME';

var
PropSQL: TSqlParams;
Dlg: TfrCustomDlg;
begin
  Dlg := TfrCustomDlg.Create(Application.MainForm);
  try
    Dlg.Caption := A_InsertImage.Caption;
    Dlg.OwnerForm := Self;
    Dlg.SmartDlg.Font := Self.SmartDlg.Font;
    Dlg.SmartDlg.Font.Size := Self.SmartDlg.Font.Size;
    case IsHtml of
      True:
        Dlg.OnSaveExecute := ExecCommandInsertHtmlImages;
      else
        Dlg.OnSaveExecute := ExecCommandInsertImages;
    end;
    Dlg.SmartDlg.OnSetEditText := DlgSetEditText;

    if not IsHTML then
      with Dlg.SmartDlg.RowsList.Add do begin
        Title := 'Откуда вставляют картинку';
        RowValue := SourceList[ 1];
        RowValueID := 1;
        FieldName := 'source';
        Style := psComboBox;
        IsEmpty := ftNotEmpty;
        PropSQL := SQL;
        PropSQL.SqlText := ArrayToStrListText(SourceList);
        SQL := PropSQL;
      end;
    with Dlg.SmartDlg.RowsList.Add do begin
      RowValue := '';
      RowValueID := -1;
      FieldName := 'src';
      case IsHtml of
        True: begin
          Title := 'Наименование картинки для вставки';
          Style := psPickListInput;
        end
        else begin
          Title := 'Путь к файлу с картинкой для вставки';
          Style := psFileOpen;
        end;
      end;
      PropSQL := SQL;
      PropSQL.SqlText := sqlFiles;
      PropSQL.KeyID := 'FILE_IMAGES_ID';
      PropSQL.Title := 'FILE_IMAGES_NAME';
      SQL := PropSQL;
      IsEmpty := ftNotEmpty;
    end;
//    with Dlg.SmartDlg.RowsList.Add do begin
//      Title := 'Выравнивание изображения';
//      RowValue := 'Left';
//      RowValueID := 0;
//      FieldName := 'align';
//      Style := psComboBox;
//      IsEmpty := ftNotEmpty;
//      PropSQL := SQL;
//      PropSQL.SqlText := ArrayToStrListText(AlignList);
//      SQL := PropSQL;
//    end;
    with Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Толщина рамки вокруг изображения';
      RowValue := '';
      RowValueID := -1;
      FieldName := 'border';
      Style := psInteger;
      IsEmpty := ftNo;
    end;
    with Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Поля сверху и снизу';
      RowValue := '10';
      RowValueID := -1;
      FieldName := 'vspase';
      Style := psInteger;
      IsEmpty := ftNotEmpty;
    end;
    with Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Поля сбоков';
      RowValue := '10';
      RowValueID := -1;
      FieldName := 'hspase';
      Style := psInteger;
      IsEmpty := ftNotEmpty;
    end;
    with Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Всплывающая подсказка';
      RowValue := '';
      RowValueID := -1;
      FieldName := 'alt';
      Style := psSimpleText;
      IsEmpty := ftNo;
    end;

    Dlg.SmartDlg.FillVisibleRows;
    Dlg.Width := ( Self.ClientWidth div 3 ) * 2;
    Dlg.ShowModal;
  finally
    Dlg.Release;
  end;
end;

procedure TfrDlgSubscribeEdit.RefreshImagesList;
var
Prop: TPropertyItem;
RowValue, CheckListID: String;
begin
  Prop := SmartDlg.RowsList.PropByNameStyle( 'FILE_IMAGES_ID', psMultySelect );
  if not Assigned( Prop ) then
    Exit;

  try
    GetMultySelectParams( Prop, dlgFillRows.PrimaryKeyValue, RowValue, CheckListID );
    Prop.RowValue := RowValue;
    Prop.CheckListID := CheckListID;
  finally
    SmartDlg.Refresh;
  end;
end;

procedure TfrDlgSubscribeEdit.ExecCommandInsertHtmlImages( Sender: TObject; Dlg: TSmartDlg );
  function GetWwwToImages( ValueID: Integer ): String;
  const
  sqlImg =
  'select' + #13#10 +
  '  HTML_LINK' + #13#10 +
  'from FILE_IMAGES' + #13#10 +
  'where' + #13#10 +
  '  FILE_IMAGES_ID = :ID';
  begin
    Result := GetQueryStrField( sqlImg, 'HTML_LINK', [ ValueID ], nil );
  end;

const
htPar =
' %S="%S" ';
ImgPar =
'<img src="%S" %S align=center>';
var
Range: IHTMLTxtRange;
ResultText, AddParam: WideString;
FilePath: String;
N: Integer;
begin
  Range := GetTxtRange;
  try
    try
      AddParam := '';
      FilePath := GetWwwToImages( Dlg.RowsList.PropByHostFieldName( 'src' ).RowValueID );

      for N := 0 to Dlg.RowsList.Count - 1 do begin
        if AnsiSameText( Dlg.RowsList.Items[ N ].FieldName, 'src' ) then
          Continue;
        if Dlg.RowsList.Items[ N ].RowValue <> '' then begin
          AddParam :=
            AddParam +
              Format( htPar, [ Dlg.RowsList.Items[ N ].FieldName, Dlg.RowsList.Items[ N ].RowValue ]);
        end;
      end;

      ResultText := Format( ImgPar, [ FilePath, AddParam ]);

      if Assigned( Range ) then
        Range.pasteHTML( ResultText );
    finally
      TCustomForm( Dlg.Owner ).Close;
    end;
  finally
    RefreshImagesList;
  end;
end;

procedure TfrDlgSubscribeEdit.ExecCommandInsertImages( Sender: TObject; Dlg: TSmartDlg );
const
htPar =
' %S="%S" ';
ImgPar =
'<img src="%S" %S align=center>';
var
Range: IHTMLTxtRange;
ResultText, AddParam: WideString;
Path, FileName, FilePath, PathToWWW: String;
N: Integer;
IsSprav: Boolean;
begin
  Range := GetTxtRange;
  try
    try
      IsSprav := Dlg.RowsList.PropByHostFieldName( 'source' ).RowValueID = 0;

      AddParam := '';
      FilePath := Dlg.RowsList.PropByHostFieldName( 'src' ).RowValue;
      if ( not IsSprav ) and ( not FileExists( FilePath )) then
        Exit;

      FileName := ExtractFileName( FilePath );
      Path := IncludeTrailingPathDelimiter( ExtractFileDir( hFileName )) + 'images\' + FileName;
      PathToWWW := 'images\' + FileName;

      if not FileExists( Path ) then begin
        ForceDirectories( ExtractFileDir( Path ));
        if not IsSprav then
          CopyFile( PChar( FilePath ), PChar( Path ), False );
      end;

      if Assigned( OnImagesToBase ) then
        case IsSprav of
          True:
            OnImagesToBase( Path, Dlg.RowsList.PropByHostFieldName( 'src' ).RowValueID );
          else
            OnImagesToBase( FilePath, -1 );
        end;


      for N := 0 to Dlg.RowsList.Count - 1 do begin
        if AnsiSameText( Dlg.RowsList.Items[ N ].FieldName, 'src' ) then
          Continue;
        if Dlg.RowsList.Items[ N ].RowValue <> '' then begin
          AddParam :=
            AddParam +
              Format( htPar, [ Dlg.RowsList.Items[ N ].FieldName, Dlg.RowsList.Items[ N ].RowValue ]);
        end;
      end;

      ResultText := Format( ImgPar, [ PathToWWW, AddParam ]);

      if Assigned( Range ) then
        Range.pasteHTML( ResultText );
    finally
      TCustomForm( Dlg.Owner ).Close;
    end;
  finally
    RefreshImagesList;
  end;
end;

procedure TfrDlgSubscribeEdit.A_InsertLineExecute(Sender: TObject);
begin
  SetExecCommand( 'InsertHorizontalRule', emptyparam );
end;

function TfrDlgSubscribeEdit.CheckFontParam( const PropValue: String ): Boolean;
var
V: Variant;
iDoc: IHtmlDocument2;
Range: IHTMLTxtRange;
begin
  Result := False;
  WaitIsBusy;
  if not Assigned( WB.ControlInterface.Document ) then
      Exit;
  WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );
  if Assigned( iDoc ) then
    if not AnsiSameText( iDoc.selection.type_, 'control' ) then
      try
        Range := iDoc.selection.createRange as IHTMLTxtRange;
      except
        //
      end
    else
      Exit;

  if Assigned( Range ) then
    try
      V := Range.queryCommandValue( PropValue );
      Result := V = True;
    except
    end;
end;

procedure TfrDlgSubscribeEdit.A_OpenFromFileExecute(Sender: TObject);
var
OD: TOpenDialog;
begin
  if MessageBox( Self.Handle,
      'При загрузке нового документа существующий будет потерян! Восстановление данных в программе не предусмотрено.' + #13#10 +
      'Вы действительно хотите загрузить новый документ?', 'Подтверждение',
      MB_YESNO or MB_ICONQUESTION or MB_SYSTEMMODAL or MB_DEFBUTTON2 ) = IDNO then
    Exit;
  OD := TOpenDialog.Create( Self );
  try
    OD.Filter := 'Файлы HTML|*.html';
    if OD.Execute then begin
      WB.Navigate2( OD.FileName );
      WaitIsBusy;
      SaveToHtmlFile( hFileName );
    end;
  finally
    OD.Free;
  end;
end;

procedure TfrDlgSubscribeEdit.A_SaveExecute(Sender: TObject);
begin
  inherited;
    //
end;

procedure TfrDlgSubscribeEdit.A_SaveToFileExecute(Sender: TObject);
var
SD: TSaveDialog;
begin
  SD := TSaveDialog.Create( Self );
  try
    try
      SD.Filter := 'Файлы HTML|*.html';
      SD.DefaultExt := 'html';
      if SD.Execute then begin
        WaitIsBusy;
        SaveToHtmlFile( SD.FileName );
      end;
    finally
      SD.Free;
      A_WbIsEditExecute( A_WbIsEdit );
      WB.Refresh2;
      SetWebBrowserIsEdit;
    end;
  except
    //
  end;
end;

procedure TfrDlgSubscribeEdit.A_SimpleListExecute(Sender: TObject);
begin
  SetExecCommand( 'InsertUnorderedList', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_SimpleListUpdate(Sender: TObject);
begin
  CheckFontParam( 'InsertUnorderedList' );
end;

procedure TfrDlgSubscribeEdit.A_SmartListExecute(Sender: TObject);
begin
  SetExecCommand( 'InsertOrderedList', emptyparam );
end;

procedure TfrDlgSubscribeEdit.A_SmartListUpdate(Sender: TObject);
begin
  CheckFontParam( 'InsertOrderedList' );
end;

procedure TfrDlgSubscribeEdit.A_WbIsEditExecute(Sender: TObject);
var
iDoc: IHtmlDocument2;
begin
  if not ( A_Save.Visible and A_Save.Enabled ) then
    Exit;
  if not ( A_WbIsEdit.Visible and A_WbIsEdit.Enabled ) then
    Exit;

  A_WbIsEdit.Checked := not A_WbIsEdit.Checked;
  WaitIsBusy;
  try
    if not Assigned( WB.ControlInterface.Document ) then
      Exit;
    WB.ControlInterface.Document.QueryInterface( IHtmlDocument2, iDoc );

    case A_WbIsEdit.Checked of
      True:
        iDoc.designMode := 'on';
      else begin
        iDoc.designMode := 'off';
        WaitIsBusy;
        SaveToHtmlFile( hFileName );
      end;
    end;
  finally
    WBEditCaption;
    ButtonEnable( iDoc );
  end;
end;

procedure TfrDlgSubscribeEdit.ButtonEnable( iDoc: IHtmlDocument2 );
var
IsEnable: Boolean;
begin
  if Assigned( iDoc ) then
    IsEnable := AnsiSameText( iDoc.designMode, 'on' )
  else
    IsEnable := False;

  A_ParCenter.Enabled := IsEnable;
  A_Parleft.Enabled := IsEnable;
  A_ParRight.Enabled := IsEnable;
  A_ParJustifyFull.Enabled := IsEnable;

  A_SimpleList.Enabled := IsEnable;
  A_SmartList.Enabled := IsEnable;

  A_Identleft.Enabled := IsEnable;
  A_IdentRigth.Enabled := IsEnable;

  A_FontBold.Enabled := IsEnable;
  A_FontItalic.Enabled := IsEnable;
  A_FontStrike.Enabled := IsEnable;
  A_FontUnderLine.Enabled := IsEnable;

  A_FontBackColor.Enabled := IsEnable;
  A_FontColor.Enabled := IsEnable;

  A_CreateLink.Enabled := IsEnable;
  A_InsertLine.Enabled := IsEnable;
  A_InsertImage.Enabled := IsEnable;

  cbParFormat.Enabled := IsEnable;
  cbFontSize.Enabled := IsEnable;

  tbInsBaseLabel.Enabled := IsEnable;
end;

procedure TfrDlgSubscribeEdit.bxAttachKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
Ind: Integer;
begin
  inherited;
  try
    if Shift <> [] then
      Exit;
    if Key <> VK_DELETE then
      Exit;
    Ind := bxAttach.ItemIndex;
    if Ind = -1 then
      Exit;
    bxAttach.Items.Delete( Ind );
    AttachList.Delete( Ind );
  finally
    bxAttach.Visible := bxAttach.Items.Count > 0;
  end;
end;

procedure TfrDlgSubscribeEdit.SaveHtmlToBase(Sender: TObject; DlgType: TStateDlg; ResultID: Integer;
  SP: TpFIBStoredProc; var NoClose: Boolean);
begin
  if A_WbIsEdit.Checked then
    A_WbIsEditExecute( A_WbIsEdit );

  SaveToHtmlFile( hFileName );
  if Assigned( OnSaveHtmlTextToBase ) then
    OnSaveHtmlTextToBase( TpFIBTransaction( SP.Transaction ), hFileName, BodyText, ResultID );

  FillSubscribeSend( Sender, DlgType, ResultID, SP, NoClose );
  LinkAttachmentFilesInMail( Sender, ResultID, TpFIBTransaction( SP.Transaction ), NoClose );

  WB.Refresh2;
  WaitIsBusy;
end;

procedure TfrDlgSubscribeEdit.SaveToHtmlFile( const FileName: String );
var
iDoc: IHtmlDocument2;
PersistFile: IPersistFile;
begin
  iDoc := nil;
  Self.ActiveControl := WB;
  while not ( Assigned( iDoc ) and Assigned( iDoc.body )) do begin
    WB.ControlInterface.Document.QueryInterface(IHtmlDocument2, iDoc);
    Application.ProcessMessages;
  end;

//  iDoc.body.innerHTML;
  PersistFile  := iDoc as IPersistFile;
  PersistFile.Save( StringToOleStr( FileName ), System.True );
  BodyText := iDoc.body.innerText;
  IsOK := True;
  WB.Refresh2;
  WaitIsBusy;
end;

procedure TfrDlgSubscribeEdit.WBEditCaption;
begin
  case A_WbIsEdit.Checked of
    True: begin
      A_WbIsEdit.Caption := 'Включить режим просмотра';
      A_WbIsEdit.ImageIndex := 51;
    end;
    else begin
      A_WbIsEdit.Caption := 'Включить режим редактирования';
      A_WbIsEdit.ImageIndex := 50;
    end;
  end;
  A_WbIsEdit.Hint := A_WbIsEdit.Caption;
end;

procedure TfrDlgSubscribeEdit.WMMouseActivate(var Msg: TMessage);
begin
  try
    inherited;
    // right mouse button
    if Msg.LParamHi = 516 then
       Msg.Result:= MA_NOACTIVATEANDEAT;
    // insert code here for show own context menu
  except
  end;
end;

procedure TfrDlgSubscribeEdit.WaitIsBusy;
var
N: Integer;
begin
  N := 0;
  while not IsOK do begin
    Application.ProcessMessages;
    sleep( 10 );
    if N > 6000 then
      Exit;
    Inc( N );
  end;
end;

procedure TfrDlgSubscribeEdit.WBBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName,
  PostData, Headers: OleVariant; var Cancel: WordBool);
begin
  IsOK := False;
  SB.Panels.Items[ 2 ].Text := VarAsType( Url, varString );
end;

procedure TfrDlgSubscribeEdit.WBDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
  IsOK := True;
  ButtonEnable(( pDisp as iWebBrowser ).document as ihtmldocument2 );
end;

function TfrDlgSubscribeEdit.ConvertColorToHtml(AColor: TColor): string;
begin
  Result := Format( '#%s%s%s',
    [ IntToHex( GetRValue( AColor ), 2 ),
      IntToHex( GetGValue( AColor ), 2 ),
      IntToHex( GetBValue( AColor ), 2 )]);
end;


procedure TfrDlgSubscribeEdit.dlgFillRowsGetRowsListParam(Dlg: TObject; DlgID: Integer; InputParams: array of TVarRec;
  Rows: TRowsList);
var
Prop: TPropertyItem;
begin
  inherited;
  if dlgFillRows.ActionType in [ sdEdit, sdCopy ] then begin
    Prop := SmartDlg.RowsList.PropByName( 'MAIL_TEMPLATE_TITLE' );
    if Assigned( Prop ) and
       ( Prop.Style = psPickList ) and
       ( DlgID = dlgSubscribeJournal ) then
      Prop.Visible := False;
  end;
end;

procedure TfrDlgSubscribeEdit.FillSubscribeSend(Sender: TObject; DlgType: TStateDlg; ResultID: Integer; SP: TpFIBStoredProc; var NoClose: Boolean);
const
sqlFill =
'execute procedure SUBSCRIBE_SEND_FILL( :LIST_ID, :GROUP_ID )';
var
Query: TNewQuery;
begin
  if SP.FieldsCount <> 2 then
    Exit;

  Query := TNewQuery.CreateNew( Self, SP.Transaction );
  try
    Query.SQL.Text := sqlFill;
    If not Query.Prepared then
      Query.Prepare;

    Query.ParamByName( 'LIST_ID' ).AsInteger := ResultID;
    Query.ParamByName( 'GROUP_ID' ).AsInteger := SP.Fields[ 1 ].AsInteger;

    try
      Query.ExecQuery;
      NoClose := False;
    except
      Raise;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

end.
