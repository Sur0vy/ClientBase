{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ClientsListBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ToolWin, ImgList, ActnList, Tools, FIBQuery, pFIBQuery,
  pFIBDatabase, RecordClients;

type
  TfrClientsListBox = class(TForm)
    ToolB: TToolBar;
    TB_Save: TToolButton;
    TB_Close: TToolButton;
    TB_S: TToolButton;
    ActList: TActionList;
    A_Save: TAction;
    A_Close: TAction;
    lbClients: TListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure A_SaveExecute(Sender: TObject);
    procedure A_CloseExecute(Sender: TObject);
  private
    { Private declarations }
    procedure FillClientsList( IBTr: TpFIBTransaction; CurrClientID: Integer );
    procedure SetFormSize( Owner: TfrRecordClients );
    function NewClientID( CurrID: Integer ): Integer;
  public
    { Public declarations }
    class function ShowClientsLinkMail( Sender: TCustomForm; IBTr: TpFIBTransaction; const Title, HostMailList: String; CurrClientID: Integer ): Integer;
  end;


implementation

{$R *.dfm}

uses
  Prima, ConstList, ClientDM, SqlTools;

procedure TfrClientsListBox.SetFormSize(Owner: TfrRecordClients);
begin
  Self.Width := Owner.ClientWidth div 2;
  Self.Height := ( Owner.ClientHeight div 3 ) * 2;
  Self.Constraints.MinHeight := Self.Height div 2;
  Self.Constraints.MinWidth := Self.Width div 2;
end;

class function TfrClientsListBox.ShowClientsLinkMail( Sender: TCustomForm; IBTr: TpFIBTransaction; const Title, HostMailList: String; CurrClientID: Integer ): Integer;
var
Dlg: TfrClientsListBox;
begin
  Result := CurrClientID;
  Dlg := TfrClientsListBox.Create( Sender );
  With Dlg do
    try
      SetFormSize( TfrRecordClients( Sender ));
      FillClientsList( IBTr, CurrClientID );
      If Dlg.ShowModal = mrOK then begin
        Result := NewClientID( CurrClientID );
        if IBTr.InTransaction then
          IBTr.Commit;
      end;
    finally
      Dlg.Release;
    end;
end;

procedure TfrClientsListBox.FillClientsList( IBTr: TpFIBTransaction; CurrClientID: Integer );
const
sqlList =
'select' + #13#10 +
'  distinct' + #13#10 +
'  CL.CLIENT_TITLE, CL.CLIENT_LIST_ID' + #13#10 +
'from V_CLIENT_LIST_MAIL CL' + #13#10 +
'  join CLIENTS_MAIL_LIST ML  on ( ML.CLIENT_LIST_ID = CL.CLIENT_LIST_ID )' + #13#10 +
'  join MAIL_TEMP T           on ( T.E_MAIL          = ML.E_MAIL )' + #13#10 +
'where' + #13#10 +
'  ML.CLIENT_LIST_ID is not null and' + #13#10 +
'  CL.CLIENT_LIST_ID <> :CURR_CLIENT_LIST_ID' + #13#10 +
'order by' + #13#10 +
'  CL.CLIENT_TITLE';

var
Query: TNewQuery;
begin
  if not IBtr.InTransaction then
    Exit;

  lbClients.Items.Clear;
  Query := TNewQuery.CreateNew( frDM, IBTr  );
  try
    Query.SQL.Text := sqlList;
    If not Query.Prepared then
      Query.Prepare;

    Query.ParamByName( 'CURR_CLIENT_LIST_ID' ).AsInteger := CurrClientID;
    try
      Query.ExecQuery;
    except
      Raise;
    end;
    while not Query.Eof do begin
      lbClients.Items.AddObject( Query.FieldByName( 'CLIENT_TITLE' ).AsString,
                                 TObject( Query.FieldByName( 'CLIENT_LIST_ID' ).AsInteger ));
      Query.Next;
    end;
    if lbClients.Items.Count > 0 then
      lbClients.Selected[ 0 ] := True;
	finally
		Query.FreeAndCommit;
	end;
end;

procedure TfrClientsListBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

function TfrClientsListBox.NewClientID( CurrID: Integer ): Integer;
begin
  Result := CurrID;
  If lbClients.Selected[ lbClients.ItemIndex ] then
    Result := Integer( lbClients.Items.Objects[ lbClients.ItemIndex ]);
end;

procedure TfrClientsListBox.A_SaveExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrClientsListBox.A_CloseExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
