{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit KeysList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSimpleForm, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet,
  pFIBDataSet, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls,
  DlgExecute, DlgParams, FIBQuery, pFIBQuery, pFIBStoredProc;

type
  TfrKeysList = class(TfrCustomSimpleForm)
    SpKeys: TSplitter;
    dbgProductList: TDBGridEh;
    Q_Product: TpFIBDataSet;
    dsProduct: TDataSource;
    A_NewKey: TAction;
    A_EditKey: TAction;
    A_DelKey: TAction;
    A_NewProdToKey: TAction;
    A_EditProdInKey: TAction;
    A_DelProdFromKey: TAction;
    pFIBStoredProc1: TpFIBStoredProc;
    A_AddCopyKey: TAction;
    procedure A_DelKeyExecute(Sender: TObject);
    procedure A_NewKeyExecute(Sender: TObject);
    procedure A_NewProdToKeyExecute(Sender: TObject);
    procedure A_EditProdInKeyExecute(Sender: TObject);
    procedure A_DelProdFromKeyExecute(Sender: TObject);
    procedure A_EditKeyExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgProductListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    procedure Q_ProductAfterScroll(DataSet: TDataSet);
    function GetAccessConditionValue: String; override;
    procedure SetAccessRight( const ActName: String  ); override;
    procedure A_AddCopyKeyExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure ShowKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure GetCurrKeyParamValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
    procedure ShowFillKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure SetFillKeysDefaultValue(Sender: TObject; var Item: TPropertyItem);
    function CheckKeysIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
    function GetParamsOfKeyProduct(FillRow: TObject; DialogID: Integer; const FieldName: String;
      var ResValue: Variant): Boolean;
  public
    { Public declarations }
    procedure FillHostMenu; override;
  end;


implementation

{$R *.dfm}

uses Prima, ConstList, RecordEdit, Procs;



procedure TfrKeysList.A_DelKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelKey.Visible and A_DelKey.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Host, 'KEYS_LIST_IUD', 'Удалить текущий ключ?', '',
                [ 'KEYS_LIST_ID' ], [ Q_Host.FieldByName( 'KEYS_LIST_ID' ).AsInteger ] );
end;

procedure TfrKeysList.A_NewKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewKey.Visible and A_NewKey.Enabled ) then
    Exit;

  ShowKeysDlg( -1, sdInsert, A_NewKey );
end;

procedure TfrKeysList.A_AddCopyKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyKey.Visible and A_AddCopyKey.Enabled ) then
    Exit;

  ShowKeysDlg( Q_Host.FieldByName( 'KEYS_LIST_ID' ).AsInteger, sdCopy, A_AddCopyKey );
end;


procedure TfrKeysList.A_EditKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditKey.Visible and A_EditKey.Enabled ) then
    Exit;

  ShowKeysDlg( Q_Host.FieldByName( 'KEYS_LIST_ID' ).AsInteger, sdEdit, A_EditKey );
end;

procedure TfrKeysList.ShowKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnCheckIsSelf := CheckKeysIsSelfRecord;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProdToKey;

  ShowEditDialog( Self, TfrRecordEdit, Q_Host, 'KEYS_LIST_ID', dlgKeysJournal, ID, DlgType, Act, CurrDlgEvent, [ ID ]);
end;

procedure TfrKeysList.A_EditProdInKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditProdInKey.Visible and A_EditProdInKey.Enabled ) then
    Exit;

  ShowFillKeysDlg( Q_Product.FieldByName( 'PRODUCT_LIST_ID' ).AsInteger, sdEdit, A_EditProdInKey );
end;

procedure TfrKeysList.A_DelProdFromKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelProdFromKey.Visible and A_DelProdFromKey.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Product, 'PRODUCT_LIST_IN_KEYS_IUD', 'Удалить текущий продукт из ключа?', '',
                [ 'KEYS_LIST_ID', 'PRODUCT_LIST_ID' ],
                [ Q_Host.FieldByName( 'KEYS_LIST_ID' ).AsInteger,
                  Q_Product.FieldByName( 'PRODUCT_LIST_ID' ).AsInteger ] );
end;

procedure TfrKeysList.A_NewProdToKeyExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewProdToKey.Visible and A_NewProdToKey.Enabled ) then
    Exit;

  ShowFillKeysDlg( -1, sdInsert, A_NewProdToKey );
end;

procedure TfrKeysList.dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    case Key of
      VK_RETURN:
        A_EditKeyExecute( A_EditKey );
    end;
end;

procedure TfrKeysList.dbgProductListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    case Key of
      VK_RETURN:
        A_EditProdInKeyExecute( A_EditProdInKey );
    end;
end;

procedure TfrKeysList.ShowFillKeysDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAddStoredParam := GetCurrKeyParamValue;
  CurrDlgEvent.OnAfterFillRow := SetFillKeysDefaultValue;
  CurrDlgEvent.OnCheckIsSelf := CheckKeysIsSelfRecord;
  CurrDlgEvent.OnGetLookupFieldValue := GetParamsOfKeyProduct;
  if DlgType <> sdEdit then
    CurrDlgEvent.ExecActionAfterThis := A_NewProdToKey;

  ShowEditDialog( Self, TfrRecordEdit, Q_Product, 'PRODUCT_LIST_ID', dlgFillKeys, ID, DlgType, Act, CurrDlgEvent,
                  [ Q_Host.FieldByName( 'KEYS_LIST_ID' ).AsInteger, ID ] );
end;

procedure TfrKeysList.GetCurrKeyParamValue(Sender: TObject; DlgType: TStateDlg; SP: TpFIBStoredProc);
begin
  if Assigned( Sp.Params.FindParam( 'KEYS_LIST_ID' )) then
    Sp.ParamByName( 'KEYS_LIST_ID' ).AsInteger := Q_Host.FieldByName( 'KEYS_LIST_ID' ).AsInteger;

  if DlgType = sdEdit then
    if Assigned( Sp.Params.FindParam( 'PRODUCT_LIST_ID' )) then
      Sp.ParamByName( 'PRODUCT_LIST_ID' ).AsInteger := Q_Product.FieldByName( 'PRODUCT_LIST_ID' ).AsInteger;
end;

function TfrKeysList.GetParamsOfKeyProduct(FillRow: TObject; DialogID: Integer; const FieldName: String; var ResValue: Variant): Boolean;
begin
  Result := False;
  ResValue := Null;
  try
    if not AnsiSameText( FieldName, 'KEYS_LIST_ID' ) then
      Exit;
    if DialogID <> dlgFillKeys then
      Exit;

    ResValue := Q_Host.FBN( 'KEYS_LIST_ID' ).AsInteger;
  finally
    Result := not VarIsNull( ResValue );
  end;
end;

procedure TfrKeysList.Q_HostAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditKey.Enabled := not Q_Host.IsEmpty;
  A_DelKey.Enabled := A_EditKey.Enabled;
  A_NewProdToKey.Enabled := A_EditKey.Enabled;
end;

procedure TfrKeysList.Q_ProductAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditProdInKey.Enabled := not Q_Product.IsEmpty;
  A_DelProdFromKey.Enabled := A_EditProdInKey.Enabled;
end;

procedure TfrKeysList.SetAccessRight(const ActName: String);
begin
  inherited;
  A_AddCopyKey.Visible := A_NewKey.Visible;
end;

procedure TfrKeysList.SetFillKeysDefaultValue(Sender: TObject; var Item: TPropertyItem);
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
          Item.RowValue := Q_Host.FieldByName( 'KEY_NUMBER' ).AsString;
          Item.RowValueID := -1;
        end;
      end;

  end;
end;

procedure TfrKeysList.FillHostMenu;
begin
  Inherited;
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddCopyKey, A_Sp, A_NewKey, A_EditKey, A_DelKey, A_Sp, A_NewProdToKey, A_EditProdInKey, A_DelProdFromKey, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Выданные ключи доступа',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewKey, A_EditKey, A_DelKey, A_Sp, A_NewProdToKey, A_EditProdInKey, A_DelProdFromKey, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;


procedure TfrKeysList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBGridToBase( dbgProductList, Self.ClassName, dbgProductList.Name );
  inherited;
end;

procedure TfrKeysList.FormResize(Sender: TObject);
begin
  inherited;
  dbgHost.Width := SElf.ClientWidth div 2;
end;

procedure TfrKeysList.FormShow(Sender: TObject);
begin
  inherited;
  Self.dbgHost.Width := Self.ClientWidth div 2;
  Application.ProcessMessages;
  BaseToDBGrid( dbgProductList, Self.ClassName, dbgProductList.Name );
end;

function TfrKeysList.CheckKeysIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
begin
  Result :=
    Q_Host.FBN( 'REG_PERSONAL_ID' ).AsInteger = CurrentUserID;
end;

function TfrKeysList.GetAccessConditionValue: String;
begin
  Result := inherited;
  Result := Format( '( REG_PERSONAL_ID = %D )', [ CurrentUserID ]);
end;

end.
