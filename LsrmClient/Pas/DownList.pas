{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit DownList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomSimpleForm, DBGridEhGrouping, ToolCtrlsEh, Data.DB, FIBDataSet,
  pFIBDataSet, PrnDbgeh, Vcl.ExtCtrls, AddActions, Vcl.DBActns, Vcl.ActnList, GridsEh, DBGridEh, Vcl.ComCtrls, Prima;

type
  TfrDownList = class(TfrCustomSimpleForm)
    function GetAccessConditionValue: String; override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FillHostMenu; override;
  end;


implementation

{$R *.dfm}

uses ConstList;

{ TfrDownList }



{ TfrDownList }

function TfrDownList.GetAccessConditionValue: String;
begin
  Result := inherited;
  Result := Format( '( REG_PERSONAL_ID = %D )', [ CurrentUserID ]);
end;

procedure TfrDownList.FillHostMenu;
begin
  with frPrima do begin
		SetMainMenuList( M_Transact, frPrima.PM,
						[ A_Clipboard, A_DsLocation, A_Refresh, A_RefreshFull, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_ToolBarSetup, A_ShowOfStart, A_Sp, A_AutoWidth, A_Align, A_Sp, A_Close ] );
		FillActionBarFromDB( Self, aTbTransact, 'Загрузки клиентами из WWW',
						[ A_First, A_Prior, A_Next, A_Last, A_Sp, A_Refresh, A_RefreshFull, A_Sp,
              A_Filtr, A_FiltrClear, A_Sp, A_Print, A_Sp,
							A_HostGridSetup, A_Sp, A_AutoWidth, A_Sp, A_Left, A_Centr, A_Right ] );
  end;
end;

end.
