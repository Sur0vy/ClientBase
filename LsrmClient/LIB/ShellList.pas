{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ShellList;

interface

Uses
  Windows, SysUtils, Classes, Forms, ComObj, ShlObj, Activex, ShellAPI; // SHFolder;

type
  TYSHChangeEvent = function( Path:STRING; var Text:STRING; Data:LONGINT ):BOOLEAN of object;

  PYBFCallbackRec = ^TYBFCallbackRec;
  TYBFCallbackRec = record
      Path     : STRING;
      OnChange : TYSHChangeEvent;
      Data     : LONGINT;
  end;{ TYBFCallbackRec }


  //Создать ярлык в заданной директории
  procedure CrShCutIcon(SysDirC: Integer; const Pap, ProgPath, Describe, Work, IconPath: String; IconIndex: Integer );

  function GetPathFromIDList( pidl:PItemIDList; var Path:STRING ):BOOLEAN;

  function GetFolderPath( Folder:LONGINT ):STRING;
  function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;

  function BrowseForFolder( var Path:STRING; Title:STRING; OnChange:TYSHChangeEvent; Data:LONGINT ):BOOLEAN;

const
  IID_IPersistFile: TGUID =
      (D1:$0000010B;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));

implementation


procedure CrShCutIcon(SysDirC: Integer; const Pap, ProgPath, Describe, Work, IconPath: String; IconIndex: Integer );
{ SysDir - Системная директория расположения ярлыка
  Pap - подкаталог системной диретории
  ProgPath - путь к программному файлу
  Describe - Надпись под ярлыком

	Work - рабочий каталог
	IconPath - Где взять иконку
  IconIndex - Индекс иконки в файле

}
var
NewLink: IShellLink;
Ws, CurrWork: String;
hRes: THandle;
pf: IPersistFile;
ResPIDL: PItemIDList;
hwndOwner: HWND;
Path: Array [ 0 .. max_path-1 ] of WideChar;
begin
   If Work = '' then
     CurrWork := ExtractFilePath( String( ProgPath ))
   else
     CurrWork := Work;

//   Case SysDir of
//     1: SysDirC:= CSIDL_DESKTOPDIRECTORY;        //рабочий стол
//     2: SysDirC:= CSIDL_STARTMENU;               //старт меню
//     3: SysDirC:= CSIDL_PROGRAMS;                //Программы
//     4: SysDirC:= CSIDL_STARTUP;                 // Автозапуск
//     5: SysDirC:= CSIDL_TEMPLATES;               // Мои документы
//     6: SysDirC:= CSIDL_COMMON_DESKTOPDIRECTORY  // Общий рабочий стол
//   else SysDirC:= SysDir
//	 end;

   hwndOwner:= Application.Handle;
	 NewLink:= CreateComObject(CLSID_SHellLink) as ISHellLink;

      NewLink.SetPath( PWideChar( String( ProgPath )));
      NewLink.SetWorkingDirectory(PChar(Work));

   SHGetSpecialFolderLocation( hwndOwner, SysDirC, ResPIDL);
   If SHGETPathFromIDList( ResPiDL, Path ) then begin
     Ws := StrPas( Path );
     If Pap <> '' then begin
       Ws := IncludeTrailingPathDelimiter( Ws ) + Pap;
       MkDir( Ws );
     end;
     Ws := IncludeTrailingPathDelimiter( Ws );
     Ws := Ws + Describe + '.lnk';
   end;

	 NewLink.SetIconLocation( PChar( IconPath ), IconIndex );

	 hRes:= NewLink.QueryInterface( IID_IPersistFile, pf );
	 if Succeeded(hRes) then
     pf.Save( PWideChar( Ws ), False );
end;

function GetPathFromIDList( pidl: PItemIDList; var Path: STRING ): BOOLEAN;
begin
  Result := FALSE;
  SetLength( Path, MAX_PATH + 1 );
  if( SHGetPathFromIDList( pidl, PCHAR( Path ) ) ) then begin
//  if( SHGetKnownFolderPath( pidl, PCHAR( Path ) ) ) then begin
      SetLength( Path, StrLen( PCHAR( Path ) ) );
      Result := TRUE;
  end
  else
    Path := '';
end;

function GetFolderPath( Folder:LONGINT ):STRING;
var
 PIDL: PItemIDList;
begin
    Result := '';
    try
     PIDL := nil;
     if( SUCCEEDED( SHGetSpecialFolderLocation( 0, Folder, PIDL ) ) and
       ( PIDL <> nil ) ) then
                           GetPathFromIDList( PIDL, Result );
    finally
        CoTaskMemFree( PIDL );
        PIDL := nil;
    end;
end;

function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
var
zFileName, zParams, zDir: array[0..MAX_PATH + 1] of Char;
begin
	Result := ShellExecute(Application.Handle, nil, StrPCopy(zFileName, FileName),
												 StrPCopy(zParams, Params), StrPCopy(zDir, DefaultDir), ShowCmd);
end;

function BrowseFolderCallback( Wnd:HWND; uMsg:UINT; lParam, lpData : LPARAM ):LONGINT stdcall;
var
    Folder, Text : STRING;
    pFolder : PItemIDList;
    pBFCRec : PYBFCallbackRec;
    Enable  : BOOLEAN;
begin
    Result  := 0;
    pBFCRec := PYBFCallbackRec( lpData );
    case uMsg of
        BFFM_INITIALIZED : begin
            // WParam is TRUE since you are passing a path.
            // It would be FALSE if you were passing a pidl.
            SendMessage( Wnd, BFFM_SETSELECTION, 1, LONGINT( POINTER( pBFCRec.Path ) ) );
        end;
        BFFM_SELCHANGED : begin
            Enable  := FALSE;
            pFolder := PItemIDList( lParam );
            if( not GetPathFromIDList( pFolder, Folder ) )then begin
                Text   := 'Этот объект не может быть выбран';
            end else if( Assigned( pBFCRec.OnChange ) )then begin
                Text   := Folder;
                Enable := pBFCRec.OnChange( Folder, Text, pBFCRec.Data );
            end else begin
                Text   := Folder;
                Enable := TRUE;
            end;
            SendMessage( Wnd, BFFM_ENABLEOK, Ord( Enable ), Ord( Enable ) );
            SendMessage( Wnd, BFFM_SETSTATUSTEXT, 0, LONGINT( PCHAR( Text ) ) );
        end;
    end;
end;{ BrowseFolderCallback }

function BrowseForFolder( var Path:STRING; Title:STRING; OnChange:TYSHChangeEvent; Data:LONGINT ):BOOLEAN;
var
Info       : BROWSEINFO;
pFolder    : PItemIDList;
BFCRec     : TYBFCallbackRec;
WindowList : POINTER;
begin
    Result  := FALSE;
//    pFolder := nil;
    Path    := ExcludeTrailingPathDelimiter( Path );
    BFCRec.Path  := Path;
    if( POINTER( BFCRec.Path ) = nil )then begin //must not be nil for callback!
        BFCRec.Path := #0;
    end;
    BFCRec.OnChange := OnChange;
    if( Title = '' )then begin
        Title := 'Выберите папку:';
    end;
    BFCRec.Data := Data;

    Info.hwndOwner      := Application.Handle;
    Info.pidlRoot       := nil;
    Info.pszDisplayName := nil;
    Info.lpszTitle      := PCHAR( Title );
    Info.ulFlags        := BIF_RETURNONLYFSDIRS or BIF_STATUSTEXT;
    Info.lpfn           := @BrowseFolderCallback;
    Info.lParam         := LONGINT( @BFCRec );
    Info.iImage         := 0;

    WindowList := DisableTaskWindows( 0 );
    try
      pFolder := SHBrowseForFolder( Info );
    finally
      EnableTaskWindows( WindowList );
    end;
    if( pFolder <> nil )then begin
        Result := GetPathFromIDList( pFolder, Path );
        CoTaskMemFree( pFolder );
//        pFolder := nil;
    end;
end;{ BrowseForFolder }




end.
