{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit SoftDelivery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSimpleForm, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet,
  pFIBDataSet, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls,
  DlgExecute, FIBQuery, pFIBQuery, pFIBStoredProc, DlgParams;

type
  TfrSoftDelivery = class(TfrCustomSimpleForm)
    A_NewDelivery: TAction;
    A_EditDelivery: TAction;
    A_DelDelivery: TAction;
    SpDelivery: TSplitter;
    dbgProductList: TDBGridEh;
    Q_Product: TpFIBDataSet;
    dsProduct: TDataSource;
    A_NewProduct: TAction;
    A_EditProduct: TAction;
    A_DelProduct: TAction;
    A_AddCopyDelivery: TAction;
    A_NewAgrees: TAction;
    procedure A_NewDeliveryExecute(Sender: TObject);
    procedure A_EditDeliveryExecute(Sender: TObject);
    procedure A_DelDeliveryExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure A_NewProductExecute(Sender: TObject);
    procedure A_EditProductExecute(Sender: TObject);
    procedure A_DelProductExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgProductListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    procedure Q_ProductAfterScroll(DataSet: TDataSet);
    function GetAccessConditionValue: String; override;
    procedure A_AddCopyDeliveryExecute(Sender: TObject);
    procedure SetAccessRight( const ActName: String  ); override;
    procedure A_NewAgreesExecute(Sender: TObject);
  private
    { Private declarations }
    procedure ShowDeliveryDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure ShowProductInDeliveryDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure GetSoftDeliveryValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
    function CheckDeliveryIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
  public
    { Public declarations }
    procedure FillHostMenu; override;
  end;


implementation

{$R *.dfm}

uses RecordEdit, Prima, ConstList, Procs, ClientDM;


procedure TfrSoftDelivery.A_DelDeliveryExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelDelivery.Visible and A_DelDelivery.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Host, 'SOFT_DELIVERY_IUD', 'Удалить текущий договор?', '',
                [ 'SOFT_DELIVERY_ID' ], [ Q_Host.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger ] );
end;

procedure TfrSoftDelivery.A_EditDeliveryExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditDelivery.Visible and A_EditDelivery.Enabled ) then
    Exit;

  ShowDeliveryDlg( Q_Host.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger, sdEdit, A_EditDelivery );
end;

procedure TfrSoftDelivery.A_NewAgreesExecute(Sender: TObject);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  inherited;
   if not ( A_NewAgrees.Visible and A_NewAgrees.Enabled ) then
    Exit;

  CurrDlgEvent := EditDldEventIsNil;

  ShowEditDialog( Self, TfrRecordEdit, nil, 'AGREES_LIST_ID', dlgAgreesListJournal, -1, sdInsert, A_NewAgrees, CurrDlgEvent, [ -1 ] );
end;

procedure TfrSoftDelivery.A_NewDeliveryExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewDelivery.Visible and A_NewDelivery.Enabled ) then
    Exit;

  ShowDeliveryDlg( -1, sdInsert, A_NewDelivery );
end;

procedure TfrSoftDelivery.A_AddCopyDeliveryExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyDelivery.Visible and A_AddCopyDelivery.Enabled ) then
    Exit;

  ShowDeliveryDlg( Q_Host.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger, sdCopy, A_AddCopyDelivery );
end;

procedure TfrSoftDelivery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
    DBGridToBase( dbgProductList, Self.ClassName, dbgProductList.Name );
  finally
    inherited;
  end;
end;

procedure TfrSoftDelivery.FormShow(Sender: TObject);
begin
  inherited;
  Self.dbgHost.Width := Self.ClientWidth div 2;
  Application.ProcessMessages;
  BaseToDBGrid( dbgProductList, Self.ClassName, dbgProductList.Name );
end;

procedure TfrSoftDelivery.ShowDeliveryDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnCheckIsSelf := CheckDeliveryIsSelfRecord;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProduct;

  ShowEditDialog( Self, TfrRecordEdit, Q_Host, 'SOFT_DELIVERY_ID', dlgSoftDeliveryJournal, ID, DlgType, Act, CurrDlgEvent, [ ID ] );
end;

procedure TfrSoftDelivery.A_NewProductExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewProduct.Visible and A_NewProduct.Enabled ) then
    Exit;

  ShowProductInDeliveryDlg( -1, sdInsert, A_NewProduct );
end;

procedure TfrSoftDelivery.dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    case Key of
      VK_RETURN:
        A_EditDeliveryExecute( A_EditDelivery );
    end;
end;

procedure TfrSoftDelivery.dbgProductListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    case Key of
      VK_RETURN:
        A_EditProductExecute( A_EditProduct );
    end;
end;

procedure TfrSoftDelivery.A_DelProductExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelProduct.Visible and A_DelProduct.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Product, 'SOFT_LIST_IN_DELIVERY_IUD', 'Удалить текущий продукт из отгрузки?', '',
                [ 'SOFT_LIST_IN_DELIVERY_ID' ],
                [ Q_Product.FieldByName( 'SOFT_LIST_IN_DELIVERY_ID' ).AsInteger ] );
end;

procedure TfrSoftDelivery.A_EditProductExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditProduct.Visible and A_EditProduct.Enabled ) then
    Exit;

  ShowProductInDeliveryDlg( Q_Product.FieldByName( 'SOFT_LIST_IN_DELIVERY_ID' ).AsInteger, sdEdit, A_EditProduct );
end;

procedure TfrSoftDelivery.ShowProductInDeliveryDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetSoftDeliveryValue;
  CurrDlgEvent.OnCheckIsSelf := CheckDeliveryIsSelfRecord;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProduct;

  ShowEditDialog( Self, TfrRecordEdit, Q_Product, 'SOFT_LIST_IN_DELIVERY_ID', dlgProductInAgrees, ID, DlgType, Act, CurrDlgEvent, [ ID ] );
end;

function TfrSoftDelivery.GetAccessConditionValue: String;
begin
  Result := inherited;
//  Result := Format( '( REG_PERSONAL_ID = %D )', [ CurrentUserID ]);
end;

procedure TfrSoftDelivery.GetSoftDeliveryValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
begin
  if Assigned( Sp.Params.FindParam( 'SOFT_DELIVERY_ID' )) then
    Sp.ParamByName( 'SOFT_DELIVERY_ID' ).AsInteger := Q_Host.FieldByName( 'SOFT_DELIVERY_ID' ).AsInteger;
  if Assigned( Sp.Params.FindParam( 'FIRM_LIST_ID' )) then
    Sp.ParamByName( 'FIRM_LIST_ID' ).AsInteger := Q_Host.FieldByName( 'FIRM_LIST_ID' ).AsInteger;
end;

procedure TfrSoftDelivery.Q_HostAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditDelivery.Enabled := not Q_Host.IsEmpty;
  A_DelDelivery.Enabled := A_EditDelivery.Enabled;
  A_NewProduct.Enabled := A_EditDelivery.Enabled;
end;

procedure TfrSoftDelivery.Q_ProductAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditProduct.Enabled := not Q_Product.IsEmpty;
  A_DelProduct.Enabled := A_EditDelivery.Enabled;
end;

procedure TfrSoftDelivery.SetAccessRight(const ActName: String);
begin
  inherited;
  frDM.SetFuncRightAccess( Self, frPrima.A_AgreesList.Name );
  A_AddCopyDelivery.Visible := A_NewDelivery.Visible;
end;

procedure TfrSoftDelivery.FillHostMenu;
begin
  Inherited;
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_NewAgrees, A_Sp, A_AddCopyDelivery, A_Sp, A_NewDelivery, A_EditDelivery, A_DelDelivery, A_Sp, A_NewProduct, A_EditProduct, A_DelProduct, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Отгрузки по договорам',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewAgrees, A_Sp, A_NewDelivery, A_EditDelivery, A_DelDelivery, A_Sp, A_NewProduct, A_EditProduct, A_DelProduct, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

function TfrSoftDelivery.CheckDeliveryIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
begin
  Result :=
    Q_Host.FBN( 'REG_PERSONAL_ID' ).AsInteger = CurrentUserID;
end;


end.
