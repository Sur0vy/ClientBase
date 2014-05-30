{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
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

    // Для прав доступа на справочники
  binSpravInsert      =  4;
  binSpravEdit        =  8;
  binSpravDelete      = 16;

    // Это для отчетов
  prShowPrintDialog =  4;
  prShowProgress    =  8;
  prIsModal         = 16;
  prPreview         = 32;

  spLandRusValue    = 169;    // Строка Россия в справочнике стран
  spHostMailTemplate =  1;   // Простой шаблон, основа для создания всех остальных почтовых шаблонов

  sprSpravParent    =    100; // Корневой узел всех справочников
  sprAdminRight     =    200; // Меню "Администрирование"
  sprUserList       =    210;
  sprLandList       =    510;  // Справочник "Список стран"
  sprGroupSubscribe =    410;  // Группы рассылок
  sprMailTemplate   =    420;  // Шаблоны для почтовой рассылки
  sprFileImages     =    430;  // Справочник "Картинки для шаблонов"
  sprSubscribInput  =    700;  // Подстановки для рассылок


  rpReportParent    =      100; // Корневой узел всех отчетов

  rpUserCart          =    10600; // Карточка сотрудника


  dlgClientsList      =    10000;     // основной журнал, Список клиентов
  dlgKeysList         =    10100;     // Ключи доступа
  dlgFillKeys         =    10150;     // Состав ключа доступа
  dlgAgreesList       =    10200;     // Список договоров с клиентом
  dlgProductInAgrees  =    10600;     // Список ПО в составе отгрузки
  dlgTraining         =    10260;     // Обучение, мастер-деталь
  dlgSubscribe        =    10270;     // Включение адресов в группы рассылки
  dlgDelivery         =    10500;     // Отгрузки по договорам

  dlgDownLoadJournal   =    11000;     // Скачанные с сайта
  dlgTrainingJournal   =    12000;     // Обучение клиентов, список
  dlgAgreesListJournal =    13000;     // Список договоров
  dlgSoftDeliveryJournal =  13500;     // Отгрузки по договорам
  dlgKeysJournal       =    14000;     // Список ключей выданных клиентам

  dlgFirmList          =    15000;     // журнал организаций
  dlgSubscribeJournal  =    16000;     // журнал почтовых рассылок
  dlgMailPreview       =    17000;     // Просмотр писем рассылки


var
  FrozedDefColor : TColor = clBtnFace;  //Цвет фиксированного столбца в таблице
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
