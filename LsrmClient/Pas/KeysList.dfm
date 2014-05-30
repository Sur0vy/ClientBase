inherited frKeysList: TfrKeysList
  Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1074#1099#1076#1072#1085#1085#1099#1093' '#1082#1083#1102#1095#1077#1081
  ClientHeight = 472
  ClientWidth = 987
  OnResize = FormResize
  ExplicitWidth = 1003
  ExplicitHeight = 510
  PixelsPerInch = 96
  TextHeight = 16
  object SpKeys: TSplitter [0]
    Left = 433
    Top = 0
    Width = 5
    Height = 453
    ExplicitLeft = 297
    ExplicitHeight = 439
  end
  inherited SB: TStatusBar
    Top = 453
    Width = 987
    ExplicitTop = 453
    ExplicitWidth = 987
  end
  inherited dbgHost: TDBGridEh
    Width = 433
    Height = 453
    Align = alLeft
    OnDblClick = A_EditKeyExecute
    OnKeyDown = dbgHostKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'KEY_NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072
        Width = 115
      end
      item
        EditButtons = <>
        FieldName = 'DATE_ISSUE'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080' '#1082#1083#1102#1095#1072
        Width = 87
      end
      item
        EditButtons = <>
        FieldName = 'FIRM_LIST_TITLE'
        Footers = <>
        Title.Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        Visible = False
        Width = 147
      end
      item
        EditButtons = <>
        FieldName = 'FIRM_LIST_SHORT'
        Footers = <>
        Title.Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
        Width = 123
      end
      item
        EditButtons = <>
        FieldName = 'COMMENT_TEXT'
        Footers = <>
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1082#1083#1102#1095#1072
        Width = 134
      end>
  end
  object dbgProductList: TDBGridEh [3]
    Left = 438
    Top = 0
    Width = 549
    Height = 453
    Align = alClient
    AllowedOperations = []
    ColumnDefValues.EndEllipsis = True
    ColumnDefValues.Title.EndEllipsis = True
    ColumnDefValues.Title.TitleButton = True
    ColumnDefValues.Title.ToolTips = True
    ColumnDefValues.ToolTips = True
    DataGrouping.GroupLevels = <>
    DataSource = dsProduct
    DrawMemoText = True
    Flat = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentFont = False
    PopupMenu = frPrima.PM
    ReadOnly = True
    RowHeight = 26
    RowLines = 1
    RowSizingAllowed = True
    SortLocal = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    OnCellClick = GridCellClick
    OnColEnter = GridColEnter
    OnDblClick = A_EditProdInKeyExecute
    OnDrawColumnCell = GridDrawColumnCell
    OnEnter = DbGridEnter
    OnKeyDown = dbgProductListKeyDown
    OnSortMarkingChanged = GridSortMarkingChanged
    Columns = <
      item
        EditButtons = <>
        FieldName = 'PRODUCT_LIST_TITLE'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1076#1091#1082#1090#1072
        Width = 299
      end
      item
        EditButtons = <>
        FieldName = 'TRACT_COUNT'
        Footers = <>
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1088#1072#1082#1090#1086#1074
        Width = 176
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  inherited FontD: TFontDialog
    Left = 104
    Top = 88
  end
  inherited ActList: TActionList
    Left = 40
    Top = 88
    object A_NewKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1053#1086#1074#1099#1081' '#1082#1083#1102#1095
      Hint = #1053#1086#1074#1099#1081' '#1082#1083#1102#1095
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewKeyExecute
    end
    object A_EditKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditKeyExecute
    end
    object A_DelKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1102#1095
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1102#1095
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelKeyExecute
    end
    object A_NewProdToKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095
      ImageIndex = 124
      ShortCut = 16429
      Visible = False
      OnExecute = A_NewProdToKeyExecute
    end
    object A_EditProdInKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095#1077
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095#1077
      ImageIndex = 126
      ShortCut = 116
      Visible = False
      OnExecute = A_EditProdInKeyExecute
    end
    object A_DelProdFromKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1082#1083#1102#1095#1072
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1082#1083#1102#1095#1072
      ImageIndex = 125
      Visible = False
      OnExecute = A_DelProdFromKeyExecute
    end
    object A_AddCopyKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1082#1083#1102#1095
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1082#1083#1102#1095
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopyKeyExecute
    end
  end
  inherited SleepTM: TTimer
    Left = 224
    Top = 88
  end
  inherited TmEnabled: TTimer
    Left = 160
    Top = 88
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 280
    Top = 88
  end
  inherited Q_Host: TpFIBDataSet
    RefreshSQL.Strings = (
      'select * from V_KEYS_LIST V'
      'where'
      '  V.KEYS_LIST_ID = :OLD_KEYS_LIST_ID')
    SelectSQL.Strings = (
      'select * from V_KEYS_LIST V'
      'order by'
      '  V.KEY_NUMBER')
    AfterOpen = Q_HostAfterScroll
  end
  inherited dsHost: TDataSource
    Left = 112
    Top = 248
  end
  object Q_Product: TpFIBDataSet
    RefreshSQL.Strings = (
      'select'
      '  K.KEYS_LIST_ID, K.PRODUCT_LIST_ID, K.TRACT_COUNT,'
      '  P.PRODUCT_LIST_TITLE'
      'from PRODUCT_LIST_IN_KEYS K'
      
        '  left join PRODUCT_LIST P        on ( P.PRODUCT_LIST_ID  = K.PR' +
        'ODUCT_LIST_ID )'
      'where'
      '  K.KEYS_LIST_ID = :KEYS_LIST_ID and'
      '  K.PRODUCT_LIST_ID = :OLD_PRODUCT_LIST_ID'
      '')
    SelectSQL.Strings = (
      'select'
      '  K.KEYS_LIST_ID, K.PRODUCT_LIST_ID, K.TRACT_COUNT,'
      '  P.PRODUCT_LIST_TITLE'
      'from PRODUCT_LIST_IN_KEYS K'
      
        '  left join PRODUCT_LIST P        on ( P.PRODUCT_LIST_ID  = K.PR' +
        'ODUCT_LIST_ID )'
      'where'
      '  K.KEYS_LIST_ID = :KEYS_LIST_ID'
      'order by'
      '  P.PRODUCT_LIST_TITLE'
      '')
    AfterOpen = Q_ProductAfterScroll
    AfterScroll = Q_ProductAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    DataSource = dsHost
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 504
    Top = 184
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object dsProduct: TDataSource
    DataSet = Q_Product
    Left = 504
    Top = 248
  end
  object pFIBStoredProc1: TpFIBStoredProc
    Left = 760
    Top = 232
  end
end
