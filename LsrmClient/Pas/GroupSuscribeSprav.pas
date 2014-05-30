{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit GroupSuscribeSprav;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSprav, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet, pFIBDataSet,
  PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls, DlgExecute,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TfrGroupSuscribeSprav = class(TfrCustomSprav)
    SpGroup: TSplitter;
    dbgClients: TDBGridEh;
    Q_Clients: TpFIBDataSet;
    dsClients: TDataSource;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowSpravDlg(ID: Integer; DlgType: TStateDlg; Act: TAction); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TfrGroupSuscribeSprav.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBGridToBase( dbgClients, Self.ClassName, dbgClients.Name );
  inherited;
end;

procedure TfrGroupSuscribeSprav.FormResize(Sender: TObject);
begin
  inherited;
  dbgClients.Width := Self.ClientWidth div 2;
end;

procedure TfrGroupSuscribeSprav.FormShow(Sender: TObject);
begin
  inherited;
  BaseToDBGrid( dbgClients, Self.ClassName, dbgClients.Name );
end;

procedure TfrGroupSuscribeSprav.ShowSpravDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
begin
  inherited;
  Q_Clients.CloseOpen( True );
end;

end.
