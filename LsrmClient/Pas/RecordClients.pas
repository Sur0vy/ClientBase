{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit RecordClients;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RecordEdit, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, pFIBStoredProc,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ActnPopup, Vcl.ExtCtrls, DlgExecute, RegSmartDlg, AddActions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, GridDlg, Vcl.ComCtrls, DlgParams;

type
  TfrRecordClients = class(TfrRecordEdit)
    A_NewFirm: TAction;
    A_EditFirm: TAction;
    IBTr_Clients: TpFIBTransaction;
    procedure A_EditFirmExecute(Sender: TObject);
    procedure A_NewFirmExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SmartDlgShowDialog(Dlg: TComponent; Info: TPropertyItem; const EditRect: TRect);
    procedure SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure A_SaveExecute(Sender: TObject); override;
  private
    { Private declarations }
    ClientIsChange: Boolean;
  public
    { Public declarations }
    procedure FillDialogMenu; override;
  end;


implementation

{$R *.dfm}

uses
  CustomForm, ConstList, ClientsList, Prima, ClientsListBox, ClientDM, SqlTools;

procedure TfrRecordClients.A_EditFirmExecute(Sender: TObject);
var
CurrItem: TPropertyItem;
FieldName: String;
begin
  inherited;
  if not ( A_EditFirm.Visible and A_EditFirm.Enabled ) then
    Exit;

  CurrItem := SmartDlg.SelectedInfo;
  if Assigned( CurrItem ) then
    FieldName := CurrItem.FieldName
  else
    FieldName := '';

  try
    SmartDlg.SetSelectedRow( 0 );
    Application.ProcessMessages;

    if not ( OwnerForm is TfrClienstList ) then
      Exit;
    ( OwnerForm as TfrClienstList ).A_EditFirmExecute( A_EditFirm );
  finally
    if FieldName <> '' then
      SmartDlg.SetRowSelected( FieldName );
  end;
end;

procedure TfrRecordClients.A_NewFirmExecute(Sender: TObject);
var
CurrItem: TPropertyItem;
FieldName: String;
begin
  inherited;
  if not ( A_NewFirm.Visible and A_NewFirm.Enabled ) then
    Exit;

  CurrItem := SmartDlg.SelectedInfo;
  if Assigned( CurrItem ) then
    FieldName := CurrItem.FieldName
  else
    FieldName := '';

  try
    SmartDlg.SetSelectedRow( 0 );
    Application.ProcessMessages;

    if not ( OwnerForm is TfrClienstList ) then
      Exit;
    ( OwnerForm as TfrClienstList ).A_NewFirmExecute( A_NewFirm );
  finally
    if FieldName <> '' then
      SmartDlg.SetRowSelected( FieldName );
  end;
end;

procedure TfrRecordClients.A_SaveExecute(Sender: TObject);
begin
  try
    inherited;
  finally
    if ClientIsChange then begin
      if OwnerForm is TfrClienstList then
        ( OwnerForm as TfrClienstList ).Q_Clients.FullRefresh;
    end;
  end;
end;

procedure TfrRecordClients.FillDialogMenu;
begin
  inherited;
  A_EditFirm.Visible := ( OwnerForm as TfrClienstList ).A_EditFirm.Visible;
  A_NewFirm.Visible := ( OwnerForm as TfrClienstList ).A_NewFirm.Visible;

  With frPrima do begin
    AddInMainMenu( nil, ppDialog, A_Between, [ A_NewFirm, A_EditFirm, A_Sp ]);
    AddActListInBar( aTbSmartDLG, A_SetBetween, [ A_NewFirm, A_EditFirm, A_Sp ]);
  end;
end;

procedure TfrRecordClients.FormCreate(Sender: TObject);
begin
  inherited;
  ClientIsChange := False;
end;

procedure TfrRecordClients.FormShow(Sender: TObject);
var
CurrItem: TPropertyItem;
begin
  inherited;
  CurrItem := SmartDlg.RowsList.PropByHostFieldName( 'FIRM_LIST_SHORT' );

  A_EditFirm.Enabled := Assigned( CurrItem ) and ( CurrItem.RowValue <> '' );
end;

procedure TfrRecordClients.SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
const
sqlMails =
'select LIST_OF_CLIENT from GET_CLIENT_OF_MAIL_LINK( :CURR_CLIENT_ID, :E_MAIL_LIST )';
var
ResValues: TArrayVariant;
Item: TPropertyItem;
begin
  inherited;
  if not AnsiSameText( CurrItem.FieldName, 'E_MAIL_LIST' ) then
    Exit;
  if not IBTr_Clients.InTransaction then
    IBTr_Clients.StartTransaction;
  if GetQueryResult( sqlMails, [ dlgFillRows.PrimaryKeyValue, Trim( CurrItem.RowValue )], IBTr_Clients, ResValues ) then begin
      Item := SmartDlg.RowsList.PropByHostFieldNameAsReadOnly( 'CLIENTS_LINK' );
      if Assigned( Item ) then begin
        if not VarIsNull( ResValues[ 0 ]) then
          Item.RowValue := ResValues[ 0 ]
        else
          Item.RowValue := '';
      end;
  end;

  SmartDlg.Refresh;
end;

procedure TfrRecordClients.SmartDlgShowDialog(Dlg: TComponent; Info: TPropertyItem; const EditRect: TRect);
var
NewClientID: Integer;
MailItem: TPropertyItem;
EList: String;
begin
  inherited;
  if not AnsiSameText( Info.FieldName, 'CLIENTS_LINK' ) then
    Exit;
  if Info.RowValue = '' then
    Exit;

  NewClientID := TfrClientsListBox.ShowClientsLinkMail( Self, IBTr_Clients, Info.Title, Info.RowValue, dlgFillRows.PrimaryKeyValue );
  Application.ProcessMessages;
  if NewClientID <> dlgFillRows.PrimaryKeyValue then begin
    MailItem := SmartDlg.RowsList.PropByHostFieldNameAsReadOnly( 'E_MAIL_LIST' );
    if not Assigned( MailItem ) then
      Exit;
    EList := MailItem.RowValue;

    dlgFillRows.PrimaryKeyValue := NewClientID;
    dlgFillRows.ActionType := sdEdit;
    Self.Caption := TfrClienstList( OwnerForm ).A_EditClient.Caption;
    dlgFillRows.FillDlgParams( DlgIdent, [ NewClientID ]);
    SmartDlg.Refresh;
    Application.ProcessMessages;
    SmartDlg.SetRowSelected( 'E_MAIL_LIST' );
    MailItem.RowValue := EList;
    MailItem.OldValue := MailItem.RowValue;
    SmartDlg.Editor.Text := EList;
    ClientIsChange := True;
  end;
end;

end.
