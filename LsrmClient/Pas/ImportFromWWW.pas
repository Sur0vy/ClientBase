{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ImportFromWWW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.OleCtrls, SHDocVw, Vcl.ImgList,
  RegExpr, Vcl.ExtCtrls, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, pFIBStoredProc, Vcl.StdCtrls,
  mshtml, Procs, Vcl.ActnList;

type
  TfrImportFromWWW = class(TForm)
    WB: TWebBrowser;
    Q_Down: TpFIBQuery;
    Q_Product: TpFIBQuery;
    Q_FindClient: TpFIBQuery;
    Q_SaveClient: TpFIBStoredProc;
    Q_findDown: TpFIBQuery;
    ActWWW: TActionList;
    A_OpenWWW: TAction;
    A_Close: TAction;
    A_Back: TAction;
    A_Forward: TAction;
    A_RefreshWWW: TAction;
    A_ExecImport: TAction;
    procedure FormCreate(Sender: TObject);
    procedure WBBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure FormActivate(Sender: TObject);
    procedure WBDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure A_OpenWWWExecute(Sender: TObject);
    procedure A_BackExecute(Sender: TObject);
    procedure A_ForwardExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure A_RefreshWWWExecute(Sender: TObject);
    procedure A_CloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure A_ExecImportExecute(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    FormCaption: String;
    IsOK: Boolean;
    AddClient: Integer;
    DateFormat: TFormatSettings;
    procedure GetDownRow( const RowStr: String );
    function GetProductID( Value: String; var PrVersion: String ): Integer;
    function GetClientID( const Value: String ): Integer;
    function SaveClientParam(iDoc: IHtmlDocument2): Integer;
    procedure FillActionMenu;
  public
    { Public declarations }
    class procedure ShowWwwImportForm( Act: TAction );
  end;



implementation

uses ClientDM, Prima;

const
url = 'http://www.lsrm.ru/root/';
urlDown = 'http://www.lsrm.ru/root/plugins/download/';


{$R *.dfm}

function GetInputValue( iDoc: IHtmlDocument2; TagName: String ): String;
var
N: integer;
ov: OleVariant;
iDisp: IDispatch;
iColl: IHTMLElementCollection;
iInputElement: IHTMLInputElement;
ElementName: String;
begin
  try
    ov := 'INPUT';

    IDisp := iDoc.all.tags(ov);
    if assigned(IDisp) then begin
      IDisp.QueryInterface(IHTMLElementCollection, iColl);
      if assigned(iColl) then begin
        for N := 1 to iColl.Get_length do begin
          iDisp := iColl.item( pred( N ), 0 );
          iDisp.QueryInterface(IHTMLInputElement, iInputElement);
          if assigned(iInputElement) then begin
            ElementName := Trim( iInputElement.Get_name );
            If AnsiSameText( ElementName, TagName ) then begin
             Result := iInputElement.value;
             Break;
            end;
          end;
        end;
      end;
    end;
  finally

  end;
end;

class procedure TfrImportFromWWW.ShowWwwImportForm( Act: TAction );
var
CurrForm: TfrImportFromWWW;
begin
  CurrForm := TfrImportFromWWW.Create( Application );
  With CurrForm do begin
    FormCaption := Act.Caption;
    frDM.SetFuncRightAccess( CurrForm, Act.Name );
    A_OpenWWWExecute( A_OpenWWW );
    FormActivate( nil );
  end;
end;

procedure TfrImportFromWWW.A_CloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrImportFromWWW.A_ForwardExecute(Sender: TObject);
begin
  try
    WB.GoForward;
  except
    //
  end;
end;

procedure TfrImportFromWWW.A_BackExecute(Sender: TObject);
begin
  try
    WB.GoBack;
  except
    //
  end;
end;

procedure TfrImportFromWWW.A_OpenWWWExecute(Sender: TObject);
begin
  IsOK := False;
  Screen.Cursor := crSQLWait;
  try
    WB.Navigate2( url );
    WB.Navigate2( urlDown );
    while not IsOK do begin
      Application.ProcessMessages;
      sleep( 500 );
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrImportFromWWW.A_RefreshWWWExecute(Sender: TObject);
begin
  try
    WB.Refresh2;
  except
    //
  end;
end;

procedure TfrImportFromWWW.A_ExecImportExecute(Sender: TObject);
  procedure DisableBtn( IsEnabled: Boolean );
  begin
    try
      A_OpenWWW.Enabled := IsEnabled;
      A_Back.Enabled := IsEnabled;
      A_Forward.Enabled := IsEnabled;
      A_RefreshWWW.Enabled := IsEnabled;
      A_ExecImport.Enabled := IsEnabled;
    finally
      Application.ProcessMessages;
    end;
  end;

var
HtmlText: String;
ResValue: string;
begin
  if not ( A_ExecImport.Visible and A_ExecImport.Enabled ) then
    Exit;

  Screen.Cursor := crSQLWait;
  AddClient := 0;
  try
    A_OpenWWWExecute( nil );

  finally
    Screen.Cursor := crDefault;
  end;

  DisableBtn( False );

  If not frDM.IBTrWrite.InTransaction then
    frDM.IBTrWrite.StartTransaction;

  Screen.Cursor := crSQLWait;
  try
    Q_Down.Close;

    HtmlText := IHtmlDocument2( WB.Document ).body.innerHTML;

    with TRegExpr.Create do
      try
        Expression:= '<TR>(.*?)</TR>';
        if ( Exec( HtmlText ) ) then begin
          repeat
            ResValue:= Match[ 1 ];
            GetDownRow( ResValue );

          until not ExecNext;
        end;
      finally
        Screen.Cursor := crDefault;
        Free;
      end;
  finally
    Screen.Cursor := crDefault;
    DisableBtn( True );
    If frDM.IBTrWrite.InTransaction then
      frDM.IBTrWrite.Commit;
  end;

  MessageBox( Self.Handle,
              PChar( Format( 'Импорт с сайта выполнен!' + #13#10 + 'Добавлено клиентов - %D', [ AddClient ])),
              'Импорт с сайта', MB_SYSTEMMODAL or MB_OK or MB_ICONINFORMATION );
end;

procedure TfrImportFromWWW.FormActivate(Sender: TObject);
begin
  if not Assigned( Sender ) then
    FillActionMenu;
end;

procedure TfrImportFromWWW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormDeactivate(Self);
  Action := caFree;
end;

procedure TfrImportFromWWW.FormCreate(Sender: TObject);
begin
  DateFormat := TFormatSettings.Create;
  DateFormat.DateSeparator := '-';
  DateFormat.TimeSeparator := ':';
  DateFormat.ShortDateFormat := 'yyyy-mm-dd hh:mm:ss';
end;

procedure TfrImportFromWWW.FormDeactivate(Sender: TObject);
begin
  FrPrima.ChildFormDeactivate( self );
end;

procedure TfrImportFromWWW.FormShow(Sender: TObject);
begin
  FillActionMenu;
end;

procedure TfrImportFromWWW.GetDownRow( const RowStr: String );
var
ResValue: string;
PrVersion: String;
N: Integer;
begin
  with TRegExpr.Create do
    try
      Expression:= '<TD>(.*?)</TD>';
      if ( Exec( RowStr ) ) then begin
        N := 0;
        PrVersion := '';
        repeat
          ResValue:= Match[ 1 ];
          case N of
            0: begin
              Q_findDown.Close;
              Q_findDown.ParamByName( 'WWW_ID' ).AsInteger := StrToIntDef( ResValue, -1 );
              Q_findDown.ExecQuery;
              if not ( Q_findDown.Eof and Q_findDown.Bof ) then
                Exit
              else
                Q_findDown.Close;

              Q_Down.ParamByName( 'WWW_ID' ).AsInteger := StrToIntDef( ResValue, -1 ) ;
            end;
            1: Q_Down.ParamByName( 'DATE_LOAD' ).AsDateTime := StrToDateTimeDef( ResValue, Date, DateFormat );
            2: begin
              Q_Down.ParamByName( 'PRODUCT_LIST_ID' ).AsInteger := GetProductID( ResValue, PrVersion );
              Q_Down.ParamByName( 'PRODUCT_VERSION' ).AsString := PrVersion;
            end;
            3: Q_Down.ParamByName( 'CLIENT_LIST_ID' ).AsInteger :=  GetClientID( ResValue );
            4: Q_Down.ParamByName( 'LOAD_FROM_ADDRESS' ).AsString := ResValue;
            5: ; // пропускаем

          end;

          Inc( N );
        until not ExecNext;

      end
      else
        Exit;

      Q_Down.ExecQuery;
      frDM.IBTrWrite.CommitRetaining;

    finally
      Screen.Cursor := crDefault;
      Free;
    end;
end;

function TfrImportFromWWW.GetProductID( Value: String; var PrVersion: String ): Integer;
var
L, N: Integer;
begin
  Result := -1;
  PrVersion := '';
  L := Pos( '.EXE', AnsiUpperCase( Value ));
  if L > 0 then begin
    Delete( Value, L, Length( Value ));
  end
  else begin
    L := Pos( '.ZIP', AnsiUpperCase( Value ));
    if L > 0 then
      Delete( Value, L, Length( Value ));
  end;

  L := Length( Value );
  for N := L downto 1 do begin
    if not CharInSet( Value[ N ], ['_','0','1','2','3','4','5','6','7','8','9' ]) then begin
      PrVersion := Copy( Value, N + 1, L );
      Delete( Value, N + 1, L );
      Break;
    end;
  end;

  L := Length( Value );
  for N := L downto 1 do begin
    if Value[ N ] = '/' then begin
      Delete( Value, 1, N );
      Break;
    end;
  end;

  Value := StringReplace( Value, '-install', '', [ rfReplaceAll, rfIgnoreCase ]);
  Value := StringReplace( Value, 'install', '', [ rfReplaceAll, rfIgnoreCase ]);
  Value := StringReplace( Value, 'inst', '', [ rfReplaceAll, rfIgnoreCase ]);


  Q_Product.Close;
  Q_Product.ParamByName( 'TITLE' ).AsString := Value;
  try
    try
      Q_Product.ExecQuery;
      Result := Q_Product.FieldByName( 'PRODUCT_LIST_ID' ).AsInteger;
    except
      raise;
    end;
  finally
    Q_Product.Close;
  end;
end;

function TfrImportFromWWW.GetClientID( const Value: String ): Integer;
var
UserUrl: String;
iDoc: IHtmlDocument2;
E_Mail: String;
begin
  with TRegExpr.Create do
    try
      Expression:= '"(.*?)"';
      if ( Exec( Value ) ) then
        UserUrl:= Match[ 1 ];
    finally
      Free;
    end;

  UserUrl := 'http://www.lsrm.ru' + UserUrl;

  WB.Navigate2( 'about:<html><body></body></html>' );
  While WB.Busy do
    Application.ProcessMessages;

  IsOK := False;
  WB.Navigate2( UserUrl );

  While WB.Busy do
    Application.ProcessMessages;

  while not IsOK do begin
    Application.ProcessMessages;
    sleep( 500 );
  end;

  iDoc := nil;
  E_Mail := '';
  while ( not Assigned( iDoc )) or ( E_Mail = '' ) or ( GetInputValue( iDoc, 'last_agent' ) = '' ) do begin
    WB.ControlInterface.Document.QueryInterface(IHtmlDocument2, iDoc);
    if Assigned( iDoc ) then
      E_Mail := GetInputValue( iDoc, 'email' );
    Application.ProcessMessages;
  end;


  Q_FindClient.Close;
  Q_FindClient.ParamByName( 'E_MAIL' ).AsString := Trim( AnsiLowercase( E_Mail ));
  Q_FindClient.ExecQuery;

  if not Q_FindClient.FieldByName( 'CLIENT_LIST_ID' ).IsNull then begin
    Result := Q_FindClient.FieldByName( 'CLIENT_LIST_ID' ).AsInteger;
    Exit;
  end;

  Result := SaveClientParam( iDoc );
  Application.ProcessMessages;
end;

function TfrImportFromWWW.SaveClientParam( iDoc: IHtmlDocument2 ): Integer;
var
N: integer;
ov: OleVariant;
iDisp: IDispatch;
iColl: IHTMLElementCollection;
iInputElement: IHTMLInputElement;
ElementName, ResValue: String;
begin
  Q_SaveClient.Close;
  Q_SaveClient.StoredProcName := '';
  Q_SaveClient.StoredProcName := 'CLIENT_LIST_IMPORT';
  if not Q_SaveClient.Prepared then
    Q_SaveClient.Prepare;


  try
    ov := 'INPUT';

    IDisp := iDoc.all.tags(ov);
    if assigned(IDisp) then begin
      IDisp.QueryInterface(IHTMLElementCollection, iColl);
      if assigned(iColl) then begin
        for N := 1 to iColl.Get_length do begin
          iDisp := iColl.item( pred( N ), 0 );
          iDisp.QueryInterface(IHTMLInputElement, iInputElement);
          if assigned(iInputElement) then begin
            ElementName := Trim( iInputElement.Get_name );
            ResValue := Trim( iInputElement.value );

            case IndexOfStrArray( ElementName,
                   [ 'name','email','lang','website','phone','org','regdate', 'occ' ]) of
              0: Q_SaveClient.ParamByName( 'FIO' ).AsString := ResValue;
              1: Q_SaveClient.ParamByName( 'E_MAIL_LIST' ).AsString := ResValue;
              2: Q_SaveClient.ParamByName( 'LAND_TITLE' ).AsString := ResValue;
              3: Q_SaveClient.ParamByName( 'DESCRIB_TEXT' ).AsString := ResValue;
              4: Q_SaveClient.ParamByName( 'PHONE_NUMBER' ).AsString := ResValue;
              5: Q_SaveClient.ParamByName( 'FIRM_TITLE' ).AsString := ResValue;
              6: try
                   Q_SaveClient.ParamByName( 'DATE_REGISTR' ).AsDateTime := StrToDateTime( trim( ResValue ), DateFormat );
                 except
                   on E: exception do
                     ShowMessage( E.Message + #13#10 + ResValue + #13#10 + Q_SaveClient.ParamByName( 'E_MAIL_LIST' ).AsString );
                 end;

              7: Q_SaveClient.ParamByName( 'JOB_POSITION_TITLE' ).AsString := ResValue;
            end;
          end;
        end;
      end;
    end;

    if Q_SaveClient.ParamByName( 'DATE_REGISTR' ).IsNull then
      ShowMessage( ResValue + #13#10 + Q_SaveClient.ParamByName( 'E_MAIL_LIST' ).AsString );

    Q_SaveClient.ExecProc;
    Result := Q_SaveClient.FieldByName( 'RESULT_ID' ).AsInteger;
    Inc( AddClient );
  finally
    iDoc := nil;
  end;
end;

procedure TfrImportFromWWW.WBBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName,
  PostData, Headers: OleVariant; var Cancel: WordBool);
begin
  IsOK := False;
  Self.Caption := FormCaption + ' (' + URL + ')';
end;

procedure TfrImportFromWWW.WBDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
  IsOK := True;
end;

procedure TfrImportFromWWW.FillActionMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
      [ A_Clipboard, A_Sp, A_Back, A_Forward, A_RefreshWWW, A_Sp, A_OpenWWW, A_ExecImport,  A_Sp, A_Close ] );

		SetFillActListInBar( atbTransact,
			[ A_EditCut, A_EditCopy, A_EditPaste, A_EditSelectAll, A_EditUndo, A_Sp, A_Back, A_Forward, A_RefreshWWW, A_Sp,
        A_OpenWWW, A_ExecImport, A_Sp, A_Close ] );
  end;
end;

end.
