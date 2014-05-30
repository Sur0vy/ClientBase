program UserBase;

uses
  Vcl.Forms,
  Prima in 'Prima.pas' {frPrima},
  ClientDM in 'ClientDM.pas' {frDM: TDataModule},
  CustomDlg in 'CustomDlg.pas' {frCustomDlg},
  CustomForm in 'CustomForm.pas' {frCustomForm},
  FiltrDlg in 'FiltrDlg.pas' {frFiltrDlg},
  RecordEdit in 'RecordEdit.pas' {frRecordEdit},
  GridSetup in 'GridSetup.pas' {FrGridSetup},
  FuncRight in 'FuncRight.pas' {FrFuncRight},
  ReportFiltr in 'ReportFiltr.pas' {frReportFiltr},
  ClientsList in 'ClientsList.pas' {frClienstList},
  SqlTools in 'SqlTools.pas',
  ConstList in 'ConstList.pas',
  ReportParam in 'ReportParam.pas',
  CustomSimpleForm in 'CustomSimpleForm.pas' {frCustomSimpleForm},
  DownList in 'DownList.pas' {frDownList},
  ClientTraining in 'ClientTraining.pas' {frClientTraining},
  SoftDelivery in 'SoftDelivery.pas' {frSoftDelivery},
  CustomSprav in 'CustomSprav.pas' {frCustomSprav},
  KeysList in 'KeysList.pas' {frKeysList},
  ImportFromWWW in 'ImportFromWWW.pas' {frImportFromWWW},
  CsvToBase in 'CsvToBase.pas',
  MailTemplate in 'MailTemplate.pas' {frMailTemplate},
  SpravFileImages in 'SpravFileImages.pas' {frSpravFileImages},
  GroupSuscribeSprav in 'GroupSuscribeSprav.pas' {frGroupSuscribeSprav},
  FirmList in 'FirmList.pas' {frFirmList},
  SubscribeJournal in 'SubscribeJournal.pas' {frSubscribeJournal},
  DlgSubscribeEdit in 'DlgSubscribeEdit.pas' {frDlgSubscribeEdit},
  ToolBarSetup in 'ToolBarSetup.pas' {frToolBarSetup},
  EMailPreview in 'EMailPreview.pas' {frEMailPreview},
  AgreesList in 'AgreesList.pas' {frAgreesList},
  RecordClients in 'RecordClients.pas' {frRecordClients},
  ClientsListBox in 'ClientsListBox.pas' {frClientsListBox};

{$R *.res}
{$I Lsrm.inc}

begin
{$WARN SYMBOL_PLATFORM OFF}
{$IFDEF COMMAND_LINE}
//  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
{$ENDIF}
{$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Клиентская база';
  Application.CreateForm(TfrPrima, frPrima);
  Application.CreateForm(TfrDM, frDM);
  Application.Run;
end.
