inherited frReportFiltr: TfrReportFiltr
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1092#1080#1083#1100#1090#1088#1072' '#1076#1083#1103' '#1086#1090#1095#1077#1090#1086#1074
  ClientWidth = 697
  ExplicitWidth = 713
  PixelsPerInch = 96
  TextHeight = 13
  inherited SB: TStatusBar
    Width = 697
    ExplicitWidth = 697
  end
  inherited SmartDlg: TSmartDlg
    Width = 697
    TabSet = SmartDlg.TabSet
    DividerPosition = 346
    ExplicitWidth = 697
  end
  inherited aTbSmartDLG: TActionToolBar
    Width = 697
    ExplicitWidth = 697
  end
  inherited TmSave: TTimer
    Left = 160
  end
  object frxBarCodeObj: TfrxBarCodeObject
    Left = 613
    Top = 48
  end
  object frxOLEObj: TfrxOLEObject
    Left = 613
    Top = 104
  end
  object frxRichObj: TfrxRichObject
    Left = 613
    Top = 160
  end
  object frxGradientObj: TfrxGradientObject
    Left = 544
    Top = 50
  end
  object frxXLSExp: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 544
    Top = 101
  end
  object frxXMLExp: TfrxXMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Background = True
    Creator = 'FastReport'
    EmptyLines = True
    SuppressPageHeadersFooters = False
    RowsCount = 0
    Split = ssNotSplit
    Left = 536
    Top = 160
  end
  object frxPDFExp: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 464
    Top = 43
  end
  object frxRTFExp: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 464
    Top = 99
  end
  object frxCSVExp: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 456
    Top = 163
  end
end
