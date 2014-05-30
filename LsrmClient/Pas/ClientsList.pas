{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ClientsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomForm, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList,
  Vcl.ComCtrls, DBGridEhGrouping, ToolCtrlsEh, GridsEh, DBGridEh, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery,
  DlgExecute, DlgParams, pFIBStoredProc, Data.DB, Vcl.OleCtrls, SHDocVw;

type
  TfrClienstList = class(TfrCustomForm)
    PC: TPageControl;
    tsClients: TTabSheet;
    tsDownload: TTabSheet;
    tsKeys: TTabSheet;
    Q_Clients: TpFIBDataSet;
    dsClients: TDataSource;
    dbgClients: TDBGridEh;
    A_NewClient: TAction;
    A_EditClient: TAction;
    A_DelClient: TAction;
    Q_Download: TpFIBDataSet;
    dsDownLoad: TDataSource;
    dbgDownLoad: TDBGridEh;
    dsKeyList: TDataSource;
    Q_FillKey: TpFIBDataSet;
    dsFillKey: TDataSource;
    dbgFillKey: TDBGridEh;
    dbgKeyList: TDBGridEh;
    spKeys: TSplitter;
    tsDelivery: TTabSheet;
    dbgDelivery: TDBGridEh;
    SpDelivery: TSplitter;
    dbgProductOnAgrees: TDBGridEh;
    dsDelivery: TDataSource;
    Q_ProductList: TpFIBDataSet;
    dsProductList: TDataSource;
    Q_Delivery: TpFIBDataSet;
    tsTraining: TTabSheet;
    dbgTraining: TDBGridEh;
    Q_Training: TpFIBDataSet;
    dsTraining: TDataSource;
    Q_KeyList: TpFIBDataSet;
    A_ExportInCSV: TAction;
    tsSubscribe: TTabSheet;
    dbgSubscribe: TDBGridEh;
    Q_Subscribe: TpFIBDataSet;
    dsSuscribe: TDataSource;
    A_GroupSubscribe: TAction;
    tsSendSubscribe: TTabSheet;
    dbgSendSubscribe: TDBGridEh;
    Q_SendSubscribe: TpFIBDataSet;
    dsSendSubscribe: TDataSource;
    WB: TWebBrowser;
    spSendSubscribe: TSplitter;
    A_AddCopyClient: TAction;
    A_NewFirm: TAction;
    A_EditFirm: TAction;
    A_NewClientTraining: TAction;
    A_EditClientTraining: TAction;
    A_DelClientTraining: TAction;
    A_AddClientTraining: TAction;
    procedure PCChange(Sender: TObject);
    procedure PCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure A_NewClientExecute(Sender: TObject);
    procedure A_EditClientExecute(Sender: TObject);
    procedure A_DelClientExecute(Sender: TObject);
    procedure Q_DownloadBeforeOpen(DataSet: TDataSet);
    procedure Q_KeyListBeforeOpen(DataSet: TDataSet);
    procedure Q_FillKeyBeforeOpen(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject); override;
    procedure Q_DeliveryBeforeOpen(DataSet: TDataSet);
    procedure Q_ProductListBeforeOpen(DataSet: TDataSet);
    procedure Q_TrainingBeforeOpen(DataSet: TDataSet);
    procedure dbGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Q_ClientsAfterScroll(DataSet: TDataSet);
    procedure Q_ClientsBeforeOpen(DataSet: TDataSet);
    procedure Q_TrainingAfterScroll(DataSet: TDataSet);
    procedure Q_KeyListAfterScroll(DataSet: TDataSet);
    procedure Q_FillKeyAfterScroll(DataSet: TDataSet);
    procedure Q_DeliveryAfterScroll(DataSet: TDataSet);
    procedure Q_ProductListAfterScroll(DataSet: TDataSet);
    procedure A_ExportInCSVExecute(Sender: TObject);
    procedure dbgClientsEnter(Sender: TObject);
    procedure dbgDownLoadEnter(Sender: TObject);
    procedure dbgKeyListEnter(Sender: TObject);
    procedure dbgFillKeyEnter(Sender: TObject);
    procedure dbgDeliveryEnter(Sender: TObject);
    procedure dbgProductOnAgreesEnter(Sender: TObject);
    procedure dbgTrainingEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Q_SubscribeBeforeOpen(DataSet: TDataSet);
    procedure Q_SubscribeAfterScroll(DataSet: TDataSet);
    procedure dbgSubscribeEnter(Sender: TObject);
    procedure A_GroupSubscribeExecute(Sender: TObject);
    procedure Q_SendSubscribeBeforeOpen(DataSet: TDataSet);
    procedure Q_SendSubscribeEndScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure Q_ClientsBeforeScroll(DataSet: TDataSet);
    procedure Q_SendSubscribeAfterScroll(DataSet: TDataSet);
    procedure Q_DownloadAfterScroll(DataSet: TDataSet);
    procedure A_AddCopyClientExecute(Sender: TObject);
    procedure A_NewFirmExecute(Sender: TObject);
    procedure A_EditFirmExecute(Sender: TObject);
    procedure A_AddClientTrainingExecute(Sender: TObject);
    procedure A_DelClientTrainingExecute(Sender: TObject);
    procedure A_EditClientTrainingExecute(Sender: TObject);
    procedure A_NewClientTrainingExecute(Sender: TObject);
  private
    { Private declarations }
    HtmlTemp: String;

    procedure FillClientsMenu;
    procedure FillDownLoadMenu;
    procedure FillKeyListMenu;
    procedure FillSaleAgreesMenu;
    procedure FillTrainingMenu;
    procedure FillSubscribeMenu;

    procedure ShowClientsDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure SetDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
    procedure ClientDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);

    function CheckClientsIsSelfRecord( Sender: TObject; DS: TpFIBDataSet ): Boolean;
    procedure SaveDataInCSV(const FileName: String);
    procedure SaveHtmlTextToTemp(var FileName: String);
    procedure FirmListResultIns( Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc );
    procedure ShowTrainingDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure GetCurrClientListValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
  public
    { Public declarations }
    class procedure ShowClientsForm( Act: TAction );
  end;


implementation

uses
  ConstList, Prima, Procs, ClientDM, RightType, RecordEdit, Math, SqlTools, GridDlg, RecordClients;

{$R *.dfm}


procedure TfrClienstList.A_AddCopyClientExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyClient.Visible and A_AddCopyClient.Enabled ) then
    Exit;

  ShowClientsDlg( Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger, sdCopy, A_AddCopyClient );
end;

procedure TfrClienstList.A_DelClientExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelClient.Visible and A_DelClient.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Clients, 'CLIENT_LIST_IUD', 'Удалить текущую запись?', '',
                [ 'CLIENT_LIST_ID' ], [ Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger ] );
end;

procedure TfrClienstList.A_EditClientExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditClient.Visible and A_EditClient.Enabled ) then
    Exit;

  ShowClientsDlg( Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger, sdEdit, A_EditClient );
end;

procedure TfrClienstList.A_NewClientExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewClient.Visible and A_NewClient.Enabled ) then
    Exit;

  A_EditFirm.Enabled := False;
  ShowClientsDlg( -1, sdInsert, A_NewClient );
end;

procedure TfrClienstList.ShowClientsDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAfterFillRow := SetDlgDefaultValue;
  CurrDlgEvent.OnCheckIsSelf := CheckClientsIsSelfRecord;
  CurrDlgEvent.OnSmartDlgSetEditText := ClientDlgSetEditText;

  ShowEditDialog( Self, TfrRecordClients, Q_Clients, 'CLIENT_LIST_ID', dlgClientsList, ID, DlgType, Act, CurrDlgEvent, [ ID ]);
end;

procedure TfrClienstList.ClientDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
begin
  if not ( TCustomSmartDlg( Dlg ).Owner is TfrRecordClients ) then
    Exit;

  if AnsiSameText( CurrItem.FieldName, 'FIRM_LIST_SHORT' ) then begin
    ( TCustomSmartDlg( Dlg ).Owner as TfrRecordClients ).A_EditFirm.Enabled := CurrItem.RowValue <> '';
  end;
end;

procedure TfrClienstList.A_NewFirmExecute(Sender: TObject);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  inherited;
  if not ( A_NewFirm.Visible and A_NewFirm.Enabled ) then
    Exit;

  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAfterFillRow := SetFirmDlgDefaultValue;
  CurrDlgEvent.OnCheckIsSelf := nil;
  CurrDlgEvent.OnSmartDlgSetEditText := SmartDlgSetEditText;
  CurrDlgEvent.OnSaveResult := FirmListResultIns;

  ShowEditDialog( TAction( Sender ).Owner, TfrRecordEdit, nil, 'FIRM_LIST_ID', dlgFirmList, -1, sdInsert,
                  TAction( Sender ), CurrDlgEvent, [ -1 ]);
end;

procedure TfrClienstList.A_EditFirmExecute(Sender: TObject);
var
CurrDlgEvent: TOnEditDialogEvent;
CurrItem: TPropertyItem;
ID: Integer;
begin
  inherited;
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAfterFillRow := SetFirmDlgDefaultValue;
  CurrDlgEvent.OnCheckIsSelf := nil;
  CurrDlgEvent.OnSmartDlgSetEditText := SmartDlgSetEditText;
  CurrDlgEvent.OnSaveResult := FirmListResultIns;

  Application.ProcessMessages;

  try
    if TAction( Sender ).Owner is TfrRecordEdit then
      with TfrRecordEdit( TAction( Sender ).Owner ) do begin
        SmartDlg.UpdateEditText;
        CurrItem := SmartDlg.RowsList.PropByHostFieldName( 'FIRM_LIST_SHORT' );
        if Assigned( CurrItem ) and ( CurrItem.RowValue <> '' ) then begin
          ID := CurrItem.RowValueID;
          ID := IfThen( ID = 0, -1, ID );
        end
        else
          Exit;
      end
    else
      ID := Q_Clients.FBN( 'FIRM_LIST_ID' ).AsInteger;

    if ID = -1 then
      Exit;

    ShowEditDialog( TAction( Sender ).Owner, TfrRecordEdit, nil, 'FIRM_LIST_ID', dlgFirmList, ID, sdEdit,
                    TAction( Sender ), CurrDlgEvent, [ ID ]);
  finally
    if TAction( Sender ).Owner is TfrClienstList then
      Q_Clients.Refresh;
  end;
end;

procedure TfrClienstList.FirmListResultIns( Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc );
const
sqlFirm =
'select FIRM_LIST_SHORT from FIRM_LIST where FIRM_LIST_ID = :ID';

var
ClientDlg: TfrRecordEdit;
CurrItem: TPropertyItem;
begin
  if not ( Sender is TfrRecordEdit ) then
    Exit;
  if not (( Sender as TfrRecordEdit ).OwnerForm is TfrRecordEdit ) then
    Exit;
  ClientDlg := ( Sender as TfrRecordEdit ).OwnerForm as TfrRecordEdit;
  CurrItem := ClientDlg.SmartDlg.RowsList.PropByHostFieldName( 'FIRM_LIST_SHORT' );
  if not Assigned( CurrItem ) then
    Exit;

  if not Assigned( SP.FindField( 'RESULT_ID' )) then
    Exit;

  try
    CurrItem.RowValueID := SP.FieldByName( 'RESULT_ID' ).AsInteger;
    CurrItem.RowValue := GetQueryStrField( sqlFirm, 'FIRM_LIST_SHORT', [ CurrItem.RowValueID ], SP.Transaction );
  finally
    ClientDlg.SmartDlg.Refresh;
    Application.ProcessMessages;
  end;
end;

function TfrClienstList.CheckClientsIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
begin
  Result :=
    Q_Clients.FBN( 'REG_PERSONAL_ID' ).AsInteger = CurrentUserID;
end;

procedure TfrClienstList.SetDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  With TfrRecordEdit( Sender ) do begin
    if AnsiSameText( 'FIRM_LIST_SHORT', Item.FieldName ) then
      A_EditFirm.Enabled := Item.RowValue <> '';

    if dlgFillRows.ActionType <> sdInsert then
      Exit;
    case IndexOfStrArray( Item.FieldName, [ 'LAND_TITLE', 'DATE_REGISTR', 'PERSONAL_TITLE' ]) of
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
    end;
  end;
end;

procedure TfrClienstList.A_GroupSubscribeExecute(Sender: TObject);
var
ID: Integer;
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  inherited;
  if not ( A_GroupSubscribe.Visible and A_GroupSubscribe.Enabled ) then
    Exit;
  ID := Q_Subscribe.FBN( 'CLIENTS_MAIL_LIST_ID' ).AsInteger;
  CurrDlgEvent.OnCheckIsSelf := CheckClientsIsSelfRecord;

  ShowEditDialog( Self, TfrRecordEdit, Q_Subscribe, 'CLIENTS_MAIL_LIST_ID', dlgSubscribe, ID, sdEdit, A_GroupSubscribe, CurrDlgEvent, [ ID ] );
end;

procedure TfrClienstList.dbgDeliveryEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

procedure TfrClienstList.dbgClientsEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

procedure TfrClienstList.dbgDownLoadEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

procedure TfrClienstList.dbgFillKeyEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

procedure TfrClienstList.dbgKeyListEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

procedure TfrClienstList.dbgProductOnAgreesEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

procedure TfrClienstList.dbgSubscribeEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

procedure TfrClienstList.dbGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift <> [] then
    Exit;
  if Key <> VK_RETURN then
    Exit;
  if not ( Sender is TDBGridEh ) then
    Exit;
  case IndexOfStrArray(( Sender as TDBGridEh ).Name,
                       [ dbgTraining.Name, dbgDelivery.Name, dbgProductOnAgrees.Name, dbgKeyList.Name, dbgFillKey.Name,
                         dbgClients.Name, dbgSubscribe.Name ])  of
    5: A_EditClientExecute( A_EditClient );
    6: A_GroupSubscribeExecute( A_GroupSubscribe );
  end;
end;

procedure TfrClienstList.dbgTrainingEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;

class procedure TfrClienstList.ShowClientsForm(Act: TAction);
begin
  With TfrClienstList.Create( Application ) do begin
    try
      IsWriteRight := False;
      A_Filtr.DlgIdent := dlgClientsList;

      PC.ActivePage := tsClients;
      ActiveControl := dbgClients;

      SetAccessRight( Act.Name );
      A_AddCopyClient.Visible := A_NewClient.Visible;
      Caption := Act.Caption;
      FormCaption := Act.Caption;
      FormActivate( nil );

      Application.ProcessMessages;
      PCChange( nil );

      if SetAccessRightOfRows( Q_Clients, Format( '( REG_PERSONAL_ID = %D )', [ CurrentUserID ])) then begin
        HostSqlText := Q_Clients.SelectSQL.Text;

        OpenDataSetOfStartForm;
      end;
    finally
      If not Q_Clients.Active then
        Close;
    end;
  end;
end;

procedure TfrClienstList.FillClientsMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_NewFirm, A_EditFirm, A_Sp, A_AddCopyClient, A_Sp, A_NewClient, A_EditClient, A_DelClient, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_ExportInCSV, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
    FillActionBarFromDB( Self, aTbTransact, 'Журнал "Клиенты"',
            [ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewFirm, A_EditFirm, A_Sp, A_NewClient, A_EditClient, A_DelClient, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_ExportInCSV, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ]);
  end;
end;

procedure TfrClienstList.FillDownLoadMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Клиенты - страница "Загрузки"',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrClienstList.FillTrainingMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddClientTraining, A_sp, A_NewClientTraining, A_EditClientTraining, A_DelClientTraining, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Клиенты - страница "Обучение"',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewClientTraining, A_EditClientTraining, A_DelClientTraining, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrClienstList.FillSubscribeMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_GroupSubscribe, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Клиенты - страница "Рассылки"',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_GroupSubscribe, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrClienstList.FillKeyListMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Клиенты - страница "Ключи"',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrClienstList.FillSaleAgreesMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Клиенты - страница "Договора"',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrClienstList.FormActivate(Sender: TObject);
begin
  inherited;
  case IndexOfStrArray( PC.ActivePage.Name, [
         tsClients.Name, tsDownload.Name, tsKeys.Name, tsDelivery.Name, tsTraining.Name ]) of
    0: FillClientsMenu;
    1: FillDownLoadMenu;
    2: FillKeyListMenu;
    3: FillSaleAgreesMenu;
    4: FillTrainingMenu;
  end;
end;

procedure TfrClienstList.FormClose(Sender: TObject; var Action: TCloseAction);
var
AllowChange: Boolean;
begin
  try
    DBGridToBase( dbgClients, Self.ClassName, dbgClients.Name );
    PCChanging( PC, AllowChange );
  finally
    //
  end;
  inherited;
end;

procedure TfrClienstList.FormCreate(Sender: TObject);
begin
  inherited;
  HtmlTemp := IncludeTrailingPathDelimiter( frPrima.TempDir ) + 'ClientSend\';
  ForceDirectories( HtmlTemp );
end;

procedure TfrClienstList.FormResize(Sender: TObject);
begin
  inherited;
  dbgKeyList.Width := Self.ClientWidth div 3;
  dbgDelivery.Width := Self.ClientWidth div 3;
  dbgSendSubscribe.Width := Self.ClientWidth div 2;
end;

procedure TfrClienstList.PCChange(Sender: TObject);
var
ClientID: Integer;
begin
  inherited;
  if Q_Clients.Active then
    ClientID := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger
  else
    ClientID := -1;

  case IndexOfStrArray( PC.ActivePage.Name, [ tsClients.Name, tsDownload.Name, tsKeys.Name, tsDelivery.Name, tsTraining.Name,
                                              tsSubscribe.Name, tsSendSubscribe.Name ]) of
    0: begin
      BaseToDBGrid( dbgClients, Self.ClassName, dbgClients.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_ClientsList.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_FirmList.Name );
      ActiveControl := dbgClients;
      if Assigned( Sender ) then
        FillClientsMenu;
      if Q_Clients.Active then
        Q_Clients.Refresh;
    end;
    1: begin
      BaseToDBGrid( dbgDownLoad, Self.ClassName, dbgDownLoad.Name );
      ActiveControl := dbgDownLoad;
      FillDownLoadMenu;
      if ( not Q_Download.Active ) or
         ( Q_Download.Tag <> ClientID ) then begin
        Q_Download.Close;
        Q_Download.Open;
        Q_Download.Tag := ClientID;
      end
      else
        Q_Download.FullRefresh;
    end;
    2: begin
      BaseToDBGrid( dbgKeyList, Self.ClassName, dbgKeyList.Name );
      BaseToDBGrid( dbgFillKey, Self.ClassName, dbgFillKey.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_KeysList.Name );
      ActiveControl := dbgKeyList;
      FillKeyListMenu;
      if ( not Q_KeyList.Active ) or
         ( Q_KeyList.Tag <> ClientID ) then begin
        Q_KeyList.Close;
        Q_KeyList.Open;
        Q_KeyList.Tag := ClientID;
      end
      else
        Q_KeyList.FullRefresh;
      dbgKeyList.Width := self.ClientWidth div 2;
    end;
    3: begin
      BaseToDBGrid( dbgDelivery, Self.ClassName, dbgDelivery.Name );
      BaseToDBGrid( dbgProductOnAgrees, Self.ClassName, dbgProductOnAgrees.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_AgreesList.Name );
      ActiveControl := dbgDelivery;
      FillSaleAgreesMenu;
      if ( not Q_Delivery.Active ) or
         ( Q_Delivery.Tag <> ClientID ) then begin
        Q_Delivery.Close;
        Q_Delivery.Open;
        Q_Delivery.Tag := ClientID;
      end
      else
        Q_Delivery.FullRefresh;
    end;
    4: begin
      BaseToDBGrid( dbgTraining, Self.ClassName, dbgTraining.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_ClientTraining.Name );
      ActiveControl := dbgTraining;
      FillTrainingMenu;
      if ( not Q_Training.Active ) or
         ( Q_Training.Tag <> ClientID ) then begin
        Q_Training.Close;
        Q_Training.Open;
        Q_Training.Tag := ClientID;
      end
      else
        Q_Training.FullRefresh;
    end;
    5: begin
      BaseToDBGrid( dbgSubscribe, Self.ClassName, dbgSubscribe.Name );
      A_GroupSubscribe.Visible := A_EditClient.Visible;
      ActiveControl := dbgSubscribe;
      FillSubscribeMenu;
      if ( not Q_Subscribe.Active ) or
         ( Q_Subscribe.Tag <> ClientID ) then begin
        Q_Subscribe.Close;
        Q_Subscribe.Open;
        Q_Subscribe.Tag := ClientID;
      end
      else
        Q_Subscribe.FullRefresh;
    end;
    6: begin
      BaseToDBGrid( dbgSendSubscribe, Self.ClassName, dbgSendSubscribe.Name );
      A_GroupSubscribe.Visible := A_EditClient.Visible;
      ActiveControl := dbgSendSubscribe;
      FillDownLoadMenu;
      if ( not Q_SendSubscribe.Active ) or
         ( Q_SendSubscribe.Tag <> ClientID ) then begin
        Q_SendSubscribe.Close;
        Q_SendSubscribe.Open;
        Q_SendSubscribe.Tag := ClientID;
      end
      else
        Q_SendSubscribe.FullRefresh;
    end;
  end;
end;

procedure TfrClienstList.PCChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  case IndexOfStrArray( PC.ActivePage.Name, [ tsClients.Name, tsDownload.Name, tsKeys.Name, tsDelivery.Name, tsTraining.Name,
                                              tsSubscribe.Name, tsSendSubscribe.Name ]) of
    0: DBGridToBase( dbgClients, Self.ClassName, dbgClients.Name );
    1: DBGridToBase( dbgDownLoad, Self.ClassName, dbgDownLoad.Name );
    2: begin
      DBGridToBase( dbgKeyList, Self.ClassName, dbgKeyList.Name );
      DBGridToBase( dbgFillKey, Self.ClassName, dbgFillKey.Name );
    end;
    3: begin
      DBGridToBase( dbgDelivery, Self.ClassName, dbgDelivery.Name );
      DBGridToBase( dbgProductOnAgrees, Self.ClassName, dbgProductOnAgrees.Name );
    end;
    4: DBGridToBase( dbgTraining, Self.ClassName, dbgTraining.Name );
    5: DBGridToBase( dbgSubscribe, Self.ClassName, dbgSubscribe.Name );
    6: DBGridToBase( dbgSendSubscribe, Self.ClassName, dbgSendSubscribe.Name );
  end;

  AllowChange := not Q_Clients.IsEmpty;
end;

procedure TfrClienstList.Q_ClientsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditClient.Enabled := not Q_Clients.IsEmpty;
  A_DelClient.Enabled := A_EditClient.Enabled;
  A_ExportInCSV.Enabled := A_EditClient.Enabled;
  A_EditFirm.Enabled := ( not Q_Clients.IsEmpty ) and ( not Q_Clients.FBN( 'FIRM_LIST_ID' ).IsNull );
  IsScroll := False;
end;

procedure TfrClienstList.Q_ClientsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if not Q_Clients.Transaction.InTransaction then
    Q_Clients.Transaction.StartTransaction;
end;

procedure TfrClienstList.Q_ClientsBeforeScroll(DataSet: TDataSet);
begin
  IsScroll := True;
  inherited;
end;

procedure TfrClienstList.Q_DownloadAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrClienstList.Q_DownloadBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Download.Tag := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
  Q_Download.ParamByName( 'CLIENT_LIST_ID' ).AsInteger := Q_Download.Tag;
end;

procedure TfrClienstList.Q_TrainingAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrClienstList.Q_TrainingBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Training.Tag := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
  Q_Training.ParamByName( 'CLIENT_LIST_ID' ).AsInteger := Q_Training.Tag;
end;

procedure TfrClienstList.Q_FillKeyAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrClienstList.Q_FillKeyBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_FillKey.ParamByName( 'KEYS_LIST_ID' ).AsInteger := Q_KeyList.FieldByName( 'KEYS_LIST_ID' ).AsInteger;
end;

procedure TfrClienstList.Q_KeyListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrClienstList.Q_KeyListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_KeyList.Tag := Q_Clients.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
  Q_KeyList.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_Clients.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
end;

procedure TfrClienstList.Q_ProductListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrClienstList.Q_ProductListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_ProductList.ParamByName( 'SOFT_DELIVERY_ID' ).AsInteger := Q_Delivery.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger;
end;

procedure TfrClienstList.Q_DeliveryAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrClienstList.Q_DeliveryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Delivery.Tag := Q_Clients.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
  Q_Delivery.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_Clients.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
end;

procedure TfrClienstList.Q_SendSubscribeAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrClienstList.Q_SendSubscribeBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_SendSubscribe.Tag := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
  Q_SendSubscribe.ParamByName( 'CLIENT_LIST_ID' ).AsInteger := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
end;

procedure TfrClienstList.Q_SendSubscribeEndScroll(DataSet: TDataSet);
var
HtmlFileName: String;
begin
  inherited;
  try
    SaveHtmlTextToTemp( HtmlFileName );
  finally
    WB.Navigate2( HtmlFileName );
  end;
  DataSetAfterScroll( DataSet );
end;

procedure TfrClienstList.SaveHtmlTextToTemp( var FileName: String );
const
sqlImagesFiles =
'select' + #13#10 +
'  F.FILE_IMAGES_NAME, F.FILE_IMAGES_BODY' + #13#10 +
'from FILE_IMAGES_SUBSCRIBE_LINK L' + #13#10 +
'  left join FILE_IMAGES F    on ( F.FILE_IMAGES_ID = L.FILE_IMAGES_ID )' + #13#10 +
'where' + #13#10 +
'  L.SUBSCRIBE_LIST_ID = :ID' + #13#10 +
'order by' + #13#10 +
'  1';

sqlReplace =
'select' + #13#10 +
'  MAIL_BASE_LABEL_NAME' + #13#10 +
'from MAIL_BASE_LABEL' + #13#10 +
'where' + #13#10 +
'  IS_DELETE > 0 and IS_USE = 1' + #13#10 +
'order by' + #13#10 +
'  1';

var
Query: TNewQuery;
LinkFileName, ImagesDir: String;
BodyValue: String;
SS: TStringList;
begin
  Query := TNewQuery.CreateNew( Self, nil );
  Query.SQL.Text := sqlReplace;

  try
    FileName := HtmlTemp + Q_SendSubscribe.FBN( 'SUBSCRIBE_LIST_ID' ).AsString + '.html';
    SS := TStringList.Create;
    try
     BodyValue := Q_SendSubscribe.FBN( 'MAIL_BODY' ).AsString;
     BodyReplaceLabel( Q_Clients, Query, BodyValue );
     SS.Text := BodyValue;
     SS.SaveToFile( FileName );
    finally
      SS.Free;
    end;

    Query.Close;
    Query.SQL.Text := sqlImagesFiles;
    if not Query.Prepared then
      Query.Prepare;
    Query.ParamByName( 'ID' ).AsInteger := Q_SendSubscribe.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger;

    try
      Query.ExecQuery;
    except
      raise;
    end;

    While not Query.Eof do begin
      LinkFileName := IncludeTrailingPathDelimiter( HtmlTemp ) + 'images\' + Query.FieldByName( 'FILE_IMAGES_NAME' ).AsString;
      ImagesDir := ExtractFileDir( LinkFileName );
      if not DirectoryExists( ImagesDir ) then
        ForceDirectories( ImagesDir );
      Query.FieldByName( 'FILE_IMAGES_BODY' ).SaveToFile( LinkFileName );
      Query.Next;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrClienstList.Q_SubscribeAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_GroupSubscribe.Enabled := not Q_Subscribe.IsEmpty;
  IsScroll := False;
end;

procedure TfrClienstList.Q_SubscribeBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Subscribe.Tag := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
  Q_Subscribe.ParamByName( 'CLIENT_LIST_ID' ).AsInteger := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
end;

procedure TfrClienstList.A_ExportInCSVExecute(Sender: TObject);
const
msSelect = 'Сохранить выделенные строки в файл формата CSV?';
msTextAll = 'Сохранить все строки из текущего фильтра в файл формата CSV?';
var
SD: TSaveDialog;
msText: PChar;
begin
  inherited;
  if not ( A_ExportInCSV.Visible and A_ExportInCSV.Enabled ) then
    Exit;

  case dbgClients.Selection.SelectionType of
    gstNon, gstColumns, gstAll:
      msText := msTextAll;
    else
      msText := msSelect;
  end;

  if MessageBox( Self.Handle, msText, 'Экспорт данных в файл',
       MB_SYSTEMMODAL or MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2 ) = mrNo  then
    Exit;

  SD := TSaveDialog.Create( Self );
  try
    SD.Filter := 'Файлы CSV|*.csv;*.txt|Все файлы|*.*';
    SD.DefaultExt := '.CSV';
    if SD.Execute then
      SaveDataInCSV( SD.FileName );
  finally
    SD.Free;
  end;
end;

procedure TfrClienstList.SaveDataInCSV( const FileName: String );
type
TColParam = record
  ColumnName: String;
  FieldName: String;
end;

const
msSelect = 'Сохранить выделенные строки в файл формата CSV?';
msTextAll = 'Сохранить все строки из текущего фильтра в файл формата CSV?';
sqlParams =
'select FILE_COLUMN_NAME, FIELD_NAME' + #13#10 +
'from CSV_EXPORT_SETUP' + #13#10 +
'where' + #13#10 +
'  ORDER_BY > 0' + #13#10 +
'order by' + #13#10 +
'  ORDER_BY';

var
F: TextFile;
BM: TBookmark;
N: Integer;
ColList: array of TColParam;

  procedure GetColumnParams;
  var
  Query: TNewQuery;
  L: Integer;
  begin
    L := 0;
    Setlength( ColList, L );
    Query := TNewQuery.CreateNew( frDM, nil );
    try
      Query.SQL.Text := sqlParams;
      If not Query.Prepared then
        Query.Prepare;

      try
        Query.ExecQuery;
      except
        Raise;
      end;
      while not Query.Eof do begin
        Inc( L );
        Setlength( ColList, L );
        ColList[ L - 1 ].ColumnName := Query.FieldByName( 'FILE_COLUMN_NAME' ).AsString;
        ColList[ L - 1 ].FieldName := Query.FieldByName( 'FIELD_NAME' ).AsString;
        Query.Next;
      end;
    finally
      Query.FreeAndCommit;
    end;
  end;

  procedure AddStrValue( var Value: String; AddStr: String );
  begin
    AddStr := StringReplace( AddStr, '"', '""', [ rfReplaceAll, rfIgnoreCase ]);
    if ( Pos( ',', AddStr ) > 0 ) or
       ( Pos( #13, AddStr ) > 0 ) or
       ( Pos( #10, AddStr ) > 0 ) then
      AddStr := AnsiQuotedStr( AddStr, '"' );


    if Value = '' then
      Value := AddStr
    else
      Value := Value + ',' + AddStr;
  end;

  procedure AppendFileHeader;
  var
  StrValue: String;
  N: Integer;
  begin
    StrValue := '';
    for N := 0 to High( ColList ) do
      AddStrValue( StrValue, ColList[ N ].ColumnName );

    Writeln( F, StrValue );
  end;

  procedure AppendSelectRowInFile;
  var
  StrValue: String;
  N: Integer;
  begin
    StrValue := '';
    for N := 0 to High( ColList ) do begin
      if ColList[ N ].FieldName = '' then
        AddStrValue( StrValue, '' )
      else
        AddStrValue( StrValue, Trim( Q_Clients.FBN( ColList[ N ].FieldName ).AsString ));
    end;
    Writeln( F, StrValue );
  end;

begin
  if ( not Q_Clients.Active ) or Q_Clients.IsEmpty then
    Exit;

  GetColumnParams;


  Q_Clients.DisableControls;
  BM := Q_Clients.Bookmark;

  AssignFile( F, FileName );
  try
    Rewrite( F );
    AppendFileHeader;
    try
      case dbgClients.Selection.SelectionType of
        gstRecordBookmarks:
          For N := 0 to dbgClients.Selection.Rows.Count - 1 do begin
            Q_Clients.Bookmark := dbgClients.Selection.Rows[ N ];

            AppendSelectRowInFile;
          end;

        gstRectangle: begin
          Q_Clients.Bookmark := dbgClients.Selection.Rect.TopRow;
          While True do begin
            AppendSelectRowInFile;
            N := Q_Clients.CompareBookmarks( Pointer( dbgClients.Selection.Rect.BottomRow ), Pointer( Q_Clients.Bookmark ));
            If N = 0 then
              Break;
            Q_Clients.Next;
            if Q_Clients.Eof then
              Break;
            Application.ProcessMessages;
          end;
        end;

        else begin
          Q_Clients.First;
          while not Q_Clients.Eof do begin
            AppendSelectRowInFile;
            Q_Clients.Next;
          end;
        end;
      end;
    finally
      if Assigned( BM ) and
         Q_Clients.BookmarkValid( BM ) then
        Q_Clients.GotoBookmark( BM );
      Q_Clients.EnableControls;
      dbgClients.Selection.Clear;
    end;
  finally
    System.Close( F );
  end;
end;

procedure TfrClienstList.A_NewClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewClientTraining.Visible and A_NewClientTraining.Enabled ) then
    Exit;

  ShowTrainingDlg( -1, sdInsert, A_NewClientTraining );
end;

procedure TfrClienstList.A_EditClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditClientTraining.Visible and A_EditClientTraining.Enabled ) then
    Exit;

  ShowTrainingDlg( Q_Training.FieldByName( 'CLIENT_TRAINING_ID' ).AsInteger, sdEdit, A_EditClientTraining );
end;

procedure TfrClienstList.A_DelClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelClientTraining.Visible and A_DelClientTraining.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Training, 'CLIENT_TRAINING_IUD', 'Удалить текущее обучение клиента?', '',
                [ 'CLIENT_TRAINING_ID' ],
                [ Q_Training.FieldByName( 'CLIENT_TRAINING_ID' ).AsInteger ] );
end;

procedure TfrClienstList.A_AddClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddClientTraining.Visible and A_AddClientTraining.Enabled ) then
    Exit;

  ShowTrainingDlg( Q_Training.FieldByName( 'CLIENT_TRAINING_ID' ).AsInteger, sdCopy, A_AddClientTraining );
end;

procedure TfrClienstList.ShowTrainingDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetCurrClientListValue;
  CurrDlgEvent.OnCheckIsSelf := CheckClientsIsSelfRecord;

  ShowEditDialog( Self, TfrRecordEdit, Q_Training, 'TRAINING_LIST_ID', dlgTraining, ID, DlgType, Act, CurrDlgEvent,
                  [ Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger, ID ] );
end;

procedure TfrClienstList.GetCurrClientListValue( Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc );
begin
  if Assigned( Sp.Params.FindParam( 'CLIENT_LIST_ID' )) then
    Sp.ParamByName( 'CLIENT_LIST_ID' ).AsInteger := Q_Clients.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
end;


end.
