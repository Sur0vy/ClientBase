{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit AgreesList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSimpleForm, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet,
  pFIBDataSet, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls,
  DlgExecute;

type
  TfrAgreesList = class(TfrCustomSimpleForm)
    A_NewAgrees: TAction;
    A_EditAgrees: TAction;
    A_DelAgrees: TAction;
    A_AddCopyAgrees: TAction;
    procedure A_DelAgreesExecute(Sender: TObject);
    procedure A_EditAgreesExecute(Sender: TObject);
    procedure A_NewAgreesExecute(Sender: TObject);
    procedure dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    function GetAccessConditionValue: String; override;
    procedure A_AddCopyAgreesExecute(Sender: TObject);
    procedure SetAccessRight( const ActName: String  ); override;
  private
    procedure ShowAgreesListDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    function CheckAgreesIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure FillHostMenu; override;
  end;


implementation

{$R *.dfm}

uses
  RecordEdit, ConstList, Prima;


procedure TfrAgreesList.A_DelAgreesExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelAgrees.Visible and A_DelAgrees.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Host, 'AGREES_LIST_IUD', 'Удалить текущее обучение клиента?', '',
                [ 'AGREES_LIST_ID' ],
                [ Q_Host.FieldByName( 'AGREES_LIST_ID' ).AsInteger ] );
end;

procedure TfrAgreesList.A_EditAgreesExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditAgrees.Visible and A_EditAgrees.Enabled ) then
    Exit;

  ShowAgreesListDlg( Q_Host.FieldByName( 'AGREES_LIST_ID' ).AsInteger, sdEdit, A_EditAgrees );
end;

procedure TfrAgreesList.A_NewAgreesExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewAgrees.Visible and A_NewAgrees.Enabled ) then
    Exit;

  ShowAgreesListDlg( -1, sdInsert, A_NewAgrees );
end;

procedure TfrAgreesList.A_AddCopyAgreesExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopyAgrees.Visible and A_AddCopyAgrees.Enabled ) then
    Exit;

  ShowAgreesListDlg( Q_Host.FieldByName( 'AGREES_LIST_ID' ).AsInteger, sdCopy, A_AddCopyAgrees );
end;

procedure TfrAgreesList.dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    case Key of
      VK_RETURN:
        A_EditAgreesExecute( A_EditAgrees );
    end;
end;

procedure TfrAgreesList.FillHostMenu;
begin
  inherited;
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddCopyAgrees, A_Sp, A_NewAgrees, A_EditAgrees, A_DelAgrees, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Список договоров',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewAgrees, A_EditAgrees, A_DelAgrees, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrAgreesList.SetAccessRight(const ActName: String);
begin
  inherited;
  A_AddCopyAgrees.Visible := A_NewAgrees.Visible;
end;

function TfrAgreesList.GetAccessConditionValue: String;
begin
  Result := inherited;
  Result := Format( '( REG_PERSONAL_ID = %D )', [ CurrentUserID ]);
end;

procedure TfrAgreesList.Q_HostAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditAgrees.Enabled := not Q_Host.IsEmpty;
  A_DelAgrees.Enabled := A_EditAgrees.Enabled;
end;

procedure TfrAgreesList.ShowAgreesListDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnCheckIsSelf := CheckAgreesIsSelfRecord;

  ShowEditDialog( Self, TfrRecordEdit, Q_Host, 'AGREES_LIST_ID', dlgAgreesListJournal, ID, DlgType, Act, CurrDlgEvent, [ ID ] );
end;

function TfrAgreesList.CheckAgreesIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
begin
  Result :=
    DS.FBN( 'REG_PERSONAL_ID' ).AsInteger = CurrentUserID;
end;




end.
