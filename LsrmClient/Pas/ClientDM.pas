{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ClientDM;

interface

{$I Lsrm.inc}

uses
  Winapi.Windows,
  System.SysUtils, System.Classes, System.Variants,
  Vcl.Controls, Vcl.ActnList, ConstList, RightType, frxClass, frxDesgn, SIBEABase, SIBFIBEA,
  FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, frxFIBComponents;

type
  TfrDM = class(TDataModule)
    IBDB: TpFIBDatabase;
    IBTrRead: TpFIBTransaction;
    IBTrWrite: TpFIBTransaction;
    Q_UserRight: TpFIBQuery;
    fibEvent: TSIBfibEventAlerter;
    IBTrGridSave: TpFIBTransaction;
    procedure frxRepBeginDoc(Sender: TObject);
    procedure frxRepClosePreview(Sender: TObject);
    procedure frxRepEndDoc(Sender: TObject);
    procedure IBDBAfterConnect(Sender: TObject);
    procedure fibEventEventAlert(Sender: TObject; EventName: string; EventCount: Integer);
    procedure IBTrReadAfterEnd(EndingTR: TFIBTransaction; Action: TTransactionAction; Force: Boolean);
  private
    { Private declarations }
    procedure GetCurrentParams;
    procedure ApplicationClose(Sender: TObject);
  public
    IsPostQueryRefresh: Boolean;
    ExistsModalDlg: Boolean;
    procedure SetFuncRightAccess(SelfForm: TWinControl; ParentName: String);
    function SetFuncWriteRight: TUserRightTypes;
end;

// Смотрите Lsrm.inc
{$IFDEF COMMAND_LINE}
const
  DebugUser = 'SYSDBA';
  DebugPass = 'masterkey';

//  DebugUser = 'DAN';
//  DebugPass = 'lsrmk273';

//  ServName  = 'Firebird:Lsrm';
  ServName  = 'Localhost:Lsrm';
{$ENDIF}

var
  frDM: TfrDM;

implementation

{$R *.dfm}

uses
  System.Math, frxPreview, Prima, Vcl.Dialogs, SqlTools, Procs, Vcl.ExtCtrls, Vcl.Forms;

{%CLASSGROUP 'System.Classes.TPersistent'}

procedure TfrDM.ApplicationClose(Sender: TObject);
begin
  Halt;
end;

procedure TfrDM.IBDBAfterConnect(Sender: TObject);
begin
  IBTrRead.StartTransaction;
  GetCurrentParams;
  SetFuncRightAccess( frPrima, 'DATA-BASE-CLIENTS' );
  fibEvent.Events.Clear;
  fibEvent.Events.Append( 'ALL_JOB_STOP' );
  fibEvent.Events.Append( EventUpdManager );

  fibEvent.AutoRegister := True;
end;

procedure TfrDM.IBTrReadAfterEnd(EndingTR: TFIBTransaction; Action: TTransactionAction; Force: Boolean);
begin
//
end;

/// Права на доступ к элементам формы
procedure TfrDM.SetFuncRightAccess(SelfForm: TWinControl; ParentName: String);
var
Comp: TComponent;
begin
  If ParentName = '' then
    Exit;

  try
    Q_UserRight.ParamByName( 'PARENT_FUNC_NAME' ).AsString := AnsiUpperCase( ParentName );
    Q_UserRight.ParamByName( 'USER_ID' ).AsInteger := CurrentUserID;

    try
      Q_UserRight.ExecQuery;
    except
      Raise;
    end;

    While not Q_UserRight.Eof do begin
      Comp := SelfForm.FindComponent( Q_UserRight.FieldByName( 'FUNC_NAME' ).AsString );
      If Comp = nil then begin
         Q_UserRight.Next;
         Continue;
      end;
      If Comp is TAction then begin
        ( Comp as TAction ).Visible := True;
      end;

      Q_UserRight.Next;
    end;
  finally
    Q_UserRight.Close;
  end;
end;

function TfrDM.SetFuncWriteRight: TUserRightTypes;
begin
  Result := [];
  if not IBTrRead.InTransaction then
    IBTrRead.StartTransaction;

  try
    Q_UserRight.ParamByName( 'PARENT_FUNC_NAME' ).AsString := 'RIGHT_ACTION';
    Q_UserRight.ParamByName( 'USER_ID' ).AsInteger := CurrentUserID;

    try
      Q_UserRight.ExecQuery;
    except
      Raise;
    end;
    If ( Q_UserRight.Bof and Q_UserRight.Eof ) then
      Result := [ IsReadOnly, isSelfShow ]
    else
      While not Q_UserRight.Eof do begin
        Case IndexOfStrArray( Q_UserRight.FieldByName( 'FUNC_NAME' ).AsString,
             [ 'READ_ONLY', 'ALL_RIGHT_EDIT', 'ALL_RIGHT_SHOW', 'SHOW_SELF', 'EDIT_SELF' ] ) of
          0: Result := Result + [ IsReadOnly ];
          1: Result := Result + [ isAllEdit ];
          2: Result := Result + [ isAllShow ];
          3: Result := Result + [ isSelfShow ];
          4: Result := Result + [ isSelfEdit ];
        end;
        Q_UserRight.Next;
      end;
  finally
    Q_UserRight.Close;
  end;
end;

procedure TfrDM.GetCurrentParams;
  function ManagerIdToLengthStr( Value, ResLength: Integer ): String;
  var
  L: Integer;
  begin
    Result := IntToStr( Value );
    L := Length( Result );
    If L < ResLength then
      Result := StringOfChar( '0', ResLength - L ) + Result;
  end;

const
sqlUserList =
'select' + #13#10 +
'  U.USER_LIST_ID, P.PERSONAL_ID, P.PERSONAL_TITLE' + #13#10 +
'from USER_LIST U ' + #13#10 +
'  left join PERSONAL P  on ( P.PERSONAL_ID = coalesce( U.USER_LIST_ID, 1 )) ' + #13#10 +
'where' + #13#10 +
'  ( U.LOGIN = current_user ) and' + #13#10 +
'  ( U.IS_DELETE > 0 )';

sqlRight =
'select' + #13#10 +
'  first 1' + #13#10 +
'  G.RIGHT_GROUP_TITLE, L.RIGHT_GROUP_ID' + #13#10 +
'from USER_RIGHT_GROUP_LINK L, RIGHT_GROUP G' + #13#10 +
'where' + #13#10 +
'  L.RIGHT_GROUP_ID = G.RIGHT_GROUP_ID and' + #13#10 +
'  L.USER_LIST_ID = :USER_LIST_ID' + #13#10 +
'order by' + #13#10 +
'  L.ORDER_BY';

var
Query: TNewQuery;
begin
	Query := TNewQuery.CreateNew( Self, IBTrRead );
	try
		Query.SQL.Text := sqlUserList;
		try
      Query.ExecQuery;
      if Query.Eof and Query.Bof then begin
        ShowMessage( 'Нет прав на доступ' );
        frPrima.Close;
        Exit;
      end;


			CurrentUserID       := Query.FieldByName( 'USER_LIST_ID' ).AsInteger;

      CurrentManagerTitle := Query.FieldByName( 'PERSONAL_TITLE' ).AsString;
      EventUpdManager     := Format( 'CHECK_PERSONAL_UPD_%S', [ ManagerIdToLengthStr( CurrentUserID, 10 )]);

      Query.Close;
    except
      Raise;
    end;

		Query.SQL.Text := sqlRight;
		try
      Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;

      Query.ExecQuery;

			CurrentRightGroupID    := Query.FieldByName( 'RIGHT_GROUP_ID' ).AsInteger;
      CurrentRightGroupTitle := Query.FieldByName( 'RIGHT_GROUP_TITLE' ).AsString;

      Query.Close;
    except
      Raise;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TfrDM.fibEventEventAlert(Sender: TObject; EventName: string; EventCount: Integer);
begin
  if AnsiSameText( EventName, 'ALL_JOB_STOP' ) then begin
		With TTimer.Create( Self ) do begin
			Enabled := False;
			Interval := 1000 * 60 * 5;  // 5 минут
			OnTimer := ApplicationClose;
			Enabled := True;
		end;

    With FormatSettings do
      MessageBox( frPrima.Handle,
                  PChar( 'В связи с профилактическими работами в ' +
                          FormatDateTime( 'hh' + TimeSeparator + 'nn', StrToTime( '0:05:00' ) + Time ) +
                         ' сервер будет отключен.' + #13#10 +
                         'Прошу завершить работу и закрыть программу "' + frPrima.Caption + '"' ),
                  'Отключение на профилактику',
                  MB_APPLMODAL or MB_OK or MB_ICONINFORMATION );
  end

  else

  if AnsiSameText( EventName, EventUpdManager ) then begin
    IsPostQueryRefresh := True;
    ExistsModalDlg :=
      Assigned( Screen.ActiveCustomForm ) and
      ( fsModal in Screen.ActiveCustomForm.FormState );
    If not ExistsModalDlg then
      frPrima.SetQueryRefresh;
  end;
end;

procedure TfrDM.frxRepBeginDoc(Sender: TObject);
var
Q_Inside: TfrxFIBQuery;
begin
	Q_Inside := TfrxFIBQuery( TfrxReport( Sender ).FindObject( 'Q_Rep' ));
	If Assigned( Q_Inside ) then
		Q_Inside.Database.Connected := True;
end;

procedure TfrDM.frxRepClosePreview(Sender: TObject);
begin
  If Assigned( Sender ) and ( Sender is TfrxPreviewForm ) then
    If Assigned( TfrxPreviewForm( Sender ).Report ) then
    	TfrxPreviewForm( Sender ).Report.FreeOnRelease;
end;


procedure TfrDM.frxRepEndDoc(Sender: TObject);
var
Q_Inside: TfrxFIBQuery;
begin
	Q_Inside := TfrxFIBQuery( TfrxReport( Sender ).FindObject( 'Q_Rep' ));
	If Assigned( Q_Inside ) then
		Q_Inside.Database.Connected := False;
end;

end.
