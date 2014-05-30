{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit SqlTools;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBGridEh, pFIBStoredProc,
  FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, FIBDataSet, pFIBDataSet, ClientDM;

type
  TArrayVariant = array of Variant;
  TArrayInteger = array of Integer;

  TNewQuery = class( TpFIBQuery )
  public
    InTrans: Boolean;   // Состояние транзакции до использования
    constructor CreateNew( AOwner: TComponent; Tr: TFIBTransaction );
    procedure FreeAndCommit;
  end;

  TDSQuery = class( TpFIBDataSet )
  public
    InTrans: Boolean;   // Состояние транзакции до использования
    constructor CreateNew( AOwner: TComponent; Tr: TFIBTransaction );
    procedure FreeAndCommit;
  end;

  // очистить значения всех параметров у хранимой процедуры
  procedure SpParamsClear( var SP: TpFIBStoredProc );
  // Сохранение парамметров грида в базу
  Procedure DBGridToBase( Grid: TDBGridEh; const FormClass, GridName: String );
  // Чтение параметров грида из базы
  Procedure BaseToDBGrid( Grid: TDBGridEh; const FormClass, GridName: String );

  // Возвращает список полей первичного ключа
  function GetConstrFieldList( const TableName, TypeName: String ): String;
  // Исполняет запрос и возвращает значение поля в виде строки
  function GetQueryStrField( SQLText, FieldResult: String; ParamValues: array of Variant; Tr: TFIBTransaction ): String;
// Исполняет запрос и возвращает значение поля в виде Integer
  function GetQueryIntField( SQLText, FieldResult: String; ParamValues: array of Variant; Tr: TFIBTransaction ): Integer;
  // Проверяет наличие поля в таблице и вхождение в PK
  function FindFieldInTable(const TableName, FieldName: String; IsPK: Boolean ): Boolean;
////     Вставка данных в кешь и Refresh их из базы
//  function NewDataCacheInsert( DS: TpFIBDataSet; Sp: TpFIBStoredProc; const TableName, PrKeyName: String; PrKeyID: Integer ): Boolean;
    // Проверяется возвращает ли запрос записи
  function CheckQueryIsEmpty( SQLText: String; ParamValues: array of Variant;  Tr: TFIBTransaction ): Boolean;
	// Исполняет запрос SQLText и возвращает в RestValues значения всех полей для первой записи
  function GetQueryResult( SQLText: String; ParamValues: array of Variant; Tr: TFIBTransaction; var ResValues: TArrayVariant ): Boolean;
  // Исполняет запрос в указанной транзакции
  function ExecuteQuery( SQLText: String; ParamValues: array of Variant; Tr: TFIBTransaction ): Boolean;
  // записывает содержимое файла в параметр хоранимой процедуры
  function SaveFileToBlob( FileName, F_Name: String; SP: TpFIBStoredProc; MaxSize: Integer = 5000000 ): Boolean;
  // Заменяет метки в шаблоне письма
  procedure BodyReplaceLabel( DS: TpFIBDataSet; Query: TpFIBQuery; var BodyText: String );


implementation

uses
  SaveGridParam, ConstList;

 { Tools }

procedure SpParamsClear( var SP: TpFIBStoredProc );
var
N: Integer;
begin
  for N := 0 to SP.ParamCount - 1 do
    SP.Params[ N ].Clear;
end;

Procedure DBGridToBase( Grid: TDBGridEh; const FormClass, GridName: String );
const
sqlGrid =
'update or insert into GRID_PARAMS (' + #13#10 +
'    USER_LIST_ID, FORM_CLASS, GRID_NAME, GRID_VALUE, FROZEN_COLS, ROW_HEIGHT )' + #13#10 +
'  values (' + #13#10 +
'    :USER_LIST_ID, :FORM_CLASS, :GRID_NAME, :GRID_VALUE, :FROZEN_COLS, :ROW_HEIGHT )' + #13#10 +
'  matching (' + #13#10 +
'    USER_LIST_ID, FORM_CLASS, GRID_NAME )';

var
ParValue: TStringStream;
RowHeight, Frozen: Integer;
Query: TNewQuery;
begin
  ParValue := TStringStream.Create;
  try
    DBGridToStreem( Grid, ParValue, RowHeight, Frozen );

    Query := TNewQuery.CreateNew( nil, frDM.IBTrWrite );
    try
      Query.SQL.Text := sqlGrid;
      If not Query.Prepared then
        Query.Prepare;

      Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
      Query.ParamByName( 'FORM_CLASS' ).AsString := FormClass;
      Query.ParamByName( 'GRID_NAME' ).AsString := GridName;
      Query.ParamByName( 'ROW_HEIGHT' ).AsInteger := RowHeight;
      Query.ParamByName( 'FROZEN_COLS' ).AsInteger := Frozen;
      Query.ParamByName( 'GRID_VALUE' ).LoadFromStream( ParValue );

      try
        Query.ExecQuery;
      except
        Raise;
      end;
    finally
      Query.FreeAndCommit;
    end;
  finally
    ParValue.Free;
  end;
end;

Procedure BaseToDBGrid( Grid: TDBGridEh; const FormClass, GridName: String );
const
sqlGrid =
'select' + #13#10 +
'  GRID_VALUE, FROZEN_COLS, ROW_HEIGHT' + #13#10 +
'from GRID_PARAMS' + #13#10 +
'where' + #13#10 +
'  USER_LIST_ID = :USER_LIST_ID and' + #13#10 +
'  FORM_CLASS = :FORM_CLASS and' + #13#10 +
'  GRID_NAME = :GRID_NAME';

var
ParValue: TStringStream;
Query: TNewQuery;
begin
  ParValue := TStringStream.Create;
  try
    Query := TNewQuery.CreateNew( nil, frDM.IBTrWrite );
    try
      Query.SQL.Text := sqlGrid;
      If not Query.Prepared then
        Query.Prepare;

      Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
      Query.ParamByName( 'FORM_CLASS' ).AsString := FormClass;
      Query.ParamByName( 'GRID_NAME' ).AsString := GridName;

      try
        Query.ExecQuery;
      except
        Raise;
      end;

      Grid.FrozenCols := Query.FieldByName( 'FROZEN_COLS' ).AsInteger;
      Grid.RowHeight := Query.FieldByName( 'ROW_HEIGHT' ).AsInteger;
      Query.FieldByName( 'GRID_VALUE' ).SaveToStream( ParValue );

      StreemToDBGrid( Grid, ParValue );
    finally
      Query.FreeAndCommit;
    end;
  finally
    ParValue.Free;
  end;
end;

function GetConstrFieldList( const TableName, TypeName: String ): String;
const
sqlList =
'select' + #13#10 +
'  list( Trim( cast( S.RDB$FIELD_NAME as varchar(32)))) as PK_LIST ' + #13#10 +
'from RDB$RELATION_CONSTRAINTS C, RDB$INDEX_SEGMENTS S' + #13#10 +
'where' + #13#10 +
'  ( C.RDB$RELATION_NAME = :TABLE_NAME ) and' + #13#10 +
'  ( C.RDB$INDEX_NAME = S.RDB$INDEX_NAME ) and' + #13#10 +
'  ( C.RDB$CONSTRAINT_TYPE = :TYPE_NAME )';
begin
  Result := GetQueryStrField( sqlList, 'PK_LIST', [ TableName, TypeName ], nil );
end;

function GetQueryStrField( SQLText, FieldResult: String; ParamValues: array of Variant; Tr: TFIBTransaction ): String;
var
Query: TNewQuery;
N: Integer;
begin
	Query := TNewQuery.CreateNew( nil, Tr );
	try
		Query.SQL.Text := SQLText;
		If not Query.Prepared then
      Query.Prepare;

		If Query.ParamCount <> Length( ParamValues ) then
			 raise Exception.Create( 'Неверное количество параметров запроса' );

		For N := 0 to High( ParamValues ) do
			Query.Params[ N ].AsVariant := ParamValues[ N ];
		try
			Query.ExecQuery;
		except
			Raise;
		end;

    if Query.Eof and Query.Bof then
      Result := ''
    else
  		Result := Query.FieldByName( FieldResult ).AsString;
	finally
		Query.FreeAndCommit;
	end;
end;

function GetQueryIntField( SQLText, FieldResult: String; ParamValues: array of Variant; Tr: TFIBTransaction ): Integer;
var
Query: TNewQuery;
N: Integer;
begin
  Result := -1;
	Query := TNewQuery.CreateNew( nil, Tr );
	try
		Query.SQL.Text := SQLText;
		If not Query.Prepared then
      Query.Prepare;

		If Query.ParamCount <> Length( ParamValues ) then
			 raise Exception.Create( 'Неверное количество параметров запроса' );

		For N := 0 to High( ParamValues ) do
			Query.Params[ N ].AsVariant := ParamValues[ N ];
		try
			Query.ExecQuery;
		except
			Raise;
		end;
    if Query.Eof and Query.Bof then
      Exit;

  	Result := Query.FieldByName( FieldResult ).AsInteger;
	finally
		Query.FreeAndCommit;
	end;
end;

function FindFieldInTable(const TableName, FieldName: String; IsPK: Boolean ): Boolean;
const
sqlFields =
'select' + #13#10 +
'  R.RDB$FIELD_NAME' + #13#10 +
'from RDB$RELATION_FIELDS R' + #13#10 +
'where' + #13#10 +
'  R.RDB$RELATION_NAME = :TABLE_NAME and' + #13#10 +
'  R.RDB$FIELD_NAME = :FIELD_NAME';

sqlIndexList =
'select ' +
'  C.RDB$INDEX_NAME ' +
'from RDB$RELATION_CONSTRAINTS C, RDB$INDEX_SEGMENTS S ' +
'where ' +
'(C.RDB$RELATION_NAME = :TABLE_NAME) and (C.RDB$INDEX_NAME = S.RDB$INDEX_NAME) and ' +
'(S.RDB$FIELD_NAME = :FIELD_NAME) and ' +
'(C.RDB$CONSTRAINT_TYPE = :TYPE_NAME)';

begin
  if IsPK then
    Result :=
      not CheckQueryIsEmpty( sqlIndexList, [ TableName, FieldName, 'PRIMARY KEY' ], nil )
  else
    Result :=
      not CheckQueryIsEmpty( sqlFields, [ TableName, FieldName ], nil );
end;

function NewDataCacheInsert( DS: TpFIBDataSet; Sp: TpFIBStoredProc; const TableName, PrKeyName: String; PrKeyID: Integer ): Boolean;
const
sqlPrKeyList =
'select ' + #13#10 +
'  S.RDB$FIELD_NAME as PR_KEY_FIELD_NAME ' + #13#10 +
'from RDB$RELATION_CONSTRAINTS C, RDB$INDEX_SEGMENTS S ' + #13#10 +
'where ' + #13#10 +
'(C.RDB$RELATION_NAME = :TABLE_NAME) and' + #13#10 +
'(C.RDB$INDEX_NAME = S.RDB$INDEX_NAME) and' + #13#10 +
'(C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' )';

var
Query: TNewQuery;
IndList: array of integer;
ValueList: array of variant;
L: Integer;
F_Name: String;
begin
  Result := False;
  Query := TNewQuery.CreateNew( frDM, frDM.IBTrRead );
  try
    Query.SQL.Text := sqlPrKeyList;
    If not Query.Prepared then
      Query.Prepare;
    Query.ParamByName( 'TABLE_NAME' ).AsString := TableName;
    try
      Query.ExecQuery;
      Result := not ( Query.Bof and Query.Eof );
    except
      Raise;
    end;

    L := 0;
    SetLength( IndList, L );
    SetLength( ValueList, L );

    while not Query.Eof do begin
      Inc ( L );
      SetLength( IndList, L );
      SetLength( ValueList, L );
      F_Name := Trim( Query.FieldByName( 'PR_KEY_FIELD_NAME' ).AsString );

      IndList[ L - 1 ] := DS.FieldByName( F_Name ).Index;
      if AnsiSameText( F_Name, PrKeyName ) then
        ValueList[ L - 1 ] := PrKeyID
      else
        ValueList[ L - 1 ] := Sp.ParamByName( F_Name ).AsVariant;

      Query.Next;
    end;

    if L > 0 then begin
      DS.CacheInsert( IndList, ValueList );
      DS.Refresh;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

function CheckQueryIsEmpty( SQLText: String; ParamValues: array of Variant;  Tr: TFIBTransaction ): Boolean;
var
Query: TNewQuery;
N: Integer;
begin
  Result := True;
  Query := TNewQuery.CreateNew( nil, Tr );
  try
    Query.SQL.Text := SQLText;
    If not Query.Prepared then
      Query.Prepare;

    If Query.ParamCount <> Length( ParamValues ) then
       raise Exception.Create( 'Неверное количество параметров запроса' );

    For N := 0 to High( ParamValues ) do
      Query.Params[ N ].AsVariant := ParamValues[ N ];
    try
      Query.ExecQuery;
    except
      Raise;
    end;
		Result := Query.Eof and Query.Bof;
  finally
    Query.FreeAndCommit;
  end;
end;

function GetQueryResult( SQLText: String; ParamValues: array of Variant; Tr: TFIBTransaction; var ResValues: TArrayVariant ): Boolean;
var
Query: TNewQuery;
N: Integer;
begin
  Result := False;
  Query := TNewQuery.CreateNew( frDM, Tr  );
  try
    Query.SQL.Text := SQLText;
    If not Query.Prepared then
      Query.Prepare;

    If Query.ParamCount <> Length( ParamValues ) then
       raise Exception.Create( 'Неверное количество параметров запроса' );

    For N := 0 to High( ParamValues ) do
      Query.Params[ N ].AsVariant := ParamValues[ N ];
    try
      Query.ExecQuery;
    except
      Raise;
    end;

    Result := not ( Query.Eof and Query.Bof );

    N := Query.FieldsCount;
    SetLength( ResValues, N );
    For N := 0 to High( ResValues ) do
      ResValues[ N ] := Query.Fields[ N ].AsVariant;

	finally
		Query.FreeAndCommit;
	end;
end;

function ExecuteQuery( SQLText: String; ParamValues: array of Variant; Tr: TFIBTransaction ): Boolean;
var
Query: TNewQuery;
N: Integer;
begin
  Result := False;
  Query := TNewQuery.CreateNew( frDM, Tr  );
  try
    Query.SQL.Text := SQLText;
    If not Query.Prepared then
      Query.Prepare;

    If Query.ParamCount <> Length( ParamValues ) then
       raise Exception.Create( 'Неверное количество параметров запроса' );

    For N := 0 to High( ParamValues ) do
      Query.Params[ N ].AsVariant := ParamValues[ N ];
    try
      Query.ExecQuery;
      Result := True;
    except
      Raise;
    end;
	finally
		Query.FreeAndCommit;
	end;
end;

function SaveFileToBlob( FileName, F_Name: String; SP: TpFIBStoredProc; MaxSize: Integer = 5000000 ): Boolean;
var
MS: TMemoryStream;
FileSize: Integer;
begin
  Result := True;

	If Trim( FileName ) = '' then
		SP.ParamByName( F_Name ).Clear
  else begin
		If not FileExists( FileName ) then
			raise Exception.Create( 'Путь к файлу указан неверно!' );
		MS := TMemoryStream.Create;
		try
      MS.LoadFromFile( FileName );
			MS.Position := 0;
			FileSize := MS.Size;

			If ( FileSize div 1024 ) > MaxSize then begin
				Raise
          Exception.Create( Format( 'Размер файла не может превышать %D Кбайт', [ MaxSize ]));
      end;

			SP.ParamByName( F_Name ).LoadFromStream( MS );
      Result := False;
		finally
			MS.Free;
		end;
	end
end;

procedure BodyReplaceLabel( DS: TpFIBDataSet; Query: TpFIBQuery; var BodyText: String );
var
FName: String;
begin
  if not Query.Prepared then
    Query.Prepare;
  try
    Query.ExecQuery;
  except
    raise;
  end;
  While not Query.Eof do begin
    FName := Query.FieldByName( 'MAIL_BASE_LABEL_NAME' ).AsString;
    if Assigned( DS.FindField( FName )) then begin
      BodyText :=
        StringReplace( BodyText,
          '####' + FName + '###',
          DS.FieldByName( FName ).AsString,
          [ rfReplaceAll, rfIgnoreCase ]);
    end;

    Query.Next;
  end;
end;



{ TNewQuery }

constructor TNewQuery.CreateNew(AOwner: TComponent; Tr: TFIBTransaction);
begin
  inherited Create( AOwner );
  Self.GoToFirstRecordOnExecute := True;
  Self.Database := frDM.IBDB;
  if not Assigned( Tr ) then
    Tr := frDM.IBTrRead;

  Self.Transaction := Tr;
  InTrans := Tr.InTransaction;
  if not Tr.InTransaction then
    Tr.StartTransaction;
end;

procedure TNewQuery.FreeAndCommit;
begin
  try
    Self.Close;
    If ( not InTrans ) and
       Self.Transaction.InTransaction then
      Self.Transaction.Commit;
  finally
    Self.Free;
  end;
end;

{ TDSQuery }

constructor TDSQuery.CreateNew(AOwner: TComponent; Tr: TFIBTransaction);
begin
  inherited Create( AOwner );
  Self.Database := frDM.IBDB;
  if not Assigned( Tr ) then
    Tr := frDM.IBTrRead;

  Self.Transaction := Tr;
  InTrans := Tr.InTransaction;
  if not Tr.InTransaction then
    Tr.StartTransaction;
end;

procedure TDSQuery.FreeAndCommit;
begin
  try
    Self.Close;
    If ( not InTrans ) and
       Self.Transaction.InTransaction then
      Self.Transaction.Commit;
  finally
    Self.Free;
  end;
end;

end.
