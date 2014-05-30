{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ReportFiltr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FiltrDlg, Vcl.ExtCtrls, DlgExecute, RegSmartDlg, Vcl.ActnList, Vcl.ComCtrls,
  Vcl.ToolWin, GridDlg, CustomDlg, Vcl.Menus, frxClass, frxExportCSV, frxExportRTF, frxExportPDF, frxExportXML,
  frxExportXLS, frxGradient, frxRich, frxOLE, frxBarcode, ReportParam, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup,
  AddActions, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TfrReportFiltr = class(TfrCustomDlg)
    frxBarCodeObj: TfrxBarCodeObject;
    frxOLEObj: TfrxOLEObject;
    frxRichObj: TfrxRichObject;
    frxGradientObj: TfrxGradientObject;
    frxXLSExp: TfrxXLSExport;
    frxXMLExp: TfrxXMLExport;
    frxPDFExp: TfrxPDFExport;
    frxRTFExp: TfrxRTFExport;
    frxCSVExp: TfrxCSVExport;
    procedure A_SaveExecute(Sender: TObject); override;
    procedure ShowPreparedReport( const ReportData, CurrPrinter: String; IsTape: Boolean; frxRep: TfrxReport = nil );
  private
    { Private declarations }
    procedure SaveLastParamValue;
  public
    { Public declarations }
    class procedure ShowReportFiltr( RepMenu: TMenuItem);

  end;



implementation

{$R *.dfm}

uses Prima, DlgParams, ClientDM, ConstList, Procs, SqlTools;

class procedure TfrReportFiltr.ShowReportFiltr(RepMenu: TMenuItem);
var
Dlg: TfrReportFiltr;
begin
  Dlg := TfrReportFiltr.Create( Application );
  with Dlg do
    try
      Dlg.Caption := RepMenu.Caption;
      OwnerForm := frPrima;
      DLG.SmartDlg.TypeDialog := isReport;
      dlgFillRows.DlgIdent := RepMenu.Tag;
      dlgFillRows.PrimaryKeyValue := -1;

      dlgFillRows.FillDlgParams( dlgFillRows.DlgIdent, [ -1, -1, -1, -1 ] );

      if SmartDlg.RowsList.Count > 0 then
        ShowModal
      else
        A_SaveExecute( A_Save );
    finally
      Dlg.Release;
    end;
end;

procedure TfrReportFiltr.A_SaveExecute(Sender: TObject);
var
NoClose: Boolean;
N, L: Integer;
ParamName, InputParams: TArrayVariant;
Prop: TPropertyItem;
CurrPrinter: String;
begin
	If not ( A_Save.Enabled and A_Save.Visible ) then
		Exit;

  inherited;
  try
    NoClose := False;
    SmartDlg.UpdateEditText;
    Screen.Cursor := crSQLWait;
    Application.ProcessMessages;

    L := 0;
    SetLength( ParamName, L );
    SetLength( InputParams, L );
    CurrPrinter := WorkDocsPrinter.DocPrinterName;
    try
      Application.ProcessMessages;
      for N := 0 to SmartDlg.RowsList.Count - 1 do begin
        Prop := SmartDlg.RowsList.Items[ N ];

        NoClose := CheckIsNoEmpty;
        If NoClose then
          Exit;

        If ( Prop.Style = psHeader ) or
           ( Trim( Prop.FieldName ) = '' ) or
           ( Prop.RowValue = '' ) then
          Continue;

        if AnsiSameText( Trim( Prop.FieldName ), 'PRINT_TITLE' )  then
          CurrPrinter := Prop.RowValue;


        Inc( L );
        SetLength( ParamName, L );
        SetLength( InputParams, L );

        Case Prop.Style of
          psPickList, psBoolean, psComboBox, psSimpleText, psPickListInput: begin
            ParamName[ L - 1 ] := VarArrayOf([ Prop.Style, Prop.FieldName, Prop.SQL.KeyID ]);
            InputParams[ L - 1 ] := VarArrayOf([ QuotedStr( Prop.RowValue ), Prop.RowValueID, '' ]);
          end;

          psDateValue: begin
            ParamName[ L - 1 ] := VarArrayOf([ Prop.Style,  Prop.FieldName, '' ]);
            InputParams[ L - 1 ] := VarArrayOf([ StrToDate( Prop.RowValue ), Prop.RowValueID, '' ]);
          end;

          psInteger, psNumeric: begin
            ParamName[ L - 1 ] := VarArrayOf([ Prop.Style, Prop.FieldName, '' ]);
            InputParams[ L - 1 ] := VarArrayOf([ StrSeparatorDelete( Prop.RowValue ), -1, '' ]);
          end;

          psMultySelect: begin
            ParamName[ L - 1 ] := VarArrayOf([ Prop.Style, Prop.FieldName, Prop.SQL.KeyID ]);
            InputParams[ L - 1 ] := VarArrayOf([ QuotedStr( Prop.RowValue ), Prop.RowValueID, QuotedStr( Prop.CheckListID ) ]);
          end

        end;
      end;

      NoClose :=
        not PrintDocument( Self, Self.dlgFillRows.DlgIdent,
                           Self.Caption, ParamName, InputParams,
                           prShowPrintDialog or prPreview{ or prIsModal},
                           nil, nil, CurrPrinter, nil );

    finally
      Screen.Cursor := crDefault;
      If not NoClose then begin
        SaveLastParamValue;
        Self.Close;
        Self.ModalResult := mrOK;
      end;
    end;
  finally
    TmSave.Enabled := True;
  end;
end;

procedure TfrReportFiltr.ShowPreparedReport( const ReportData, CurrPrinter: String; IsTape: Boolean; frxRep: TfrxReport = nil );
var
St: TStringStream;
begin
  frxRep.OnClosePreview := frDM.frxRepClosePreview;

  if CurrPrinter <> '' then
    frxRep.PrintOptions.Printer := CurrPrinter
  else begin
    frxRep.PrintOptions.Printer := WorkDocsPrinter.DocPrinterName;
  end;

  if frxRep.PrintOptions.Printer = '' then
    frxRep.PrintOptions.Printer := WorkDocsPrinter.DefPrinter;

  frxRep.PreviewOptions.Modal := False;
  frxRep.PreviewOptions.MDIChild := True;
  frxRep.PreviewOptions.Maximized := True;
  frxRep.ShowProgress := True;
  frxRep.PrintOptions.ShowDialog := WorkDocsPrinter.ShowPrintSetup;


  St := TStringStream.Create;
  try
    St.Clear;
    St.WriteString( ReportData );
    St.Seek( 0, soBeginning );
    frxRep.PreviewPages.LoadFromStream( St );
    frxRep.ReportOptions.Description.Text := Self.Caption;
  finally
    St.Free;
  end;
  if WorkDocsPrinter.ShowPreview then
    frxRep.ShowPreparedReport
  else
    frxRep.Print;
end;

procedure TfrReportFiltr.SaveLastParamValue;
var
N: Integer;
Prop: TPropertyItem;
Params: OleVariant;
begin
  Params := VarArrayCreate([ 0, SmartDlg.RowsList.Count - 1 ], varVariant );

  for N := 0 to SmartDlg.RowsList.Count - 1 do begin
    Prop := SmartDlg.RowsList.Items[ N ];

    If ( Prop.Style = psHeader ) or
       ( Trim( Prop.FieldName ) = '' ) or
       ( Prop.RowValue = '' ) then
      Continue;

      Params[ N ] := VarArrayOf([ CurrentUserID, dlgFillRows.DlgIdent, Prop.PrKeyID,
                                  Prop.RowValue, Prop.RowValueID, Prop.CheckListID ]);
  end;
end;


end.
