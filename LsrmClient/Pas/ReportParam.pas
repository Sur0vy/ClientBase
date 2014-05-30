{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ReportParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, frxClass, pFIBDatabase, pFIBQuery, frxFIBComponents, DlgParams, SqlTools, ConstList;

type
	TParamOfReport = record
		ParamName: String;
		Value: Variant;
		Style: TPropertyStyle;
	end;
	TParamsOfReport = array of TParamOfReport;

  TReportExist = ( reExcelReport, reFrxReport, reSaveReport );
  TReportExists = set of TReportExist;

	TCreateFiltredSQL = function( frxRep: TfrxReport ): Boolean of Object;

  TSetSQLParams = procedure ( Q_Inside: TObject ) of Object;
  TFiltredInsideSQL = procedure ( var Q_Inside: TfrxFIBQuery; const OriginSQLText: String) of Object;

  procedure LoadReportFromDB( frxRep: TfrxReport; const KeyValue: Integer; IBTr_R: TpFIBTransaction );
  procedure PrintReport(const IndReport: Integer; Title: String;	ParamList: TParamsOfReport; FiltredSQL: TCreateFiltredSQL; IsModal: Boolean );
  function PrintDocument( Sender: TComponent; const IndReport: Integer; Title: String;
                          ParamName, InputParams: TArrayVariant; repOption: Integer;
                          const SetSQLParams: TSetSQLParams = nil;
                          const FiltredSQL: TFiltredInsideSQL = nil;
                          const CheckPrinter: String = ''; frxRep: TfrxReport = nil ): Boolean;


implementation

uses
  FIBQuery, fib, frxPreview, Procs, Prima, ClientDM;


Procedure GetPeriodValue( frxRep: TfrxReport );
var
Period: String;
D_Min, D_Max: TDateTime;
begin
	Period := '';
	try
		if VarIsNull( frxRep.Variables[ 'DATE_START' ]) or
			 VarIsNull( frxRep.Variables[ 'DATE_END' ]) then
																										Exit;

		D_Min := VarToDateTime( frxRep.Variables[ 'DATE_START' ]);
		D_Max := VarToDateTime( frxRep.Variables[ 'DATE_END' ]);
		Period :=
			 Concat( 'за период с ', FormatDateTime( 'dd.mm.yyyyг', D_Min ),
							 ' по ', FormatDateTime( 'dd.mm.yyyyг', D_Max )  );
	finally
		frxRep.Variables[ 'PERIOD' ] := QuotedStr( Period );
  end;
end;

function PrintDocument( Sender: TComponent; const IndReport: Integer; Title: String;	ParamName, InputParams: TArrayVariant; repOption: Integer;
                        const SetSQLParams: TSetSQLParams = nil;
                        const FiltredSQL: TFiltredInsideSQL = nil;
                        const CheckPrinter: String = ''; frxRep: TfrxReport = nil ): Boolean;
var
Q_Inside: TfrxFIBQuery;
N: Integer;
IsModal, ShowPreview: Boolean;
ParName, LookupParName: String;
CurrStyle: TPropertyStyle;
//IsTape: Boolean;

	procedure LoadFromDB;
	const
	FrSQL =
    'SELECT FAST_REPORT, IS_TAPE_PRINT FROM REPORT_LIST where REPORT_LIST_ID = %D';
	var
	St: TMemoryStream;
	Q_Fr: TNewQuery;
	begin
    if Not Assigned( frxRep ) then
		  frxRep := TfrxReport.Create( frPrima );
		St := TMemoryStream.Create;
		Q_Fr := TNewQuery.CreateNew( frDM, nil );
		try
			Q_Fr.SQL.Text := Format( FrSQL, [ IndReport ] );
			try
				Q_Fr.ExecQuery;
			except
				Raise;
			end;
//      IsTape := Q_Fr.FieldByName( 'IS_TAPE_PRINT' ).AsInteger = 1;
			Q_Fr.FieldByName( 'FAST_REPORT' ).SaveToStream( St );
			St.Position := 0;
			frxRep.Clear;
      frxRep.ShowProgress := ShowPreview;
			frxRep.LoadFromStream( St );
      frxRep.OnClosePreview := frDM.frxRepClosePreview;
      frxRep.OnEndDoc := frDM.frxRepEndDoc;
      frxRep.OnBeginDoc := frDM.frxRepBeginDoc;
      frxRep.PrintOptions.Printer := CheckPrinter;
		finally
			St.Free;
			Q_Fr.FreeAndCommit;
		end;
	end;

begin
  Result := False;
	If ( IndReport = -1 ) or
     ( Length( ParamName ) <> Length( InputParams )) then
    Exit;
	Screen.Cursor := crSQLWait;
  IsModal     := repOption and prIsModal = prIsModal;
  ShowPreview := repOption and prPreview = prPreview;
	try
		LoadFromDB;
		Q_Inside := TfrxFIBQuery( frxRep.FindObject( 'Q_Rep' ));
		If not Assigned( Q_Inside ) then
			Exit;
		Q_Inside.Database.Connected := False;
		try
      Q_Inside.Database.Database.LibraryName := frDM.IBDB.LibraryName;
			Q_Inside.Database.DatabaseName := frDM.IBDB.DBName;
			Q_Inside.Database.SQLDialect := frDM.IBDB.SQLDialect;
			Q_Inside.Database.LoginPrompt := False;
			Q_Inside.Database.Params.Clear;
			Q_Inside.Database.Params.AddStrings( frDM.IBDB.DBParams );
		except
			Raise;
		end;

    If Assigned( SetSQLParams ) then
      SetSQLParams( Q_Inside );
    If Assigned( FiltredSQL ) then
      FiltredSQL( Q_Inside, Q_Inside.SQL.Text );  

		For N := 0 to High( InputParams ) do begin
      if VarIsNull( ParamName[ N ]) or
         VarIsNull( InputParams[ N ]) then
        Continue;

      If VarIsArray( ParamName[ N ]) then begin
        ParName := VarAsType( ParamName[ N ][ 1 ], varString );
        LookupParName := VarAsType( ParamName[ N ][ 2 ], varString );
        CurrStyle := TPropertyStyle( VarAsType( ParamName[ N ][ 0 ], varInteger ));

        Case CurrStyle of
          psPickList: begin
            With frxRep.Variables.Add do
              Name := LookupParName;
            frxRep.Variables[ LookupParName ] := InputParams[ N ][ 1 ];
            frxRep.Variables[ ParName ]       := InputParams[ N ][ 0 ];
            If Assigned( Q_Inside.Params.Find( LookupParName )) then
              Q_Inside.ParamByName( LookupParName ).Value := InputParams[ N ][ 1 ];
          end;
          psBoolean, psComboBox: begin
            frxRep.Variables[ ParName ]       := InputParams[ N ][ 1 ];
            If Assigned( Q_Inside.Params.Find( ParName )) then
              Q_Inside.ParamByName( ParName ).Value := InputParams[ N ][ 1 ];
          end;

          psSimpleText, psPickListInput: begin
            frxRep.Variables[ ParName ]       := InputParams[ N ][ 0 ];
            If Assigned( Q_Inside.Params.Find( ParName )) then
              Q_Inside.ParamByName( ParName ).Value := InputParams[ N ][ 0 ];
          end;

          psDateValue: begin
            frxRep.Variables[ ParName ]     := StrToDate( InputParams[ N ][ 0 ] );
            If Assigned( Q_Inside.Params.Find( ParName )) then
              Q_Inside.ParamByName( ParName ).Value := StrToDate( InputParams[ N ][ 0 ] );
          end;

//          geTimeValue: begin
//            frxRep.Variables[ ParName ]     := StrToTime( InputParams[ N ][ 0 ] );
//            If Assigned( Q_Inside.Params.Find( ParName )) then
//              Q_Inside.ParamByName( ParName ).Value := StrToTime( InputParams[ N ][ 0 ] );
//          end;

          psInteger, psNumeric: begin
            frxRep.Variables[ ParName ]     := StrSeparatorDelete( InputParams[ N ][ 0 ] );
            If Assigned( Q_Inside.Params.Find( ParName )) then
              Q_Inside.ParamByName( ParName ).Value := StrSeparatorDelete( InputParams[ N ][ 0 ] );
          end;
          psMultySelect: begin
            frxRep.Variables[ ParName ]       := InputParams[ N ][ 0 ];
            frxRep.Variables[ LookupParName ] := InputParams[ N ][ 2 ];
          end

          else
            frxRep.Variables[ ParName ] := InputParams[ N ][ 0 ];
        end;
      end   // If VarIsArray( ParamName[ N ]) then
      else begin
        ParName := VarAsType( ParamName[ N ], varString );
        If Assigned( Q_Inside.Params.Find( ParName )) then
          Q_Inside.ParamByName( ParName ).Value := InputParams[ N ];
        frxRep.Variables[ ParName ] := InputParams[ N ];
      end;
    end;
    GetPeriodValue( frxRep );

    if CheckPrinter = '' then begin
      frxRep.PrintOptions.Printer := WorkDocsPrinter.DocPrinterName;
    end
    else
      frxRep.PrintOptions.Printer := CheckPrinter;

		frxRep.ReportOptions.Description.Text := Title;
    frxRep.Variables[ 'R_TITLE' ] := QuotedStr( Title );

		frxRep.PreviewOptions.Modal := IsModal;
		frxRep.PreviewOptions.MDIChild := not IsModal;
		frxRep.PreviewOptions.Maximized := not IsModal;

    frxRep.ShowProgress := repOption and prShowProgress = prShowProgress;
    frxRep.PrintOptions.ShowDialog := repOption and prShowPrintDialog = prShowPrintDialog;
    If frxRep.PrepareReport then
      case ShowPreview of
        True: begin
          frxRep.ShowPreparedReport;
          Result := True;
        end
        else
          Result := frxRep.Print;
      end;

	finally
    Screen.Cursor := crDefault;
	end;
end;

procedure LoadReportFromDB( frxRep: TfrxReport; const KeyValue: Integer; IBTr_R: TpFIBTransaction );
const
SQL_ReportParam =
		'SELECT REPORT_LIST_ID, FAST_REPORT, SQL_TEXT, IS_FAST_REPORT, IS_EXCEL_REPORT FROM GET_REPORT_PARAMS(%D)';
var
Query: TpFIBQuery;

	procedure SaveSqlToBase( SelectSQLText: String );
	const
	SQL_UpdateSQLText = ' update REPORT_LIST' +
											'   set SQL_TEXT = :SQL_TEXT ' +
											'   where REPORT_LIST_ID = %D';
	var
	QSave: TNewQuery;
	begin
    If not AnsiSameText( CurrentUserLogin, 'SYSDBA' ) then
      Exit;

		QSave := TNewQuery.CreateNew( Application, frDM.IBTrWrite );
		try
			QSave.SQL.Text := Format( SQL_UpdateSQLText, [ KeyValue ] );
			If not QSave.Prepared then
															QSave.Prepare;
			try
				QSave.ParamByName( 'SQL_TEXT' ).AsString := SelectSQLText;
				QSave.ExecQuery;
			except
				Raise;
			end;
		finally
			If QSave.Transaction.InTransaction then
				QSave.Transaction.Commit;
			QSave.Close;
			QSave.FreeAndCommit;
		end;
	end;

	procedure LoadFromDB;
	var
	St: TMemoryStream;
	begin
		St := TMemoryStream.Create;
		try
			If Query.FieldByName( 'FAST_REPORT' ).IsNull then
																										 Exit;
			Query.FieldByName( 'FAST_REPORT' ).SaveToStream( St );
			St.Position := 0;
			frxRep.Clear;
			frxRep.LoadFromStream( St );
		finally
			St.Free;
		end;
	end;

begin
	Query := TpFIBQuery.Create( IBTr_R.Owner );

  try
    If not IBTr_R.InTransaction then
																	IBTr_R.StartTransaction;
		Query.Database := TpFIBDatabase( IBTr_R.DefaultDatabase );
		Query.Transaction := IBTr_R;
		Query.SQL.Text := Format( SQL_ReportParam, [ KeyValue ] );
    try
		  Query.ExecQuery;
    except
      raise;
    end;
    SaveSqlToBase( Query.FN( 'SQL_TEXT' ).AsString );
		LoadFromDB;
    
  finally
    Query.Close;
    If IBTr_R.InTransaction then
                              IBTr_R.Commit;
    Query.Free;
  end;
end;

procedure PrintReport(const IndReport: Integer; Title: String; ParamList: TParamsOfReport; FiltredSQL: TCreateFiltredSQL; IsModal: Boolean);
var
frxRep: TfrxReport;
N: Integer;
begin
	If IndReport = -1 then
											Exit;

	Screen.Cursor := crSQLWait;
	frxRep := TfrxReport.Create( frDM );
	try
		try
			frxRep.Variables.Clear;
			frxRep.PreviewOptions.ZoomMode := zmPageWidth;
			frxRep.EngineOptions.PrintIfEmpty := False;
			frxRep.OnClosePreview := frDM.frxRepClosePreview;
			frxRep.PreviewOptions.Buttons :=
				 [pbPrint,pbLoad,pbSave,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator,pbExportQuick,pbNoEmail];

      LoadReportFromDB( frxRep, IndReport, frDM.IBTrRead );

			if Assigned( FiltredSQL ) then
				if not FiltredSQL( frxRep ) then
        Exit;

			For N := 0 to High( ParamList ) do
				frxRep.Variables[ ParamList[ N ].ParamName ] := ParamList[ N ].Value;

			frxRep.ReportOptions.Description.Text := Title;
			frxRep.Variables[ 'REPORT_TITLE' ] := Title;

			GetPeriodValue( frxRep );

			frxRep.PreviewOptions.Modal := IsModal;
			frxRep.PreviewOptions.MDIChild := not IsModal;
			frxRep.PreviewOptions.Maximized := not IsModal;

			If frxRep.PrepareReport then
				frxRep.ShowPreparedReport;
		except
			On E: Exception do begin
				raise Exception.Create( E.Message + #13#10#13#10 +
																frxRep.Errors.Text );
			end;
		end;
	finally
		Screen.Cursor := crDefault;
	end;
end;


end.
