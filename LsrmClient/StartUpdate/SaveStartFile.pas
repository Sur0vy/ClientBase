unit SaveStartFile;

interface

uses
  Winapi.Windows, vcl.Forms, system.SysUtils, system.Classes,
  FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, vcl.ExtCtrls;

type
	TMutexObj = class( TObject )
	protected
		FHandle: THandle;
	private
		//
	public
		constructor Create(const Name: string);
		destructor Destroy; override;
		function GetSignal: Boolean;
		function Release: Boolean;

		property Handle: THandle read FHandle;
	end;

  TSaveStart = class
  private
    Query: TFIBQuery;
    IBDB: TpFIBDatabase;
    IBTr: TpFIBTransaction;
    Mutex: TMutexObj;
    procedure WriteToFile(FIleName: String);
    function GetMutexName: String;
  public
    constructor Create;
    destructor Destroy; override;
    class procedure SaveExecute;
  end;

{$WARN SYMBOL_PLATFORM OFF}

implementation

{ TMutex }

constructor TMutexObj.Create(const Name: string);
var
MutexName : array[ 0..MAX_PATH ] of Char;
L, N: Integer;
begin
	try
		L := GetModuleFileName( MainInstance, MutexName, SizeOf( MutexName ));
	except
		Raise;
	end;

	For N := 0 to L - 1 do
		if MutexName[ N ] = '\' then
															MutexName[ N ] := '_';

	StrCat( MutexName, PChar( '_' + Name ));
	FHandle := CreateMutex( nil, False, MutexName );

	if FHandle = 0 then
									 Abort;
end;

destructor TMutexObj.Destroy;
begin
	if FHandle <> 0 then
										CloseHandle(FHandle);
	inherited;
end;

function TMutexObj.GetSignal: Boolean;
const
TimeOut = 600000;  // ∆дем 10 минут 60 * 10 * 1000
begin
	Result := WaitForSingleObject(FHandle, LongWord( TimeOut )) = WAIT_OBJECT_0;
end;

function TMutexObj.Release: Boolean;
begin
	Result := ReleaseMutex( FHandle );
end;

{ TSaveStart }

procedure TSaveStart.WriteToFile( FIleName: String );
var
F: TFileStream;
File_New: Integer;
UpdateDate: Integer;
begin
  UpdateDate := -1;
  try
    F := TFileStream.Create( FileName, fmCreate );
  except
    Exit;
  end;
  try
    F.Position := 0;
    try
      Query.FieldByName( 'EXE' ).SaveToStream( F );
      UpdateDate := DateTimeToFileDate( Query.FieldByName( 'DATE_UPDATE' ).AsDateTime );
    except
      raise;
    end;
  finally
    F.Free;
  end;
  If UpdateDate = -1 then
    Exit;
  SetFileAttributes( PChar( FileName ), FILE_ATTRIBUTE_NORMAL );
  File_New := FileOpen( FileName, fmOpenReadWrite );
  try
    try
      FileSetDate( File_New, UpdateDate );
    except
      Raise;
    end;
  finally
    FileClose( File_New );
  end;
end;

{ TSaveStart }

constructor TSaveStart.Create;
const
sqlValue =
'SELECT EXE, DATE_UPDATE FROM EXE_FILES_LIST ' +
' WHERE EXE_FILES_LIST_ID = :EXE_FILES_LIST_ID';
begin
  inherited;
	Mutex := TMutexObj.Create( GetMutexName );  
  IBDB := TpFIBDatabase.Create( nil );
  IBDB.DBName := ParamStr( 3 );
  IBDB.ConnectParams.UserName := ParamStr( 4 );
  IBDB.ConnectParams.Password := ParamStr( 5 );
  IBDB.ConnectParams.RoleName := ParamStr( 6 );
  IBDB.ConnectParams.CharSet := 'WIN1251';
  IBDB.LibraryName := 'fbclient.dll';

  IBTr := TpFIBTransaction.Create( IBDB );
  IBTr.DefaultDatabase := IBDB;

  Query := TpFIBQuery.Create( IBDB );
  Query.Database := IBDB;
  Query.Transaction := IBTr;
  Query.SQL.Text := sqlValue;
end;

destructor TSaveStart.Destroy;
begin
  If Assigned( Query ) then begin
    Query.Close;
    Query.Free;
  end;
  If Assigned( IBTr ) then
    IBTr.Free;
  If Assigned( IBDB ) then
    IBDB.Free; 
	If Assigned( Mutex ) then
	  Mutex.Free;

  inherited;
end;

function TSaveStart.GetMutexName: String;
begin
  Result := ParamStr( 0 );
  Result := StringReplace( Result, '\', '/', [ rfReplaceAll ]);
end;

class procedure TSaveStart.SaveExecute;
var
SS: TSaveStart;
ExeID: Integer;
FileName: String;
begin
  SS := TSaveStart.Create;
  with SS do
    If Mutex.GetSignal then
      try
    try
      ExeID := StrToIntDef( ParamStr( 1 ), -1 );
      FileName := ParamStr( 2 );
      SetFileAttributes( PChar( FileName ), FILE_ATTRIBUTE_NORMAL );
      try
        IBDB.Open;
        IBTr.StartTransaction;
        Query.Close;
        Query.ParamByName( 'EXE_FILES_LIST_ID' ).AsInteger := ExeID;
        Query.ExecQuery;
        WriteToFile( FileName );
      except
        raise;
      end;
      Query.Close;
    finally
      Mutex.Release;
    end;
  finally
    SS.Free;
  end;
end;


end.
