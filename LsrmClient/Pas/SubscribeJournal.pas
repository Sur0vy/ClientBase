{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit SubscribeJournal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSimpleForm, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet,
  pFIBDataSet, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls,
  Vcl.OleCtrls, SHDocVw, DlgExecute, DlgParams, pFIBDatabase, pFIBStoredProc;

type
  TfrSubscribeJournal = class(TfrCustomSimpleForm)
    SpSub: TSplitter;
    PC: TPageControl;
    tsWebEMail: TTabSheet;
    tsSubscribe: TTabSheet;
    WB: TWebBrowser;
    dbgSubscribe: TDBGridEh;
    Q_Subscribe: TpFIBDataSet;
    dsSubscribe: TDataSource;
    A_NewSubscribe: TAction;
    A_EditSubscribe: TAction;
    A_DelSubscribe: TAction;
    A_SendMail: TAction;
    A_AddAttachment: TAction;
    tsAttachment: TTabSheet;
    dbgAttachment: TDBGridEh;
    Q_Attachment: TpFIBDataSet;
    dsAttachment: TDataSource;
    A_RepeatSend: TAction;
    A_AddCopySubscribe: TAction;
    A_MailPreview: TAction;
    procedure FormResize(Sender: TObject);
    procedure SetAccessRight( const ActName: String  ); override;
    procedure PCChange(Sender: TObject);
    procedure PCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure A_SendMailExecute(Sender: TObject);
    procedure A_DelSubscribeExecute(Sender: TObject);
    procedure A_EditSubscribeExecute(Sender: TObject);
    procedure A_NewSubscribeExecute(Sender: TObject);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    procedure Q_SubscribeBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure Q_HostEndScroll(DataSet: TDataSet);
    procedure dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Q_HostAfterRefresh(DataSet: TDataSet);
    procedure A_AddAttachmentExecute(Sender: TObject);
    procedure Q_AttachmentBeforeOpen(DataSet: TDataSet);
    procedure A_RepeatSendExecute(Sender: TObject);
    procedure Q_HostBeforeScroll(DataSet: TDataSet);
    procedure A_AddCopySubscribeExecute(Sender: TObject);
    procedure A_MailPreviewExecute(Sender: TObject);
  private
    { Private declarations }
    HtmlTemp: String;
    HtmlFileName: String;
    LastSheet: TTabSheet;
    procedure ShowSendMailDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
    procedure SaveHtmlTextToTemp( var FileName: String; TempID: Integer );
    procedure SetDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
    procedure SetPreviewDefaultValue(Sender: TObject; var Item: TPropertyItem);
    procedure SaveHtmlTextToBase( IBTr: TpFIBTransaction; FileName, TextBody: String; PrKeyValue: Integer );
    procedure SaveImagesToBase(FileName: String; ImageID: Integer );

  public
    { Public declarations }
    procedure FillHostMenu; override;
    class procedure ShowSubscribeJournal(Act: TAction);
  end;


implementation

{$R *.dfm}

uses
  ConstList, CustomForm, DlgSubscribeEdit, SqlTools, ClientDM, Prima, Procs, Math, RecordEdit, EMailPreview;

class procedure TfrSubscribeJournal.ShowSubscribeJournal(Act: TAction);
begin
  With Self.Create( Application ) do begin
    try
      IsWriteRight := False;
      A_Filtr.DlgIdent := dlgSubscribeJournal;

      PC.ActivePage := tsWebEMail;
      LastSheet := tsWebEMail;
      ActiveControl := dbgHost;
      HostSqlText := Q_Host.SelectSQL.Text;

      SetAccessRight( Act.Name );
      Caption := Act.Caption;
      FormCaption := Act.Caption;
      FormActivate( nil );

      Application.ProcessMessages;
      PCChange( PC );

      OpenDataSetOfStartForm;
    finally
      If not Q_Host.Active then
        Close;
    end;
  end;
end;

procedure TfrSubscribeJournal.A_AddAttachmentExecute(Sender: TObject);
  procedure LoadAddFile( const FileName: String );
  const
  sqlAttach =
  'update or insert into MAIL_ATTACHMENT (' + #13#10 +
  '    SUBSCRIBE_LIST_ID, FILE_NAME, FILE_DATA )' + #13#10 +
  '  values (' + #13#10 +
  '    :SUBSCRIBE_LIST_ID, :FILE_NAME, :FILE_DATA )' + #13#10 +
  '  matching (' + #13#10 +
  '    SUBSCRIBE_LIST_ID, FILE_NAME )';

  var
  Query: TNewQuery;
  begin
    Query := TNewQuery.CreateNew( Self, frDM.IBTrWrite );
    try
      Query.SQL.Text := sqlAttach;
      if not Query.Prepared then
        Query.Prepare;
      Query.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger;
      Query.ParamByName( 'FILE_NAME' ).AsString := ExtractFileName( FileName );
      Query.ParamByName( 'FILE_DATA' ).LoadFromFile( FileName );

      try
        Query.ExecQuery;
      except
        raise;
      end;

    finally
      Query.FreeAndCommit;
    end;
  end;

var
opdOpen: TOpenDialog;
begin
  inherited;
  if not ( A_AddAttachment.Visible and A_AddAttachment.Enabled ) then
    Exit;

  opdOpen := TOpenDialog.Create( Self );
  try
    opdOpen.Filter := 'Все файлы|*.*';
    If opdOpen.Execute then begin
      LoadAddFile( opdOpen.FileName );
    end;
  finally
    opdOpen.Free;
  end;

  if PC.ActivePage = tsAttachment then
    Q_Attachment.CloseOpen( True );
end;

procedure TfrSubscribeJournal.A_DelSubscribeExecute(Sender: TObject);
begin
  inherited;
  if not ( A_DelSubscribe.Visible and A_DelSubscribe.Enabled ) then
    Exit;

  DeleteRecord( Self, Q_Host, 'SUBSCRIBE_LIST_IUD', 'Удалить текущую рассылку?', '',
                [ 'SUBSCRIBE_LIST_ID' ], [ Q_Host.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger ] );
end;

procedure TfrSubscribeJournal.A_EditSubscribeExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewSubscribe.Visible and A_NewSubscribe.Enabled ) then
    Exit;

  ShowSendMailDlg( Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger, sdEdit, A_EditSubscribe );
end;

procedure TfrSubscribeJournal.A_NewSubscribeExecute(Sender: TObject);
begin
  inherited;
  if not ( A_NewSubscribe.Visible and A_NewSubscribe.Enabled ) then
    Exit;

  ShowSendMailDlg( -1, sdInsert, A_NewSubscribe );
end;

procedure TfrSubscribeJournal.A_AddCopySubscribeExecute(Sender: TObject);
begin
  inherited;
  if not ( A_AddCopySubscribe.Visible and A_AddCopySubscribe.Enabled ) then
    Exit;

  ShowSendMailDlg( Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger, sdCopy, A_EditSubscribe );
end;

procedure TfrSubscribeJournal.A_RepeatSendExecute(Sender: TObject);
const
sqlRepeat =
'update SUBSCRIBE_SEND SS' + #13#10 +
'set' + #13#10 +
'  SS.DATE_SEND = null, SS.IS_OK = 0 ' + #13#10 +
'where' + #13#10 +
'  SS.SUBSCRIBE_LIST_ID = :SUBSCRIBE_LIST_ID and' + #13#10 +
'  SS.ERROR_TEXT != ''Отправлено''';
var
Query: TNewQuery;
begin
  inherited;
  if not ( A_RepeatSend.Visible and A_RepeatSend.Enabled ) then
    Exit;

  Query := TNewQuery.CreateNew( frDM, frDM.IBTrWrite );
  try
    try
      Query.SQL.Text := sqlRepeat;
      if not Query.Prepared then
        Query.Prepare;

      Query.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger :=
        Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger;

      try
        Query.ExecQuery;
      except
        raise;
      end;
    finally
      Query.FreeAndCommit;
    end;
  finally
    Q_Subscribe.FullRefresh;
  end;
end;

procedure TfrSubscribeJournal.A_SendMailExecute(Sender: TObject);
const
sqlSend =
'update SUBSCRIBE_LIST' + #13#10 +
'  set' + #13#10 +
'    IS_SEND = 1' + #13#10 +
'where' + #13#10 +
'  SUBSCRIBE_LIST_ID = :ID';

var
Query: TNewQuery;
begin
  if not ( A_SendMail.Visible and A_SendMail.Enabled ) then
    Exit;

  inherited;
  Query := TNewQuery.CreateNew( frDM, frDM.IBTrWrite );
  try
    try
      Query.SQL.Text := sqlSend;
      if not Query.Prepared then
        Query.Prepare;

      Query.ParamByName( 'ID' ).AsInteger := Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger;

      try
        Query.ExecQuery;
      except
        raise;
      end;
    finally
      Query.FreeAndCommit;
    end;
  finally
    Q_Host.Refresh;
  end;
end;

procedure TfrSubscribeJournal.dbgHostKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  FormKeyDown( Sender, Key, Shift );
  if Shift <> [] then
    Exit;
  if Key <> VK_RETURN then
    Exit;
  if not ( Sender is TDBGridEh ) then
    Exit;

  case IndexOfStrArray(( Sender as TDBGridEh ).Name,
                       [ dbgHost.Name ])  of
    0: A_EditSubscribeExecute( A_EditSubscribe );

  end;
end;

procedure TfrSubscribeJournal.ShowSendMailDlg(ID: Integer; DlgType: TStateDlg; Act: TAction);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  CurrDlgEvent := EditDldEventIsNil;
  try
    CurrDlgEvent.OnAfterFillRow := SetDlgDefaultValue;
    ShowEditDialog( Self, TfrDlgSubscribeEdit, Q_Host, 'SUBSCRIBE_LIST_ID', dlgSubscribeJournal, ID, DlgType, Act, CurrDlgEvent, [ ID ]);
  finally
    Q_Subscribe.Tag := -1;
    Q_Subscribe.CloseOpen( True );   //FillSubscribeSend
  end;
end;

procedure TfrSubscribeJournal.SetAccessRight(const ActName: String);
begin
  inherited;
  frDM.SetFuncRightAccess( Self, frPrima.A_Subscribe.Name );
  A_SendMail.Visible := A_EditSubscribe.Visible;
  A_AddAttachment.Visible := A_EditSubscribe.Visible;
  A_RepeatSend.Visible := A_EditSubscribe.Visible;
  A_AddCopySubscribe.Visible := A_NewSubscribe.Visible;
  A_MailPreview.Visible := A_EditSubscribe.Visible;
end;

procedure TfrSubscribeJournal.SetDlgDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  With TfrDlgSubscribeEdit( Sender ) do begin
    hFileName := Self.HtmlFileName;
    OnSaveHtmlTextToBase := Self.SaveHtmlTextToBase;
    OnImagesToBase := Self.SaveImagesToBase;
    OnSaveTemplateToTemp := Self.SaveHtmlTextToTemp;

    if not ( dlgFillRows.ActionType in [ sdInsert, sdCopy ]) then
      Exit;
    case IndexOfStrArray( Item.FieldName, [ 'PERSONAL_TITLE', 'MAIL_TEMPLATE_TITLE', 'IS_SEND' ]) of
      0: begin
        Item.RowValue := CurrentManagerTitle;
        Item.RowValueID := CurrentUserID;
      end;
      1: begin
        Item.RowValue := GetMailTemplateSpravValue( spHostMailTemplate );
        Item.RowValueID := spHostMailTemplate;
      end;
      2: begin
        Item.RowValue := BoolTitle[ 0 ];
        Item.RowValueID := 0;
      end;
    end;
  end;
end;

procedure TfrSubscribeJournal.FormCreate(Sender: TObject);
begin
  inherited;
  HtmlTemp := IncludeTrailingPathDelimiter( frPrima.TempDir ) + 'Subscribe\';
  ForceDirectories( HtmlTemp );
end;

procedure TfrSubscribeJournal.FormResize(Sender: TObject);
begin
  inherited;
  dbgHost.Width := ( Self.ClientWidth div 3 ) * 2;
end;

procedure TfrSubscribeJournal.PCChange(Sender: TObject);
var
SubscribeID: Integer;
begin
  inherited;
  if Q_Host.Active then
    SubscribeID := Q_Host.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger
  else
    SubscribeID := -1;

  case IndexOfStrArray( PC.ActivePage.Name, [ tsWebEMail.Name, tsSubscribe.Name, tsAttachment.Name ]) of
    0: begin
      if Assigned( WB.Document ) then
        WB.Refresh2;
    end;
    1: begin
      BaseToDBGrid( dbgSubscribe, Self.ClassName, dbgSubscribe.Name );
      ActiveControl := dbgSubscribe;
      if ( not Q_Subscribe.Active ) or
         ( Q_Subscribe.Tag <> SubscribeID ) then begin
        Q_Subscribe.Close;
        Q_Subscribe.Open;
        Q_Subscribe.Tag := SubscribeID;
      end
      else
        Q_Subscribe.FullRefresh;
    end;
    2: begin
      BaseToDBGrid( dbgAttachment, Self.ClassName, dbgAttachment.Name );
      ActiveControl := dbgAttachment;
      if ( not Q_Attachment.Active ) or
         ( Q_Attachment.Tag <> SubscribeID ) then begin
        Q_Attachment.Close;
        Q_Attachment.Open;
        Q_Attachment.Tag := SubscribeID;
      end
      else
        Q_Attachment.FullRefresh;
    end;
  end;
  A_RepeatSend.Enabled := A_EditSubscribe.Enabled and ( PC.ActivePage = tsSubscribe );
end;

procedure TfrSubscribeJournal.PCChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  case IndexOfStrArray( PC.ActivePage.Name, [ tsWebEMail.Name, tsSubscribe.Name, tsAttachment.Name ]) of
    0: begin
     //
    end;
    1: DBGridToBase( dbgSubscribe, Self.ClassName, dbgSubscribe.Name );
    2: DBGridToBase( dbgAttachment, Self.ClassName, dbgAttachment.Name );
  end;

  AllowChange := not Q_Host.IsEmpty;
end;

procedure TfrSubscribeJournal.Q_HostAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  Q_HostAfterScroll( DataSet );
  if ( PC.ActivePage = tsWebEMail ) and
     Assigned( WB.Document ) then
    WB.Refresh2;
end;

procedure TfrSubscribeJournal.Q_HostAfterScroll(DataSet: TDataSet);
begin
  A_EditSubscribe.Enabled := not Q_Host.IsEmpty;
  A_DelSubscribe.Enabled := A_EditSubscribe.Enabled;
  A_RepeatSend.Enabled := A_EditSubscribe.Enabled and ( PC.ActivePage = tsSubscribe );
  A_SendMail.Enabled :=
    A_EditSubscribe.Enabled and
    Q_Host.Active and
    ( Q_Host.FBN( 'IS_SEND' ).AsInteger = 0 );
  A_AddAttachment.Enabled := A_SendMail.Enabled;
  A_MailPreview.Enabled := A_EditSubscribe.Enabled;

//  inherited;  Это так правильно!!!!
end;

procedure TfrSubscribeJournal.Q_HostBeforeScroll(DataSet: TDataSet);
begin
  inherited;
  LastSheet := PC.ActivePage;
end;

procedure TfrSubscribeJournal.Q_HostEndScroll(DataSet: TDataSet);
begin
  inherited;
  try
    PC.ActivePage := tsWebEMail;
  finally
    PC.ActivePage := LastSheet;
    PCChange( PC );
    SaveHtmlTextToTemp( HtmlFileName, -1 );
    WB.Navigate2( HtmlFileName );
    IsScroll := False;
  end;
end;

procedure TfrSubscribeJournal.Q_SubscribeBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Subscribe.Tag := Q_Host.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger;
  Q_Subscribe.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := Q_Subscribe.Tag;
end;

procedure TfrSubscribeJournal.Q_AttachmentBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Q_Attachment.Tag := Q_Host.FieldByName( 'SUBSCRIBE_LIST_ID' ).AsInteger;
  Q_Attachment.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := Q_Attachment.Tag;
end;

procedure TfrSubscribeJournal.SaveHtmlTextToTemp( var FileName: String; TempID: Integer );
const
sqlImagesFiles =
'select' + #13#10 +
'  F.FILE_IMAGES_NAME, F.FILE_IMAGES_BODY' + #13#10 +
'from FILE_IMAGES_SUBSCRIBE_LINK L' + #13#10 +
'  left join FILE_IMAGES F    on ( F.FILE_IMAGES_ID = L.FILE_IMAGES_ID )' + #13#10 +
'where' + #13#10 +
'  L.SUBSCRIBE_LIST_ID = :ID' + #13#10 +
'order by' + #13#10 +
'  1';

sqlTemplateImagesFiles =
'select' + #13#10 +
'  F.FILE_IMAGES_NAME, F.FILE_IMAGES_BODY' + #13#10 +
'from FILE_IMAGES_TEMPLATE_LINK L' + #13#10 +
'  left join FILE_IMAGES F    on ( F.FILE_IMAGES_ID = L.FILE_IMAGES_ID )' + #13#10 +
'where' + #13#10 +
'  L.MAIL_TEMPLATE_ID = :ID' + #13#10 +
'order by' + #13#10 +
'  1';

sqlTemplate =
'select' + #13#10 +
'  TEMPLATE_TEXT' + #13#10 +
'from MAIL_TEMPLATE' + #13#10 +
'where' + #13#10 +
'  MAIL_TEMPLATE_ID = :TEMPLATE_ID';

var
Query: TNewQuery;
LinkFileName, ImagesDir: String;

  procedure SaveTemlate;
  begin
    Query.SQL.Text := sqlTemplate;
    if not Query.Prepared then
      Query.Prepare;
    Query.ParamByName( 'TEMPLATE_ID' ).AsInteger := TempID;
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
    if TempID = -1 then begin
      HtmlFileName := HtmlTemp + Q_Host.FBN( 'SUBSCRIBE_TITLE' ).AsString + '.html';
      TFIBBlobField( Q_Host.FBN( 'MAIL_BODY' )).SaveToFile( HtmlFileName );
    end
    else begin
      HtmlFileName := HtmlTemp + 'Новая рассылка.html';
      SaveTemlate;
    end;

    Query.Close;
    Query.SQL.Text := sqlImagesFiles;
    if not Query.Prepared then
      Query.Prepare;
    Query.ParamByName( 'ID' ).AsInteger :=
      IfThen( TempID = -1, Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger, TempID );

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
    FileName := HtmlFileName;
    Query.FreeAndCommit;
    IsScroll := False;
  end;
end;

procedure TfrSubscribeJournal.SaveHtmlTextToBase( IBTr: TpFIBTransaction; FileName, TextBody: String; PrKeyValue: Integer );
const
sqlSave =
'update SUBSCRIBE_LIST' + #13#10 +
'  set' + #13#10 +
'    MAIL_BODY = :MAIL_BODY, BODY_TEXT = :BODY_TEXT ' + #13#10 +
'where' + #13#10 +
'  SUBSCRIBE_LIST_ID = :SUBSCRIBE_LIST_ID';
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
      Query.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := PrKeyValue;
      Query.ParamByName( 'MAIL_BODY' ).AsString := SetRelativePath( SL.Text );
      Query.ParamByName( 'BODY_TEXT' ).AsString := TextBody;

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

procedure TfrSubscribeJournal.SaveImagesToBase( FileName: String; ImageID: Integer );
const
sqlSave =
'execute procedure FILE_IMAGES_IUD(' + #13#10 +
' :ACTION_TYPE, :FILE_IMAGES_ID, :FILE_IMAGES_NAME, null, :FILE_IMAGES_BODY, null, :SUBSCRIBE_LIST_ID, :IS_USE )';
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
      Query.ParamByName( 'SUBSCRIBE_LIST_ID' ).AsInteger := Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger;
      Query.ParamByName( 'IS_USE' ).AsInteger := -1;
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

procedure TfrSubscribeJournal.A_MailPreviewExecute(Sender: TObject);
var
CurrDlgEvent: TOnEditDialogEvent;
begin
  inherited;
  if not ( A_MailPreview.Visible and A_MailPreview.Enabled ) then
    Exit;

  CurrDlgEvent := EditDldEventIsNil;
  CurrDlgEvent.OnAfterFillRow := SetPreviewDefaultValue;

  ShowEditDialog( Self, TfrEMailPreview, Q_Host, 'SUBSCRIBE_LIST_ID', dlgMailPreview,
                  Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger, sdEdit, A_MailPreview, CurrDlgEvent,
                  [ Q_Host.FBN( 'SUBSCRIBE_LIST_ID' ).AsInteger ]);
end;

procedure TfrSubscribeJournal.SetPreviewDefaultValue(Sender: TObject; var Item: TPropertyItem);
begin
  With TfrEMailPreview( Sender ) do
    hFileName := Self.HtmlFileName;
end;

procedure TfrSubscribeJournal.FillHostMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_AddCopySubscribe, A_Sp, A_NewSubscribe, A_EditSubscribe, A_DelSubscribe, A_Sp,
              A_AddAttachment, A_SendMail, A_RepeatSend, A_Sp, A_MailPreview, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Журнал почтовых рассылок',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_NewSubscribe, A_EditSubscribe, A_DelSubscribe, A_Sp,
              A_AddAttachment, A_SendMail, A_RepeatSend, A_Sp, A_MailPreview, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;



end.
