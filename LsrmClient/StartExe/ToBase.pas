unit ToBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GridDlg, RegSmartDlg, FIBQuery, pFIBQuery, pFIBErrorHandler, FIBDatabase,
  pFIBDatabase, Vcl.Menus, Vcl.ImgList, Vcl.StdActns, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  DlgParams;

type
  TfrToBase = class(TForm)
    SmartDlg: TSmartDlg;
    ActList: TActionList;
    A_Save: TAction;
    A_Close: TAction;
    A_Help: THelpContents;
    A_ClearAll: TAction;
    A_Clear: TAction;
    A_Font: TAction;
    A_ServParam: TAction;
    FontD: TFontDialog;
    ImList: TImageList;
    PM: TPopupMenu;
    IBDB: TpFIBDatabase;
    IBTr_R: TpFIBTransaction;
    IBTr: TpFIBTransaction;
    Query: TpFIBQuery;
    IB_Q: TpFIBQuery;
    ToolB: TToolBar;
    TB_Connect: TToolButton;
    TB_Close: TToolButton;
    tb_Sp1: TToolButton;
    TB_ClearAll: TToolButton;
    TB_Clear: TToolButton;
    tbSp2: TToolButton;
    TB_Serv: TToolButton;
    SB: TStatusBar;
    pFibErrorHandler1: TpFibErrorHandler;
    PB: TProgressBar;
    pmSave: TMenuItem;
    pmClose: TMenuItem;
    pmSep: TMenuItem;
    pmClearAll: TMenuItem;
    pmClear: TMenuItem;
    pmSep2: TMenuItem;
    pmServParams: TMenuItem;
    A_ClearCurrList: TAction;
    pmClearList: TMenuItem;
    A_EditCut: TEditCut;
    A_EditCopy: TEditCopy;
    A_EditPaste: TEditPaste;
    tbEditCut: TToolButton;
    tbEditCopy: TToolButton;
    tbEditPaste: TToolButton;
    tbSp3: TToolButton;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    pmSp4: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure A_ServParamExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure A_SaveExecute(Sender: TObject);
    Procedure CMDialogKey(var AMessage: TCMDialogKey); message CM_DIALOGKEY;
    procedure SmartDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure A_ClearCurrListExecute(Sender: TObject);
    procedure SmartDlgChangeRow(Sender: TObject; NewRow: Integer);
    procedure A_ClearExecute(Sender: TObject);
    procedure A_ClearAllExecute(Sender: TObject);
  private
    { Private declarations }
    SysLogin: String;
    ServInd, PathInd, UserInd, PassInd: Integer;
    WorkDir: String;

    procedure GetServParam;
    function ReadRegList(Key, Param: String; var RegItems: TStringList): Boolean;
    function SaveRegList(Key, Param, Value: String): Boolean;
    procedure ExceptionShow(Sender: TObject; E: Exception);
    procedure ToolBarDisable(IsEnable: Boolean);
    procedure ServParamExecute(Sender: TObject);
    procedure SetIBDBParams( Pass, ServName, BasePath: String );
    function GetExportParams(var MessStr: String): Boolean;
    procedure ProgListExecute;
    procedure GetNewFile( IsExecute, ID: Integer );
    function IsRunExe(Path: String): Boolean;
    procedure WriteToFile(FIleName: String; UpdateDate: Integer; Query: TpFIBQuery);
    function ReadDefaultParams(var ServName, PathName: String): Boolean;
    procedure CreateIcon;
  public
    { Public declarations }
  end;

var
  frToBase: TfrToBase;

const
	RegConnectOld = 'SoftWare\LPT\Lsrm\Connect\OLD';
  RegConnect    = 'SoftWare\LPT\Lsrm\Connect';


implementation

uses
  ProcReg, FIBConsts, fib, IB_ErrorCodes, Procs, ShellList, ShlObj;

{$R *.dfm}



procedure TfrToBase.A_ClearAllExecute(Sender: TObject);
var
N: Integer;
begin
  for N := 0 to SmartDlg.RowsList.Count - 1 do begin
    With SmartDlg.RowsList.Items[ N ] do begin
      if ( Style = psReadOnlyText ) then
        Continue;
      if ShowAsReadOnly then
        Continue;
      RowValue := '';
      RowValueID := -1;
      CheckListID := '';
    end;
  end;

  SmartDlg.RefreshEditText;
  SmartDlg.Refresh;
end;

procedure TfrToBase.A_ClearCurrListExecute(Sender: TObject);
var
Prop: TPropertyItem;
S: TSqlParams;
begin
  Prop := SmartDlg.SelectedInfo;
  if not Assigned( Prop ) then
    Exit;

  if Prop.Index = ServInd then
    RegDeleteValues( HKEY_CURRENT_USER, RegConnect + '\Serv' )
  else
  if Prop.Index = ServInd then
    RegDeleteValues( HKEY_CURRENT_USER, RegConnect + '\Path' )
  else
  if Prop.Index = ServInd then
    RegDeleteValues( HKEY_CURRENT_USER, RegConnect + '\User' )
  else
    Exit;

  S := Prop.SQL;
  S.SqlText := '';
  Prop.SQL := S;
end;

procedure TfrToBase.A_ClearExecute(Sender: TObject);
var
Prop: TPropertyItem;
begin
  Prop := SmartDlg.SelectedInfo;
  if ( Prop.Style = psReadOnlyText ) then
    Exit;
  if Prop.ShowAsReadOnly then
    Exit;

  Prop.RowValue := '';
  Prop.RowValueID := -1;
  Prop.CheckListID := '';

  SmartDlg.RefreshEditText;
  SmartDlg.Refresh;
end;

procedure TfrToBase.A_SaveExecute(Sender: TObject);
begin
	try
    ToolBarDisable( False );
    SB.Visible := False;
		PB.Visible := True;
		ServParamExecute( Self );
	finally
		ToolBarDisable( True );
		SB.Visible := True;
		PB.Visible := False;
	end;
end;

procedure TfrToBase.A_ServParamExecute(Sender: TObject);
begin
  if ( ServInd = -1 ) or ( PathInd = -1 ) then
    Exit;

  try
    SmartDlg.RowsList.Items[ ServInd ].Visible := A_ServParam.Checked;
    SmartDlg.RowsList.Items[ PathInd ].Visible := A_ServParam.Checked;
  finally
    SmartDlg.FillVisibleRows;
    SmartDlg.Refresh;
  end;
end;

procedure TfrToBase.FormCreate(Sender: TObject);
begin
  Application.OnException := ExceptionShow;
  ChDir( ExtractFileDir( ParamStr( 0 )));
//  SetLanguage( LANG_ENGLISH );
end;

function TfrToBase.ReadDefaultParams( var ServName, PathName: String ): Boolean;
var
FileName: String;
begin
  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ))) + 'DefParam.ini';
  try
		ServName := IniGetStringDef( FileName, 'DEFAULT', 'SERV', '' );
    PathName := IniGetStringDef( FileName, 'DEFAULT', 'PATH', '' );
  finally
    Result := PathName <> '';
  end;
end;

procedure TfrToBase.CMDialogKey(var AMessage: TCMDialogKey);
begin
  if AMessage.CharCode <> VK_TAB then
    inherited;
end;

procedure TfrToBase.CreateIcon;
//var
//  ExeFile: string;
//  Dir: string;
//  IconTitle: string;
begin
//  try
//    ExeFile := ExpandUNCFileName(ParamStr(0));
//    Dir := IncludeTrailingPathDelimiter(ExtractFileDir(ExeFile));
//    IconTitle := Query.FieldByName('DESCRIB').AsString;
//    CrShCutIcon(CSIDL_DESKTOP, { CSIDL_COMMON_DESKTOPDIRECTORY} '', ExeFile, IconTitle, Dir, ExeFile, 0);
//  except
//    raise ;
//  end;
end;

procedure TfrToBase.FormShow(Sender: TObject);
begin
  GetServParam;
  A_ServParamExecute( nil );
  Self.Width := Screen.Width div 2;
end;

procedure TfrToBase.GetServParam;
var
Pass, RegServ, RegPath: String;
StrList: TStringList;
S: TSqlParams;
begin
	StrList := TStringList.Create;
  SmartDlg.RowsList.Clear;

  if not ReadDefaultParams( RegServ, RegPath ) then begin
    RegServ := RegGetStringDef( HKEY_CURRENT_USER, RegConnectOld, 'Serv', '' );
    RegPath := RegGetStringDef( HKEY_CURRENT_USER, RegConnectOld, 'Path', '' );
  end;

	If (( RegServ = '' ) and ( RegPath = '' )) then begin
		 RegDeleteValues( HKEY_CURRENT_USER, RegConnect + '\Serv' );

		 If not (( RegServ = '' ) and ( RegPath = '' )) then begin
			 RegSetString( HKEY_CURRENT_USER, RegConnectOld, 'Serv', RegServ, True );
			 RegSetString( HKEY_CURRENT_USER, RegConnectOld, 'Path', RegPath, True );
     end;
  end;

  try
    ServInd := -1;
    PathInd := -1;

    ReadRegList( RegConnect, 'Serv', StrList );
    With SmartDlg.RowsList.Add do begin
      Title := 'Имя или IP-адрес сервера';
      RowValue := RegServ;
      RowValueID := -1;
      Style := psComboBoxInput;
      S.SqlText := StrList.Text;
      SQL := S;
      MaxWidth := MAX_PATH;
      SetLang := 1;
      ServInd := Index;
    end;

    ReadRegList( RegConnect, 'Path', StrList );
    With SmartDlg.RowsList.Add do begin
      Title := 'Путь к базе данных';
      RowValue := RegPath;
      RowValueID := -1;
      Style := psComboBoxInput;
      S.SqlText := StrList.Text;
      SQL := S;
      MaxWidth := MAX_PATH;
      SetLang := 1;
      PathInd := Index;
    end;

    ReadRegList( RegConnect, 'User', StrList );
    SysLogin := RegGetString(HKEY_CURRENT_USER, RegConnectOld,'User');
    With SmartDlg.RowsList.Add do begin
      Title := 'Имя пользователя';
      RowValue := SysLogin;
      RowValueID := -1;
      Style := psComboBoxInput;
      S.SqlText := StrList.Text;
      SQL := S;
      MaxWidth := 30;
      SetLang := 2;
      UserInd := Index;
    end;

    If AnsiSameText( SysLogin, 'sysdba' ) then
      Pass := RegGetString(HKEY_CURRENT_USER, RegConnectOld,'Pass')
    else
      Pass := '';

    With SmartDlg.RowsList.Add do begin
      Title := 'Пароль доступа';
      RowValue := Pass;
      RowValueID := -1;
      Style := psPassword;
      S.SqlText := StrList.Text;
      SQL := S;
      MaxWidth := 30;
      SetLang := 1;
      PassInd := Index;
    end;
  finally
    StrList.Free;
    SmartDlg.FillVisibleRows;
  end;
end;

function TfrToBase.ReadRegList(Key, Param: String; var RegItems: TStringList ): Boolean;
var
N: Integer;
Str: String;
begin
  Result := False;
  If not Assigned( RegItems ) then
                                Exit;
  RegItems.Clear;
  try
    For N := 0 to 25 do begin
      Str := RegGetString(HKEY_CURRENT_USER, Key + '\' + Param, IntToStr( N ));
      If Str > '' then
                    RegItems.Append( Str );
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TfrToBase.SaveRegList(Key, Param, Value: String): Boolean;
var
N, L: Integer;
RegItems: TStringList;
begin
  Result := False;
  RegItems := TStringList.Create;
  try
    ReadRegList( Key, Param, RegItems );
    If not Assigned( RegItems ) then
                                  Exit;
    Value := Trim( Value );
    N :=  RegItems.IndexOf( Value );
    If ( N <> -1 ) then
                     RegItems.Delete( N );
    RegItems.Insert( 0, Value );
    N := 0;
    L := RegItems.Count;

    try
      While  ( N < 25 ) and ( N < L ) do begin
         RegSetString( HKEY_CURRENT_USER, Key + '\' + Param,
                                 IntToStr( N ), RegItems.Strings[ N ], True );
         N := N + 1;
      end;
      Result := True;
    except
      Result := False;
    end;
  finally
    RegItems.Free;
  end;
end;

procedure TfrToBase.ExceptionShow(Sender: TObject; E: Exception);
begin
  try
    Case EFIBError( E ).IBErrorCode of
       isc_network_error: raise exception.Create( 'Ошибка в имени сервера или сервер не найден.' );
       isc_io_error:      raise exception.Create( 'Не найден путь к базе данных.' );
       isc_lock_conflict,
       isc_login:         raise exception.Create( 'Ошибка соединения с сервером. Неправильное имя пользователя или пароль.' );
       isc_shutdown:      raise exception.Create( 'Доступ закрыт администратором.' );
       else
         raise exception.Create( E.Message );
    end;
  except
    on NewE: Exception do ShowMessage( NewE.Message );
  end;
end;

procedure TfrToBase.ToolBarDisable( IsEnable: Boolean );
var
N: Integer;
begin
  For N := 0 to ToolB.ButtonCount - 1 do
    ToolB.Buttons[ N ].Enabled := IsEnable;
end;

procedure TfrToBase.ServParamExecute(Sender: TObject);
var
MessStr: String;
Pass, ServName, BasePath: String;
begin
	SmartDlg.UpdateEditText;
  Pass := SmartDlg.RowsList.Items[ PassInd ].RowValue;

  If Pass = '' then begin
     ShowMessage( 'Не указан пароль доступа!' );
     Exit;
  end;

  ServName := SmartDlg.RowsList.Items[ ServInd ].RowValue;
  BasePath := SmartDlg.RowsList.Items[ PathInd ].RowValue;
  SysLogin := SmartDlg.RowsList.Items[ UserInd ].RowValue;

	RegSetString( HKEY_CURRENT_USER, RegConnectOld, 'Serv', ServName, True );
  RegSetString( HKEY_CURRENT_USER, RegConnectOld, 'Path', BasePath, True );
	SaveRegList( RegConnect, 'SERV', ServName );
	SaveRegList( RegConnect, 'PATH', BasePath );

  RegSetString( HKEY_CURRENT_USER, RegConnectOld, 'User', SysLogin, True );
	SaveRegList( RegConnect, 'User', SysLogin );

	Application.ProcessMessages;

	SetIBDBParams( Pass, ServName, BasePath );
	try
		IBDB.Open;
	except
		raise;
	end;
	If IBDB.Connected then
		try
		 Screen.Cursor := crSQLWait;
		 If not GetExportParams( MessStr ) then begin
			 ShowMessage( MessStr );
			 Self.Close;
			 Exit;
		 end;
		 ProgListExecute;
		finally
			Screen.Cursor := crDefault;
		end;
end;

procedure TfrToBase.SetIBDBParams( Pass, ServName, BasePath: String );
begin
	IBDB.Close;
	IBDB.LibraryName :=
		IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ))) + 'fbclient.dll';
	With IBDB do begin
    If ServName = '' then
      DBName := BasePath
    else
			IBDB.DBName := ServName + ':' + BasePath;

    If IBDB.DBName = '' then
      raise exception.Create( 'Не указаны параметры подключения' );

    ConnectParams.UserName := CyrToLatTranslit( SysLogin );

    ConnectParams.Password := Pass;
    ConnectParams.RoleName := 'RIGHT_TO_ACCESS';
    ConnectParams.CharSet := 'WIN1251';
    SQLDialect := 3;
  end;
end;

procedure TfrToBase.SmartDlgChangeRow(Sender: TObject; NewRow: Integer);
var
Prop: TPropertyItem;
begin
  Prop := SmartDlg.SelectedInfo;
  if not Assigned( Prop ) then
    Exit;

  A_ClearCurrList.Enabled := Prop.Style = psComboBoxInput;
  case A_ClearCurrList.Enabled of
    True: begin
      A_ClearCurrList.Caption :=
        A_ClearCurrList.Hint + ' (' + Prop.Title + ')';
      A_ClearCurrList.Tag := NewRow;
    end;
    else begin
      A_ClearCurrList.Caption := A_ClearCurrList.Hint;
      A_ClearCurrList.Tag := -1;
    end;
  end;
end;

procedure TfrToBase.SmartDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift <> [] then
    Exit;

  case Key of
    VK_RETURN:
      A_SaveExecute( A_Save );
    VK_ESCAPE:
      Self.Close;
  end;
end;

function TfrToBase.GetExportParams( var MessStr: String ): Boolean;
var
IB_Query: TpFIBQuery;
begin
  Result := False;
  IB_Query := TpFIBQuery.Create( Self );
  try
    IB_Query.Database := IBDB;
    IB_Query.Options := [];
    IB_Query.Transaction := IBTr_R;
    If not IBTr_R.InTransaction then
      IBTr_R.StartTransaction;


		IB_Query.SQL.Text :=
      'select EXE_FILES_LIST_ID, IS_JOB from EXE_FILES_LIST_S';

    try
			IB_Query.ExecQuery;
		except
      Raise;
    end;
    If IB_Query.FieldByName( 'IS_JOB' ).AsInteger = 1 then begin
      Result := False;
      WorkDir := '';
      MessStr := 'Сервер отключен для профилактических работ';
    end
    else begin
      Result := not IB_Query.FieldByName( 'EXE_FILES_LIST_ID' ).IsNull;
      If not Result then
         MessStr := 'У Вас отсутствуют права доступа!'
    end;
  finally
    IB_Query.Close;
    IB_Query.Free;
    If IBTr_R.InTransaction then
      IBTr_R.Commit;
  end;
end;

procedure TfrToBase.ProgListExecute;
begin
  If not IBDB.Connected then
    Exit;

	try
    If not IBTr_R.InTransaction then
      IBTr_R.StartTransaction;
    try
			Query.ExecQuery;
      If not IB_Q.Prepared then
        IB_Q.Prepare;
    except
      raise;
		end;
		while not Query.Eof do begin
			GetNewFile( Query.FieldByName( 'ON_EXECUTE' ).AsInteger,
									Query.FieldByName( 'EXE_FILES_LIST_ID' ).AsInteger  );
			PB.StepBy( 15 );

      Application.ProcessMessages;
      Sleep( 100 );
      Query.Next;
    end;
    Query.Close;
  finally
    If IBTr_R.InTransaction then
      IBTr_R.Commit;
    IBDB.Close;
    Self.Close;
	end;
end;

procedure TfrToBase.GetNewFile( IsExecute, ID: Integer );
var
F_Name: string;
IsOK: Boolean;
F_Date, U_Date: Integer;
F: Integer;
begin
  Screen.Cursor := crSQLwait;
  try
    IsOK := True;
		WorkDir := IncludeTrailingPathDelimiter( GetFolderPath( CSIDL_APPDATA ));

    // создается каталог по умолчанию "C:\Documents and Settings\"USER"\Application Data\"
    If not DirectoryExists( WorkDir ) then
      try
        IsOK := ForceDirectories( WorkDir );
      except
        raise Exception.Create( 'Не может быть создан каталог "' + WorkDir + '"' );
      end;

    WorkDir := IncludeTrailingPathDelimiter( WorkDir + 'LPT\Lsrm\' );
    If IsOK and ( not DirectoryExists( WorkDir )) then
      try
       ForceDirectories( WorkDir );
      except
        raise Exception.Create( 'Не может быть создан каталог "' + WorkDir + '"' );
      end;

    F_Name  := Query.FieldByName( 'FILE_NAME' ).AsString;
    F       := FileOpen( WorkDir + F_Name, fmOpenReadWrite );
    try
      F_Date := FileGetDate( F );
    finally
      FileClose( F );
    end;
    U_Date := DateTimeToFileDate( Query.FieldByName( 'DATE_UPDATE' ).AsDateTime );

    If (( F_Date = -1 ) or ( F_Date <> U_Date )) then begin
       If not IsRunExe( WorkDir + F_Name ) then begin
         try
           If ( F_Date <> -1 ) Then begin
              SetFileAttributes( PChar( WorkDir + F_Name ), FILE_ATTRIBUTE_NORMAL );
              System.SysUtils.DeleteFile( WorkDir + F_Name );
           end;
           If not FileExists( WorkDir + F_Name ) then begin
             try
               try
                 IB_Q.Close;
                 IB_Q.ParamByName( 'EXE_FILES_LIST_ID' ).AsInteger := ID;
                 IB_Q.ExecQuery;
               except
                 raise;
               end;
               WriteToFile( WorkDir + F_Name, U_Date, IB_Q );
             finally
               IB_Q.Close;
             end;
           end;
         except
           on E: Exception do
              raise Exception.Create( 'Ошибка обновления версии программы' + #13 + E.Message  );
         end;
       end
       else
         MessageBox( Self.Handle,
           'Программа уже запущена!', 'Запуск приложения', MB_OK or MB_DEFBUTTON1 or  MB_ICONSTOP);

    end;

    try
      If FileExists( WorkDir + F_Name ) then
        case IsExecute of
        1: begin
          CreateIcon;

          ExecuteFile( WorkDir + F_Name,
             '"' + IBDB.DBName + '" "' + IBDB.ConnectParams.UserName + '" "' + IBDB.ConnectParams.Password + '"',
             WorkDir, SW_MAXIMIZE );
        end;
        2: ExecuteFile( 'RegSvr32.exe', '/S /I "' + WorkDir + F_Name + '"', WorkDir, SW_HIDE );
      end;
      ChDir( ExtractFileDir( ParamStr( 0 ) ));
    except
      raise;
    end;

  finally
    Screen.Cursor := crDefault;
  end;
end;

function TfrToBase.IsRunExe( Path: String ): Boolean;
var
Mutex : THandle;
MutexName : array[0..255] of Char;
N: Integer;
begin
  For N := 0 to Length( Path ) do
    if Path[ N ] = '\' then
                         Path[ N ] := '/';
  StrPCopy( MutexName, Path );
  Mutex := OpenMutex( MUTEX_ALL_ACCESS, True, MutexName );
  try
    Result := ( Mutex <> 0 );   // Если мьютекс существует

  finally
    if Mutex <> 0 then
      CloseHandle( Mutex );
  end;
end;

procedure TfrToBase.WriteToFile( FIleName: String; UpdateDate: Integer; Query: TpFIBQuery );
var
F: TFileStream;
File_New: Integer;
begin
  try
    F := TFileStream.Create( FileName, fmCreate );
  except
    raise;
  end;
  try
    F.Position := 0;
    try
      Query.FieldByName( 'EXE' ).SaveToStream( F );
    except
      raise;
    end;
  finally
    F.Free;
  end;
  SetFileAttributes( PChar( FileName ), FILE_ATTRIBUTE_NORMAL );
  File_New := FileOpen( FileName, fmOpenReadWrite );
{$WARN SYMBOL_PLATFORM OFF}
  try
    try
      FileSetDate( File_New, UpdateDate );
    except
      Raise;
    end;
{$WARN SYMBOL_PLATFORM ON}
  finally
    FileClose( File_New );
  end;
end;


end.
