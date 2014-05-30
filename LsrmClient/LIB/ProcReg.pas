{***************************************************************}
{  Работа с реестром Windows через функции API                  }
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ProcReg;

interface

uses Windows, SysUtils, Procs;

type
	STRINGS = array of STRING;


{ Удаляет значение ключа регистра }
function RegDeleteValue( Root:HKEY; Key, Param : STRING ):BOOLEAN;
{ копирует значение ключа в другой ключ }
function RegCopyValue( SrcRoot:HKEY; SrcKey, SrcParam : STRING; DstRoot:HKEY; DstKey, DstParam : STRING ):BOOLEAN;
{ Перемещает значение ключа в другой ключ }
function RegMoveValue( SrcRoot:HKEY; SrcKey, SrcParam : STRING; DstRoot:HKEY; DstKey, DstParam : STRING ):BOOLEAN;
{ Удаляет ключ регистра. Works properly in Win95/Win98/WinNT }
function RegDeleteKey( Root:HKEY; Key:STRING ):BOOLEAN;
{ Удалить ключ только если он пустой }
function RegDeleteEmptyKey( Root:HKEY; Key:STRING ):BOOLEAN;
{ Копирует ключ вместе с субключами и значениями }
function RegCopyKey( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
{ Переносит ключ вместе с субключами и значениями }
function RegMoveKey( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
{ Переименовать ключ }
function RegRenameKey( Root:HKEY; Path, OldKey, NewKey : STRING ):BOOLEAN;
{ Извлекает любые данные формата }
function RegGetData( Root:HKEY; Key, Param : STRING ):STRING;
{ Записывает двоичные данные }
function RegSetData( Root:HKEY; Key, Param : STRING; var Data; Count:LONGINT; AllowCreateKey:BOOLEAN ):BOOLEAN;
{ Записвает бинарные данные в строку }
function RegSetDataString( Root:HKEY; Key, Param : STRING; Value:STRING; AllowCreateKey:BOOLEAN ):BOOLEAN;
{ Читает значение ключа }
function RegGetString( Root:HKEY; Key, Param : STRING ):STRING;
{ Читает строковое значение ключа с Default}
function RegGetStringDef( Root:HKEY; Key, Param, Default : STRING ):STRING;
{ Записывает значение строки в ключ }
function RegSetString( Root:HKEY; Key, Param, Value : String; AllowCreateKey:BOOLEAN ):BOOLEAN;
{ Writes a boolean Value of Key Param. }
function RegSetBoolean( Root:HKEY; Key, Param : STRING; Value:BOOLEAN; AllowCreateKey:BOOLEAN ):BOOLEAN;
{ Read a boolean Value of Key Param. }
function RegGetBoolean( Root:HKEY; Key, Param : STRING ):BOOLEAN;
{ Read a boolean Value of Key Param. }
function RegGetBooleanDef( Root:HKEY; Key, Param : STRING; DefValue:BOOLEAN ):BOOLEAN;
{ Writes an integer Value of Key Param. }
function RegSetInteger( Root:HKEY; Key, Param : STRING; Value:LONGINT; AllowCreateKey:BOOLEAN ):BOOLEAN;
{ Reads an integer Value of Key Param. }
function RegGetInteger( Root:HKEY; Key, Param : STRING; DefValue:LONGINT ):LONGINT;
{ Writes an integer Value of Key Param. }
function RegSetDWord( Root:HKEY; Key, Param : STRING; Value:DWORD; AllowCreateKey:BOOLEAN; AsString:BOOLEAN = TRUE ):BOOLEAN;
{ Reads an integer Value of Key Param. }
function RegGetDWord( Root:HKEY; Key, Param : STRING; DefValue:DWORD ):LONGINT;
{ Writes a double float Value of Key Param. }
function RegSetFloat( Root:HKEY; Key, Param : STRING; Value:DOUBLE; AllowCreateKey:BOOLEAN ):BOOLEAN;
{ Reads a double float Value of Key Param. }
function RegGetFloat( Root:HKEY; Key, Param : STRING; DefValue:DOUBLE ):DOUBLE;
{ Checks the Key }
function RegKeyExists( Root:HKEY; Key:STRING ):BOOLEAN;
{ Checks the Param }
function RegParamExists( Root:HKEY; Key, Param:STRING ):BOOLEAN;

{ Returns all the values names }
function RegEnumValues( Root:HKEY; Key:STRING ):STRINGS;
{ Deletes all the key values }
function RegDeleteValues( Root:HKEY; Key:STRING ):BOOLEAN;
{ Copies all the key values }
function RegCopyValues( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
{ Moves all the key values }
function RegMoveValues( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
{ Returns all the subkeys names }
function RegEnumSubkeys( Root:HKEY; Key:STRING ):STRINGS;

{Ini-file functions}

{ Запись строки в INI - файл }
function IniSetString( FileName, Section, Key, Value : STRING ):BOOLEAN;
{ Чтение строки из ini - файла с подстановкой значения по умолчанию }
function IniGetStringDef( FileName, Section, Key, Default : STRING ):STRING;
{ Reads integer value from Ini file. If Key does not exist returns Default value }
function IniGetIntegerDef( FileName, Section, Key : STRING; DefValue:LONGINT ):LONGINT;
{ Writes Integer value into Ini file }
function IniSetInteger( FileName, Section, Key : STRING; Value:LONGINT ):BOOLEAN;
{ Reads boolean value from Ini file. If Key does not exist returns Default value }
function IniGetBooleanDef( FileName, Section, Key : STRING; DefValue:BOOLEAN ):BOOLEAN;
{ Reads boolean value from Ini file. If Key does not exist returns FALSE }
function IniGetBoolean( FileName, Section, Key : STRING ):BOOLEAN;
{ Writes boolean (as integer) value into Ini file }
function IniSetBoolean( FileName, Section, Key : STRING; Value:LONGINT ):BOOLEAN;



{ Возвращает WindowsDirectory. }
function GetWinDir:STRING;
{ Returns SystemDirectory. }
function GetSysDir:STRING;
{ Возвращает TemporaryDirectory. }
function GetTempDir:STRING;


implementation

function _RegEnumSubkeys( H:HKEY ):STRINGS;
var
    Sub : STRING;
    I, Res : LONGINT;
		SubLen, SubCnt, MaxSubLen : DWORD;
    FileTime : TFileTime;

    function GetSubkey( Index:LONGINT ):LONGINT;
		begin
				SubLen := MaxSubLen + 1;
        SetLength( Sub, SubLen );
				Result := RegEnumKeyEx( H, Index, PCHAR( Sub ), SubLen, nil, nil, nil, @FileTime );
				case Result of
            ERROR_SUCCESS : SetLength( Sub, SubLen );
            else            Sub := '';
        end;
    end;{ GetSubkey }
begin
    SetLength( Result, 0 );
    if( H = 0 )then begin
        Exit;
    end;
		Res := RegQueryInfoKey( H, nil, nil, nil, @SubCnt, @MaxSubLen, nil, nil, nil, nil, nil, nil );
		if ( Res = ERROR_SUCCESS ) and ( SubCnt > 0 ) then begin
        for I := 0 to  SubCnt - 1 do begin
						Res := GetSubkey( I );
            case Res of
                ERROR_SUCCESS : begin
                    SetLength( Result, Succ( Length( Result ) ) );
                    Result[ Pred( Length( Result ) ) ] := Sub;
                end;
                ERROR_NO_MORE_ITEMS : break;
            end;
        end;
    end;
end;{ _RegEnumSubkeys }

function _RegDeleteSubkeys( H:HKEY ):BOOLEAN;
var
    Subkeys : STRINGS;
    Sub     : STRING;
    I : LONGINT;
begin
    Result := FALSE;
    SetLength( SubKeys, 0 );
    if( H = 0 )then begin
        Exit;
    end;
    Result := TRUE;
    Subkeys := _RegEnumSubkeys( H );
    for I := 0 to Length( Subkeys ) - 1 do begin
        Sub := Subkeys[ I ];
        Result := RegDeleteKey( H, Sub ) and Result;
    end;
end;{ _RegDeleteSubkeys }

function _RegCopyValue( HS:HKEY; SrcParam:STRING; HD:HKEY; DstParam:STRING ):BOOLEAN;
var
    Res, Size, Typ : LONGINT;
    Data : STRING;
begin
    Result := FALSE;
    Size   := 0;
    Res := RegQueryValueEx( HS, PCHAR( SrcParam ), nil, @Typ, nil, @Size );
    if( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) )then begin
        SetLength( Data, Size );
        Res := RegQueryValueEx( HS, PCHAR( SrcParam ), nil, @Typ, POINTER( Data ), @Size );
        if( Res = ERROR_SUCCESS )then begin
            Res := RegSetValueEx( HD, PCHAR( DstParam ), 0, Typ, POINTER( Data ), Length( Data ) );
            Result := ( Res = ERROR_SUCCESS );
        end;
    end;
end;{ _RegCopyValue }

function _RegEnumValues( H:HKEY ):STRINGS;
var
    Val : STRING;
    I, Res : LONGINT;
    ValLen, ValCnt, MaxValLen : DWORD;
{ subroutines }
    function GetValue( Index:LONGINT ):LONGINT;
    begin
        ValLen := MaxValLen + 1;
        SetLength( Val, ValLen );
        Result := RegEnumValue( H, Index, PCHAR( Val ), ValLen, nil, nil, nil, nil );
        case Result of
            ERROR_SUCCESS : SetLength( Val, ValLen );
            else            Val := '';
        end;
    end;{ GetValue }
begin
    SetLength( Result, 0 );
    if( H = 0 )then begin
        Exit;
    end;
    Res := RegQueryInfoKey( H, nil, nil, nil, nil, nil, nil, @ValCnt, @MaxValLen, nil, nil, nil );
    if ( Res = ERROR_SUCCESS ) and ( ValCnt > 0 ) then begin
        for I := 0 to  ValCnt - 1 do begin
            Res := GetValue( I );
            case Res of
                ERROR_SUCCESS : begin
                    SetLength( Result, Succ( Length( Result ) ) );
                    Result[ Pred( Length( Result ) ) ] := Val;
                end;
                ERROR_NO_MORE_ITEMS : break;
            end;
        end;
    end;
end;{ _RegEnumValues }

function _RegDeleteValues( H:HKEY ):BOOLEAN;
var
    Values : STRINGS;
    Val : STRING;
    I, Res : LONGINT;
begin
    Result := FALSE;
    SetLength( Values, 0 );
    if( H = 0 )then begin
        Exit;
    end;
    Result := TRUE;
    Values := _RegEnumValues( H );
    for I := 0 to Length( Values ) - 1 do begin
        Val := Values[ I ];
        Res := Windows.RegDeleteValue( H, PCHAR( Val ) );
        Result := ( ERROR_SUCCESS = Res ) and Result;
    end;
end;{ _RegDeleteValues }

function _RegCopySubkeys( HS, HD : HKEY ):BOOLEAN;
var
    Subkeys : STRINGS;
    Sub : STRING;
    I : LONGINT;
begin
    Result := FALSE;
    SetLength( SubKeys, 0 );
    if( ( HS = 0 ) or ( HD = 0 ) or ( HS = HD ) )then begin
        Exit;
    end;
    Result  := TRUE;
    Subkeys := _RegEnumSubkeys( HS );
    for I := 0 to Length( Subkeys ) - 1 do begin
        Sub    := Subkeys[ I ];
        Result := RegCopyKey( HS, Sub, HD, Sub ) and Result;
    end;
end;{ _RegCopyValues }

function _RegCopyValues( HS, HD : HKEY ):BOOLEAN;
var
    Values : STRINGS;
    Val : STRING;
    I : LONGINT;
begin
    Result := FALSE;
    SetLength( Values, 0 );
    if( ( HS = 0 ) or ( HD = 0 ) or ( HS = HD ) )then begin
        Exit;
    end;
    Result := TRUE;
    Values := _RegEnumValues( HS );
    for I := 0 to Length( Values ) - 1 do begin
        Val    := Values[ I ];
        Result := _RegCopyValue( HS, Val, HD, Val ) and Result;
    end;
end;{ _RegCopyValues }






function RegDeleteValue( Root:HKEY; Key, Param : STRING ):BOOLEAN;
var
    H : HKEY;
begin
    Result := FALSE;
    H      := 0;
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Result := ( ERROR_SUCCESS = Windows.RegDeleteValue( H, PCHAR( Param ) ) );
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegDeleteValue }

function RegCopyValue( SrcRoot:HKEY; SrcKey, SrcParam : STRING; DstRoot:HKEY; DstKey, DstParam : STRING ):BOOLEAN;
var
    HS, HD : HKEY;
    Disp : LONGINT;
begin
    Result := FALSE;
    if( ( SrcRoot = 0 ) or ( SrcKey = '' ) or ( DstRoot = 0 ) or ( DstKey = '' ) )then begin
        Exit;
    end;
    HS := $FFFFFFFF;
    HD := $FFFFFFFF;
    if(     ( ERROR_SUCCESS = RegOpenKeyEx( SrcRoot, PCHAR( SrcKey ), 0, KEY_READ, HS ) )
        and ( ERROR_SUCCESS = RegCreateKeyEx( DstRoot, PCHAR( DstKey ), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, HD, @Disp ) )
    )then begin
        Result := _RegCopyValue( HS, SrcParam, HD, DstParam );
    end;
    RegCloseKey( HD );
    RegCloseKey( HS );
end;{ RegCopyValue }

function RegMoveValue( SrcRoot:HKEY; SrcKey, SrcParam : STRING; DstRoot:HKEY; DstKey, DstParam : STRING ):BOOLEAN;
begin
    Result := RegCopyValue( SrcRoot, SrcKey, SrcParam, DstRoot, DstKey, DstParam )
        and RegDeleteValue( SrcRoot, SrcKey, SrcParam )
    ;
end;{ RegMoveValue }

function RegDeleteKey( Root:HKEY; Key:STRING ):BOOLEAN;
var
H : HKEY;
begin
  H      := $FFFFFFFF;
  if( Key = '' )then begin
                       Result := FALSE;
                       Exit;
                     end;

  Result := TRUE;
  if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
      Result := _RegDeleteSubkeys( H ) and Result;
      Result := _RegDeleteValues( H ) and Result;
      RegCloseKey( H );
  end;
  Result := ( ERROR_SUCCESS = Windows.RegDeleteKey( Root, PCHAR( Key ) ) ) and Result;
end;{ RegDeleteKey }

function RegDeleteEmptyKey( Root:HKEY; Key:STRING ):BOOLEAN;
var
H : HKEY;
SubCnt, ValCnt : LONGINT;
CanDelete : BOOLEAN;
begin
  Result := FALSE;
  if( Key = '' )then begin
      Exit;
  end;
  H         := $FFFFFFFF;
  CanDelete := FALSE;
  if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_READ, H ) )then begin
      if( ERROR_SUCCESS = RegQueryInfoKey( H, nil, nil, nil, @SubCnt, nil, nil, @ValCnt, nil, nil, nil, nil ) )then begin
          CanDelete := ( SubCnt = 0 ) and ( ValCnt = 0 );
      end;
      RegCloseKey( H );
  end;
  if( CanDelete )then begin
      Result := ( ERROR_SUCCESS = Windows.RegDeleteKey( Root, PCHAR( Key ) ) );
  end;
end;{ RegDeleteEmptyKey }

function RegCopyKey( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
var
    HS, HD : HKEY;
    Disp   : LONGINT;
begin
    Result := FALSE;
    if( ( SrcRoot = 0 ) or ( SrcKey = '' ) or ( DstRoot = 0 ) or ( DstKey = '' ) )then begin
        Exit;
    end;
    HS := $FFFFFFFF;
    HD := $FFFFFFFF;
    if(     ( ERROR_SUCCESS = RegOpenKeyEx( SrcRoot, PCHAR( SrcKey ), 0, KEY_READ, HS ) )
        and ( ERROR_SUCCESS = RegCreateKeyEx( DstRoot, PCHAR( DstKey ), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, HD, @Disp ) )
    )then begin
        Result := _RegCopySubkeys( HS, HD );
        Result := _RegCopyValues( HS, HD ) and Result;
    end;
    RegCloseKey( HD );
    RegCloseKey( HS );
end;{ RegCopyKey }

function RegMoveKey( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
begin
  Result := False;
  if( RegCopyKey( SrcRoot, SrcKey, DstRoot, DstKey ) )then
                             Result := RegDeleteKey( SrcRoot, SrcKey );
end;{ RegMoveKey }

function RegRenameKey( Root:HKEY; Path, OldKey, NewKey : STRING ):BOOLEAN;
begin
    if AnsiSameStr( OldKey, NewKey ) then
        Result := TRUE
                                     else
        Result := RegMoveKey( Root, AddPath( Path, OldKey ), Root, AddPath( Path, NewKey ) );
end;{ RegRenameKey }

function RegGetData( Root:HKEY; Key, Param : STRING ):STRING;
var
    H : HKEY;
    Res, Size, Typ : LONGINT;
begin
    Result := '';
    H      := 0;
    Size   := 0;
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Res := RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, nil, @Size );
            if( ( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) ) and ( Size > 0 ) )then begin
                SetLength( Result, Size );
                RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, POINTER( Result ), @Size );
            end;
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegGetData }

function RegSetData( Root:HKEY; Key, Param : STRING; var Data; Count:LONGINT; AllowCreateKey:BOOLEAN ):BOOLEAN;
var
    H : HKEY;
    Disp, Res : LONGINT;
begin
    Result := FALSE;
    try
        H := 0;
        If not AllowCreateKey then
           Res := RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H )
                              else
           Res := RegCreateKeyEx( Root, PCHAR( Key ), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, H, @Disp );

        if( Res = ERROR_SUCCESS )then begin
            Result := ( ERROR_SUCCESS = RegSetValueEx( H, PCHAR( Param ), 0, REG_BINARY, @Data, Count ) );
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegSetData }

function RegSetDataString( Root:HKEY; Key, Param : STRING; Value:STRING; AllowCreateKey:BOOLEAN ):BOOLEAN;
var
    H : HKEY;
    Disp, Res : LONGINT;
begin
    Result := FALSE;
    try
        H := 0;
        If not AllowCreateKey then
            Res := RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H )
                              else
            Res := RegCreateKeyEx( Root, PCHAR( Key ), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, H, @Disp );

        if( Res = ERROR_SUCCESS )then begin
            Result := ( ERROR_SUCCESS = RegSetValueEx( H, PCHAR( Param ), 0, REG_BINARY, POINTER( Value ), Length( Value ) ) );
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegSetDataString }

function RegGetString( Root:HKEY; Key, Param : STRING ):STRING;
var
    H : HKEY;
    Res, Size, Typ : LONGINT;
begin
    Result := '';
    H      := 0;
    Size   := 0;
    Typ    := REG_SZ;
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Res := RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, nil, @Size );
            if( ( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) ) and ( Size > 0 )
                and ( ( Typ = REG_SZ ) or ( Typ = REG_EXPAND_SZ ) )
            )then begin
                SetLength( Result, Size );
                RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, POINTER( Result ), @Size );
                Normalize( Result );
            end;
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegGetString }

function RegGetStringDef( Root:HKEY; Key, Param, Default : STRING ):STRING;
var
    H : HKEY;
    Res, Size, Typ : LONGINT;
begin
    Result := Default;
    H      := 0;
    Size   := 0;
    Typ    := REG_SZ;
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Res := RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, nil, @Size );
            if( ( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) )
                and ( ( Typ = REG_SZ ) or ( Typ = REG_EXPAND_SZ ) )
            )then begin
                if( Size > 0 )then begin
                    SetLength( Result, Size );
                    RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, POINTER( Result ), @Size );
                    Normalize( Result );
                end else begin
                    Result := '';
                end;
            end;
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegGetStringDef }

function RegSetString( Root:HKEY; Key, Param, Value : String; AllowCreateKey:BOOLEAN ):BOOLEAN;
var
H: HKEY;
Disp, Res: LONGINT;
SaveStr: PWideChar;
L: Cardinal;
begin
    Result := FALSE;
    H      := 0;
    L := Length( Value ) * StringElementSize( Value );   // Длину строки умножаем на размер символа
    try
        If not AllowCreateKey then
            Res := RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H )
                              else
            Res := RegCreateKeyEx( Root, PCHAR( Key ), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, H, @Disp );

        SaveStr := PWideChar( Value );
        if( Res = ERROR_SUCCESS )then begin
            Result := ( ERROR_SUCCESS = RegSetValueEx( H, PChar( Param ), 0, REG_SZ, SaveStr, L ));
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegSetString }

function RegSetBoolean( Root:HKEY; Key, Param : STRING; Value:BOOLEAN; AllowCreateKey:BOOLEAN ):BOOLEAN;
const
    BL : array[ BOOLEAN ] of CHAR = ( '0', '1' );
begin
    Result := RegSetString( Root, Key, Param, BL[ Value ], AllowCreateKey );
end;{ RegSetBoolean }

function RegGetBoolean( Root:HKEY; Key, Param : STRING ):BOOLEAN;
begin
    Result := ( RegGetInteger( Root, Key, Param, -1 ) > 0 );
end;{ RegGetBoolean }

function RegGetBooleanDef( Root:HKEY; Key, Param : STRING; DefValue:BOOLEAN ):BOOLEAN;
var
    Res : LONGINT;
begin
    Result := DefValue;
    Res    := RegGetInteger( Root, Key, Param, -1 );
    if( Res >= 0 )then begin
        Result := ( Res > 0 );
    end;
end;{ RegGetBooleanDef }

function RegSetInteger( Root:HKEY; Key, Param : STRING; Value:LONGINT; AllowCreateKey:BOOLEAN ):BOOLEAN;
begin
    Result := RegSetString( Root, Key, Param, IntToStr( Value ), AllowCreateKey );
end;{ RegSetInteger }

function RegGetInteger( Root:HKEY; Key, Param : STRING; DefValue:LONGINT ):LONGINT;
var
    H : HKEY;
    Res, Size, Typ : LONGINT;
    StrVal : STRING;
begin
    Result := DefValue;
    H      := 0;
    Size   := 0;
    Typ    := REG_SZ;
    StrVal := '';
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Res := RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, nil, @Size );
            if( ( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) ) and ( Size > 0 ) )then begin
                case Typ of
                    REG_SZ, REG_EXPAND_SZ : begin
                        SetLength( StrVal, Size );
                        if( ERROR_SUCCESS = RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, POINTER( StrVal ), @Size ) )then begin
                            Normalize( StrVal );
                            Result := StrToIntDef( StrVal, DefValue );
                        end;
                    end;
                    REG_DWORD : begin
                        Size := SizeOf( Result );
                        if( ERROR_SUCCESS <> RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, @Result, @Size ) )then begin
                            Result := DefValue;
                        end;
                    end;
                end;
            end;
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegGetInteger }

function RegSetDwordValue( Root:HKEY; Key, Param : STRING; Value:DWORD; AllowCreateKey:BOOLEAN ):BOOLEAN;
var
    H : HKEY;
    Disp, Res : LONGINT;
begin
    Result := FALSE;
    H      := 0;
    try
        If not AllowCreateKey then
           Res := RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H )
                              else
           Res := RegCreateKeyEx( Root, PCHAR( Key ), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, H, @Disp );

        if( Res = ERROR_SUCCESS )then begin
            Result := ( ERROR_SUCCESS = RegSetValueEx( H, PCHAR( Param ), 0, REG_DWORD, @Value, SizeOf( Value ) ) );
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegSetDwordValue }

function RegSetDWord( Root:HKEY; Key, Param : STRING; Value:DWORD; AllowCreateKey:BOOLEAN; AsString:BOOLEAN = TRUE ):BOOLEAN;
begin
    if( AsString )then begin
        Result := RegSetString( Root, Key, Param, IntToStr( Value ), AllowCreateKey );
    end else begin
        Result := RegSetDwordValue( Root, Key, Param, Value, AllowCreateKey );
    end;
end;{ RegSetDWord }

function RegSetFloat( Root:HKEY; Key, Param : STRING; Value:DOUBLE; AllowCreateKey:BOOLEAN ):BOOLEAN;
begin
    Result := RegSetData( Root, Key, Param, Value, SizeOf( Value ), AllowCreateKey );
end;{ RegSetFloat }

function RegGetFloat( Root:HKEY; Key, Param : STRING; DefValue:DOUBLE ):DOUBLE;
var
    H : HKEY;
    Res, Size, Typ : LONGINT;
    StrVal : STRING;
begin
    Result := DefValue;
    H      := 0;
    Size   := 0;
    Typ    := REG_SZ;
    StrVal := '';
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Res := RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, nil, @Size );
            if( ( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) ) and ( Size > 0 ) )then begin
                case Typ of
                    REG_SZ, REG_EXPAND_SZ : begin
                        SetLength( StrVal, Size );
                        if( ERROR_SUCCESS = RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, POINTER( StrVal ), @Size ) )then begin
                            Normalize( StrVal );
                            Result := StrToFloatDef( StrVal, DefValue );
                        end;
                    end;
                    REG_BINARY : begin
                        Size := SizeOf( Result );
                        if( ( ERROR_SUCCESS <> RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, @Result, @Size ) )
                            or ( Size <> SizeOf( Result ) )
                        )then begin
                            Result := DefValue;
                        end;
                    end;
                end;
            end;
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegGetFloat }

function RegGetDWord( Root:HKEY; Key, Param : STRING; DefValue:DWORD ):LONGINT;
var
    H : HKEY;
    Res, Size, Typ : LONGINT;
    StrVal : STRING;
begin
    Result := DefValue;
    H      := 0;
    Size   := 0;
    Typ    := REG_SZ;
    StrVal := '';
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Res := RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, nil, @Size );
            if( ( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) ) and ( Size > 0 ) )then begin
                case Typ of
                    REG_SZ, REG_EXPAND_SZ : begin
                        SetLength( StrVal, Size );
                        if( ERROR_SUCCESS = RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, POINTER( StrVal ), @Size ) )then begin
                            Normalize( StrVal );
                            Result := StrToIntDef( StrVal, DefValue );
                        end;
                    end;
                    REG_DWORD : begin
                        Size := SizeOf( Result );
                        if( ERROR_SUCCESS <> RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, @Result, @Size ) )then begin
                            Result := DefValue;
                        end;
                    end;
                end;
            end;
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegGetDWord }

function RegKeyExists( Root:HKEY; Key:STRING ):BOOLEAN;
var
    H : HKEY;
begin

    H := 0;
    try
        Result := ( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) );
    finally
 //       if( H <> 0 )then begin
 //           RegCloseKey( H );
 //           Result := FALSE;
 //       end;
    end;
end;{ RegKeyExists }

function RegParamExists( Root:HKEY; Key, Param:STRING ):BOOLEAN;
var
    H : HKEY;
    Res, Size, Typ : LONGINT;
begin
    Result := FALSE;
    H      := 0;
    try
        if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
            Res := RegQueryValueEx( H, PCHAR( Param ), nil, @Typ, nil, @Size );
            Result := ( ( Res = ERROR_SUCCESS ) or ( Res = ERROR_MORE_DATA ) );
        end;
    finally
        if( H <> 0 )then begin
            RegCloseKey( H );
        end;
    end;
end;{ RegParamExists }

function RegEnumValues( Root:HKEY; Key:STRING ):STRINGS;
var
    H : HKEY;
begin
    SetLength( Result, 0 );
    H := $FFFFFFFF;
    if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_READ, H ) )then begin
        Result := _RegEnumValues( H );
        RegCloseKey( H );
    end;
end;{ RegEnumValues }

function RegDeleteValues( Root:HKEY; Key:STRING ):BOOLEAN;
var
    H : HKEY;
begin
    Result := FALSE;
    if( ( Root = 0 ) or ( Key = '' ) )then begin
        Exit;
    end;
    H := $FFFFFFFF;
    if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_ALL_ACCESS, H ) )then begin
        Result := _RegDeleteValues( H );
    end;
    RegCloseKey( H );
end;{ RegDeleteValues }

function RegCopyValues( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
var
    HS, HD : HKEY;
    Disp : LONGINT;
begin
    Result := FALSE;
    if( ( SrcRoot = 0 ) or ( SrcKey = '' ) or ( DstRoot = 0 ) or ( DstKey = '' )
        or ( ( SrcRoot = DstRoot ) and AnsiSameStr( SrcKey, DstKey ) )
    )then begin
        Exit;
    end;
    HS := $FFFFFFFF;
    HD := $FFFFFFFF;
    if(     ( ERROR_SUCCESS = RegOpenKeyEx( SrcRoot, PCHAR( SrcKey ), 0, KEY_READ, HS ) )
        and ( ERROR_SUCCESS = RegCreateKeyEx( DstRoot, PCHAR( DstKey ), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, HD, @Disp ) )
    )then begin
        Result := _RegCopyValues( HS, HD );
    end;
    RegCloseKey( HD );
    RegCloseKey( HS );
end;{ RegCopyValues }

function RegMoveValues( SrcRoot:HKEY; SrcKey:STRING; DstRoot:HKEY; DstKey:STRING ):BOOLEAN;
begin
    Result := RegCopyValues( SrcRoot, SrcKey, DstRoot, DstKey )
        and RegDeleteValues( SrcRoot, SrcKey )
    ;
end;{ RegMoveValues }

function RegEnumSubkeys( Root:HKEY; Key:STRING ):STRINGS;
var
    H : HKEY;
begin
		SetLength( Result, 0 );
    H := $FFFFFFFF;
		if( ERROR_SUCCESS = RegOpenKeyEx( Root, PCHAR( Key ), 0, KEY_READ, H ) )then begin
				Result := _RegEnumSubkeys( H );
        RegCloseKey( H );
    end;
end;{ RegEnumSubkeys }



{ Ini-file functions } // ***********************************************************************************

function IsQuoted( Str:STRING ):BOOLEAN;
begin
    Result := (
        ( Length( Str ) > 1 )
        and (  ( ( Str[ 1 ] = '"' ) and ( Str[ Length( Str ) ] = '"' ) )
            or ( ( Str[ 1 ] = #39 ) and ( Str[ Length( Str ) ] = #39 ) ) )
    );
end;{ IsQuoted }

function Enquote( Str:STRING ):STRING;
begin
    case IsQuoted( Str ) of
        FALSE : Result := '"' + Str + '"';
        TRUE  : Result := Str;
    end;
end;{ Enquote }

function Dequote( Str:STRING ):STRING;
begin
    Result := Str;
    if( IsQuoted( Result ) )then begin
        Delete( Result, Length( Result ), 1 );
        Delete( Result, 1, 1 );
    end;
end;{ Dequote }

function NeedQuote( Str:STRING ):BOOLEAN;
var
    I : LONGINT;
begin
    Result := FALSE;
    for I := 1 to Length( Str ) do begin
        if( Str[ I ] <= #32 )then begin
            Result := TRUE;
            break;
        end;
    end;
end;{ NeedQuote }

function ForceQuote( Str:STRING ):STRING;
begin
    Result := Str;
    if( NeedQuote( Result ) )then begin
        Result := Enquote( Result );
    end;
end;{ ForceQuote }

function StrToText( Str:STRING ):STRING;
var
    Start : STRING;
begin
    Result := '';
    if( Length( Str ) > 0 )then begin
        Start  := Copy( Str, 1, 1 );
        Result := AnsiLowerCase( Str );
        Result[ 1 ] := AnsiUpperCase( Start )[ 1 ];
    end;
end;{ StrToText }

function IniGetStringDef( FileName, Section, Key, Default : STRING ):STRING;
var
Res : DWORD;
begin
//	if ( Default = '' ) then
//    Default := #0;
	SetLength( Result, 2036 );
	Res := GetPrivateProfileString( PCHAR( Section ), PCHAR( Key ), PCHAR( Default ), PCHAR( Result ), Length( Result ), PCHAR( FileName ));
	If Res > 0 then
		Normalize( Result )
  else
		Result := Default;
end;{ IniGetStringDef }

function IniSetString( FileName, Section, Key, Value : STRING ):BOOLEAN;
begin
	if( 0 < Pos( ' ', Value ) )then begin
			Value := Enquote( Value );
	end;
	Result := WritePrivateProfileString( PCHAR( Section ), PCHAR( Key ), PCHAR( Value ), PCHAR( FileName ) );
end;{ IniSetString }

function IniGetIntegerDef( FileName, Section, Key : STRING; DefValue:LONGINT ):LONGINT;
begin
    Result := GetPrivateProfileInt( PCHAR( Section ), PCHAR( Key ), DefValue, PCHAR( FileName ) );
end;{ IniSetInteger }

function IniSetInteger( FileName, Section, Key : STRING; Value:LONGINT ):BOOLEAN;
begin
    Result := WritePrivateProfileString( PCHAR( Section ), PCHAR( Key ), PCHAR( IntToStr( Value ) ), PCHAR( FileName ) );
end;{ IniSetInteger }

function IniGetBooleanDef( FileName, Section, Key : STRING; DefValue:BOOLEAN ):BOOLEAN;
begin
    Result := ( 0 <> IniGetIntegerDef( FileName, Section, Key, Ord( DefValue ) ) );
end;{ IniSetInteger }

function IniGetBoolean( FileName, Section, Key : STRING ):BOOLEAN;
begin
    Result := IniGetBooleanDef( FileName, Section, Key, FALSE );
end;{ IniSetInteger }

function IniSetBoolean( FileName, Section, Key : STRING; Value:LONGINT ):BOOLEAN;
begin
    Result := IniSetInteger( FileName, Section, Key, Ord( Value ) );
end;{ IniSetBoolean }



	 { Функции определения системных директорий }  // **********************************************************************

function GetWinDir:STRING;
var
    Len : LONGINT;
begin
    SetLength( Result, MAX_PATH );
    Len := GetWindowsDirectory( PCHAR( Result ), MAX_PATH );
    if( Len > MAX_PATH )then begin
        SetLength( Result, Len );
        Len := GetWindowsDirectory( PCHAR( Result ), Len );
    end;
    SetLength( Result, Len );
end;{ GetWinDir }

function GetSysDir:STRING;
var
    Len : LONGINT;
begin
    SetLength( Result, MAX_PATH );
    Len := GetSystemDirectory( PCHAR( Result ), MAX_PATH );
    if( Len > MAX_PATH )then begin
        SetLength( Result, Len );
        Len := GetSystemDirectory( PCHAR( Result ), Len );
    end;
    SetLength( Result, Len );
end;{ GetSysDir }

function GetTempDir:STRING;
var
    Len : LONGINT;
begin
    SetLength( Result, MAX_PATH );
    Len := GetTempPath( MAX_PATH, PCHAR( Result ) );
    if( Len > MAX_PATH )then begin
        SetLength( Result, Len );
        Len := GetTempPath( Len, PCHAR( Result ) );
    end;
    SetLength( Result, Len );
end;{ GetTempDir }




end.
