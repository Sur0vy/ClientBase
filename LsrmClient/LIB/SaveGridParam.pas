{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit SaveGridParam;

interface

uses
  winapi.Windows, winapi.Messages, System.SysUtils, System.Classes, vcl.Graphics, vcl.Controls, vcl.Forms, vcl.Dialogs,
  System.Variants, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, DBGridEh, Data.DB, System.Math, System.UITypes,
	ProcReg;

  // сохранить в реестр
procedure DBGridToReg(Grid: TDBGridEh; Key, Param: String);
  // загрузить из реестра
procedure RegToDBGrid(Grid: TDBGridEh; Key, Param: String; HeightDef, FrozenDef: Integer );

procedure DBGridToStreem(Grid: TDBGridEh; var ParValue: TStringStream; out RowHeight, Frozen: Integer );

procedure StreemToDBGrid(Grid: TDBGridEh; ParValue: TStringStream );

implementation


function NormValueSize( Value: Integer ): Integer;
var
ScreenWidth: Integer;
begin
  Result := Value;
  ScreenWidth := ( Screen.Width div 3 ) * 2;

  If ( Value > ScreenWidth ) then
    Result := ScreenWidth
  else
  If ( Value < 5 ) then
    Result := 5;
end;

function SaveColumnParamToStr( Grid: TDBGridEh; Ind: Integer ): String;
var
PList: TStringList;
Al: TAlignment;
FS : TFontStyles;
PS: TFontPitch;
StyleInt: Byte;
begin
  If ( not Assigned( Grid )) or ( not Assigned( Grid.Columns[ Ind ] )) then
    Exit;
  PList := TStringList.Create;
  With Grid.Columns[ Ind ] do
    try
      PList.Clear;
      PList.Append( FieldName );
      PList.Append( IntToStr( Index ));
      PList.Append( IntToStr( NormValueSize( Width )));
      PList.Append( Font.Name );
      PList.Append( IntToStr( Font.Charset ));
      PList.Append( IntToStr( Font.Size ));
      PList.Append( IntToStr( Font.Height ));
      PList.Append( IntToStr( Font.Color ));

      Al := Alignment;
      Move( Al, StyleInt, 1);
      PList.Append( IntToStr( StyleInt ));
      FS := Font.Style;
      Move( FS, StyleInt, 1);
      PList.Append( IntToStr( StyleInt ));
      PS := Font.Pitch;
      Move( PS, StyleInt, 1);
      PList.Append( IntToStr( StyleInt ));

      PList.Append( IntToStr( Integer( Visible )));
    finally
      Result := PList.Text;
      PList.Free;
    end;
end;

function IntToSortString( Ind, CharCount: Integer ): String;
begin
  Result := IntToStr( Ind );
  If Length( Result ) < CharCount then
    Result := StringOfChar( '0', CharCount - Length( Result ) ) + Result;
end;

Procedure DBGridToReg(Grid: TDBGridEh; Key, Param: String);
var
N: Integer;
KeyName, StrCol: String;
begin
  If not Assigned( Grid ) then
    Exit;
  Grid.AutoFitColWidths := False;
  Application.ProcessMessages;
  KeyName := Key + '\' + Param;
  try
    RegDeleteKey( HKEY_CURRENT_USER, KeyName );
  except
    raise;
  end;
  RegSetInteger( HKEY_CURRENT_USER, KeyName, 'RowHeight', Grid.RowHeight, True );
  RegSetInteger( HKEY_CURRENT_USER, KeyName, 'Frozen', Grid.FrozenCols, True);
  For N := 0 to Grid.Columns.Count - 1 do begin
    StrCol := SaveColumnParamToStr( Grid, N );
    RegSetString(HKEY_CURRENT_USER, KeyName, IntToSortString( N, 3 ), StrCol, True);
  end;
end;

procedure DBGridToStreem(Grid: TDBGridEh; var ParValue: TStringStream; out RowHeight, Frozen: Integer );
var
N, L: Integer;
StrCol: String;
begin
  if not Assigned( ParValue ) then begin
    Exit;
  end;
  If not Assigned( Grid ) then
    Exit;

  Grid.AutoFitColWidths := False;
  Application.ProcessMessages;

  RowHeight := Grid.RowHeight;
  Frozen := Grid.FrozenCols;

  ParValue.Seek( 0, soBeginning );
  For N := 0 to Grid.Columns.Count - 1 do begin
    StrCol := SaveColumnParamToStr( Grid, N );
    L := length( StrCol );
    ParValue.Write( L, SizeOf( Integer ));
    ParValue.WriteString( StrCol );
  end;
end;

function LoadFieldNameFromStr( StrColumn: String ): String;
var
PList: TStringList;
begin
  PList := TStringList.Create;
  PList.Clear;
  PList.Text := StrColumn;
  If PList.Count = 0 then begin
    Result := '';
    Exit;
  end;
  try
    Result := PList.Strings[ 0 ];
  finally
    PList.Free;
  end;
end;

procedure LoadColumnParamFromStr( Grid: TDBGridEh; ColName: String; StrColumn: String );
  Function GetColumnName( F_Name: String ): Integer;
  var
  N: Integer;
  begin
    Result := -1;
    For N := 0 to Grid.Columns.Count - 1 do
      If AnsiSameText( F_Name, Grid.Columns.Items[ N ].FieldName ) then begin
        Result := N;
        Break;
      end;
  end;
var
PList: TStringList;
Al: TAlignment;
FS : TFontStyles;
PS: TFontPitch;
StyleInt: Byte;
Ind: Integer;
ColumnInd: Integer;
begin
  If not Assigned( Grid ) then
    Exit;
  Ind := GetColumnName( ColName );
  If ( Ind = -1 ) or ( not Assigned( Grid.Columns.Items[ Ind ] )) then
    Exit;

  PList := TStringList.Create;
  PList.Clear;
  PList.Text := StrColumn;

  With Grid.Columns.Items[ Ind ] do
    try
      If ( PList.Strings[ 0 ] = '' ) or
         ( not AnsiSameText( PList.Strings[ 0 ], ColName )) then
        Exit;

      ColumnInd := StrToIntDef( PList.Strings[ 1 ], 0);
      If ColumnInd >= Grid.Columns.Count then
        Index := Grid.Columns.Count - 1
      else
        Index := ColumnInd;

      Width := NormValueSize(StrToIntDef( PList.Strings[ 2 ], 50));
      Font.Name := PList.Strings[ 3 ];
      Font.Charset := StrToIntDef( PList.Strings[ 4 ], 204);
      Font.Size := StrToIntDef( PList.Strings[ 5 ], 8);
      Font.Height := StrToIntDef( PList.Strings[ 6 ], -11);
      Font.Color := StrToIntDef( PList.Strings[ 7 ], 0);

      StyleInt := StrToIntDef( PList.Strings[ 8 ], 0 );
      Move( StyleInt, Al, 1);
      Alignment := Al;

      StyleInt := StrToIntDef( PList.Strings[ 9 ], 0 );
      Move( StyleInt, FS, 1);
      Font.Style := FS;

      StyleInt := StrToIntDef( PList.Strings[ 10 ], 0 );
      Move( StyleInt, PS, 1);
      Font.Pitch := PS;
      If PList.Count > 11 then
         Visible := StrToIntDef( PList.Strings[ 11 ], 0 ) = 1;
    finally
      PList.Free;
    end;
end;

procedure RegToDBGrid(Grid: TDBGridEh; Key, Param: String; HeightDef, FrozenDef: Integer );
var
N, Frozen: Integer;
F_Name, KeyName, StrCol: String;
begin
  KeyName := Key + '\' + Param;
  Grid.RowHeight := RegGetInteger( HKEY_CURRENT_USER, KeyName, 'RowHeight', HeightDef );
  Frozen := RegGetInteger( HKEY_CURRENT_USER, KeyName, 'Frozen', FrozenDef );
  If Frozen >= 6 then
    Frozen := FrozenDef;

  try
    If Frozen >= Grid.Columns.Count then
      Grid.FrozenCols := 0
    else
      Grid.FrozenCols := Frozen;
  except
    Grid.FrozenCols := 0;
  end;

  N := 0;
  While RegParamExists( HKEY_CURRENT_USER, KeyName, IntToSortString( N, 3 ) )  do begin
    StrCol := RegGetString( HKEY_CURRENT_USER, KeyName, IntToSortString( N, 3 ));
    F_Name := LoadFieldNameFromStr( StrCol );
    LoadColumnParamFromStr( Grid, F_Name, StrCol );
    Inc( N );
  end;
end;

procedure StreemToDBGrid(Grid: TDBGridEh; ParValue: TStringStream );
var
L: Integer;
F_Name, StrCol: String;
begin
  if not Assigned( ParValue ) then
    Exit;
  ParValue.Seek( 0, soBeginning );

  While ParValue.Position < ParValue.Size  do begin
    ParValue.Read( L, SizeOf( Integer ));
    Setlength( StrCol, L );
    StrCol := ParValue.ReadString( L );
    F_Name := LoadFieldNameFromStr( StrCol );
    LoadColumnParamFromStr( Grid, F_Name, StrCol );
  end;
end;


end.
