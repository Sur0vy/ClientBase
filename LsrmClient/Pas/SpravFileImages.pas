{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit SpravFileImages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Imaging.pngimage,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSprav, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet, pFIBDataSet,
  PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls, Vcl.DBCtrls,
  Vcl.OleCtrls, SHDocVw, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TfrSpravFileImages = class(TfrCustomSprav)
    A_ShowImage: TAction;
    spImage: TSplitter;
    imShowImage: TImage;
    procedure A_ShowImageExecute(Sender: TObject);
    procedure Q_HostAfterScroll(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure Q_HostEndScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ImageTemp: String;
  public
    { Public declarations }
    procedure FillHostMenu; override;
  end;


implementation

{$R *.dfm}

uses
  Prima, ShellList;

procedure TfrSpravFileImages.A_ShowImageExecute(Sender: TObject);
var
FileName: String;
begin
  inherited;
  if not ( A_ShowImage.Visible and A_ShowImage.Enabled ) then
    Exit;
  FileName := ImageTemp + Q_Host.FBN( 'FILE_IMAGES_NAME' ).AsString;

  TFIBBlobField( Q_Host.FBN( 'FILE_BODY' )).SaveToFile( FileName );
  ExecuteFile( 'mspaint.exe', FileName, ImageTemp, SW_SHOW );
end;

procedure TfrSpravFileImages.FillHostMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_SpravAddCopy, A_Sp, A_SpravNew, A_SpravEdit, A_SpravDelete, A_Sp, A_ShowImage, A_Sp, A_ShowDelete,A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Справочники',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_SpravNew, A_SpravEdit, A_SpravDelete, A_Sp, A_ShowImage, A_Sp,  A_ShowDelete, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

procedure TfrSpravFileImages.FormCreate(Sender: TObject);
begin
  inherited;
  ImageTemp := IncludeTrailingPathDelimiter( frPrima.TempDir ) + 'SpravImages\';
  ForceDirectories( ImageTemp );
end;

procedure TfrSpravFileImages.FormResize(Sender: TObject);
begin
  inherited;
  dbgHost.Width := Self.ClientWidth div 2;
end;

procedure TfrSpravFileImages.Q_HostAfterScroll(DataSet: TDataSet);
begin
  inherited;
  A_ShowImage.Visible := A_SpravEdit.Visible;
  A_ShowImage.Enabled := A_SpravEdit.Enabled;
end;

procedure TfrSpravFileImages.Q_HostEndScroll(DataSet: TDataSet);
var
ImgField: TFIBBlobField;
FileName: String;
begin
  inherited;

  ImgField:= TFIBBlobField( Q_Host.FBN( 'FILE_BODY' ));
  if not ImgField.IsNull then begin
    try
      FileName := ImageTemp + Q_Host.FBN( 'FILE_IMAGES_NAME' ).AsString;
      ImgField.SaveToFile( FileName );
      sleep( 50 );
      imShowImage.Picture.LoadFromFile( FileName );
    finally

    end;
  end;

  imShowImage.Refresh;
end;

end.
