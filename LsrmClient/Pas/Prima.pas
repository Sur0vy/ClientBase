{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit Prima;

interface

{$I Lsrm.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.Menus, Vcl.ImgList, Vcl.StdActns,
  AddActions, Vcl.ActnList, ConstList, Vcl.AppEvnts, CustomForm, Vcl.StdCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, Vcl.CustomizeDlg, Vcl.BandActn;

type
  TSpravMenu = class( TMenuItem )
  public
    RightValue: Integer;
    AddInputParams: Integer;
		constructor Create(AOwner: TComponent); override;
  end;

  TfrPrima = class(TForm)
    ImList: TImageList;
    MM: TMainMenu;
    PM: TPopupMenu;
    ControlB: TControlBar;
    ActManager: TActionManager;
    aTbServ: TActionToolBar;
    ppPrima: TPopupActionBar;
    aTbTransact: TActionToolBar;

    SB: TStatusBar;
    A_Sp: TAction;
    A_ServerSetup: TAction;
    A_EditCut: TEditCut;
    A_EditCopy: TEditCopy;
    A_EditPaste: TEditPaste;
    A_EditSelectAll: TEditSelectAll;
    A_EditUndo: TEditUndo;
    A_Clipboard: TPopMenuAction;
    AConnect: TAction;
    A_PrinterList: TAction;
    AExit: TAction;
    WindowClose: TWindowClose;
    A_WindowCascade: TWindowCascade;
    A_WindowTileHorizontal: TWindowTileHorizontal;
    A_WindowTileVertical: TWindowTileVertical;
    A_WindowMinimizeAll: TWindowMinimizeAll;
    A_CloseAll: TAction;
    A_NextWindow: TAction;
    MServer: TMenuItem;
    mnServerSetup: TMenuItem;
    M_Sep3: TMenuItem;
    mnExit: TMenuItem;
    M_Journal: TMenuItem;
    M_Transact: TMenuItem;
    M_Sprav: TMenuItem;
    M_Report: TMenuItem;
    M_Window: TMenuItem;
    M_WindowCascade: TMenuItem;
    M_WindowTileHorizontal: TMenuItem;
    M_WindowTileVertical: TMenuItem;
    M_WindowMinimizeAll: TMenuItem;
    M_CloseAll: TMenuItem;
    M_NextWindow: TMenuItem;
    MHelp: TMenuItem;
    MHelpExec: TMenuItem;
    MAbout: TMenuItem;
    A_ClientsList: TAction;
    A_DownLoadList: TAction;
    A_ClientTraining: TAction;
    A_AgreesList: TAction;
    A_KeysList: TAction;
    m_Sep4: TMenuItem;
    m_WinSep1: TMenuItem;
    m_WinSep2: TMenuItem;
    A_ImportFromWWW: TAction;
    A_ImportFromCsv: TAction;
    mnImportCsv: TMenuItem;
    mnImport: TMenuItem;
    mnSepImport: TMenuItem;
    mnImportWWW: TMenuItem;
    HtmlImList: TImageList;
    A_FirmList: TAction;
    A_Subscribe: TAction;
    A_SoftDelivery: TAction;
    A_RightRegInfo: TAction;

    procedure A_NextWindowExecute(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure ConnectExecute(Sender: TObject);
    procedure A_ServerSetupExecute(Sender: TObject);
    procedure A_PrinterListExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ChildFormDeactivate(Sender: TObject);
    procedure A_ClientsListExecute(Sender: TObject);
    procedure A_DownLoadListExecute(Sender: TObject);
    procedure A_ClientTrainingExecute(Sender: TObject);
    procedure A_AgreesListExecute(Sender: TObject);
    procedure A_KeysListExecute(Sender: TObject);
    procedure A_CloseAllExecute(Sender: TObject);
    procedure A_CloseAllUpdate(Sender: TObject);
    procedure A_NextWindowUpdate(Sender: TObject);
    procedure A_ImportFromWWWExecute(Sender: TObject);
    procedure A_ImportFromCsvExecute(Sender: TObject);
    procedure A_FirmListExecute(Sender: TObject);
    procedure A_SubscribeExecute(Sender: TObject);
    procedure A_SoftDeliveryExecute(Sender: TObject);
    procedure A_RightRegInfoExecute(Sender: TObject);

  private
    { Private declarations }
    procedure AlignProperty(M_Item: TMenuItem; N: Integer; Act: TAction);
    procedure CreateSubMenu(AOwner: TMenuItem; List: TArrayAction);
    procedure ShowNextWindow(Sender: TObject);
    procedure CreateMenuSpravAndReport;
    procedure CreateSpravMenu(SpravMenu: TMenuItem; ParentID: Integer);


    procedure ShowException(Sender: TObject; E: Exception);
    procedure CreateReportMenu(ReportMenu: TMenuItem; ParentID: Integer);
    function  FindChildMDIForm(FormClassName, FormCaption: String; StartCaption: Boolean = False ): TForm;
    procedure ShowSpravForm(Sender: TObject);
    procedure ShowRightFuncSprav(Sender: TObject);
    procedure ShowReport(Sender: TObject);
    procedure ShowHostMenuAndToolBar( var Message: TMessage ); message CM_ShowPrimaToolBar;
    procedure CreateTempDirectory( var Message: TMessage ); message CM_ClearTempDir;
    procedure ChildFormClose( var Message: TMessage ); message CM_ChildFormClose;
    procedure StartExeExecute( var Message: TMessage ); message CM_StartExe;
    procedure SetActionBarWidth( var Message: TMessage ); message CM_SetActionbarWidth;
    procedure AddMenu(MM: TMenuItem; N: Integer; ArrayAction: array of TAction; Ind: Integer = -1 );
    procedure ToolBarRefresh(Bar: TActionBarItem);
    function FindActionInArrayOfName(const ActName: String; ArrayAction: array of TAction): TAction;
    function LoadActionListFromDB(Sender: TCustomForm; Bar: TActionBarItem; const BarCaption: string; LastAction: TActionClientItem; ArrayAction: array of TAction; IsAdd: Boolean): Boolean;
    procedure SetWithActionBar(Bar: TActionBarItem);
  public
    { Public declarations }
    TempDir: String;
    CurrToolBarDefaultList: TList;
    procedure SetQueryRefresh;
    procedure SBRecordCount(RecNo, RecCount: Integer);
    procedure ShowMenuItem;
    procedure SetMainMenuList(MainItem: TMenuItem; Popup: TPopupMenu; ArrayAction: array of TAction);
    procedure AddInMainMenu(MainItem: TMenuItem; Popup: TPopupMenu; AfterAct: TAction; ArrayAction: array of TAction);


    procedure SetFillActListInBar( TB: TActionToolBar; ArrayAction: array of TAction);
    procedure AddActListInBar(TB: TActionToolBar; AfterAct: TAction; ArrayAction: array of TAction);

    procedure AddActionInToolBar(Bar: TActionBarItem; AddAct: TAction; var LastAction: TActionClientItem);
    procedure FillActionBarFromDB( Sender: TCustomForm; ActionTB: TActionToolBar; const BarCaption: String; ArrayAction: array of TAction );
    procedure AddActListInBarFromDB( Sender: TCustomForm; TB: TActionToolBar; AfterAct: TAction;  ArrayAction: array of TAction);

    function ShowAssignToolBar( TB: TActionToolBar; IsShow: Boolean ): TActionBarItem;
    procedure HideAllToolBar;
  end;

var
  frPrima: TfrPrima;

implementation

{$R *.dfm}

uses ClientDM, CustomDlg, DlgParams, Vcl.Printers, Procs, ProcReg, Tools, FuncRight, ReportFiltr, Math,
  ClientsList, SqlTools, ShellList, Winapi.ShellAPI, Winapi.ShlObj, DownList, ClientTraining, SoftDelivery,
  CustomSprav, KeysList, ImportFromWWW, CsvToBase, MailTemplate, SpravFileImages, GroupSuscribeSprav, GridSetup,
  FirmList, SubscribeJournal, FIB, RegExpr, AgreesList;

{ TSpravMenu }

constructor TSpravMenu.Create(AOwner: TComponent);
begin
  inherited;
	RightValue := 0;
	AddInputParams := -1;
end;

{ TfrPrima }

procedure TfrPrima.ConnectExecute(Sender: TObject);
begin
  frDM.IBDB.Close;
  atbServ.Left := 0;
  Screen.Cursor :=  crSQLWait;

  frDM.IBDB.ConnectParams.CharSet := 'WIN1251';
  frDM.IBDB.LibraryName := 'fbClient.dll';

{$IFDEF COMMAND_LINE}
   frDM.IBDB.DatabaseName := ServName;
   frDM.IBDB.ConnectParams.UserName := DebugUser;
   frDM.IBDB.ConnectParams.Password := DebugPass;
   CurrentUserLogin := DebugUser;
{$ELSE}
   if ParamCount <> 3 then begin
     ShowMessage( 'Неверно заданы входные параметры!' );
     Self.Close;
     Exit;
   end;

   frDM.IBDB.DatabaseName := ParamStr( 1 );
   frDM.IBDB.ConnectParams.UserName := ParamStr( 2 );
   frDM.IBDB.ConnectParams.Password := ParamStr( 3 );
   CurrentUserLogin := ParamStr( 2 );
{$ENDIF}

  try
    try
      frDM.IBDB.Open;
      sleep( 200 );
    except
      on E: Exception do begin
        ShowMessage( 'Нет доступа к серверу!' + #13#10 +
                     ParamStr( 1 ) + ', ' + ParamStr( 2 ) + ', ' + ParamStr( 3 ));
        Self.Close;
      end;
    end;
    Application.ProcessMessages;

    CreateMenuSpravAndReport;
  finally
    Screen.Cursor :=  crDefault;
    SB.Panels.Items[ 3 ].Text :=
      Format( 'Сервер: %S, Пользователь: %S', [ frDM.IBDB.DBName, CurrentManagerTitle ]);
  end;
end;

procedure TfrPrima.AExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrPrima.AlignProperty(M_Item: TMenuItem; N: Integer; Act: TAction);
begin
  If AnsiSameText( Act.Name, 'A_Left' ) or
     AnsiSameText( Act.Name, 'A_Right' ) or
     AnsiSameText( Act.Name, 'A_Centr' ) then begin
    M_Item.RadioItem := True;
    M_Item.GroupIndex := 1;
  end;
end;

procedure TfrPrima.A_ClientsListExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_ClientsList.Visible and A_ClientsList.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrClienstList.ClassName, A_ClientsList.Caption, True );
  If Fr = nil then begin
     TfrClienstList.ShowClientsForm( A_ClientsList );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_FirmListExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_FirmList.Visible and A_FirmList.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrFirmList.ClassName, A_FirmList.Caption, True );
  If Fr = nil then begin
     TfrFirmList.ShowFirmListForm( A_FirmList );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_SubscribeExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_Subscribe.Visible and A_Subscribe.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrSubscribeJournal.ClassName, A_Subscribe.Caption, True );
  If Fr = nil then begin
     TfrSubscribeJournal.ShowSubscribeJournal( A_Subscribe );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_ClientTrainingExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_ClientTraining.Visible and A_ClientTraining.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrClientTraining.ClassName, A_ClientTraining.Caption, True );
  If Fr = nil then begin
     TfrClientTraining.ShowSimpleForm( A_ClientTraining, dlgTrainingJournal );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_AgreesListExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_AgreesList.Visible and A_AgreesList.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrAgreesList.ClassName, A_AgreesList.Caption, True );
  If Fr = nil then begin
     TfrAgreesList.ShowSimpleForm( A_AgreesList, dlgAgreesListJournal );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_SoftDeliveryExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_SoftDelivery.Visible and A_SoftDelivery.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrSoftDelivery.ClassName, A_AgreesList.Caption, True );
  If Fr = nil then begin
     TfrSoftDelivery.ShowSimpleForm( A_SoftDelivery, dlgSoftDeliveryJournal );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_KeysListExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_KeysList.Visible and A_KeysList.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrKeysList.ClassName, A_KeysList.Caption, True );
  If Fr = nil then begin
     TfrKeysList.ShowSimpleForm( A_KeysList, dlgKeysJournal );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_DownLoadListExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_DownLoadList.Visible and A_DownLoadList.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrDownList.ClassName, A_DownLoadList.Caption, True );
  If Fr = nil then begin
     TfrDownList.ShowSimpleForm( A_DownLoadList, dlgDownLoadJournal );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_ImportFromCsvExecute(Sender: TObject);
var
opdOpen: TOpenDialog;
begin
  if not ( A_ImportFromCsv.Visible and A_ImportFromCsv.Enabled ) then
    Exit;

  opdOpen := TOpenDialog.Create( Self );
  try
    opdOpen.Filter := 'Файлы CSV|*.csv;*.txt|Все файлы|*.*';
    If opdOpen.Execute( Self.Handle ) then begin
      TLoadCsvToBase.GetDataFromFile( opdOpen.FileName );
    end;
  finally
    opdOpen.Free;
  end;
end;

procedure TfrPrima.A_ImportFromWWWExecute(Sender: TObject);
var
Fr: TForm;
begin
  if not ( A_ImportFromWWW.Visible and A_ImportFromWWW.Enabled ) then
    Exit;

  Fr := FindChildMDIForm( TfrImportFromWWW.ClassName, A_ImportFromWWW.Caption, True );
  If Fr = nil then begin
     TfrImportFromWWW.ShowWwwImportForm( A_ImportFromWWW );
  end
  else
    Fr.Show;

  ShowMenuItem;
end;

procedure TfrPrima.A_NextWindowExecute(Sender: TObject);
begin
  If not ( A_NextWindow.Visible and A_NextWindow.Enabled ) then
    Exit;
  ShowNextWindow( Sender );
end;

procedure TfrPrima.A_NextWindowUpdate(Sender: TObject);
begin
  A_NextWindow.Enabled := MDIChildCount > 1;
end;

procedure TfrPrima.A_PrinterListExecute(Sender: TObject);
  function DefaultPrinter(APrinter: TPrinter): string;
  begin
    APrinter.PrinterIndex := -1;
    Result := APrinter.Printers[ APrinter.PrinterIndex ];
  end;

var
FPrinter: TPrinter;
Ind: Integer;
PrintList: TStrings;
DefPrinter, RegPrint: String;
Dlg: TfrCustomDlg;
S: TSqlParams;
begin
  Exit;
  If not ( A_PrinterList.Enabled and A_PrinterList.Visible ) then
    Exit;

  RegPrint := RegString + '\' + CurrentUserLogin + '\Print\';

  Screen.Cursor := crSQLWait;
  FPrinter := Printer;
  FPrinter.Refresh;
  PrintList := FPrinter.Printers;
    // Принтер по умолчанию на данном ПК
  DefPrinter := DefaultPrinter( FPrinter );

  try
    WorkDocsPrinter.DocPrinterName := RegGetString( HKEY_CURRENT_USER, RegPrint, 'DocPrinterName' );
    WorkDocsPrinter.ShowPreview := RegGetInteger( HKEY_CURRENT_USER, RegPrint, 'ShowPreview', 0 ) = 1;
    WorkDocsPrinter.ShowPrintSetup := RegGetInteger( HKEY_CURRENT_USER, RegPrint, 'ShowSetup', 0 ) = 1;

    Ind := PrintList.IndexOf( WorkDocsPrinter.DocPrinterName );
    if Ind = -1 then begin
      WorkDocsPrinter.DocPrinterName := '';
      RegSetString( HKEY_CURRENT_USER, RegPrint, 'DocPrinterName', '', True );
    end;

    if Assigned( Sender ) then begin
      S.SqlText := PrintList.Text;
      Dlg := TfrCustomDlg.Create( Self );
      try
        Dlg.Caption := A_PrinterList.Caption;
        Dlg.OnBeforeSaveExecute := Dlg.EmptySaveExecute;
        Dlg.OwnerForm := Self;
        Dlg.SmartDlg.Font := Self.Font;
        Dlg.SmartDlg.Font.Size := 12;
        With Dlg.SmartDlg.RowsList.Add do begin
          Title := 'Принтер для печати документов';
          RowValue := WorkDocsPrinter.DocPrinterName;
          Style := psComboBox;
          FieldName := 'DocPrinterName';
          SQL := S;
        end;
        With Dlg.SmartDlg.RowsList.Add do begin
          Title := 'Перед печатью показывать окно просмотра';
          RowValue := BoolTitle[ Integer( WorkDocsPrinter.ShowPreview )];
          Style := psBoolean;
          FieldName := 'PREVIEW';
        end;
        With Dlg.SmartDlg.RowsList.Add do begin
          Title := 'Показывать окно настройки печати';
          RowValue := BoolTitle[ Integer( WorkDocsPrinter.ShowPrintSetup )];
          Style := psBoolean;
          FieldName := 'SETUP';
        end;

        Dlg.SmartDlg.FillVisibleRows;
        Dlg.A_Save.Enabled := False;

        If ( not Assigned( Sender )) or
           ( Dlg.ShowModal = mrOk ) then begin
          WorkDocsPrinter.DocPrinterName :=
            Dlg.SmartDlg.RowsList.PropByName( 'DocPrinterName' ).RowValue;
          WorkDocsPrinter.ShowPreview :=
            GetBoolTitleIndex( Dlg.SmartDlg.RowsList.PropByName( 'PREVIEW' ).RowValue ) = 1;
          WorkDocsPrinter.ShowPrintSetup :=
            GetBoolTitleIndex( Dlg.SmartDlg.RowsList.PropByName( 'SETUP' ).RowValue ) = 1;
        end;
      finally
        Dlg.Release;
      end;
    end;

  finally
    RegSetString( HKEY_CURRENT_USER, RegPrint, 'DocPrinterName', WorkDocsPrinter.DocPrinterName, True );
    RegSetInteger( HKEY_CURRENT_USER, RegPrint, 'ShowPreview', Integer( WorkDocsPrinter.ShowPreview ), True );
    RegSetInteger( HKEY_CURRENT_USER, RegPrint, 'ShowSetup', Integer( WorkDocsPrinter.ShowPrintSetup ), True );
  end;
end;

procedure TfrPrima.A_RightRegInfoExecute(Sender: TObject);
begin
  // IsEmpty
end;

procedure TfrPrima.A_ServerSetupExecute(Sender: TObject);
var
Dlg: TfrCustomDlg;
begin
  if not ( A_ServerSetup.Visible and A_ServerSetup.Enabled ) then
    Exit;

  Dlg := TfrCustomDlg.Create( Self );
  try
    Dlg.Caption := A_ServerSetup.Caption;
    Dlg.OwnerForm := Self;
    Dlg.SmartDlg.Font := Self.Font;
    Dlg.SmartDlg.Font.Size := 12;

    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Имя сервера и путь к базе данных';
      RowValue := frDM.IBDB.DatabaseName;
      Style := psReadOnlyText;
    end;
    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Имя пользователя';
      RowValue := frDM.IBDB.ConnectParams.UserName;
      Style := psReadOnlyText;
    end;

    Dlg.SmartDlg.FillVisibleRows;
    Dlg.SetDlgReadOnly;

    Dlg.ShowModal;
  finally
    Dlg.Release;
  end;
end;

procedure TfrPrima.SBRecordCount(RecNo, RecCount: Integer);
begin
  If ( RecNo > 0 ) and ( RecCount = 0 ) then
    Self.SB.Panels[ 1 ].Text := IntToStr( RecNo )
  else
    Self.SB.Panels[ 1 ].Text := Format( '%D из %D записей', [ RecNo, RecCount ]);
end;

procedure TfrPrima.AddMenu( MM: TMenuItem; N: Integer; ArrayAction: array of TAction; Ind: Integer = -1 );
var
M_Item: TMenuItem;
begin
  M_Item := TMenuItem.Create(MM);
  if ArrayAction[N] = A_Sp then begin
    M_Item.Caption := '-';
    M_Item.Hint := '-';
  end
  else
    M_Item.Action := ArrayAction[N];

  AlignProperty(M_Item, N, ArrayAction[N]);

  if Ind = -1 then
    MM.Add( M_Item )
  else
    MM.Insert( Ind, M_Item );

  if M_Item.Action is TPopMenuAction then
    CreateSubMenu(M_Item, TPopMenuAction(M_Item.Action).List);
end;

procedure TfrPrima.SetMainMenuList(MainItem: TMenuItem; Popup: TPopupMenu; ArrayAction: array of TAction);
var
N: Integer;
begin
  If Length( ArrayAction ) = 0 then
    Exit;
  try
    If Assigned( MainItem ) then begin
      MainItem.Clear;  // главное меню
			For N := 0 to High( ArrayAction ) do begin
        AddMenu( MainItem, N, ArrayAction );
      end;
    end;

    If Assigned( Popup ) then begin
      Popup.Items.Clear;  // контекстное меню
      For N := 0 to High( ArrayAction ) do begin
        AddMenu( Popup.Items, N, ArrayAction );
      end;
    end;
  finally
    If Assigned( MainItem ) then
      MainItem.Visible := MainItem.Count > 0;
  end;
end;

procedure TfrPrima.AddInMainMenu(MainItem: TMenuItem; Popup: TPopupMenu; AfterAct: TAction; ArrayAction: array of TAction);
  function FindAfterMenu( MM: TMenuItem ): Integer;
  var
  N: Integer;
  begin
    Result := -1;
    for N := 0 to MM.Count - 1 do
      if MM.Items[ N ].Action = AfterAct then begin
        Result := N;
        Break;
      end;
  end;

var
LastInd, N: Integer;
begin
  if Assigned( MainItem ) then begin
    LastInd := FindAfterMenu( MainItem );
    if LastInd <> -1 then begin
      For N := 0 to High( ArrayAction ) do begin
        AddMenu( MainItem, N, ArrayAction, LastInd + 1 );
        Inc( LastInd );
      end;
    end;
  end;

  if Assigned( Popup ) then begin
    LastInd := FindAfterMenu( Popup.Items );
    if LastInd <> -1 then begin
      For N := 0 to High( ArrayAction ) do begin
        AddMenu( Popup.Items, N, ArrayAction, LastInd + 1 );
        Inc( LastInd );
      end;
    end;
  end;
end;

procedure TfrPrima.SetQueryRefresh;
begin
  PostMessage( Self.Handle, CM_ItemsRefresh, 0, 0 );
end;

procedure TfrPrima.SetActionBarWidth(var Message: TMessage);
var
Bar: TActionBarItem;
begin
  Bar := nil;
  if Message.WParam = 0 then
    Exit;
  try
    Bar := TActionBarItem( Pointer( Message.WParam ));
  except
    //
  end;
  if not Assigned( Bar ) then
    Exit;

  SetWithActionBar( Bar );
end;

procedure TfrPrima.SetFillActListInBar(TB: TActionToolBar; ArrayAction: array of TAction);
var
Bar: TActionBarItem;
N: Integer;
LastAction: TActionClientItem;
begin
  LastAction := nil;
  Bar := ShowAssignToolBar( TB, False );
  if not Assigned( Bar ) then
    Exit;

  try
    try
      Bar.Items.Clear;
      for N := 0 to High( ArrayAction ) do
        AddActionInToolBar( Bar, ArrayAction[ N ], LastAction );

      ToolBarRefresh( Bar );
      Bar.ActionBar.Visible := Bar.Items.Count > 0;
      Bar.ActionBar.Height := 22;
    finally
      ShowMenuItem;
    end;
  finally
    PostMessage( Self.Handle, CM_SetActionbarWidth, Integer( Pointer( Bar )), 0 );
  end;
end;

function TfrPrima.FindActionInArrayOfName( const ActName: String; ArrayAction: array of TAction ): TAction;
var
N: Integer;
begin
  Result := nil;
  for N := 0 to High( ArrayAction ) do
    if Assigned( ArrayAction[ N ]) and
       Assigned( ArrayAction[ N ].Owner ) and
       AnsiSameText( ArrayAction[ N ].Name, ActName ) then begin
      Result := ArrayAction[ N ];
      Exit;
    end;
end;

procedure TfrPrima.FillActionBarFromDB( Sender: TCustomForm; ActionTB: TActionToolBar; const BarCaption: String; ArrayAction: array of TAction );
var
Bar: TActionBarItem;
N: Integer;
LastAction: TActionClientItem;
begin
  LastAction := nil;
  ActionTB.Caption := BarCaption;
  Bar := ShowAssignToolBar( ActionTB, False );
  if not Assigned( Bar ) then
    Exit;
  Bar.Items.Clear;

  try
    CurrToolBarDefaultList.Clear;
    for N := 0 to High( ArrayAction ) do
      CurrToolBarDefaultList.Add( ArrayAction[ N ]);

    try
      If ( BarCaption <> '' ) and
         LoadActionListFromDB( Sender, Bar, BarCaption, LastAction, ArrayAction, False ) then
        Exit;

      Bar.Items.Clear;
      for N := 0 to High( ArrayAction ) do
        AddActionInToolBar( Bar, ArrayAction[ N ], LastAction );

    finally
      ToolBarRefresh( Bar );
      Bar.ActionBar.Visible := Bar.Items.Count > 0;
      Bar.ActionBar.Height := 22;
    end;
  finally
    Application.ProcessMessages;
    PostMessage( Self.Handle, CM_SetActionbarWidth, Integer( Pointer( Bar )), 0 );
  end;
end;

procedure TfrPrima.AddActListInBarFromDB( Sender: TCustomForm; TB: TActionToolBar; AfterAct: TAction; ArrayAction: array of TAction);
var
Bar: TActionBarItem;
N, AfterActInd: Integer;
LastAction: TActionClientItem;
begin
  AfterActInd := CurrToolBarDefaultList.IndexOf( Pointer( AfterAct ));
  if AfterActInd = -1 then
    Exit;

  for N := 0 to High( ArrayAction ) do
    CurrToolBarDefaultList.Insert( AfterActInd + N + 1, Pointer( ArrayAction[ N ] ));

  Bar := ShowAssignToolBar( TB, False );
  if not Assigned( Bar ) then
    Exit;

  try
    LastAction := ActManager.FindItemByAction( AfterAct );
    if not Assigned( LastAction ) then
      Exit;

    If LoadActionListFromDB( Sender, Bar, TB.Caption, LastAction, ArrayAction, True ) then
      Exit;

    try
      for N := 0 to High( ArrayAction ) do
        AddActionInToolBar( Bar, ArrayAction[ N ], LastAction );

      ToolBarRefresh( Bar );
      Bar.ActionBar.Visible := Bar.Items.Count > 0;
      Bar.ActionBar.Height := 22;
    finally
      ShowMenuItem;
    end;
  finally
    PostMessage( Self.Handle, CM_SetActionbarWidth, Integer( Pointer( Bar )), 0 );
  end;
end;

procedure TfrPrima.AddActListInBar( TB: TActionToolBar; AfterAct: TAction; ArrayAction: array of TAction);
var
Bar: TActionBarItem;
N: Integer;
LastAction: TActionClientItem;
begin
  Bar := ShowAssignToolBar( TB, False );
  if not Assigned( Bar ) then
    Exit;

  try
    LastAction := ActManager.FindItemByAction( AfterAct );
    if not Assigned( LastAction ) then
      Exit;

    try
      for N := 0 to High( ArrayAction ) do
        AddActionInToolBar( Bar, ArrayAction[ N ], LastAction );

      ToolBarRefresh( Bar );
      Bar.ActionBar.Visible := Bar.Items.Count > 0;
      Bar.ActionBar.Height := 22;
    finally
      ShowMenuItem;
    end;
  finally
    PostMessage( Self.Handle, CM_SetActionbarWidth, Integer( Pointer( Bar )), 0 );
  end;
end;

procedure TfrPrima.SetWithActionBar( Bar: TActionBarItem );
var
N, L: Integer;
begin
  ToolBarRefresh( Bar );
  if aTbServ = Bar.ActionBar then
    L := 15
  else
    L := 55;

  for N := 0 to Bar.Items.Count - 1 do begin
    if Bar.Items[ N ].Control.Visible then
      Inc( L, Bar.Items[ N ].Control.Width );
  end;

  Bar.ActionBar.ClientWidth := L;
  Bar.ActionBar.AutoSizing := True;
end;

procedure TfrPrima.ToolBarRefresh( Bar: TActionBarItem );
var
N: Integer;
LastIsSeparator: Boolean;
begin
  LastIsSeparator := True;
  if not Assigned( Bar ) then
    Exit;

  for N := 0 to Bar.Items.Count - 1 do begin
    if Bar.Items[ N ].Control.Separator then begin
      if LastIsSeparator then
        Bar.Items[ N ].Control.Visible := False;
    end;
    if Bar.Items[ N ].Visible and
       ( Bar.Items[ N ].Caption <> '' ) then
      LastIsSeparator := Bar.Items[ N ].Control.Separator;
  end;
end;

procedure TfrPrima.ShowException(Sender: TObject; E: Exception);
  procedure GetMessageText( var Value: String );
  var
  NewText: String;
  begin
    NewText := '';
    with TRegExpr.Create do
      try
        Expression:= '#START#(.*?)#END##';
        if ( Exec( Value ) ) then
          NewText:= Match[ 1 ];
      finally
        Screen.Cursor := crDefault;
        Free;
      end;
    if NewText <> '' then
      Value := NewText;
  end;

var
IsClose: Boolean;
MessText: String;
begin
  IsClose := False;
  try
    if E is EExternalException  then
      Halt( 33 );

    IsClose := True;

    if PosCase( E.Message, 'Error reading from socket', True ) > 0 then begin
      MessText := 'Сервер недоступен';
    end
    else
    if PosCase( E.Message, 'No server available', True ) > 0 then begin
      MessText := 'Сервер недоступен';
    end
    else begin
      IsClose := False;
      If E is EFIBError then
        MessText := EFIBError( E ).Message
      else
        MessText := E.Message;
    end;
    GetMessageText( MessText );

    MessageBox( Application.Handle, PChar( MessText ), PChar( Self.Caption ), MB_SYSTEMMODAL or MB_ICONINFORMATION or MB_OK );
  finally
    If IsClose then
      FrPrima.Close;
  end;
end;

procedure TFrPrima.ShowNextWindow(Sender: TObject);
var
N, L: integer;
begin
  try
    A_NextWindow.Enabled := False;
    L := MDIChildCount;
    If L = 1 then
      Exit;
    For N := 0 to L - 1 do
      If MDIChildren[ N ].Active then begin
        If N <> L - 1 then
          MDIChildren[ N + 1 ].Show
        else
          MDIChildren[ 0 ].Show;
        Break;
      end;
    Application.ProcessMessages;
    Sleep( 1000 );
  finally
    A_NextWindow.Enabled := True;
  end;
end;

procedure TfrPrima.A_CloseAllExecute(Sender: TObject);
var
N, L: Integer;
begin
  A_CloseAll.Enabled := False;
  try
    L := MDIChildCount;
      If L = 0 then
        Exit;

    for N := L - 1 downto 0 do begin
      MDIChildren[ N ].Close;
    end;
    Application.ProcessMessages;
    Sleep( 500 );
  finally
    A_CloseAll.Enabled := True;
  end;
end;

procedure TfrPrima.A_CloseAllUpdate(Sender: TObject);
begin
  A_CloseAll.Enabled := MDIChildCount > 0;
end;

procedure TfrPrima.CreateTempDirectory(var Message: TMessage);
begin
  TempDir := ExtractFileDir( ParamStr( 0 ));
  TempDir := Concat( TempDir, '\', 'Temp\' );
  If DirectoryExists( TempDir ) then
    RemoveNoEmptyDir( TempDir );

  ForceDirectories( TempDir );
end;

procedure TfrPrima.ShowMenuItem;
begin
  try
    M_Journal.Visible := M_Journal.Count > 0;
    M_Sprav.Visible := M_Sprav.Count > 0;
    M_Transact.Visible := M_Transact.Count > 0;
    M_Report.Visible := M_Report.Count > 0;
    mnImport.Visible := mnImportCsv.Visible or mnImportWWW.Visible;
  finally
    aTbTransact.Left := aTbServ.Width - 10;
  end;
end;

procedure TfrPrima.ChildFormClose( var Message: TMessage );
var
N: Integer;
begin
	for N := MDIChildCount - 1 downto 0 do
    try
      MDIChildren[ N ].Close;
    except
      raise;
		end;
end;

procedure TfrPrima.CreateMenuSpravAndReport;
begin
  CreateSpravMenu( M_Sprav, sprSpravParent );
  CreateReportMenu( M_Report, rpReportParent );
  ShowMenuItem;
end;

procedure TfrPrima.CreateReportMenu(ReportMenu: TMenuItem; ParentID: Integer);
const
sqlMenuReport =
'select * from GET_REPORT_LIST(:PARENT_ID, :USER_LIST_ID) order by REPORT_TITLE';

var
Query: TNewQuery;
M_Item: TMenuItem;
begin
  try
    Query := TNewQuery.CreateNew( Self, nil );
    try
      Query.SQL.Text := sqlMenuReport;
      Query.ParamByName( 'PARENT_ID' ).AsInteger := ParentID;
      Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
      try
        Query.ExecQuery;
      except
        Raise;
      end;

      While not Query.Eof do begin
        M_Item := TMenuItem.Create( ReportMenu );
        With M_Item do begin
          Caption := Query.FieldByName( 'REPORT_TITLE' ).AsString;
          Tag     := Query.FieldByName( 'REPORT_LIST_ID' ).AsInteger;
          OnClick    := nil;
          if Query.FieldByName( 'IS_PARENT' ).AsInteger = 1 then
            CreateReportMenu( M_Item, Tag )
          else
            OnClick := ShowReport;

          ReportMenu.Add( M_Item );
        end;

        Query.Next;
      end;
    finally
      Query.FreeAndCommit;
    end;
  finally
    //
  end;
end;

procedure TfrPrima.ShowRightFuncSprav( Sender: TObject );
begin
  With TFrFuncRight.Create( Self ) do
    try
      ShowModal;
    finally
      Release;
    end;
end;

procedure TFrPrima.CreateSpravMenu( SpravMenu: TMenuItem; ParentID: Integer );
const
sqlMenuSprav =
'select * from GET_SPRAV_LIST(:PARENT_DIALOG_ID, :USER_LIST_ID) order by DIALOG_CAPTION';
var
Query: TNewQuery;
M_Item: TSpravMenu;

  procedure AddRightFuncSprav;
  begin
    if ParentID <> sprAdminRight then   // В меню Администрирование
      Exit;
    M_Item := TSpravMenu.Create( TSpravMenu( SpravMenu ));
    With M_Item do begin
      Caption := 'Права на доступ к данным';
      OnClick := ShowRightFuncSprav;
      SpravMenu.Add( M_Item );
    end;
    M_Item := TSpravMenu.Create( TSpravMenu( SpravMenu ));
    With M_Item do begin
      Caption := '-';
      OnClick := nil;
      SpravMenu.Add( M_Item );
    end;
  end;

begin
  AddRightFuncSprav;
  try
    Query := TNewQuery.CreateNew( Self, nil );
    try
      Query.SQL.Text := sqlMenuSprav;
      Query.ParamByName( 'PARENT_DIALOG_ID' ).AsInteger := ParentID;
      Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
      try
        Query.ExecQuery;
      except
        Raise;
      end;

      While not Query.Eof do begin
        M_Item := TSpravMenu.Create( TSpravMenu( SpravMenu ));
        With M_Item do begin
          Caption := Query.FieldByName( 'DIALOG_CAPTION' ).AsString;
          Tag     := Query.FieldByName( 'DIALOG_ID' ).AsInteger;
          RightValue := Query.FieldByName( 'RIGHT_VALUE' ).AsInteger;
          OnClick    := nil;
          if Query.FieldByName( 'IS_PARENT' ).AsInteger = 1 then
            CreateSpravMenu( M_Item, Tag )
          else
            OnClick := ShowSpravForm;

          SpravMenu.Add( M_Item );
        end;

        Query.Next;
      end;
    finally
      Query.FreeAndCommit;
    end;
  finally
    //
  end;
end;

procedure TFrPrima.ShowSpravForm( Sender: TObject );
var
SpravMenu: TSpravMenu;
Fr: TfrCustomSprav;
FrClassName: String;
begin
  SpravMenu := TSpravMenu( Sender );
  case SpravMenu.Tag of
    sprMailTemplate:
      FrClassName := TfrMailTemplate.ClassName;
    sprFileImages:
      FrClassName := TfrSpravFileImages.ClassName;
    sprGroupSubscribe:
      FrClassName := TfrGroupSuscribeSprav.ClassName;
    else
      FrClassName := TfrCustomSprav.ClassName;
  end;

  Fr := TfrCustomSprav( FindChildMDIForm( FrClassName, SpravMenu.Caption, True ));
  If Assigned( Fr ) then
    Fr.Show
  else begin
    case SpravMenu.Tag of
      sprMailTemplate:
        TfrMailTemplate.ShowSprav( SpravMenu.Caption, SpravMenu.Tag, SpravMenu.RightValue, True );
      sprFileImages:
        TfrSpravFileImages.ShowSprav( SpravMenu.Caption, SpravMenu.Tag, SpravMenu.RightValue, True );
      sprGroupSubscribe:
        TfrGroupSuscribeSprav.ShowSprav( SpravMenu.Caption, SpravMenu.Tag, SpravMenu.RightValue, True );
      else
        TfrCustomSprav.ShowSprav( SpravMenu.Caption, SpravMenu.Tag, SpravMenu.RightValue, True );
    end;
  end;
end;

/// Обновление версии "Пускача" и связанных с ним файлов
procedure TfrPrima.StartExeExecute(var Message: TMessage);
const
sqlExe =
'select' + #13#10 +
'  E.DATE_UPDATE, E.FILE_NAME, E.EXE_FILES_LIST_ID, E.ON_EXECUTE' + #13#10 +
'from EXE_FILES_LIST E' + #13#10 +
'where' + #13#10 +
'  ( E.ON_EXECUTE = 3 ) or ( E.IS_DATABASE = 1 )';

var
ExeStart: String;
F, F_Date, U_Date: Integer;
Query: TNewQuery;
SaveDir, HostDir, StartDir, UpdateExe: String;

  function GetSaveDir( const FileName: String ): String;
  begin
    case AnsiSameText( FileName, 'firebird.msg' ) of
      True:
        Result := HostDir;
      else
        Result := StartDir;
    end;
  end;

begin
  HostDir := IncludeTrailingPathDelimiter( GetFolderPath( CSIDL_APPDATA )) + 'LPT\';

  StartDir := HostDir + 'StartDir\';
  if not DirectoryExists( StartDir ) then
    ForceDirectories( StartDir );

  UpdateExe := HostDir + 'Lsrm\';
  if not DirectoryExists( UpdateExe ) then
    Exit;

  UpdateExe := UpdateExe + 'StartUpdate.exe';
  if not FileExists( UpdateExe ) then
    Exit;

	Query := TNewQuery.CreateNew( Self, nil );
	try
		Query.SQL.Text := sqlExe;
		try
			Query.ExecQuery;
		except
			Raise;
		end;

    while Not Query.Eof do begin
      ExeStart := Query.FieldByName( 'FILE_NAME' ).AsString;
      SaveDir  := GetSaveDir( ExeStart );
      ChDir( SaveDir );
      ExeStart := ExpandUNCFileName( ExeStart );

      F := FileOpen( ExeStart, fmOpenReadWrite );
      try
        F_Date := FileGetDate( F );
      finally
        FileClose( F );
      end;
      U_Date := DateTimeToFileDate( Query.FieldByName( 'DATE_UPDATE' ).AsDateTime );
      If (( F_Date = -1 ) or ( F_Date <> U_Date )) then
        ExecuteFile( UpdateExe, '"' +
                     Query.FieldByName( 'EXE_FILES_LIST_ID' ).AsString + '" "' +
                     ExeStart + '" "' +
                     frDM.IBDB.DBName + '" "' +
                     frDM.IBDB.ConnectParams.UserName + '" "' +
                     frDM.IBDB.ConnectParams.Password + '" "' +
                     frDM.IBDB.ConnectParams.RoleName + '"',
                     SaveDir,
                     SW_HIDE );

      If ( Query.FieldByName( 'ON_EXECUTE' ).AsInteger = 3 ) then
        CrShCutIcon( CSIDL_DESKTOP, '',
                     ExeStart, Self.Caption, StartDir, ExeStart, 0 );

      Query.Next;
      Application.ProcessMessages;
    end;
	finally
		Query.FreeAndCommit;
	end;
end;

procedure TFrPrima.ShowReport( Sender: TObject );
begin
  TfrReportFiltr.ShowReportFiltr( TMenuItem( Sender ));
end;

procedure TfrPrima.CreateSubMenu(AOwner: TMenuItem; List: TArrayAction);
var
N: Integer;
SubItem: TMenuItem;
begin
  If not Assigned( AOwner ) then
    Exit;

  For N := 0 to High( List ) do begin
    SubItem := TMenuItem.Create( AOwner );
    SubItem.Action := List[ N ];
    AlignProperty( SubItem, N, List[ N ] );

    If SubItem.Action is TPopMenuAction then
      CreateSubMenu( SubItem, TPopMenuAction( SubItem.Action ).List );

    AOwner.Add( SubItem );
  end;
end;

function TfrPrima.FindChildMDIForm(FormClassName, FormCaption: String; StartCaption: Boolean = False ): TForm;
var
N: Integer;
Fr: TForm;
begin
  Result := nil;
  For N := 0 to FrPrima.MDIChildCount - 1 do begin
    Fr := FrPrima.MDIChildren[ N ];
    If AnsiSameText( Fr.ClassName, FormClassName ) and
       (( FormCaption = '' ) or
          AnsiSameText( Fr.Caption, FormCaption ) or
          ( StartCaption and ( Pos( FormCaption, Fr.Caption ) = 1 ))) then begin
       Result := Fr;
       Break;
    end;
  end;
end;

procedure TfrPrima.FormActivate(Sender: TObject);
begin
  ChildFormDeactivate( Self );
end;

procedure TfrPrima.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned( CurrToolBarDefaultList ) then
    CurrToolBarDefaultList.Free;

  SendMessage( Self.Handle, CM_ChildFormClose, 0, 0 );
end;

procedure TfrPrima.FormCreate(Sender: TObject);
begin
  Self.WindowState := wsMaximized;
  CurrToolBarDefaultList := TList.Create;
  A_Clipboard.SetMenuArray([ A_EditCut, A_EditCopy, A_EditPaste, A_Sp, A_EditSelectAll, A_EditUndo ]);
  Application.OnException := ShowException;
  PostMessage( Self.Handle, CM_ClearTempDir, 0, 0 );
  Self.Width := ( Screen.Width * 3 ) div 4;
  Self.Height := ( Screen.Height * 3 ) div 4;
end;

procedure TfrPrima.FormShow(Sender: TObject);
begin
  A_PrinterListExecute( nil );
  ConnectExecute( nil );
  Application.ProcessMessages;
  PostMessage( Self.Handle, CM_StartExe, 0, 0 );
  PostMessage( Self.Handle, CM_ShowPrimaToolBar, 0, 0 );
end;

procedure TfrPrima.ShowHostMenuAndToolBar(var Message: TMessage);
begin
  SetMainMenuList( M_Journal, ppPrima,
          [ A_ClientsList, A_FirmList, A_Subscribe, A_Sp,
            A_DownLoadList, A_AgreesList, A_SoftDelivery, A_ClientTraining, A_KeysList ] );
  FillActionBarFromDB( Self, aTbServ, '',
          [ A_ClientsList, A_FirmList, A_Subscribe, A_Sp,
            A_DownLoadList, A_AgreesList, A_SoftDelivery, A_ClientTraining, A_KeysList ]);
end;

procedure TfrPrima.HideAllToolBar;
var
N: Integer;
begin
  for N := 0 to ActManager.ActionBars.Count - 1 do
    ActManager.ActionBars[ N ].Visible := False;
end;

function TfrPrima.LoadActionListFromDB( Sender: TCustomForm; Bar: TActionBarItem; const BarCaption: string; LastAction: TActionClientItem; ArrayAction: array of TAction; IsAdd: Boolean ): Boolean;
const
sqlBarParam =
'select' + #13#10 +
'  ACTION_NAME' + #13#10 +
'from ACTION_BAR_PARAMS_S(:USER_LIST_ID, :FORM_CLASS, :BAR_NAME)';

var
AddAct: TAction;
Query: TNewQuery;
begin
  Result := False;
  Query := TNewQuery.CreateNew(Self, nil);
  try
    Query.SQL.Text := sqlBarParam;
    if not Query.Prepared then
      Query.Prepare;
    try
      Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
      Query.ParamByName( 'FORM_CLASS' ).AsString := Sender.ClassName;
      Query.ParamByName( 'BAR_NAME' ).AsString := BarCaption;
      Query.ExecQuery;
    except
      raise ;
    end;

    if not ( Query.Eof and Query.Bof ) then begin
      Result := True;
      while not Query.Eof do begin
        if IsAdd then
          Exit;
        AddAct := FindActionInArrayOfName( Query.FieldByName( 'ACTION_NAME' ).AsString, ArrayAction );
        AddActionInToolBar( Bar, AddAct, LastAction );
        Query.Next;
      end;
    end;

  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrPrima.AddActionInToolBar(Bar: TActionBarItem; AddAct: TAction; var LastAction: TActionClientItem);
var
CurrAction: TActionClientItem;

  procedure CreateSubMenu( Item: TActionClientItem; Act: TPopMenuAction );
  var
  N: Integer;
  NewItem: TActionClientItem;
  begin
    for N := 0 to High( Act.List ) do begin
      NewItem := Item.Items.Add;
      NewItem.Action := Act.List[ N ];
      if Act.List[ N ] is TPopMenuAction then
        CreateSubMenu( NewItem, Act.List[ N ] as TPopMenuAction );
    end;
    Item.CommandStyle := csMenu;
  end;

begin
  if Assigned( AddAct ) and
     Assigned( AddAct.Owner ) then begin
    if Assigned(LastAction) then begin
      if AddAct = A_Sp then
        CurrAction := ActManager.AddSeparator( LastAction, True )
      else
        CurrAction := ActManager.AddAction( AddAct, LastAction, True );
    end
    else begin
      if AddAct <> A_Sp then begin
        CurrAction := TActionClientItem( Bar.Items.Add );
        CurrAction.Action := AddAct;
      end
      else
        Exit;
    end;

    if AddAct is TPopMenuAction then begin
      CreateSubMenu( CurrAction, AddAct as TPopMenuAction );
    end;

    CurrAction.ShowCaption := False;
    LastAction := CurrAction;
  end;
end;

function TfrPrima.ShowAssignToolBar( TB: TActionToolBar; IsShow: Boolean ): TActionBarItem;
var
N, IndOfNil: Integer;
begin
  Result := nil;
  IndOfNil := -1;
  for N := 0 to ActManager.ActionBars.Count - 1 do
    if Not Assigned( ActManager.ActionBars[ N ].ActionBar ) then
      IndOfNil := N
    else
    if ActManager.ActionBars[ N ].ActionBar = TB then begin
      Result := ActManager.ActionBars[ N ];
      Break;
    end;

  if ( Not Assigned( Result )) and ( IndOfNil <> -1 ) then begin
    Result := ActManager.ActionBars[ IndOfNil ];
    Result.ActionBar := TB;
  end
  else
  if ( Not Assigned( Result )) and ( IndOfNil = -1 ) then begin
    Result := ActManager.ActionBars.Add;
    Result.ActionBar := TB;
  end;

  if Assigned( Result ) then begin
    Result.Visible := IsShow;
    Result.Index := 0;
    TActionClients( Result.Items ).CaptionOptions := coNone;
  end;
end;

procedure TFrPrima.ChildFormDeactivate(Sender: TObject);
  procedure MenuClear( M_Item: TMenuItem );
  begin
    If M_Item.Visible then
      try
        M_Item.Clear;
      finally
        M_Item.Visible := False;
      end;
  end;

begin
  try
    ShowAssignToolBar( aTbTransact, False );
    MenuClear ( M_Transact );
    ShowMenuItem;
  finally
    SB.Panels[ 1 ].Text := '';
    SB.Panels[ 2 ].Text := '';
  end;
end;


end.
