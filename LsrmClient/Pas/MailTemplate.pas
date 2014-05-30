{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit MailTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSprav, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet, pFIBDataSet,
  PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls, DlgParams, DlgExecute,
  Vcl.OleCtrls, SHDocVw, pFIBDatabase, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TfrMailTemplate = class(TfrCustomSprav)
    spWeb: TSplitter;
    WB: TWebBrowser;
    A_HostTemplateEdit: TAction;
    procedure FormCreate(Sender: TObject);
    procedure DataSetAfterScroll(DataSet: TDataSet);
    procedure SetIsUseDefaultValue(Sender: TObject; var Item: TPropertyItem); override;
    procedure Q_HostAfterOpen(DataSet: TDataSet);
    procedure Q_HostEndScroll(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure Q_HostAfterRefresh(DataSet: TDataSet);
    procedure A_SpravNewExecute(Sender: TObject);
    procedure A_HostTemplateEditExecute(Sender: TObject);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject); override;
    procedure FillHostSqlText( var HostSQL: String; const QuerySQL: String ); override;
  private
    { Private declarations }
    HtmlTemp: String;
    HtmlFileName: String;
    procedure SaveHtmlTextToTemp( NewRecord: Boolean );
    procedure SaveHtmlTextToBase( IBTr: TpFIBTransaction; FileName, TextBody: String; PrKeyValue: Integer );
    procedure SaveImagesToBase(FileName: String; ImageID: Integer );
  public
    { Public declarations }
     //
  end;



implementation

{$R *.dfm}

uses
  Prima, SqlTools, ClientDM, DlgSubscribeEdit, Math, ConstList, SqlTxtRtns;


procedure TfrMailTemplate.A_HostTemplateEditExecute(Sender: TObject);
begin
  inherited;
  if not ( A_HostTemplateEdit.Visible and A_HostTemplateEdit.Enabled ) then
    Exit;
  ShowSpravDlg( spHostMailTemplate, sdEdit, A_HostTemplateEdit );
end;

procedure TfrMailTemplate.A_SpravNewExecute(Sender: TObject);
begin
  SaveHtmlTextToTemp( True );
  inherited;
end;

procedure TfrMailTemplate.DataSetAfterScroll(DataSet: TDataSet);
begin
  inherited;
  Q_Host.Refresh;
end;

procedure TfrMailTemplate.FillHostSqlText(var HostSQL: String; const QuerySQL: String);
begin
  inherited FillHostSqlText( HostSQL, QuerySQL );
  HostSQL := AddToWhereClause( QuerySQL, '(MAIL_TEMPLATE_ID <> 1)' );
end;

procedure TfrMailTemplate.FormActivate(Sender: TObject);
begin
  inherited;
  with frPrima do
    AddInMainMenu( M_Transact, frPrima.PM, A_SpravDelete, [ A_Sp, A_HostTemplateEdit ]);
end;

procedure TfrMailTemplate.FormCreate(Sender: TObject);
begin
  inherited;
  DlgClass := TfrDlgSubscribeEdit;
  HtmlTemp := IncludeTrailingPathDelimiter( frPrima.TempDir ) + 'Html\';
  ForceDirectories( HtmlTemp );
end;

procedure TfrMailTemplate.FormResize(Sender: TObject);
begin
  inherited;
  dbgHost.Width := ClientWidth div 2;
end;

procedure TfrMailTemplate.Q_HostAfterOpen(DataSet: TDataSet);
begin
  inherited;
  Q_HostAfterScroll( DataSet );
  Q_HostEndScroll( DataSet );
end;

procedure TfrMailTemplate.Q_HostAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  Q_HostAfterScroll( DataSet );
  WB.Refresh2;
end;

procedure TfrMailTemplate.Q_HostAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_HostTemplateEdit.Enabled := A_SpravEdit.Enabled;
  A_HostTemplateEdit.Visible := A_SpravEdit.Visible;
end;

procedure TfrMailTemplate.Q_HostEndScroll(DataSet: TDataSet);
begin
  inherited;
  try
    SaveHtmlTextToTemp( False );
  finally
    WB.Navigate2( HtmlFileName );
  end;
end;

procedure TfrMailTemplate.SaveHtmlTextToBase( IBTr: TpFIBTransaction; FileName, TextBody: String; PrKeyValue: Integer );
const
sqlSave =
'update MAIL_TEMPLATE' + #13#10 +
'set' + #13#10 +
'  TEMPLATE_TEXT = :TEMPLATE_TEXT' + #13#10 +
'where' + #13#10 +
'  MAIL_TEMPLATE_ID = :MAIL_TEMPLATE_ID';
var
Query: TNewQuery;
SL: TStringList;
begin
  Query := TNewQuery.CreateNew( frDM, IBTr );
  SL := TStringList.Create;
  try
    try
      Query.SQL.Text := sqlSave;
      if not Query.Prepared then
        Query.Prepare;

      SL.LoadFromFile( HtmlFileName );
      Query.ParamByName( 'MAIL_TEMPLATE_ID' ).AsInteger := PrKeyValue;
      Query.ParamByName( 'TEMPLATE_TEXT' ).AsString := SetRelativePath( SL.Text );

      try
        Query.ExecQuery;
      except
        raise;
      end;
    finally
      Q_Host.Refresh;
      Query.FreeAndCommit;
    end;
  finally
    SL.Free;
  end;
end;

procedure TfrMailTemplate.SaveImagesToBase( FileName: String; ImageID: Integer );
const
sqlSave =
'execute procedure FILE_IMAGES_IUD(' + #13#10 +
' :ACTION_TYPE, :FILE_IMAGES_ID, :FILE_IMAGES_NAME, null, :FILE_IMAGES_BODY, :MAIL_TEMPLATE_ID, null, :IS_USE )';
sqlGet =
'select FILE_IMAGES_BODY from FILE_IMAGES where FILE_IMAGES_ID = :FILE_IMAGES_ID';
var
Query: TNewQuery;
begin
  Query := TNewQuery.CreateNew( frDM, frDM.IBTrWrite );
  try
    case ImageID of
      -1:
        Query.SQL.Text := sqlSave;
      else
        Query.SQL.Text := sqlGet;
    end;

    if not Query.Prepared then
      Query.Prepare;

    if ImageID = -1 then begin
      Query.ParamByName( 'ACTION_TYPE' ).AsString := 'INS';
      Query.ParamByName( 'FILE_IMAGES_ID' ).AsInteger := -1;
      Query.ParamByName( 'FILE_IMAGES_NAME' ).AsString := ExtractFileName( FileName );
      Query.ParamByName( 'FILE_IMAGES_BODY' ).LoadFromFile( FileName );
      Query.ParamByName( 'MAIL_TEMPLATE_ID' ).AsInteger := Q_Host.FBN( 'MAIL_TEMPLATE_ID' ).AsInteger;
      Query.ParamByName( 'IS_USE' ).AsInteger := 1;
    end
    else begin
      Query.ParamByName( 'FILE_IMAGES_ID' ).AsInteger := ImageID;
    end;

    try
      case ImageID of
       -1:
         Query.ExecProc;
       else begin
         Query.ExecQuery;
         Query.FieldByName( 'FILE_IMAGES_BODY' ).SaveToFile( FileName );
       end;
      end;
    except
      raise;
    end;
  finally
    Q_Host.Refresh;
    Query.FreeAndCommit;
  end;
end;

procedure TfrMailTemplate.SetIsUseDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  inherited;
  With TfrDlgSubscribeEdit( Sender ) do begin
    hFileName := Self.HtmlFileName;
    OnSaveHtmlTextToBase := Self.SaveHtmlTextToBase;
    OnImagesToBase := Self.SaveImagesToBase;
  end;
end;

procedure TfrMailTemplate.SaveHtmlTextToTemp( NewRecord: Boolean );
const
sqlFiles =
'select' + #13#10 +
'  F.FILE_IMAGES_NAME, F.FILE_IMAGES_BODY' + #13#10 +
'from FILE_IMAGES_TEMPLATE_LINK L' + #13#10 +
'  left join FILE_IMAGES F    on ( F.FILE_IMAGES_ID = L.FILE_IMAGES_ID )' + #13#10 +
'where' + #13#10 +
'  L.MAIL_TEMPLATE_ID = :MAIL_TEMPLATE_ID' + #13#10 +
'order by' + #13#10 +
'  1';
sqlTemplate =
'select' + #13#10 +
'  TEMPLATE_TEXT' + #13#10 +
'from MAIL_TEMPLATE' + #13#10 +
'where' + #13#10 +
'  MAIL_TEMPLATE_ID = 1';

var
Query: TNewQuery;
LinkFileName, ImagesDir: String;

  procedure SaveNewTemlate;
  begin
    Query.SQL.Text := sqlTemplate;
    try
      Query.ExecQuery;
    except
      raise;
    end;
    Query.FieldByName( 'TEMPLATE_TEXT' ).SaveToFile( HtmlFileName );
  end;

begin
  Query := TNewQuery.CreateNew( Self, nil );
  try
    if NewRecord then begin
      HtmlFileName := HtmlTemp + 'Новый шаблон.html';
      SaveNewTemlate;
    end
    else begin
      HtmlFileName := HtmlTemp + Q_Host.FBN( 'MAIL_TEMPLATE_TITLE' ).AsString + '.html';
      TFIBBlobField( Q_Host.FBN( 'TEMPLATE_TEXT' )).SaveToFile( HtmlFileName );
    end;

    Query.Close;
    Query.SQL.Text := sqlFiles;
    if not Query.Prepared then
      Query.Prepare;
    Query.ParamByName( 'MAIL_TEMPLATE_ID' ).AsInteger :=
      IfThen( NewRecord, spHostMailTemplate, Q_Host.FBN( 'MAIL_TEMPLATE_ID' ).AsInteger );

    try
      Query.ExecQuery;
    except
      raise;
    end;

    While not Query.Eof do begin
      LinkFileName := IncludeTrailingPathDelimiter( HtmlTemp ) + 'images\' + Query.FieldByName( 'FILE_IMAGES_NAME' ).AsString;
      ImagesDir := ExtractFileDir( LinkFileName );
      if not DirectoryExists( ImagesDir ) then
        ForceDirectories( ImagesDir );
      Query.FieldByName( 'FILE_IMAGES_BODY' ).SaveToFile( LinkFileName );
      Query.Next;
    end;
  finally
    Query.FreeAndCommit;
  end;
end;



end.
