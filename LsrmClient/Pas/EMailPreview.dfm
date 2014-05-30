inherited frEMailPreview: TfrEMailPreview
  Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088' EMail'
  ClientHeight = 460
  ExplicitHeight = 498
  PixelsPerInch = 96
  TextHeight = 13
  object SpPreview: TSplitter [0]
    Left = 0
    Top = 81
    Width = 686
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  inherited SB: TStatusBar
    Top = 441
    ExplicitTop = 441
  end
  inherited SmartDlg: TSmartDlg
    Height = 52
    Align = alTop
    TabSet = SmartDlg.TabSet
    ExplicitHeight = 52
  end
  object WB: TWebBrowser [4]
    Left = 0
    Top = 86
    Width = 686
    Height = 355
    Align = alClient
    TabOrder = 3
    ExplicitTop = 87
    ControlData = {
      4C000000E6460000B12400000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  inherited FontD: TFontDialog
    Left = 24
    Top = 136
  end
  inherited ActListDialog: TActionList
    Top = 136
  end
  inherited dlgFillRows: TFillRows
    Left = 24
    Top = 208
  end
  inherited TmSave: TTimer
    Left = 328
    Top = 136
  end
  inherited ppDialog: TPopupActionBar
    Left = 256
    Top = 136
  end
  inherited SpEdit: TpFIBStoredProc
    Top = 136
  end
  inherited IBTrWrite: TpFIBTransaction
    Left = 400
  end
  object Q_Label: TpFIBQuery
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    SQL.Strings = (
      'select'
      '  MAIL_BASE_LABEL_NAME'
      'from MAIL_BASE_LABEL'
      'where'
      '  IS_DELETE > 0 and IS_USE = 1'
      'order by'
      '  1')
    Left = 104
    Top = 272
  end
  object Q_Preview: TpFIBDataSet
    SelectSQL.Strings = (
      'select'
      '  *'
      
        'from SUBSCRIBE_PREVIEW_S( :SUBSCRIBE_LIST_ID, :CLIENTS_MAIL_LIST' +
        '_ID )'
      '')
    BeforeOpen = Q_PreviewBeforeOpen
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 24
    Top = 272
    poUseBooleanField = False
  end
  object tmShow: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmShowTimer
    Left = 328
    Top = 208
  end
end
