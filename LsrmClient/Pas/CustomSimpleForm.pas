{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit CustomSimpleForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomForm, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList,
  Vcl.ComCtrls, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet, pFIBDataSet, GridsEh, DBGridEh;

type
  TfrCustomSimpleForm = class(TfrCustomForm)
    dbgHost: TDBGridEh;
    Q_Host: TpFIBDataSet;
    dsHost: TDataSource;
    procedure FormActivate(Sender: TObject); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Q_HostBeforeOpen(DataSet: TDataSet);
    function GetAccessConditionValue: String; virtual;
    procedure Q_HostEndScroll(DataSet: TDataSet);
    procedure dbgHostEnter(Sender: TObject);
    procedure Q_HostBeforeScroll(DataSet: TDataSet);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure FillHostMenu; virtual; abstract;
    class procedure ShowSimpleForm( Act: TAction; DlgIdent: Integer );
  end;



implementation

{$R *.dfm}

uses Prima, ClientDM;

{ TfrCustomSimpleForm }

procedure TfrCustomSimpleForm.FormActivate(Sender: TObject);
begin
  inherited;
  FillHostMenu;
  if Q_Host.Active then
    Q_Host.Refresh;
end;

procedure TfrCustomSimpleForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
    DBGridToBase( dbgHost, Self.ClassName, dbgHost.Name );
  finally
    inherited;
  end;
end;

function TfrCustomSimpleForm.GetAccessConditionValue: String;
begin
  Result := '';
end;

procedure TfrCustomSimpleForm.Q_HostAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsScroll := False;
end;

procedure TfrCustomSimpleForm.Q_HostBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if not Q_Host.Transaction.InTransaction then
    Q_Host.Transaction.StartTransaction;
end;

procedure TfrCustomSimpleForm.Q_HostBeforeScroll(DataSet: TDataSet);
begin
  IsScroll := True;
  inherited;
end;

procedure TfrCustomSimpleForm.Q_HostEndScroll(DataSet: TDataSet);
begin
  inherited;
  DataSetAfterScroll( DataSet );
end;

class procedure TfrCustomSimpleForm.ShowSimpleForm( Act: TAction; DlgIdent: Integer );
begin
  With Self.Create( Application ) do begin
    try
      IsWriteRight := True;
      A_Filtr.DlgIdent := DlgIdent;
      WindowState := wsMaximized;

      ActiveControl := dbgHost;

      SetAccessRight( Act.Name );
      BaseToDBGrid( dbgHost, Self.ClassName, dbgHost.Name );
      Caption := Act.Caption;
      FormCaption := Act.Caption;
      FormActivate( nil );

      if SetAccessRightOfRows( Q_Host, GetAccessConditionValue ) then begin
        HostSqlText := Q_Host.SelectSQL.Text;
        OpenDataSetOfStartForm;
      end;
    finally
      If not Q_Host.Active then
        Close;
    end;
  end;
end;

procedure TfrCustomSimpleForm.dbgHostEnter(Sender: TObject);
begin
  inherited;
  DbGridEnter( Sender );
end;



end.
