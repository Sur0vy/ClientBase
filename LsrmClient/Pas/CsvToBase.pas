{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit CsvToBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Dialogs, Vcl.Forms,
  RegSmartDlg, GridDlg, DlgParams, CustomDlg, FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, pFIBStoredProc;

type
  TLoadCsvToBase = class(TObject)
  private
    CsvFile: File;
    FileBodyText: String;
    HeaderStr: String;
    FileBody: TStringList;
    RowData: TStringList;
    CurrDelim: Char;
    ColumnCount: Integer;
    ErrorLog: String;
    procedure ReadFromFile(const FileName: String);
    procedure SetupOfColumns;
    procedure ParseCSVString(var RowTString: TStringList; const FileRowStr: string; const IsDelim, Quoted: Char);
    procedure ReadSetupParams(DLG: TSmartDlg);
    procedure DlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
    procedure SaveParamsAndImport( Sender: TObject; DLG: TSmartDlg );
    procedure SaveLinkParams( IBTr: TpFIBTransaction; RowsList: TRowsList );
    procedure SaveDataToBase( IBTr: TpFIBTransaction; DLG: TSmartDlg );
    procedure SaveSubscribeGroup( IBTr: TpFIBTransaction; GroupList: String; ClientID: Integer );
    procedure GetRowsFromCsvData(var Body: TStringList; StrValue: String; const IsDelim, Quoted: Char );
    procedure AfterShowDlg( Sender: TObject );
    procedure ErrorToLog( const StrValue: string );
  public
    constructor Create;
    destructor Destroy; override;
    class procedure GetDataFromFile( const FileName: String );
  end;

implementation

{ LoadCsvToBase }

uses
  Procs, SqlTools, ClientDM, Vcl.Controls, ConstList, pFIBDataSet, FIBDataSet;

procedure TLoadCsvToBase.AfterShowDlg(Sender: TObject);
begin
  TfrCustomDlg( Sender ).A_Save.Enabled := RowData.Count > 1;
end;

constructor TLoadCsvToBase.Create;
begin
  inherited;
  CurrDelim := ',';
  FileBody := TStringList.Create;
  FileBody.Clear;
  RowData := TStringList.Create;
  RowData.Clear;
end;

destructor TLoadCsvToBase.Destroy;
begin
  if Assigned( FileBody ) then
    FileBody.Free;
  if Assigned( RowData ) then
    RowData.Free;

  inherited;
end;

class procedure TLoadCsvToBase.GetDataFromFile(const FileName: String);
begin
  With TLoadCsvToBase.Create do
    try
      ReadFromFile( FileName );
      SetupOfColumns;
    finally
      Free;
    end;
end;

procedure TLoadCsvToBase.ParseCSVString( var RowTString: TStringList; const FileRowStr: string; const IsDelim, Quoted: Char );
var
N, L: Integer;
CellValue: string;
InQuoted: Boolean;
begin
  If not Assigned( RowTString ) then
    Exit;

  RowTString.Clear;
  L := Length( FileRowStr );
  if L = 0 then
    Exit;

  CellValue := '';
  InQuoted := False;
  N:=0;

  while N < L do begin
    Inc( N );
    if FileRowStr[ N ] = Quoted then begin
      if InQuoted and ( N < L ) and ( FileRowStr[ N + 1 ] = Quoted ) then begin
        CellValue := CellValue + '"';
        N := N + 1;
      end
      else
        InQuoted := not InQuoted;
    end
    else
    if FileRowStr[ N ] = IsDelim then begin
      if InQuoted then
        CellValue := CellValue + FileRowStr[ N ]
      else begin
        if ( CellValue <> '' ) and
           ( CellValue[ 1 ] = Quoted ) and
           ( CellValue[ length( CellValue )] = Quoted ) then
          CellValue := copy( CellValue, 2, length( CellValue ) - 2 );
        RowTString.Add( CellValue );
        InQuoted := false;
        CellValue := '';
      end;
    end
    else
      CellValue := CellValue + FileRowStr[ N ];
  end;
  RowTString.Add( CellValue );
end;

procedure TLoadCsvToBase.ReadFromFile(const FileName: String);
var
WStrBuff : WideString;
CountWideChar : Integer;
begin
  ErrorLog := IncludeTrailingPathDelimiter( ExtractFileDir( Filename )) + 'Error_' +
              ExtractFileName( FileName );
  if FileExists( ErrorLog ) then
    DeleteFile( ErrorLog );

  FileBodyText := '';
  AssignFile( CsvFile, FileName );
  try
    Reset( CsvFile, SizeOf(WideChar));  // открываю в режиме чтения по 2 байта
    CountWideChar := FileSize( CsvFile );  // длина файла в 2-х байтных блоках
    SetLength(WStrBuff, CountWideChar);
    BlockRead( CsvFile, PWideChar(WStrBuff)^, CountWideChar ); // читаем данные в строку
               // Сохраняю в переменную для дальнейшего разбора....
    FileBodyText := WideCharLenToString( PWideChar(WStrBuff), CountWideChar );
    GetRowsFromCsvData( FileBody, FileBodyText, CurrDelim, '"' );
  finally
    SetLength( WStrBuff, 0 );
    Close( CsvFile );
  end;
end;

procedure TLoadCsvToBase.GetRowsFromCsvData( var Body: TStringList; StrValue: String; const IsDelim, Quoted: Char );
var
N, L: Integer;
IsQuoted: Boolean;
begin
  if not Assigned( Body ) then
    Exit;
  Body.Clear;
  HeaderStr := '';

  try
    try
      IsQuoted := False;
      L := Length( StrValue );
      for N := 1 to L do begin
        if IsDelimiter( Quoted, StrValue, N ) then begin
          if StrValue[ N - 1 ] = IsDelim then
            IsQuoted := True;
        end
        else
        if IsDelimiter( IsDelim, StrValue, N ) then begin
          if StrValue[ N - 1 ] = Quoted then
            IsQuoted := False;
        end
        else
        if IsDelimiter( #13#10, StrValue, N ) then begin
          if IsQuoted then
            StrValue[ N ] := ' ';
        end;
      end;

    finally
      Body.Text := StrValue;
    end;
  finally
    if FileBody.Count > 0 then
      HeaderStr := FileBody.Strings[ 0 ];   // Строки заголовков выделены для диалога настройки
  end;
end;

procedure TLoadCsvToBase.SaveLinkParams(IBTr: TpFIBTransaction; RowsList: TRowsList );
const
sqlParams =
'update CSV_IMPORT_SETUP' + #13#10 +
'  set' + #13#10 +
'    FILE_COLUMN_NAME = :FILE_COLUMN_NAME' + #13#10 +
'  where' + #13#10 +
'    FIELD_NAME = :FIELD_NAME';
var
Query: TNewQuery;
N: Integer;
begin
   Query := TNewQuery.CreateNew( frDM, IBtr );
  try
    Query.SQL.Text := sqlParams;
    If not Query.Prepared then
      Query.Prepare;

    for N := 0 to RowsList.Count - 1 do begin
      if RowsList.Items[ N ].Style <> psComboBox then
        Continue;
      if AnsiSameText( RowsList.Items[ N ].FieldName, 'DelimSetup' ) then
        Continue;

      Query.ParamByName( 'FILE_COLUMN_NAME' ).AsString := RowsList.Items[ N ].RowValue;
      Query.ParamByName( 'FIELD_NAME' ).AsString := RowsList.Items[ N ].FieldName;
      try
        Query.ExecQuery;
      except
        if frDM.IBTrWrite.InTransaction then
          frDM.IBTrWrite.Rollback;
        raise;
      end;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TLoadCsvToBase.ErrorToLog( const StrValue: string );
var
FFile: TextFile;
begin
	try
		try
			AssignFile( FFile, ErrorLog );
			If FileExists( ErrorLog ) then
        Append( FFile )
      else
        Rewrite( FFile );

			Writeln( FFile, String( AnsiToUtf8( StrValue )));
		except
			//  Если не удалось записать, то значит не судьба.
		end;
	finally
		CloseFile( FFile );
	end;
end;

procedure TLoadCsvToBase.SaveDataToBase(IBTr: TpFIBTransaction; DLG: TSmartDlg );
var
N, M, Ind, FSize, ErrCount: integer;
GroupList, fldName, fldValue: String;
SP: TpFIBStoredProc;
NoExec, IsOk, NoShowMessage: Boolean;
RegDate: TDateTime;
RegPersonalID: Integer;
ColSize: array of integer;

  procedure FillDescribParam( Value: String );
  var
  CurrValue: String;
  begin
    if Value = '' then
      Exit;

    CurrValue := Trim( SP.ParamByName( 'DESCRIB_TEXT' ).AsString );
    if CurrValue = '' then
      SP.ParamByName( 'DESCRIB_TEXT' ).AsString := AnsiQuotedStr( Value, '"' )
    else
      SP.ParamByName( 'DESCRIB_TEXT' ).AsString := CurrValue + #13#10 + AnsiQuotedStr( Value, '"' );
  end;

  procedure FillMailParam( Value: String );
  var
  CurrValue: String;
  begin
    if Value = '' then
      Exit;
    Value := StringReplace( Value, '(', '', [ rfReplaceAll, rfIgnoreCase ]);
    Value := StringReplace( Value, ')', '', [ rfReplaceAll, rfIgnoreCase ]);
    Value := StringReplace( Value, '-', '', [ rfReplaceAll, rfIgnoreCase ]);
    Value := StringReplace( Value, '"', '', [ rfReplaceAll, rfIgnoreCase ]);

    CurrValue := Trim( SP.ParamByName( 'E_MAIL_LIST' ).AsString );
    if CurrValue = '' then
      SP.ParamByName( 'E_MAIL_LIST' ).AsString := Value
    else
      SP.ParamByName( 'E_MAIL_LIST' ).AsString := CurrValue + ',' + Value;
  end;

  procedure FillFirmListTitle( Value: String );
  begin
    if Value = '' then
      Exit;
    if SP.ParamByName( 'FIRM_TITLE' ).AsString = '' then
      SP.ParamByName( 'FIRM_TITLE' ).AsString := Value;
  end;

  procedure SaveColumnsLength;
  var
  N: Integer;
  begin
    SetLength( ColSize, SP.ParamCount );
    for N := 0 to SP.ParamCount - 1 do
      ColSize[ N ] := SP.Params[ N ].ServerSize;
  end;

begin
//  IsOk := False;
  NoShowMessage := False;
  ErrCount := 0;
  RegDate := Dlg.RowsList.PropByHostFieldName( 'DATE_REGISTR' ).AsDateValue;
  RegPersonalID := Dlg.RowsList.PropByHostFieldName( 'PERSONAL_TITLE' ).RowValueID;

  SP := TpFIBStoredProc.Create( frDM );
  if not IBTr.InTransaction then
    IBTr.StartTransaction;
  try
    SP.Database := frDM.IBDB;
    SP.Transaction := IBTr;
    SP.StoredProcName := 'CLIENT_LIST_IMPORT';
    if not SP.Prepared then
      SP.Prepare;
    SaveColumnsLength;

    for N := 1 to FileBody.Count - 1 do begin  // пропускаем 1-ю строку с заголовком
      GroupList := '';
      ParseCSVString( RowData, FileBody.Strings[ N ], CurrDelim, '"' );
      if RowData.Count <> ColumnCount then
        Continue;
      if not IBTr.InTransaction then
        IBTr.StartTransaction;

      SpParamsClear( SP );

      NoExec := False;

      for M := 0 to Dlg.RowsList.Count - 1 do begin
        if Dlg.RowsList.Items[ M ].Style <> psComboBox then
          Continue;
        if AnsiSameText( Dlg.RowsList.Items[ M ].FieldName, 'DelimSetup' ) then
          Continue;

        fldName := Dlg.RowsList.Items[ M ].FieldName;
        Ind := Dlg.RowsList.Items[ M ].RowValueID;
        if Ind = -1 then
          Continue;
        fldValue := Trim( RowData.Strings[ Ind ]);

        if AnsiSameText( Dlg.RowsList.Items[ M ].FieldName, 'GROUP_SUBSCRIBE' ) then begin
          GroupList := Trim( fldValue );
          Continue;
        end;

        if ( Pos( 'E_MAIL_', fldName ) = 1 ) and
             Assigned( SP.FindParam( 'E_MAIL_LIST' ))then
          FillMailParam( fldValue );

        if ( Pos( 'FIRM_TITLE', fldName ) = 1 ) and
             Assigned( SP.FindParam( 'FIRM_TITLE' ))then
          FillFirmListTitle( fldValue );


        if Assigned( SP.FindParam( fldName )) then begin
          if AnsiSameText( fldName, 'DESCRIB_TEXT' ) then
            FillDescribParam( fldValue )
          else begin
            FSize := ColSize[ SP.ParamByName( fldName ).Index ];
            if FSize < length( fldValue ) then begin
              SP.ParamByName( fldName ).AsString := Copy( fldValue, 1, FSize - 1 );
              FillDescribParam( fldValue );
            end
            else
              SP.ParamByName( fldName ).AsString := fldValue;
          end;
        end;
      end;

      if SP.ParamByName( 'E_MAIL_LIST' ).IsNull or
         ( SP.ParamByName( 'E_MAIL_LIST' ).AsString = '' ) then
        NoExec := True;

      if not NoExec then begin
        try
          SP.ParamByName( 'DATE_REGISTR' ).AsDateTime := RegDate;
          SP.ParamByName( 'REG_PERSONAL_ID' ).AsInteger := RegPersonalID;

          SP.ExecProc;
          if SP.FieldByName( 'MESS_TEXT' ).AsString <> ''  then begin
            IsOk := False;
            Inc( ErrCount );
            ErrorToLog( SP.FieldByName( 'MESS_TEXT' ).AsString );
            ErrorToLog( FileBody.Strings[ N ]);
            ErrorToLog( '' );

            TfrCustomDlg( Dlg.Owner ).SB.Panels.Items[ 2 ].Text :=
              Format( '%D строка из %D, ошибок импорта - %D', [ N, FileBody.Count, ErrCount ]);
            Application.ProcessMessages;

            if not NoShowMessage then
              Case MessageDlg( SP.FieldByName( 'MESS_TEXT' ).AsString + #13#10#13#10 +
                          '   - Нажмите "Yes" чтобы пропустить эту строку и продолжить.' + #13#10 +
                          '   - Нажмите "YesToAll" чтобы пропустить все строки с ошибками.' + #13#10 +
                          '   - Нажмите "Cancel" чтобы прекратить импорт.' + #13#10#13#10 +
                          'Вся информация об ошибках будет записана в файл "' + ErrorLog + '"', mtInformation,
                          [ mbYes, mbYesToAll, mbCancel ], 0, mbYes ) of
                mrCancel:
                  Exit;
                mrAll:
                  ;
                mrYesToAll:
                  NoShowMessage := True;
              end
            else
              Continue;
          end
          else
            IsOk := True;

          if IsOk then begin
            SaveSubscribeGroup( IBTr, GroupList, SP.FieldByName( 'RESULT_ID' ).AsInteger );
            if IBTr.InTransaction then
              IBTr.Commit;
          end
          else
            if IBTr.InTransaction then
              IBTr.Rollback;
        except
          on E: Exception do begin
//            IsOk := False;
            if IBTr.InTransaction then
              IBTr.Rollback;
            ShowMessage( E.Message );
            Exit;
          end;
        end;
      end;

      Application.ProcessMessages;
    end;
  finally
    if IBTr.InTransaction then
      IBTr.Commit;

    MessageBox( Application.Handle,
      PChar( Format( 'Готово!' + #13#10 + 'Произведен импорт %D записей из CSV файла.' + #13#10 + 'Ошибок импорта - %D',
               [ FileBody.Count, ErrCount ])),
      'Импорт данных из файла', MB_OK or MB_SYSTEMMODAL or MB_ICONINFORMATION );

    SP.Close;
    SP.Free;
  end;
end;

procedure TLoadCsvToBase.SaveParamsAndImport( Sender: TObject; DLG: TSmartDlg );
var
DlgForm: TfrCustomDlg;
begin
  DlgForm := TfrCustomDlg( Sender );

  try
    SaveLinkParams( frDM.IBTrWrite, DLG.RowsList );
    if frDM.IBTrWrite.InTransaction then
      frDM.IBTrWrite.Commit;
    SaveDataToBase( frDM.IBTrWrite, DLG );


  finally
    DlgForm.SetButtonActive( True, False );
    if frDM.IBTrWrite.InTransaction then
      frDM.IBTrWrite.Commit;
    DlgForm.Close;
  end;
end;

procedure TLoadCsvToBase.SaveSubscribeGroup(IBTr: TpFIBTransaction; GroupList: String; ClientID: Integer );
var
Group: TStringList;
SP: TpFIBStoredProc;
N: Integer;
begin
  GroupList := StringReplace( GroupList, '*', #13#10, [ rfReplaceAll, rfIgnoreCase ]);
  GroupList := StringReplace( GroupList, ':::', #13#10, [ rfReplaceAll, rfIgnoreCase ]);
  SP := TpFIBStoredProc.Create( frDM );
  Group := TStringList.Create;
  try
    if not IBTr.InTransaction then
      IBTr.StartTransaction;
    SP.Database := frDM.IBDB;
    SP.Transaction := IBTr;
    SP.StoredProcName := 'SUBSCRIBE_GROUP_NEW';
    if not SP.Prepared then
      SP.Prepare;

    Group.Text := GroupList;
    try
      for N := 0 to Group.Count - 1 do begin
        SP.Params.ClearValues;
        SP.ParamByName( 'CLIENT_LIST_ID' ).AsInteger := ClientID;
        SP.ParamByName( 'SUBSCRIBE_GROUP_TITLE' ).AsString := Trim( Group.Strings[ N ]);
        try
          SP.ExecProc;
        except
          if IBTr.InTransaction then
            IBTr.Rollback;
          raise;
        end;
      end;
    finally
      if IBTr.InTransaction then
        IBTr.CommitRetaining;
    end;
  finally
    Group.Free;
    SP.Close;
    SP.Free;
  end;
end;

procedure TLoadCsvToBase.SetupOfColumns;
const
dlmList: array [ 0..2 ] of String = ( 'Запятая', 'Точка с запятой', 'Табуляция' );
sqlPersonal =
'select' + #13#10 +
'  PERSONAL_TITLE, PERSONAL_ID as REG_PERSONAL_ID' + #13#10 +
'from PERSONAL' + #13#10 +
'where' + #13#10 +
'  IS_DELETE > 0 and IS_WORK = 1' + #13#10 +
'order by' + #13#10 +
'  PERSONAL_TITLE';

var
PropSQL: TSQLParams;
Dlg: TfrCustomDlg;
begin
  ParseCSVString( RowData, HeaderStr, ',', '"' );
  ColumnCount := RowData.Count;
  Dlg := TfrCustomDlg.Create( Application.MainForm );
  try
    Dlg.Caption := 'Настройка соответствия колонок в файле и программе';
    Dlg.OwnerForm := Application.MainForm;
    Dlg.SmartDlg.Font := Application.MainForm.Font;
    Dlg.SmartDlg.Font.Size := 12;
    Dlg.SmartDlg.OnSetEditText := DlgSetEditText;
    Dlg.OnSaveExecute := SaveParamsAndImport;
    Dlg.OnAfterFormShow := AfterShowDlg;

    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Разделитель колонок в файле';
      RowValue := 'Запятая';
      RowValueID := 0;
      FieldName := 'DelimSetup';
      Style := psComboBox;
      IsEmpty := ftNotEmpty;
      PropSQL := SQL;
      PropSQL.SqlText := ArrayToStrListText( dlmList );
      SQL := PropSQL;
    end;
    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Дата регистрации клиентов из файла';
      RowValue := FormatDateTime( 'dd.mm.yyyy', Date );
      RowValueID := -1;
      FieldName := 'DATE_REGISTR';
      Style := psDateValue;
      IsEmpty := ftNotEmpty;
    end;
    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Сотрудник на которого регистрируются клиенты';
      RowValue := CurrentManagerTitle;
      RowValueID := CurrentUserID;
      FieldName := 'PERSONAL_TITLE';
      Style := psPickList;
      IsEmpty := ftNotEmpty;
      PropSQL := SQL;
      PropSQL.KeyID := 'REG_PERSONAL_ID';
      PropSQL.Title := 'PERSONAL_TITLE';
      PropSQL.SqlText := sqlPersonal;
      SQL := PropSQL;
    end;

    With Dlg.SmartDlg.RowsList.Add do begin
      Title := 'Выберите из списка подходящую по смыслу колонку:';
      RowValue := '';
      Style := psHeader;
    end;

    ReadSetupParams( Dlg.SmartDlg );

    Dlg.SmartDlg.FillVisibleRows;

    Dlg.ShowModal;

  finally
    Dlg.Release;
  end;
end;

procedure TLoadCsvToBase.DlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
const
dlmValue: array [ 0..2 ] of Char = ( ',', ';', #9 );
var
N: Integer;
RowsList: TRowsList;
PropSQL: TSQLParams;
begin
  if not IsChange then
    Exit;

  if AnsiSameText( CurrItem.FieldName, 'DelimSetup' ) and
     ( CurrItem.RowValueID <> -1 ) then begin
    CurrDelim := dlmValue[ CurrItem.RowValueID ];
    GetRowsFromCsvData( FileBody, FileBodyText, CurrDelim, '"' );
    ParseCSVString( RowData, HeaderStr, CurrDelim, '"' );

    RowsList := TSmartDlg( Dlg ).RowsList;
    for N := 0 to RowsList.Count - 1 do begin
      if RowsList.Items[ N ].Style <> psComboBox then
        Continue;
      if AnsiSameText( RowsList.Items[ N ].FieldName, 'DelimSetup' ) then
        Continue;

      PropSQL := RowsList.Items[ N ].SQL;
      if RowData.Count <= 1 then
        PropSQL.SqlText := ''
      else
        PropSQL.SqlText := RowData.Text;

      RowsList.Items[ N ].SQL := PropSQL;
    end;
  end;

  AfterShowDlg( TSmartDlg( Dlg ).Owner );
end;

procedure TLoadCsvToBase.ReadSetupParams( DLG: TSmartDlg );
const
sqlParams =
'select' + #13#10 +
'  FIELD_NAME, ORDER_BY, FIELD_CAPTION, FILE_COLUMN_NAME, IS_NO_EMPTY' + #13#10 +
'from CSV_IMPORT_SETUP' + #13#10 +
'where' + #13#10 +
'  ORDER_BY > 0' + #13#10 +
'order by' + #13#10 +
'  ORDER_BY';

var
Query: TNewQuery;
PropSQL: TSQLParams;
FindInd: Integer;
ColumnName: String;
begin
  Query := TNewQuery.CreateNew( frDM, nil );
  try
    Query.SQL.Text := sqlParams;
    If not Query.Prepared then
      Query.Prepare;
    try
      Query.ExecQuery;
    except
      raise;

    end;
    While not Query.Eof do begin
      ColumnName := Query.FieldByName( 'FILE_COLUMN_NAME' ).AsString;
      FindInd := RowData.IndexOf( ColumnName );
      With Dlg.RowsList.Add do begin
        Title := Query.FieldByName( 'FIELD_CAPTION' ).AsString;
        IsEmpty := TFillerType( Query.FieldByName( 'IS_NO_EMPTY' ).AsInteger );

        if FindInd = -1 then begin
          RowValue := '';
          RowValueID := -1;
        end
        else begin
          RowValue := ColumnName;
          RowValueID := FindInd;
        end;

        FieldName := Query.FieldByName( 'FIELD_NAME' ).AsString;
        Style := psComboBox;
        PropSQL := SQL;
        PropSQL.SqlText := RowData.Text;
        SQL := PropSQL;
      end;


      Query.Next;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;

end.
