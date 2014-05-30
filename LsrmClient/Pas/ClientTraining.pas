{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ClientTraining;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSimpleForm, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet,
  pFIBDataSet, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls,
  DlgExecute;

type
  TfrClientTraining = class(TfrCustomSimpleForm)
    A_NewClientTraining: TAction;
    A_EditClientTraining: TAction;
    A_DelClientTraining: TAction;
    A_AddClientTraining: TAction;
    procedure A_DelClientTrainingExecute(Sender: TObject);
    procedure A_EditClientTrainingExecute(Sender: TObject);
    procedure A_NewClientTrainingExecute(Sender: TObject);
    procedure dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    function GetAccessConditionValue: String; override;
    procedure A_AddClientTrainingExecute(Sender: TObject);
    procedure SetAccessRight( const ActName: String  ); override;
  private
    procedure ShowTrainingDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    function CheckTrainingIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure FillHostMenu; override;
  end;


implementation

{$R *.dfm}

uses
  RecordEdit, ConstList, Prima;


procedure TfrClientTraining.A_DelClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelClientTraining.Visible and A_DelClientTraining.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Host, 'CLIENT_TRAINING_IUD', 'Удалить текущее обучение клиента?', '',
                [ 'CLIENT_TRAINING_ID' ],
                [ Q_Host.FieldByName( 'CLIENT_TRAINING_ID' ).AsInteger ] );
end;

procedure TfrClientTraining.A_EditClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_EditClientTraining.Visible and A_EditClientTraining.Enabled ) then
    Exit;

  ShowTrainingDlg( Q_Host.FieldByName( 'CLIENT_TRAINING_ID' ).AsInteger, sdEdit, A_EditClientTraining );
end;

procedure TfrClientTraining.A_NewClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewClientTraining.Visible and A_NewClientTraining.Enabled ) then
    Exit;

  ShowTrainingDlg( -1, sdInsert, A_NewClientTraining );
end;

procedure TfrClientTraining.A_AddClientTrainingExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddClientTraining.Visible and A_AddClientTraining.Enabled ) then
    Exit;

  ShowTrainingDlg( Q_Host.FieldByName( 'CLIENT_TRAINING_ID' ).AsInteger, sdCopy, A_AddClientTraining );
end;

procedure TfrClientTraining.dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    case Key of
      VK_RETURN:
        A_EditClientTrainingExecute( A_EditClientTraining );
    end;
end;

procedure TfrClientTraining.FillHostMenu;
begin
  inherited;
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddClientTraining, A_Sp, A_NewClientTraining, A_EditClientTraining, A_DelClientTraining, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Обучение клиентов',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewClientTraining, A_EditClientTraining, A_DelClientTraining, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrClientTraining.SetAccessRight(const ActName: String);
begin
  inherited;
  A_AddClientTraining.Visible := A_NewClientTraining.Visible;
end;

function TfrClientTraining.GetAccessConditionValue: String;
begin
  Result := inherited;
  Result := Format( '( REG_PERSONAL_ID = %D )', [ CurrentUserID ]);
end;

procedure TfrClientTraining.Q_HostAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_EditClientTraining.Enabled := not Q_Host.IsEmpty;
  A_DelClientTraining.Enabled := A_EditClientTraining.Enabled;
end;

procedure TfrClientTraining.ShowTrainingDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnCheckIsSelf := CheckTrainingIsSelfRecord;

  ShowEditDialog( Self, TfrRecordEdit, Q_Host, 'TRAINING_LIST_ID', dlgTrainingJournal, ID, DlgType, Act, CurrDlgEvent, [ ID ] );
end;

function TfrClientTraining.CheckTrainingIsSelfRecord(Sender: TObject; DS: TpFIBDataSet): Boolean;
begin
  Result :=
    DS.FBN( 'REG_PERSONAL_ID' ).AsInteger = CurrentUserID;
end;

end.
