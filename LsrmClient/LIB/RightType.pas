{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit RightType;

interface

uses
  Vcl.Graphics, Winapi.Windows, Winapi.Messages, System.SysUtils, Vcl.ActnList;

type
	TUserRightType = ( isReadOnly, isAllEdit, isSelfEdit, isSelfShow, isAllShow );
  TUserRightTypes = set of TUserRightType;

  function StringToUserRightType( const Value: String ): TUserRightType;

implementation

uses
  System.TypInfo;


 /// Получить право на доступ из строкового значения
function StringToUserRightType( const Value: String ): TUserRightType;
var
N, L: Integer;
StrValue: String;
begin
  Result := isReadOnly;
  L := GetTypeData( TypeInfo( TUserRightType ))^.MaxValue;
  for N := 0 to L do begin
    StrValue := GetEnumName( TypeInfo( TUserRightType ), N );
    if AnsiSameText( StrValue, Value ) then begin
      Result := TUserRightType( N );
      Exit;
    end;
  end;
end;



end.
