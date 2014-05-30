{***************************************************************}
{    Сервис для E-Mail рассылки                                 }
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit frLsrmSend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Data.DB, IBDatabase, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IBCustomDataSet, IBQuery, Vcl.ExtCtrls, IBEvents;

type
  TSaveInLog = ( slNo, slAll, slError );

  TLsrmMailSend = class(TService)
    IBDB: TIBDatabase;
    IBTr_Read: TIBTransaction;
    IBTr_Write: TIBTransaction;
    SMTP: TIdSMTP;
    Mess: TIdMessage;
    OpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    TM: TTimer;
    Q_Mess: TIBQuery;
    Q_Save: TIBQuery;
    Q_MessAttach: TIBQuery;
    IBEvent: TIBEvents;
    Q_LabelList: TIBQuery;
    Q_LabelValue: TIBQuery;
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceExecute(Sender: TService);
    procedure TMTimer(Sender: TObject);
    procedure IBEventEventAlert(Sender: TObject; EventName: string; EventCount: Integer; var CancelAlerts: Boolean);
    procedure Q_LabelValueBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    IniPath: String;
    SaveInLog: TSaveInLog;
    function GetLogFileName: String;
    procedure ToLogFile(const Str: string);
    function ConnectParams: Boolean;
    procedure ReadMailList;
    procedure SaveResult( IsSend: Boolean; const ResultText: String);
    function SendToEMail(var ResultText: String): Boolean;
    procedure AddAttachmentFile( var Body: String );
    function MailBodyReplaceLabel( BodyValue: String ): String;
    property LogFileName: String read GetLogFileName;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

// Интервал опроса
const
  tiSmall = 3000;       // 3 секунды
  tiBig   = 1800000;   // 30 минут

var
  LsrmMailSend: TLsrmMailSend;

implementation


{$R *.DFM}

uses
  IdAttachment, IdAttachmentFile, IdText, IdHashMessageDigest;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  LsrmMailSend.Controller(CtrlCode);
end;

  {MD5}

function StrToMd5( Value: string ): string;
var
Hash: TIdHashMessageDigest5;
begin
  Result := '';
  Hash := TIdHashMessageDigest5.Create;
  try
    Result := AnsiUpperCase( Hash.HashStringAsHex( Value ));
  finally
    Hash.Free;
  end;
end;

  { Работа с ini-файлом }
function IniGetString( FileName, Section, Key: String ): String;
var
Res : DWORD;
begin
	SetLength( Result, MAX_PATH );
	Res := GetPrivateProfileString( PChar( Section ), PChar( Key ), #0, PChar( Result ), Length( Result ), PChar( FileName ));
	If Res > 0 then
		SetLength( Result, Res )
	else
		Result := '';
end;

function IniGetInteger( FileName, Section, Key : STRING ): Integer;
begin
  Result :=
    GetPrivateProfileInt( PChar( Section ), PChar( Key ), -1, PChar( FileName ) );
end;

function IniGetIntegerDef( FileName, Section, Key : STRING; DefValue: Integer ): Integer;
begin
  Result :=
    GetPrivateProfileInt( PChar( Section ), PChar( Key ), DefValue, PChar( FileName ) );
end;

   {TLsrmMailSend}

function TLsrmMailSend.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TLsrmMailSend.IBEventEventAlert(Sender: TObject; EventName: string; EventCount: Integer;
  var CancelAlerts: Boolean);
begin
  if TM.Enabled then
    ReadMailList;
end;


procedure TLsrmMailSend.TMTimer(Sender: TObject);
begin
  TM.Enabled := False;
  try
    If not ConnectParams then
      Exit;
    ReadMailList;
  finally
    TM.Enabled := True;
  end;
end;

/// Запись данных в лог
procedure TLsrmMailSend.ToLogFile(const Str: string);
var
FFile: TextFile;
begin
  if SaveInLog = slNo then
    Exit;

	try
		try
			AssignFile( FFile, LogFileName );
			If FileExists( LogFileName ) then
        Append( FFile )
      else
        Rewrite( FFile );

			Writeln( FFile, Str + #9 + DateTimeToStr( Now ));
		except
			//  Если не удалось записать, то значит не судьба.
		end;
	finally
		CloseFile( FFile );
	end;
end;

/// имя лог файла
function TLsrmMailSend.GetLogFileName: String;
  function GetLogPathDefault: String;
  begin
    Result := ExtractFileDir( ParamStr( 0 ));
    Result := IncludeTrailingPathDelimiter( IncludeTrailingPathDelimiter( Result ) + 'LOG' );
  end;

const
LogName = 'Log.txt';
begin
  Result := GetLogPathDefault + LogName;
	If not DirectoryExists( ExtractFileDir( Result )) then
		 ForceDirectories( ExtractFileDir( Result ));
end;

procedure TLsrmMailSend.SaveResult( IsSend: Boolean; const ResultText: String);
begin
  If not IBTr_Write.InTransaction then
    IBTr_Write.StartTransaction;
  try
    case IsSend of
      True:
        Q_Save.ParamByName( 'DATE_SEND' ).AsDateTime := Now;
      else
        Q_Save.ParamByName( 'DATE_SEND' ).Clear;
    end;
    Q_Save.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := Q_Mess.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger;
    Q_Save.ParamByName( 'CLIENTS_MAIL_LIST_ID' ).AsInteger := Q_Mess.FieldByName( 'CLIENTS_MAIL_LIST_ID' ).AsInteger;
    Q_Save.ParamByName( 'ERROR_TEXT' ).AsString := ResultText;
    Q_Save.ParamByName( 'IS_OK' ).AsInteger := Integer( IsSend );

    try
      Q_Save.ExecSQL;
      if SaveInLog = slAll then
        ToLogFile( Format( 'Запись результата отправки: "%S"', [ ResultText ]) );
    except
      on E: Exception do begin
        ToLogFile( E.Message );
        If IBTr_Write.InTransaction then
          IBTr_Write.Rollback;
      end;
    end;
  finally
    If IBTr_Write.InTransaction then
      IBTr_Write.Commit;
  end;
end;

procedure TLsrmMailSend.ServiceCreate(Sender: TObject);
begin
//  sleep( 5000 );

  IniPath := IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + 'Login.ini';
  GetFormatSettings;
  SysLocale.PriLangID := LANG_RUSSIAN;
  SysLocale.SubLangID := SUBLANG_ENGLISH_US;

  SaveInLog := TSaveInLog( IniGetIntegerDef( IniPath, 'LOG_FILE', 'SaveInLog', 0 ));

  SMTP.Host := IniGetString( IniPath, 'MAIL_SERVER', 'ServerName' );
  SMTP.Username := IniGetString( IniPath, 'MAIL_SERVER', 'Login' );
  SMTP.Password := IniGetString( IniPath, 'MAIL_SERVER', 'Pass' );
  SMTP.Port     := IniGetInteger( IniPath, 'MAIL_SERVER', 'Port' );
//  Mess.From.Domain  := IniGetString( IniPath, 'MAIL_SERVER', 'Domain' );
  Mess.From.Address := IniGetString( IniPath, 'MAIL_SERVER', 'FromAddress' );
//  Mess.From.User    := SMTP.Username;
  Mess.Sender.Address := IniGetString( IniPath, 'MAIL_SERVER', 'FromAddress' );
//  Mess.Sender.User    := SMTP.Username;

  OpenSSL.Destination := SMTP.Host + ':' + IntToStr( SMTP.Port );
  OpenSSL.Host := SMTP.Host;
  OpenSSL.Port := SMTP.Port;
  OpenSSL.DefaultPort := 0;
  OpenSSL.SSLOptions.Method := sslvTLSv1;
  OpenSSL.SSLOptions.Mode := sslmUnassigned;

//  SMTP.UseTLS := utUseExplicitTLS;
end;

function TLsrmMailSend.ConnectParams: Boolean;
begin
  IBDB.Close;
  sleep( 1000 );
  IBDB.Params.Clear;
  try
    IBDB.Params.Values[ 'user_name' ]     := IniGetString(IniPath, 'User', 'Login' );
    IBDB.Params.Values[ 'password' ]      := IniGetString(IniPath, 'User', 'Pass' );
    IBDB.Params.Values[ 'sql_role_name' ] := IniGetString(IniPath, 'User', 'Role' );
    IBDB.Params.Values[ 'lc_ctype' ]      := 'WIN1251';

    IBDB.DatabaseName  := IniGetString(IniPath, 'Base', 'Path' );
    if SaveInLog = slAll then begin
      ToLogFile( IBDB.DatabaseName );
      ToLogFile( IBDB.Params.Text );
    end;

    try
      IBDB.Connected := True;
      if SaveInLog = slAll then
        ToLogFile( 'IBDB.Connected := True' );
      IBTr_Read.StartTransaction;
      IBEvent.AutoRegister := True;
    except
      on E: Exception do begin
        ToLogFile( 'Ошибка коннекта к базе' + #13#10 + E.Message );
      end;
    end;
  finally
    Result := IBDB.Connected;
  end;
end;

procedure TLsrmMailSend.ServiceExecute(Sender: TService);
begin
  ToLogFile( 'Start' );
  If ConnectParams then begin

    sleep( 1000 );
    ReadMailList;
  end
  else
    Self.Status := csStopped;

  If not Terminated then
    ServiceThread.ProcessRequests(True);
end;

procedure TLsrmMailSend.ReadMailList;
var
ResultText: String;
IsSend: Boolean;
begin
  TM.Enabled := False;
  SaveInLog := TSaveInLog( IniGetIntegerDef( IniPath, 'LOG_FILE', 'SaveInLog', 0 ));
  TM.Interval := tiBig;   // Интервал для повторного запуска при отсутствии событий в базе (контрольная проверка)
  try
    if SaveInLog = slAll then
      ToLogFile( 'Чтение списка для отправки' );
    try
      if not IBTr_Read.InTransaction then
        IBTr_Read.StartTransaction;

      try
        Q_Mess.Open;
      except
        on E: Exception do
          ToLogFile( 'Чтение списка: ' + #13#10 + E.Message );
      end;

      while not Q_Mess.Eof do begin
        IsSend := SendToEMail( ResultText );
        SaveResult( IsSend, ResultText );
        Q_Mess.Next;
      end;
    finally
      Q_Mess.Close;
    end;
  finally
    TM.Enabled := True;
  end;
end;

function TLsrmMailSend.MailBodyReplaceLabel(BodyValue: String): String;
var
FName: String;
begin
  Result := StringReplace( BodyValue, 'src="images/', ' src="cid:', [ rfReplaceAll, rfIgnoreCase ]);

  Q_LabelList.Close;
  Q_LabelList.Open;
  Q_LabelList.First;
  while not Q_LabelList.Eof do begin
    FName := Q_LabelList.FieldByName( 'MAIL_BASE_LABEL_NAME' ).AsString;
    if Assigned( Q_LabelValue.FindField( FName )) then begin
      Result :=
        StringReplace( Result,
          '####' + FName + '###',
          Q_LabelValue.FieldByName( FName ).AsString,
          [ rfReplaceAll, rfIgnoreCase ]);
    end;

    Q_LabelList.Next;
  end;
end;

procedure TLsrmMailSend.Q_LabelValueBeforeOpen(DataSet: TDataSet);
begin
  Q_LabelValue.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := Q_MEss.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger;
  Q_LabelValue.ParamByName( 'CLIENTS_MAIL_LIST_ID' ).AsInteger := Q_MEss.FieldByName( 'CLIENTS_MAIL_LIST_ID' ).AsInteger;
end;

function TLsrmMailSend.SendToEMail( var ResultText: String ): Boolean;
const
rsOK = 'Отправлено';
rsErr = 'Ошибка отправки';
var
TestMail, BodySource: String;
begin
  Result := false;
  ResultText := '';
  if SaveInLog = slAll then
    ToLogFile( '********************************************' );

  try
    try
      if SaveInLog = slAll then
        ToLogFile( 'Соединение с сервером почты' );
      SMTP.Connect;
    except
      on E: Exception do begin
        ToLogFile( E.Message );
        Exit;
      end;
    end;

    try
      if SaveInLog = slAll then
        ToLogFile( Format( 'Connected = %D ', [ Integer( SMTP.Connected )]) );
      try
        Mess.ContentType := 'multipart/mixed';  //'multipart/mixed';
        Mess.MessageParts.Clear;
        Mess.CharSet := 'utf-8';
        Mess.Date := Date + Time;
        Mess.Subject := Q_Mess.FieldByName( 'SUBJECT' ).AsString;
        Mess.Body.Clear;


        with TIdText.Create( Mess.MessageParts ) do begin
          ContentType := 'multipart/related; type="multipart/alternative"';
        end;

        with TIdText.Create( Mess.MessageParts ) do begin
          ContentType := 'multipart/alternative';
          ParentPart := 0;
        end;

        Q_LabelValue.Close;
        Q_LabelValue.Open;

        with TIdText.Create( Mess.MessageParts ) do begin
          Body.Text :=
            String( AnsiToUtf8( MailBodyReplaceLabel( Q_Mess.FieldByName( 'BODY_TEXT' ).AsString )));
          ContentType := 'text/plain';
          CharSet := 'utf-8';
          ParentPart := 1;
        end;

        with TIdText.Create( Mess.MessageParts ) do begin
          BodySource := MailBodyReplaceLabel( Q_Mess.FieldByName( 'MAIL_BODY' ).AsString );
          ContentType := 'text/html';
          CharSet := 'utf-8';
          ParentPart := 1;
          AddAttachmentFile( BodySource );
          Body.Text :=
            String( AnsiToUtf8( BodySource ));
        end;



        TestMail := Trim( IniGetString(IniPath, 'TEST_MODE', 'E_Mail' ));
        if TestMail <> '' then
          Mess.Recipients.EMailAddresses := TestMail
        else
          Mess.Recipients.EMailAddresses := Q_Mess.FieldByName( 'E_MAIL' ).AsString;

        Mess.CCList.EMailAddresses := Q_Mess.FieldByName( 'COPY_ADDRESS' ).AsString;
        Mess.ReplyTo.EMailAddresses := Q_Mess.FieldByName( 'REPLY_ADDRESS' ).AsString;

        if SaveInLog = slAll then begin
          ToLogFile( Format( 'Тема: "%S"', [ Mess.Subject ]));
          ToLogFile( Format( 'Отправка для "%S"', [ Mess.Recipients.EMailAddresses ]));
          ToLogFile( Format( 'Кодировка "%S"', [ Mess.ContentType ]));
        end;

        Mess.CharSet := 'utf-8';

      except on E: Exception do
        ToLogFile( E.Message );
      end;

      If SMTP.Connected {and SMTP.Authenticate} then
        try
          SMTP.Send( Mess );
          ResultText := rsOK;
          if SaveInLog = slAll then
            ToLogFile( 'Сообщение отправлено!' );
        except
          on E: Exception do begin
            ResultText := rsErr + #13#10 + E.Message;
            ToLogFile( ResultText );
            Exit;
          end;
        end;
    finally
      if SaveInLog = slAll then
        ToLogFile( ResultText );
      SMTP.Disconnect;
      Q_LabelValue.Close;
    end;
  finally
    Result := ResultText = rsOK;
  end;
end;

procedure TLsrmMailSend.AddAttachmentFile( var Body: String );
var
ST: TMemoryStream;
ContentName: String;
begin
  if SaveInLog = slAll then
    ToLogFile( Format( 'Добавить attach: "%D"', [ Q_Mess.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger ]) );
  Q_MessAttach.Close;
  Q_MessAttach.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger :=
    Q_Mess.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger;

  try
    Q_MessAttach.Open;
  except
    on E: Exception do
      ToLogFile( 'Добавить attach ' + #13#10 + E.Message );
  end;

  If Q_MessAttach.Eof and Q_MessAttach.Bof then begin
    if SaveInLog = slAll then
      ToLogFile( 'attach не найден' );
    Exit;
  end;

  ST := TMemoryStream.Create;
  try
    while not Q_MessAttach.Eof do begin
      ST.Clear;
      try
        TBlobField( Q_MessAttach.FieldByName( 'FILE_BODY' )).SaveToStream( ST );
        ST.Position := 0;
        With TIdAttachmentFile.Create( Mess.MessageParts ) do begin
          if Q_MessAttach.FieldByName( 'IS_RELATED' ).AsInteger = 1 then begin
            ContentName := StrToMd5( Q_MessAttach.FieldByName( 'FILE_NAME' ).AsString );
            Body := StringReplace( Body, Q_MessAttach.FieldByName( 'FILE_NAME' ).AsString, ContentName, [ rfReplaceAll, rfIgnoreCase ]);
            ContentID := ContentName;
            ParentPart := 0;
            ContentDisposition := 'inline';
          end;
          ContentType := 'image/' + StringReplace( ExtractFileExt( Q_MessAttach.FieldByName( 'FILE_NAME' ).AsString ), '.', '', []);
          FileName := Q_MessAttach.FieldByName( 'FILE_NAME' ).AsString;
          LoadFromStream( ST );
          if SaveInLog = slAll then
            ToLogFile( Format( 'Add "%S" "%S"', [ FileName, ContentName ]));
        end;
      except
        on E:Exception do
          ToLogFile( 'Ошибка при добавлении вложения'+ #13#10 + E.Message );
      end;
      Q_MessAttach.Next;
      Sleep( 1000 );
    end;
  finally
    ST.Free;
  end;
end;

procedure TLsrmMailSend.ServiceShutdown(Sender: TService);
begin
  Self.Status := csStopped;
end;

procedure TLsrmMailSend.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  ToLogFile( 'Stop' + #13#10#13#10 );
end;

end.
