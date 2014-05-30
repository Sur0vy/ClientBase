{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit EMailPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomDlg, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ActnPopup,
  Vcl.ExtCtrls, DlgExecute, RegSmartDlg, AddActions, Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, GridDlg,
  Vcl.ComCtrls, Vcl.OleCtrls, SHDocVw, DlgParams, RecordEdit, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery,
  pFIBStoredProc, ConstList, Data.DB, FIBDataSet, pFIBDataSet;

type
  TfrEMailPreview = class(TfrRecordEdit)
    SpPreview: TSplitter;
    WB: TWebBrowser;
    Q_Label: TpFIBQuery;
    Q_Preview: TpFIBDataSet;
    tmShow: TTimer;
    procedure SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
    function dlgFillRowsGetLookupFieldValue(Sender: TObject; DialogID: Integer; const FieldName: string; var ResValue: Variant): Boolean;
    procedure FormShow(Sender: TObject);
    procedure Q_PreviewBeforeOpen(DataSet: TDataSet);
    procedure tmShowTimer(Sender: TObject);
  private
    procedure ShowPreview( RowValueID: Integer );
    { Private declarations }
  public
    { Public declarations }
    hFileName: String;
  end;


implementation

{$R *.dfm}

uses SqlTools, ClientDM, mshtml, ActiveX;

function TfrEMailPreview.dlgFillRowsGetLookupFieldValue(Sender: TObject; DialogID: Integer; const FieldName: string;
  var ResValue: Variant): Boolean;
const
sqlSubGroup =
'select' + #13#10 +
'  SUBSCRIBE_GROUP_ID' + #13#10 +
'from SUBSCRIBE_LIST' + #13#10 +
'where' + #13#10 +
'  SUBSCRIBE_LIST_ID = :ID';
begin
  inherited;
  Result := False;
  ResValue := -1;
  try
    if not AnsiSameText( FieldName, 'SUBSCRIBE_GROUP_ID' ) then
      Exit;
    if DialogID <> dlgMailPreview then
      Exit;
    ResValue := GetQueryIntField( sqlSubGroup, FieldName, [ dlgFillRows.PrimaryKeyValue ], frDM.IBTrRead );
  finally
    Result := ResValue <> -1;
  end;
end;

procedure TfrEMailPreview.FormShow(Sender: TObject);
var
Item: TPropertyItem;
begin
  inherited;
  SmartDlg.SetRowSelected( 'E_MAIL' );

  A_Save.Visible := False;
  Self.Width := ( OwnerForm.ClientWidth * 3 ) div 4;
  Self.Height := ( OwnerForm.ClientHeight * 3 ) div 4;
  Item := SmartDlg.RowsList.PropByHostFieldName( 'E_MAIL' );
  if Assigned( Item ) then
    ShowPreview( Item.RowValueID );
end;

procedure TfrEMailPreview.Q_PreviewBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if not frDM.IBTrRead.InTransaction then
    frDM.IBTrRead.StartTransaction;
end;

procedure TfrEMailPreview.ShowPreview( RowValueID: Integer );
var
SS: TStringList;
BodyValue, PrevFileName: string;
begin
  PrevFileName := IncludeTrailingPathDelimiter( ExtractFileDir( hFileName )) + 'Prev_' + ExtractFileName( hFileName );
  Q_Preview.Close;
  Q_Label.Close;
  try
    Q_Preview.ParamByName('SUBSCRIBE_LIST_ID').AsInteger := dlgFillRows.PrimaryKeyValue;
    Q_Preview.ParamByName('CLIENTS_MAIL_LIST_ID').AsInteger := RowValueID;
    try
      Q_Preview.Open;
    except
      raise ;
    end;
    if not Q_Preview.IsEmpty then begin
      try
        SS := TStringList.Create;
        try
          SS.LoadFromFile( hFileName );
          BodyValue := SS.Text;
          BodyReplaceLabel( Q_Preview, Q_Label, BodyValue );
          SS.Clear;
          SS.Text := BodyValue;
          SS.SaveToFile( PrevFileName );
        finally
          SS.Free;
        end;
      finally
        Application.ProcessMessages;
        WB.Navigate2( PrevFileName );
      end;
    end;
  finally
    Q_Preview.Close;
  end;
end;

procedure TfrEMailPreview.SmartDlgSetEditText(Dlg: TObject; CurrItem: TPropertyItem; IsChange: Boolean);
begin
  inherited;
  if not IsChange then
    Exit;
  if not AnsiSameText( CurrItem.FieldName, 'E_MAIL' ) then
    Exit;

  tmShow.Enabled := False;
  tmShow.Tag := CurrItem.RowValueID;
  tmShow.Enabled := True;
end;

procedure TfrEMailPreview.tmShowTimer(Sender: TObject);
begin
  inherited;
  tmShow.Enabled := False;
  ShowPreview( tmShow.Tag );
end;

end.
