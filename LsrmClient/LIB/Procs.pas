{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit Procs;

interface

uses Windows, Classes, SysUtils, Dialogs, Variants;


  // Индекс строки в массиве
Function IndexOfStrArray(Str: String; ArrayStr: array of String): Integer;
  // Индекс элемента в числовом массиве
function IndexOfArray( N: Integer; ArrInt: Array of integer ): Integer;
  // Индекс элемента в массиве строковых констант
function IndexOfConst( const Str: String; ArrConst: Array of Const ): Integer;


{ Складывает путь и имя файла и приводит к нормальному виду. }
function AddPath( Path:STRING; FileName:STRING ):STRING;
{ Добавляет символы в конец строки.}
function AddLast( Str:STRING; Last:STRING ):STRING;
{ Удаляет первые символы строки если они равны "First"}
function DelFirst( Str:STRING; First:STRING ):STRING;
{ Поиск подстроки в строке. Если True регистр значения не имеет }
function PosCase ( SubStr, Str: String; IsCase: Boolean ): Integer;
{ Конвертирует пустую строку в Null }
function ValueToNull ( Value: String ): Variant;
  // Преобразует заголовки грида к нормальному виду
function NormHeaderGrid( Str: String ): String;
 // Возвращает значение строки из TString.Text ( StrList ) по индексу Ind
Function GetComboBoxValue( StrList: String; Ind: Integer ): String;
  // Возвращает индекс строки из TString.Text ( StrList ) по ее значению
function GetComboBoxIndex(StrList, Value: String): Integer;
  // создает строку типа TString.Text из элементов строкового массива
function ArrayToStrListText( List: array of String ): String;


{ Возвращает True или False в согласно Условию }
function IfString( Condition:BOOLEAN; TrueString, FalseString : STRING ):STRING;
{ Возвращает True или False в согласно Условию }
function IfInteger( Condition:BOOLEAN; TrueValue, FalseValue : LONGINT ):LONGINT;
{ Возвращает True или False в согласно Условию }
function IfDWord( Condition:BOOLEAN; TrueValue, FalseValue : DWORD ):DWORD;
{ Удаляет все символы после первого недействительного-символа }
procedure Normalize( var Str:STRING );


{ Converts string to EXTENDED if possible else returns default value. Uses SyUtils.DecimalSeparator. }
//function StrToFloatDef( S:STRING; Default:EXTENDED ):EXTENDED;
{ Возвращает TRUE, если цифра }
function IsCharNumeric( ch:Char ):LONGBOOL; stdcall;
{ Конвертирует DWORD в десятичное представление с необходимым числом цифр. }

 // Удаляет из строки разделители тысяч
function StrSeparatorDelete( Value: String ): String;
 // Установка раскладки клавиатуры
procedure SetLanguage( Lang: Integer );
 // Имя компа в сети
function GetComputerName:String;
 // Конвертирует кирилицу в текст латиницей для целей преобразования логина
function CyrToLatTranslit( const CyrStr: String ): String;
 // Конвертирует кирилицу в текст латиницей по ГОСТ
function CyrilTranslit( StrIn: String; const SetUpper: Boolean = False ): String;
 // Очищает содержимое каталога от всех вложенных файлов и каталогов и удаляет его
procedure RemoveNoEmptyDir( DirName : String );


const
	BoolTitle: array [0..1] of String = ( 'Нет', 'Да' );

implementation


procedure RemoveNoEmptyDir( DirName : String );
var
Ind: Integer;
SR: TSearchRec;
FileName : String;
begin
  DirName:= IncludeTrailingPathDelimiter( DirName ) + '*.*';
  Ind := FindFirst( DirName, faAnyFile, SR );
  try
    while Ind = 0 do begin
      FileName := IncludeTrailingPathDelimiter( ExtractFileDir( DirName )) + SR.Name;
      if SR.Attr = faDirectory then begin
        if (SR.Name <> '' )  and
           (SR.Name <> '.')  and
           (SR.Name <> '..') then
          RemoveNoEmptyDir( FileName );
      end
      else begin
        if SR.Attr <> faArchive then
          FileSetAttr( FileName, faArchive );
        DeleteFile(FileName);
      end;
      Ind := FindNext( SR );
    end;
  finally
    FindClose(SR);
  end;

  RemoveDir( ExtractFileDir( DirName ));
end;

Function IndexOfStrArray(Str: String; ArrayStr: array of String): Integer;
var
N: Integer;
begin
  Result := -1;
  For N := 0 to High( ArrayStr ) do
    If AnsiSameText( Str, ArrayStr[ N ] ) then begin
      Result := N;
      Exit;
    end;
end;

function IndexOfConst( const Str: String; ArrConst: Array of Const ): Integer;
var
N: Integer;
begin
  Result := -1;
  For N := 0 to High( ArrConst ) do
    If AnsiSameText( Str, String( ArrConst[ N ].VPChar )) then begin
      Result := N;
      Exit;
    end;
end;

function IndexOfArray( N: Integer; ArrInt: Array of integer ): Integer;
var
I: Integer;
begin
  Result := -1;
  For I := 0 to High( ArrInt ) do
    If ArrInt[ I ] = N then begin
      Result := N;
      Break;
    end;
end;

function AddPath( Path:STRING; FileName:STRING ):STRING;
begin
    Result := IfString( Path <> '', AddLast( Path, '\' ) + DelFirst( FileName, '\' ), FileName );
end;{ AddPath }

function AddLast( Str:STRING; Last:STRING ):STRING;
begin
    Result := Str;
    if( not AnsiSameStr( Copy( Result, Length( Result ) - Length( Last ) + 1, Length( Last ) ), Last ) )then begin
        Result := Result + Last;
    end;
end;{ AddLast }

function DelFirst( Str:STRING; First:STRING ):STRING;
begin
    Result := Str;
    if( ( Result <> '' ) and ( First <> '' ) )then begin
        if( ( Length( Result ) >= Length( First ) )
            and ( 0 = AnsiStrLComp( PCHAR( POINTER( Result ) ), PCHAR( POINTER( First ) ), Length( First ) ) )
        )then begin
            Delete( Result, 1, Length( First ) );
        end;
    end;
end;{ DelFirst }

function IfString( Condition:BOOLEAN; TrueString, FalseString : STRING ):STRING;
begin
    If Condition then
                   Result := TrueString
                 else
                   Result := FalseString;
end;{ IfString }

function IfInteger( Condition:BOOLEAN; TrueValue, FalseValue : LONGINT ):LONGINT;
begin
    If Condition then
                   Result := TrueValue
                 else
                   Result := FalseValue;
end;{ IfInteger }

function IfDWord( Condition:BOOLEAN; TrueValue, FalseValue : DWORD ):DWORD;
begin
    If Condition then
                   Result := TrueValue
                 else
                   Result := FalseValue;
end;{ IfDWord }

procedure Normalize( var Str:STRING );
begin
    SetLength( Str, StrLen( PCHAR( Str ) ) );
end;{ Normalize }

function StrToFloatDef( S:STRING; Default:EXTENDED ):EXTENDED;
var
    SepFound, Good  : BOOLEAN;
    Sign, IntVal, PartVal, Rank : EXTENDED;
    IntStr, PartStr : STRING;
    I : LONGINT;
begin
    Result := Default;
    S      := Trim( S );
    if( S = '' )then begin
        Exit;
    end;

    Sign    := 1.0;
    IntStr  := '';
    PartStr := '';
    if( S = '' )then begin
    end else if( S[ 1 ] = '-' )then begin
        Sign := -1.0;
        Delete( S, 1, 1 );
        S := Trim( S );
    end else if( S[ 1 ] = '-' )then begin
        Delete( S, 1, 1 );
        S := Trim( S );
    end;
    if( S = '' )then begin
        Exit;
    end;

    SepFound := FALSE;
    Good := TRUE;
    for I := 1 to Length( S ) do begin
        if( S[ I ] = SysUtils.FormatSettings.DecimalSeparator )then begin
            if( SepFound )then begin
                Good := FALSE;
                break; //two dots
            end;
            SepFound := TRUE;
        end else if( IsCharNumeric( S[ I ]  ) )then begin
            if( not SepFound )then begin
                IntStr := IntStr + S[ I ];
            end else begin
                PartStr := PartStr + S[ I ];
            end;
        end else begin
            Good := FALSE;
            break; //unallowable symbol
        end;
    end;
    Good := Good and SepFound;
    if( not Good )then begin
        Exit;
    end;

    Rank    := 1.0;
    IntVal  := 0.0;
    PartVal := 0.0;
    for I := Length( IntStr ) downto 1 do begin
        IntVal := IntVal + ( ( BYTE( IntStr[ I ] ) - $30 ) * Rank );
        Rank := Rank * 10.0;
    end;
    Rank := 0.1;
    for I := 1 to Length( PartStr ) do begin
        PartVal := PartVal + ( ( BYTE( PartStr[ I ] ) - $30 ) * Rank );
        Rank := Rank / 10.0;
    end;

    Result := Sign * ( IntVal + PartVal );
end;{ StrToFloatDef }

function IsCharNumeric( ch:Char ):LONGBOOL; stdcall;
begin
    Result := ( '0' <= ch ) and ( ch <= '9' );
end;{ IsCharNumeric }

function PosCase ( SubStr, Str: String; IsCase: Boolean ): Integer;
begin
	If IsCase then
		Result := Pos( AnsiUpperCase( SubStr ), AnsiUpperCase( Str ) )
						else
		Result := Pos( SubStr, Str  );
end; {PosCase}

function ValueToNull ( Value: String ): Variant;
begin
  If Trim( Value ) = '' then
     Result := null
                        else
     Result := Value;
end;

function NormHeaderGrid( Str: String ): String;
var
N, L: Integer;
begin
  N := 1;
  L := Length( Str );
  Result := Str;
  While N <= L do begin
    If IsDelimiter( '|', Result, N ) then begin
      Delete( Result, N, 1 );
      Insert( '. ', Result, N );
      L := Length( Result );
    end;
    Inc( N );
  end;
end;

Function GetComboBoxValue( StrList: String; Ind: Integer ): String;
var
StrItem: TStringList;
begin
  Result := '';
  If ( StrList = '' ) or ( Ind = -1 ) then
                                        Exit;
  StrItem := TStringList.Create;
  try
    StrItem.Text := StrList;
    Result := StrItem.Strings[ Ind ];
  finally
    StrItem.Free;
  end;
end;

function GetComboBoxIndex(StrList, Value: String): Integer;
var
StrItem: TStringList;
begin
  Result := -1;
  If ( StrList = '' ) or ( Value = '' ) then
                                           Exit;
  StrItem := TStringList.Create;
  try
    StrItem.Text := StrList;
    If StrItem.Count > 0 then
       Result := StrItem.IndexOf( Value );
  finally
    StrItem.Free;
  end;
end;

function ArrayToStrListText( List: array of String ): String;
var
N: Integer;
StrList: TStringList;
begin
  Result := '';
  If Length( List ) = 0 then
                          Exit;
  StrList := TStringList.Create;
  StrList.Clear;
  try
    For N := 0 to High( List ) do
      StrList.Append( List[ N ] );
    Result := StrList.Text;
  finally
    StrList.Free;
  end;
end;

function StrSeparatorDelete( Value: String ): String;
var
N, L: Integer;
IsDecimal: Boolean;
begin
  IsDEcimal := False;
  If Trim( Value ) = '' then
    Value := '0';
  Result := Value;
  L := Length( Value );
  For N := L downto 1 do begin
    If IsDecimal and ( Result[ N ] = FormatSettings.DecimalSeparator ) then
      Result := Copy( Result, 1, N - 1 ) + Copy( Result, N + 1, L );
    If Result[ N ] = FormatSettings.DecimalSeparator then
      IsDecimal := True;
    If Result[ N ] = FormatSettings.ThousandSeparator then
      Result := Copy( Result, 1, N - 1 ) + Copy( Result, N + 1, L );
  end;
end;

function GetXMLTagValue( const XmlText, TagName: String ): String;
var
Start, L: Integer;
EndTagName: String;
begin
  Start := Pos( TagName, XmlText );
  If Start > 0 then begin
    Start := Start + Length( TagName );
    EndTagName := TagName[ 1 ] + '/' + Copy( TagName, 2, Length( TagName ));
    L := 0;
    while ( not AnsiSameText( copy( XmlText, Start + L, Length( TagName ) + 1 ), EndTagName )) do begin
      Inc( L );
      If L > 48 then
        Break;
    end;
    Result := Copy( XmlText, Start, L );
  end;
end;

procedure SetLanguage( Lang: Integer );
var                          
N, I: Byte;
RusL: THandle;
Layouts: array [ 0 .. 10 ] of THandle;
begin
   RusL:= 0;
   N:= GetKeyboardLayoutList( High(Layouts) + 1, Layouts );

   If N > 0 then
      For I := 0 to N - 1 do
        If LoWord( Layouts[ I ] ) and $FF = Lang then
          RusL:= Layouts[ I ];
   If RusL <> 0 then
     ActivateKeyboardLayout( RusL, 0 );
end;

function GetComputerName:String;
var
Len : DWORD;
begin
  SetString( Result, nil, MAX_COMPUTERNAME_LENGTH + 1 );
  Len := Length( Result );
  if ( Windows.GetComputerName( PCHAR( Result ), Len ) and
     ( Len > 0 )) then
    SetLength( Result, Len )
                  else
    Result := '';
end;

function CyrilTranslit( StrIn: String; const SetUpper: Boolean = False ): String;
const
CyrilStr = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
Trans : array [1..33] of string =
  ( 'a','b','v','g','d','e','jo','zh','z', 'i','jj','k','l','m','n','o','p','r','s','t','u','f','kh','c','ch',
    'sh','shh','"','y','''','eh','yu','ya' );
var
N, L, Ind: Integer;
begin
  Result := '';
  StrIn := Trim( AnsiUpperCase( StrIn ));
  L := Length( StrIn );
  for N := 1 to L do begin
    Ind := Pos( StrIn[ N ], CyrilStr );
    If Ind = 0 then
      Result := Result + StrIn[ N ]
    else
      Result := Result + Trans[ Ind ];
  end;
  If SetUpper then
    Result := AnsiUpperCase( Result );
end;

function CyrToLatTranslit( const CyrStr: String ): String;
var
NewStr: String;
N: Integer;
begin
  Result := '';
  If CyrStr > '' then begin
    for N := 1 to Length( CyrStr ) do begin
      case CyrStr[ N ] of
        'а', 'А': NewStr := 'A';
        'б', 'Б': NewStr := 'B';
        'в', 'В': NewStr := 'V';
        'г', 'Г': NewStr := 'G';
        'д', 'Д': NewStr := 'D';
        'е', 'Е': NewStr := 'E';
        'ё', 'Ё': NewStr := 'E1';
        'ж', 'Ж': NewStr := 'J';
        'з', 'З': NewStr := 'Z';
        'и', 'И': NewStr := 'I';
        'й', 'Й': NewStr := 'I1';
        'к', 'К': NewStr := 'K';
        'л', 'Л': NewStr := 'L';
        'м', 'М': NewStr := 'M';
        'н', 'Н': NewStr := 'N';
        'о', 'О': NewStr := 'O';
        'п', 'П': NewStr := 'P';
        'р', 'Р': NewStr := 'R';
        'с', 'С': NewStr := 'S';
        'т', 'Т': NewStr := 'T';
        'у', 'У': NewStr := 'Y';
        'ф', 'Ф': NewStr := 'PH';
        'х', 'Х': NewStr := 'X';
        'ц', 'Ц': NewStr := 'C';
        'ч', 'Ч': NewStr := 'CH';
        'ш', 'Ш': NewStr := 'SH';
        'щ', 'Щ': NewStr := 'ZH';
        'ъ', 'Ъ': NewStr := '25';
        'ы', 'Ы': NewStr := 'Y2';
        'ь', 'Ь': NewStr := '38';
        'э', 'Э': NewStr := 'EE';
        'ю', 'Ю': NewStr := 'U';
        'я', 'Я': NewStr := 'JA';
        #32:      NewStr := '-';
        else NewStr := AnsiUpperCase( CyrStr[ N ] );
      end;
      Result := Result + NewStr;
    end;
  end;
end;




end.







