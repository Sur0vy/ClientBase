{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit FirmList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, DlgParams,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomForm, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList,
  Vcl.ComCtrls, DBGridEhGrouping, ToolCtrlsEh, GridsEh, DBGridEh, Data.DB, FIBDataSet, pFIBDataSet, DlgExecute,
  pFIBStoredProc, ConstList;

type
  TfrFirmList = class(TfrCustomForm)
    PC: TPageControl;
    tsFirmList: TTabSheet;
    dbgFirmList: TDBGridEh;
    tsKeys: TTabSheet;
    spKeys: TSplitter;
    dbgFillKey: TDBGridEh;
    dbgKeyList: TDBGridEh;
    tsDeliveryList: TTabSheet;
    SpAgrees: TSplitter;
    dbgDelivery: TDBGridEh;
    dbgProductOnAgrees: TDBGridEh;
    tsTraining: TTabSheet;
    dbgTraining: TDBGridEh;
    Q_FirmList: TpFIBDataSet;
    dsFirmList: TDataSource;
    Q_Training: TpFIBDataSet;
    dsTraining: TDataSource;
    Q_FillKey: TpFIBDataSet;
    dsFillKey: TDataSource;
    dsKeyList: TDataSource;
    Q_KeyList: TpFIBDataSet;
    Q_ProductList: TpFIBDataSet;
    dsProductList: TDataSource;
    dsDelivery: TDataSource;
    Q_Delivery: TpFIBDataSet;
    tsEmployee: TTabSheet;
    dbgEmployee: TDBGridEh;
    Q_Employee: TpFIBDataSet;
    dsEmployee: TDataSource;
    A_NewFirm: TAction;
    A_EditFirm: TAction;
    A_DelFirm: TAction;
    A_NewKey: TAction;
    A_EditKey: TAction;
    A_DelKey: TAction;
    A_NewProdToKey: TAction;
    A_EditProdInKey: TAction;
    A_DelProdFromKey: TAction;
    A_NewAgrees: TAction;
    A_EditAgrees: TAction;
    A_DelAgrees: TAction;
    A_NewProduct: TAction;
    A_EditProduct: TAction;
    A_DelProduct: TAction;
    A_NewClientTraining: TAction;
    A_EditClientTraining: TAction;
    A_DelClientTraining: TAction;
    A_AddCopyAgrees: TAction;
    A_AddCopyFirm: TAction;
    A_AddCopyKey: TAction;
    A_AddClientTraining: TAction;
    tsAgreesList: TTabSheet;
    dbgAgreesList: TDBGridEh;
    Q_AgreesList: TpFIBDataSet;
    dsAgreesList: TDataSource;
    A_NewDelivery: TAction;
    A_EditDelivery: TAction;
    A_DelDelivery: TAction;
    A_AddCopyDelivery: TAction;
    A_NewClient: TAction;
    A_EditClient: TAction;
    procedure FormActivate(Sender: TObject); override;
    procedure PCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PCChange(Sender: TObject);
    procedure Q_EmployeeBeforeOpen(DataSet: TDataSet);
    procedure A_NewFirmExecute(Sender: TObject);
    procedure A_EditFirmExecute(Sender: TObject);
    procedure A_DelFirmExecute(Sender: TObject);
    procedure dbGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Q_KeyListBeforeOpen(DataSet: TDataSet);
    procedure Q_FillKeyBeforeOpen(DataSet: TDataSet);
    procedure Q_FirmListAfterScroll(DataSet: TDataSet);
    procedure Q_FirmListBeforeOpen(DataSet: TDataSet);
    procedure Q_KeyListAfterScroll(DataSet: TDataSet);
    procedure Q_FillKeyAfterScroll(DataSet: TDataSet);
    procedure A_NewKeyExecute(Sender: TObject);
    procedure A_EditKeyExecute(Sender: TObject);
    procedure A_DelKeyExecute(Sender: TObject);
    procedure A_NewProdToKeyExecute(Sender: TObject);
    procedure A_EditProdInKeyExecute(Sender: TObject);
    procedure A_DelProdFromKeyExecute(Sender: TObject);
    procedure A_NewAgreesExecute(Sender: TObject);
    procedure A_EditAgreesExecute(Sender: TObject);
    procedure A_DelAgreesExecute(Sender: TObject);
    procedure A_NewProductExecute(Sender: TObject);
    procedure A_EditProductExecute(Sender: TObject);
    procedure A_DelProductExecute(Sender: TObject);
    procedure Q_TrainingBeforeOpen(DataSet: TDataSet);
    procedure Q_TrainingAfterScroll(DataSet: TDataSet);
    procedure Q_AgreesListBeforeOpen(DataSet: TDataSet);
    procedure Q_AgreesListAfterScroll(DataSet: TDataSet);
    procedure Q_ProductListBeforeOpen(DataSet: TDataSet);
    procedure Q_ProductListAfterScroll(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure Q_FirmListBeforeScroll(DataSet: TDataSet);
    procedure Q_EmployeeAfterScroll(DataSet: TDataSet);
    procedure A_AddCopyAgreesExecute(Sender: TObject);
    procedure A_AddCopyFirmExecute(Sender: TObject);
    procedure A_AddCopyKeyExecute(Sender: TObject);
    procedure Q_DeliveryAfterScroll(DataSet: TDataSet);
    procedure Q_DeliveryBeforeOpen(DataSet: TDataSet);
    procedure A_NewDeliveryExecute(Sender: TObject);
    procedure A_EditDeliveryExecute(Sender: TObject);
    procedure A_DelDeliveryExecute(Sender: TObject);
    procedure A_AddCopyDeliveryExecute(Sender: TObject);
    procedure A_NewClientExecute(Sender: TObject);
    procedure A_EditClientExecute(Sender: TObject);
  private
    { Private declarations }
    procedure FillFirmListMenu;
    procedure FillKeyListMenu;
    procedure FillAgreesListMenu;
    procedure FillDeliveryMenu;
    procedure FillTrainingMenu;
    procedure FillEmployeeMenu;
    procedure ShowFirmListDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    function CheckFirmListIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
    procedure ShowKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure GetCurrFirmListValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
    procedure ShowFillKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure SetFillKeysDefaultValue(Sender: TObject; var Item: TPropertyItem);
    procedure GetCurrKeyParamValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
    procedure ShowAgreesListDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure ShowProductInAgreesDlg(ID: Integer; DlgType: TStateDlg; Act: TAction );
    procedure GetDeliveryValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
    procedure ShowDeliveryDlg( ID: Integer; DlgType: TStateDlg; Act: TAction );
    function GetParamsOfAgreesNumber( FillRow: TObject; DialogID: Integer; const FieldName: String; var ResValue: Variant ): Boolean;
    function GetParamsOfKeyProduct( FillRow: TObject; DialogID: Integer; const FieldName: String; var ResValue: Variant ): Boolean;
    procedure ExecNewProduct( var Message: TMessage ); message CM_ExecNewProduct;
    procedure SetDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
  public
    { Public declarations }
    class procedure ShowFirmListForm(Act: TAction);
  end;


implementation

{$R *.dfm}

uses
  Prima, Procs, ClientDM, RecordEdit, RightType, GridDlg, RegSmartDlg;

class procedure TfrFirmList.ShowFirmListForm(Act: TAction);
begin
  With Self.Create( Application ) do begin
    try
      IsWriteRight := False;
      A_Filtr.DlgIdent := dlgFirmList;

      PC.ActivePage := tsFirmList;
      ActiveControl := dbgFirmList;

      SetAccessRight( Act.Name );
      A_AddCopyFirm.Visible := A_NewFirm.Visible;
      Caption := Act.Caption;
      FormCaption := Act.Caption;
      FormActivate( nil );

      Application.ProcessMessages;
      PCChange( PC );

      if SetAccessRightOfRows( Q_FirmList, Format( '( REG_PERSONAL_ID = %D )', [ CurrentUserID ])) then begin
        HostSqlText := Q_FirmList.SelectSQL.Text;
        OpenDataSetOfStartForm;
      end;

      FormActivate( nil );
    finally
      If not Q_FirmList.Active then
        Close;
    end;
  end;
end;

procedure TfrFirmList.FillFirmListMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddCopyFirm, A_Sp, A_NewFirm, A_EditFirm, A_DelFirm, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Журнал - "Организации"',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewFirm, A_EditFirm, A_DelFirm, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrFirmList.FillTrainingMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Организации - обучение',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrFirmList.FillEmployeeMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_EditClient, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Организации - сотрудники',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_EditClient, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrFirmList.FillKeyListMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddCopyKey, A_Sp, A_NewKey, A_EditKey, A_DelKey, A_Sp, A_NewProdToKey, A_EditProdInKey, A_DelProdFromKey, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Организации - ключи',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewKey, A_EditKey, A_DelKey, A_Sp, A_NewProdToKey, A_EditProdInKey, A_DelProdFromKey, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrFirmList.FillAgreesListMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddCopyAgrees, A_Sp, A_NewAgrees, A_EditAgrees, A_DelAgrees, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Организации - договора',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewAgrees, A_EditAgrees, A_DelAgrees, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrFirmList.FillDeliveryMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddCopyDelivery, A_Sp, A_NewDelivery, A_EditDelivery, A_DelDelivery, A_Sp, A_NewProduct, A_EditProduct, A_DelProduct, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Организации - отгрузки',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewDelivery, A_EditDelivery, A_DelDelivery, A_Sp, A_NewProduct, A_EditProduct, A_DelProduct, A_Sp,
              A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrFirmList.FormActivate(Sender: TObject);
begin
  inherited;
  case IndexOfStrArray( PC.ActivePage.Name, [
         tsFirmList.Name, tsKeys.Name, tsDeliveryList.Name, tsTraining.Name, tsEmployee.Name, tsAgreesList.Name ]) of
    0: FillFirmListMenu;
    1: FillKeyListMenu;
    2: FillDeliveryMenu;
    3: FillTrainingMenu;
    4: FillEmployeeMenu;
    5: FillAgreesListMenu;
  end;
end;

procedure TfrFirmList.FormResize(Sender: TObject);
begin
  inherited;
  dbgKeyList.Width := Self.ClientWidth div 4;
  dbgDelivery.Width := Self.ClientWidth div 3;
end;

procedure TfrFirmList.PCChange(Sender: TObject);
var
FirmListID: Integer;
begin
  inherited;
  if Q_FirmList.Active then
    FirmListID := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger
  else
    FirmListID := -1;

  case IndexOfStrArray( PC.ActivePage.Name, [ tsFirmList.Name, tsKeys.Name, tsAgreesList.Name,
                                              tsTraining.Name, tsEmployee.Name, tsDeliveryList.Name ]) of
    0: begin
      BaseToDBGrid( dbgFirmList, Self.ClassName, dbgFirmList.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_FirmList.Name );
      ActiveControl := dbgFirmList;
      FillFirmListMenu;
      if Q_FirmList.Active then
        Q_FirmList.Refresh;
    end;
    1: begin
      BaseToDBGrid( dbgKeyList, Self.ClassName, dbgKeyList.Name );
      BaseToDBGrid( dbgFillKey, Self.ClassName, dbgFillKey.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_KeysList.Name );
      A_AddCopyKey.Visible := A_NewKey.Visible;
      ActiveControl := dbgKeyList;
      FillKeyListMenu;
      if ( not Q_KeyList.Active ) or
         ( Q_KeyList.Tag <> FirmListID ) then begin
        Q_KeyList.Close;
        Q_KeyList.Open;
        Q_KeyList.Tag := FirmListID;
      end
      else
        Q_KeyList.FullRefresh;
      dbgKeyList.Width := Self.ClientWidth div 2;
    end;
    2: begin
      BaseToDBGrid( dbgAgreesList, Self.ClassName, dbgAgreesList.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_AgreesList.Name );
      A_AddCopyAgrees.Visible := A_NewAgrees.Visible;
      ActiveControl := dbgAgreesList;
      FillAgreesListMenu;
      if ( not Q_AgreesList.Active ) or
         ( Q_AgreesList.Tag <> FirmListID ) then begin
        Q_AgreesList.Close;
        Q_AgreesList.Open;
        Q_AgreesList.Tag := FirmListID;
      end
      else
        Q_AgreesList.FullRefresh;
    end;
    3: begin
      BaseToDBGrid( dbgTraining, Self.ClassName, dbgTraining.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_ClientTraining.Name );
      A_AddClientTraining.Visible := A_NewClientTraining.Visible;
      ActiveControl := dbgTraining;
      FillTrainingMenu;
      if ( not Q_Training.Active ) or
         ( Q_Training.Tag <> FirmListID ) then begin
        Q_Training.Close;
        Q_Training.Open;
        Q_Training.Tag := FirmListID;
      end
      else
        Q_Training.FullRefresh;
    end;
    4: begin
      BaseToDBGrid( dbgEmployee, Self.ClassName, dbgEmployee.Name );
      ActiveControl := dbgEmployee;
      frDM.SetFuncRightAccess( Self, frPrima.A_ClientsList.Name );
      FillEmployeeMenu;
      if ( not Q_Employee.Active ) or
         ( Q_Employee.Tag <> FirmListID ) then begin
        Q_Employee.Close;
        Q_Employee.Open;
        Q_Employee.Tag := FirmListID;
      end
      else
        Q_Employee.FullRefresh;
    end;
    5: begin
      BaseToDBGrid( dbgDelivery, Self.ClassName, dbgDelivery.Name );
      BaseToDBGrid( dbgProductOnAgrees, Self.ClassName, dbgProductOnAgrees.Name );
      frDM.SetFuncRightAccess( Self, frPrima.A_SoftDelivery.Name );
      A_AddCopyDelivery.Visible := A_NewDelivery.Visible;
      ActiveControl := dbgDelivery;
      FillDeliveryMenu;
      if ( not Q_Delivery.Active ) or
         ( Q_Delivery.Tag <> FirmListID ) then begin
        Q_Delivery.Close;
        Q_Delivery.Open;
        Q_Delivery.Tag := FirmListID;
      end
      else
        Q_Delivery.FullRefresh;
    end;
  end;
end;

procedure TfrFirmList.PCChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  case IndexOfStrArray( PC.ActivePage.Name, [ tsFirmList.Name, tsKeys.Name, tsAgreesList.Name,
                                              tsTraining.Name, tsEmployee.Name, tsDeliveryList.Name ]) of
    0: DBGridToBase( dbgFirmList, Self.ClassName, dbgFirmList.Name );
    1: begin
      DBGridToBase( dbgKeyList, Self.ClassName, dbgKeyList.Name );
      DBGridToBase( dbgFillKey, Self.ClassName, dbgFillKey.Name );
    end;
    2: DBGridToBase( dbgAgreesList, Self.ClassName, dbgAgreesList.Name );
    3: DBGridToBase( dbgTraining, Self.ClassName, dbgTraining.Name );
    4: DBGridToBase( dbgEmployee, Self.ClassName, dbgEmployee.Name );
    5: begin
      DBGridToBase( dbgDelivery, Self.ClassName, dbgDelivery.Name );
      DBGridToBase( dbgProductOnAgrees, Self.ClassName, dbgProductOnAgrees.Name );
    end;
  end;

  AllowChange := not Q_FirmList.IsEmpty;
end;

procedure TfrFirmList.Q_EmployeeAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditClient.Enabled := not Q_Employee.IsEmpty;
  IsScroll := False;
end;

procedure TfrFirmList.Q_EmployeeBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Employee.Tag := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
  Q_Employee.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_Employee.Tag;
end;

procedure TfrFirmList.Q_FillKeyAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditProdInKey.Enabled := not Q_FillKey.IsEmpty;
  A_DelProdFromKey.Enabled := A_EditProdInKey.Enabled;
  IsScroll := False;
end;

procedure TfrFirmList.Q_FillKeyBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_FillKey.ParamByName( 'KEYS_LIST_ID' ).AsInteger := Q_KeyList.FieldByName( 'KEYS_LIST_ID' ).AsInteger;
end;

procedure TfrFirmList.Q_FirmListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditFirm.Enabled := not Q_FirmList.IsEmpty;
  A_DelFirm.Enabled := A_EditFirm.Enabled;
  IsScroll := False;
end;

procedure TfrFirmList.Q_FirmListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if not Q_FirmList.Transaction.InTransaction then
    Q_FirmList.Transaction.StartTransaction;
end;

procedure TfrFirmList.Q_FirmListBeforeScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := True;
end;

procedure TfrFirmList.Q_KeyListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditKey.Enabled := not Q_KeyList.IsEmpty;
  A_DelKey.Enabled := A_EditKey.Enabled;
  A_NewProdToKey.Enabled := A_EditKey.Enabled;
  IsScroll := False;
end;

procedure TfrFirmList.Q_KeyListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_KeyList.Tag := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
  Q_KeyList.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_KeyList.Tag;
end;

procedure TfrFirmList.Q_ProductListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditProduct.Enabled := not Q_ProductList.IsEmpty;
  A_DelProduct.Enabled := A_EditProduct.Enabled;
  IsScroll := False;
end;

procedure TfrFirmList.Q_ProductListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_ProductList.ParamByName( 'SOFT_DELIVERY_ID' ).AsInteger := Q_Delivery.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger;
end;

procedure TfrFirmList.Q_AgreesListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditAgrees.Enabled := not Q_AgreesList.IsEmpty;
  A_DelAgrees.Enabled := A_EditAgrees.Enabled;
  IsScroll := False;
end;

procedure TfrFirmList.Q_AgreesListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_AgreesList.Tag := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
  Q_AgreesList.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
end;

procedure TfrFirmList.Q_DeliveryAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditDelivery.Enabled := not Q_Delivery.IsEmpty;
  A_DelDelivery.Enabled := A_EditDelivery.Enabled;
  IsScroll := False;
end;

procedure TfrFirmList.Q_DeliveryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Delivery.Tag := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
  Q_Delivery.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
end;

procedure TfrFirmList.Q_TrainingAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditClientTraining.Enabled := not Q_Training.IsEmpty;
  A_DelClientTraining.Enabled := A_EditClientTraining.Enabled;
  IsScroll := False;
end;

procedure TfrFirmList.Q_TrainingBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Training.Tag := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
  Q_Training.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_Training.Tag;
end;

procedure TfrFirmList.A_DelFirmExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelFirm.Visible and A_DelFirm.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_FirmList, 'FIRM_LIST_IUD', 'Удалить текущую запись?', '',
                [ 'FIRM_LIST_ID' ], [ Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger ] );
end;

procedure TfrFirmList.A_EditFirmExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditFirm.Visible and A_EditFirm.Enabled ) then
    Exit;

  ShowFirmListDlg( Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger, sdEdit, A_EditFirm );
end;

procedure TfrFirmList.A_AddCopyFirmExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyFirm.Visible and A_AddCopyFirm.Enabled ) then
    Exit;

  ShowFirmListDlg( Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger, sdCopy, A_AddCopyFirm );
end;

procedure TfrFirmList.A_NewFirmExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewFirm.Visible and A_NewFirm.Enabled ) then
    Exit;

  ShowFirmListDlg( -1, sdInsert, A_NewFirm );
end;


procedure TfrFirmList.ShowFirmListDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAfterFillRow := SetFirmDlgDefaultValue;
  CurrDlgEvent.OnCheckIsSelf := CheckFirmListIsSelfRecord;
  CurrDlgEvent.OnSmartDlgSetEditText := SmartDlgSetEditText;

  ShowEditDialog( Self, TfrRecordEdit, Q_FirmList, 'FIRM_LIST_ID', dlgFirmList, ID, DlgType, Act, CurrDlgEvent, [ ID ]);
end;

procedure TfrFirmList.A_NewKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewKey.Visible and A_NewKey.Enabled ) then
    Exit;

  ShowKeysDlg( -1, sdInsert, A_NewKey );
end;

function TfrFirmList.CheckFirmListIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
begin
  Result :=
    Q_FirmList.FBN( 'REG_PERSONAL_ID' ).AsInteger = CurrentUserID;
end;

procedure TfrFirmList.A_EditKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditKey.Visible and A_EditKey.Enabled ) then
    Exit;

  ShowKeysDlg( Q_KeyList.FieldByName( 'KEYS_LIST_ID' ).AsInteger, sdEdit, A_EditKey );
end;

procedure TfrFirmList.A_AddCopyKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyKey.Visible and A_AddCopyKey.Enabled ) then
    Exit;

  ShowKeysDlg( Q_KeyList.FieldByName( 'KEYS_LIST_ID' ).AsInteger, sdCopy, A_AddCopyKey );
end;

procedure TfrFirmList.A_DelKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelKey.Visible and A_DelKey.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_KeyList, 'KEYS_LIST_IUD', 'Удалить текущий ключ?', '',
                [ 'KEYS_LIST_ID' ], [ Q_KeyList.FieldByName( 'KEYS_LIST_ID' ).AsInteger ] );
end;

procedure TfrFirmList.ShowKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetCurrFirmListValue;
  CurrDlgEvent.OnCheckIsSelf := CheckFirmListIsSelfRecord;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProdToKey;

  ShowEditDialog( Self, TfrRecordEdit, Q_KeyList, 'KEYS_LIST_ID', dlgKeysList, ID, DlgType, Act, CurrDlgEvent, [ ID ]);
end;

procedure TfrFirmList.GetCurrFirmListValue( Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc );
begin
  if Assigned( Sp.Params.FindParam( 'FIRM_LIST_ID' )) then
    Sp.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_FirmList.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
end;

procedure TfrFirmList.A_NewProdToKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewProdToKey.Visible and A_NewProdToKey.Enabled ) then
    Exit;

  ShowFillKeysDlg( -1, sdInsert, A_NewProdToKey );
end;

procedure TfrFirmList.A_EditProdInKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditProdInKey.Visible and A_EditProdInKey.Enabled ) then
    Exit;

  ShowFillKeysDlg( Q_FillKey.FieldByName( 'PRODUCT_LIST_ID' ).AsInteger, sdEdit, A_EditProdInKey );
end;

procedure TfrFirmList.A_DelProdFromKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelProdFromKey.Visible and A_DelProdFromKey.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_FillKey, 'PRODUCT_LIST_IN_KEYS_IUD', 'Удалить текущий продукт из ключа?', '',
                [ 'KEYS_LIST_ID', 'PRODUCT_LIST_ID' ],
                [ Q_FillKey.FieldByName( 'KEYS_LIST_ID' ).AsInteger,
                  Q_FillKey.FieldByName( 'PRODUCT_LIST_ID' ).AsInteger ] );
end;

procedure TfrFirmList.ShowFillKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetCurrKeyParamValue;
  CurrDlgEvent.OnAfterFillRow := SetFillKeysDefaultValue;
  CurrDlgEvent.OnCheckIsSelf := CheckFirmListIsSelfRecord;
  CurrDlgEvent.OnGetLookupFieldValue := GetParamsOfKeyProduct;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProdToKey;

  ShowEditDialog( Self, TfrRecordEdit, Q_FillKey, 'PRODUCT_LIST_ID', dlgFillKeys, ID, DlgType, Act, CurrDlgEvent,
                  [ Q_KeyList.FieldByName( 'KEYS_LIST_ID' ).AsInteger, ID ] );
end;

function TfrFirmList.GetParamsOfKeyProduct(FillRow: TObject; DialogID: Integer; const FieldName: String; var ResValue: Variant): Boolean;
begin
  Result := False;
  ResValue := Null;
  try
    if not AnsiSameText( FieldName, 'KEYS_LIST_ID' ) then
      Exit;
    if DialogID <> dlgFillKeys then
      Exit;

    ResValue := Q_KeyList.FBN( 'KEYS_LIST_ID' ).AsInteger;
  finally
    Result := not VarIsNull( ResValue );
  end;
end;


procedure TfrFirmList.SetFillKeysDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  With TfrRecordEdit( Sender ) do begin
    if dlgFillRows.ActionType = sdEdit then
      case IndexOfStrArray( Item.FieldName, [ 'PRODUCT_LIST_TITLE' ]) of
        0: begin
          Item.Style := psReadOnlyText;
        end;
      end;

    if dlgFillRows.ActionType = sdInsert then
      case IndexOfStrArray( Item.FieldName, [ 'KEY_NUMBER' ]) of
        0: begin
          Item.RowValue := Q_KeyList.FieldByName( 'KEY_NUMBER' ).AsString;
          Item.RowValueID := -1;
        end;
      end;
  end;
end;

procedure TfrFirmList.GetCurrKeyParamValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
begin
  if Assigned( Sp.Params.FindParam( 'KEYS_LIST_ID' )) then
    Sp.ParamByName( 'KEYS_LIST_ID' ).AsInteger := Q_KeyList.FieldByName( 'KEYS_LIST_ID' ).AsInteger;

  if DlgType = sdEdit then
    if Assigned( Sp.Params.FindParam( 'PRODUCT_LIST_ID' )) then
      Sp.ParamByName( 'PRODUCT_LIST_ID' ).AsInteger := Q_FillKey.FieldByName( 'PRODUCT_LIST_ID' ).AsInteger;
end;

procedure TfrFirmList.A_NewAgreesExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewAgrees.Visible and A_NewAgrees.Enabled ) then
    Exit;

  ShowAgreesListDlg( -1, sdInsert, A_NewAgrees );
end;

procedure TfrFirmList.A_EditAgreesExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditAgrees.Visible and A_EditAgrees.Enabled ) then
    Exit;

  ShowAgreesListDlg( Q_AgreesList.FieldByName( 'AGREES_LIST_ID' ).AsInteger, sdEdit, A_EditAgrees );
end;

procedure TfrFirmList.A_AddCopyAgreesExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyAgrees.Visible and A_AddCopyAgrees.Enabled ) then
    Exit;

  ShowAgreesListDlg( Q_AgreesList.FieldByName( 'AGREES_LIST_ID' ).AsInteger, sdCopy, A_AddCopyAgrees );
end;

procedure TfrFirmList.A_DelAgreesExecute(Sender: TObject);
begin
  if not ( A_DelAgrees.Visible and A_DelAgrees.Enabled ) then
    Exit;
  inherited;
  DeleteRecord( Self, Q_AgreesList, 'AGREES_LIST_IUD', 'Удалить текущий договор?', '',
                [ 'AGREES_LIST_ID' ], [ Q_AgreesList.FieldByName( 'AGREES_LIST_ID' ).AsInteger ] );
end;

procedure TfrFirmList.ShowAgreesListDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetCurrFirmListValue;
  CurrDlgEvent.OnCheckIsSelf := CheckFirmListIsSelfRecord;

  ShowEditDialog( Self, TfrRecordEdit, Q_AgreesList, 'AGREES_LIST_ID', dlgAgreesList, ID, DlgType, Act, CurrDlgEvent, [ ID ] );
end;

procedure TfrFirmList.A_NewDeliveryExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewDelivery.Visible and A_NewDelivery.Enabled ) then
    Exit;

  ShowDeliveryDlg( -1, sdInsert, A_NewDelivery );
end;

procedure TfrFirmList.A_EditDeliveryExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditDelivery.Visible and A_EditDelivery.Enabled ) then
    Exit;

  ShowDeliveryDlg( Q_Delivery.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger, sdEdit, A_EditDelivery );
end;

procedure TfrFirmList.A_AddCopyDeliveryExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyDelivery.Visible and A_AddCopyDelivery.Enabled ) then
    Exit;

  ShowDeliveryDlg( Q_Delivery.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger, sdCopy, A_AddCopyDelivery );
end;

procedure TfrFirmList.A_DelDeliveryExecute(Sender: TObject);
begin
  if not ( A_DelDelivery.Visible and A_DelDelivery.Enabled ) then
    Exit;
  inherited;
  DeleteRecord( Self, Q_AgreesList, 'SOFT_DELIVERY_IUD', 'Удалить текущeую отгрузку?', '',
                [ 'SOFT_DELIVERY_ID' ], [ Q_AgreesList.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger ] );
end;

procedure TfrFirmList.ShowDeliveryDlg( ID: Integer; DlgType: TStateDlg; Act: TAction );
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetCurrFirmListValue;
  CurrDlgEvent.OnGetLookupFieldValue := GetParamsOfAgreesNumber;
  CurrDlgEvent.OnCheckIsSelf := CheckFirmListIsSelfRecord;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProduct;

  ShowEditDialog( Self, TfrRecordEdit, Q_Delivery, 'SOFT_DELIVERY_ID', dlgDelivery, ID, DlgType, Act, CurrDlgEvent, [ ID ] );
end;

procedure TfrFirmList.ExecNewProduct(var Message: TMessage);
begin
  A_NewProductExecute( A_NewProduct );
end;

function TfrFirmList.GetParamsOfAgreesNumber(FillRow: TObject; DialogID: Integer; const FieldName: String; var ResValue: Variant): Boolean;
begin
  Result := False;
  ResValue := -1;
  try
    if not AnsiSameText( FieldName, 'FIRM_LIST_ID' ) then
      Exit;
    if DialogID <> dlgDelivery then
      Exit;
    ResValue := Q_FirmList.FBN( 'FIRM_LIST_ID' ).AsInteger;
  finally
    Result := ResValue <> -1;
  end;
end;

procedure TfrFirmList.A_NewProductExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewProduct.Visible and A_NewProduct.Enabled ) then
    Exit;

  ShowProductInAgreesDlg( -1, sdInsert, A_NewProduct );
end;

procedure TfrFirmList.A_EditProductExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditProduct.Visible and A_EditProduct.Enabled ) then
    Exit;

  ShowProductInAgreesDlg( Q_ProductList.FieldByName( 'SOFT_LIST_IN_DELIVERY_ID' ).AsInteger, sdEdit, A_EditProduct );
end;

procedure TfrFirmList.A_DelProductExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelProduct.Visible and A_DelProduct.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_ProductList, 'SOFT_LIST_IN_DELIVERY_IUD', 'Удалить текущий продукт из отгрузки?', '',
                [ 'SOFT_LIST_IN_DELIVERY_ID' ],
                [ Q_ProductList.FieldByName( 'SOFT_LIST_IN_DELIVERY_ID' ).AsInteger ] );
end;

procedure TfrFirmList.ShowProductInAgreesDlg(ID: Integer; DlgType: TStateDlg; Act: TAction );
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetDeliveryValue;
  CurrDlgEvent.OnCheckIsSelf := CheckFirmListIsSelfRecord;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProduct;

  ShowEditDialog( Self, TfrRecordEdit, Q_ProductList, 'SOFT_LIST_IN_DELIVERY_ID', dlgProductInAgrees, ID, DlgType, Act, CurrDlgEvent, [ ID ] );
end;

procedure TfrFirmList.GetDeliveryValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
begin
  if Assigned( Sp.Params.FindParam( 'SOFT_DELIVERY_ID' )) then
    Sp.ParamByName( 'SOFT_DELIVERY_ID' ).AsInteger := Q_Delivery.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger;
end;

procedure TfrFirmList.A_NewClientExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrFirmList.A_EditClientExecute(Sender: TObject);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  inherited;
  if not ( A_EditClient.Visible and A_EditClient.Enabled ) then
    Exit;

  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAfterFillRow := SetDlgDefaultValue;
  CurrDlgEvent.OnCheckIsSelf := CheckFirmListIsSelfRecord;

  ShowEditDialog( Self, TfrRecordEdit, Q_Employee, 'CLIENT_LIST_ID', dlgClientsList,
                  Q_Employee.FBN( 'CLIENT_LIST_ID' ).AsInteger, sdEdit, A_EditClient, CurrDlgEvent,
                  [ Q_Employee.FBN( 'CLIENT_LIST_ID' ).AsInteger ]);
end;

procedure TfrFirmList.SetDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  With TfrRecordEdit( Sender ) do begin

    case IndexOfStrArray( Item.FieldName, [ 'FIRM_LIST_TITLE' ]) of
      0: begin
        Item. ShowAsReadOnly := True;
      end;
    end;
  end;
end;

procedure TfrFirmList.dbGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  FormKeyDown( Sender, Key, Shift );
  if Shift <> [] then
    Exit;
  if Key <> VK_RETURN then
    Exit;
  if not ( Sender is TDBGridEh ) then
    Exit;
  case IndexOfStrArray(( Sender as TDBGridEh ).Name,
                       [ dbgTraining.Name, dbgDelivery.Name, dbgProductOnAgrees.Name, dbgKeyList.Name, dbgFillKey.Name,
                         dbgFirmList.Name, dbgEmployee.Name ])  of
    0: ;
    1: A_EditAgreesExecute( A_EditAgrees );
    2: A_EditProductExecute( A_EditProduct );
    3: A_EditKeyExecute( A_EditKey );
    4: A_EditProdInKeyExecute( A_EditProdInKey );
    5: A_EditFirmExecute( A_EditFirm );
    6: A_EditClientExecute( A_EditClient );
  end;
end;


end.
