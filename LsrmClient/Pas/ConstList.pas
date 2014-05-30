{***************************************************************}
{    Copyright (c) 2013 ���             .                       }
{    ������� ������ ��������, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ConstList;

interface

uses
  Vcl.Graphics, Winapi.Windows, Winapi.Messages, System.SysUtils, RightType;


type
  TWorkDocsPrinter = record
    DocPrinterName: String;
    ShowPreview: Boolean;
    ShowPrintSetup: Boolean;
    DefPrinter: String;
  end;

  TGroupItem = record
    GroupItemID: Integer;
    GroupItemNumber: String;
  end;

const
  CM_StartExe = WM_USER + 10;
  CM_ItemsRefresh = WM_USER + 11;
  CM_ClearTempDir = WM_USER + 12;
  CM_ChildFormClose = WM_USER + 13;
  CM_SetActionEnabled = WM_USER + 14;
  CM_ExecNewProduct = WM_USER + 15;
  CM_SetActionbarWidth = WM_USER + 16;
  CM_ShowPrimaToolBar = WM_USER + 17;

  spSeparatorImage = 132;


  RegString           = 'SoftWare\LPT\LsrmClient';
	RegConnect          = 'SoftWare\LPT\LsrmClient\Connect';
  RegFormsGrid        = 'SoftWare\LPT\LsrmClient\Forms';
  RegReportParam      = 'SoftWare\LPT\LsrmClient\Report';

    // ��� ���� ������� �� �����������
  binSpravInsert      =  4;
  binSpravEdit        =  8;
  binSpravDelete      = 16;

    // ��� ��� �������
  prShowPrintDialog =  4;
  prShowProgress    =  8;
  prIsModal         = 16;
  prPreview         = 32;

  spLandRusValue    = 169;    // ������ ������ � ����������� �����
  spHostMailTemplate =  1;   // ������� ������, ������ ��� �������� ���� ��������� �������� ��������

  sprSpravParent    =    100; // �������� ���� ���� ������������
  sprAdminRight     =    200; // ���� "�����������������"
  sprUserList       =    210;
  sprLandList       =    510;  // ���������� "������ �����"
  sprGroupSubscribe =    410;  // ������ ��������
  sprMailTemplate   =    420;  // ������� ��� �������� ��������
  sprFileImages     =    430;  // ���������� "�������� ��� ��������"
  sprSubscribInput  =    700;  // ����������� ��� ��������


  rpReportParent    =      100; // �������� ���� ���� �������

  rpUserCart          =    10600; // �������� ����������


  dlgClientsList      =    10000;     // �������� ������, ������ ��������
  dlgKeysList         =    10100;     // ����� �������
  dlgFillKeys         =    10150;     // ������ ����� �������
  dlgAgreesList       =    10200;     // ������ ��������� � ��������
  dlgProductInAgrees  =    10600;     // ������ �� � ������� ��������
  dlgTraining         =    10260;     // ��������, ������-������
  dlgSubscribe        =    10270;     // ��������� ������� � ������ ��������
  dlgDelivery         =    10500;     // �������� �� ���������

  dlgDownLoadJournal   =    11000;     // ��������� � �����
  dlgTrainingJournal   =    12000;     // �������� ��������, ������
  dlgAgreesListJournal =    13000;     // ������ ���������
  dlgSoftDeliveryJournal =  13500;     // �������� �� ���������
  dlgKeysJournal       =    14000;     // ������ ������ �������� ��������

  dlgFirmList          =    15000;     // ������ �����������
  dlgSubscribeJournal  =    16000;     // ������ �������� ��������
  dlgMailPreview       =    17000;     // �������� ����� ��������


var
  FrozedDefColor : TColor = clBtnFace;  //���� �������������� ������� � �������
  MinDateValue: TDateTime = 10000;

  CurrentUserID: Integer = 1;
  CurrentUserLogin: String = 'SYSDBA';
  CurrentManagerTitle: String = '';
  EventUpdManager: String = '';

	CurrentRightGroupID: Integer = -1;
  CurrentRightGroupTitle: String = '';

  WorkDocsPrinter: TWorkDocsPrinter = (
    DocPrinterName: '';
    ShowPreview: False;
    ShowPrintSetup: False;
    DefPrinter: '' );


implementation




end.
