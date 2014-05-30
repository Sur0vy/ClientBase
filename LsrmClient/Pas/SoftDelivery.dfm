inherited frSoftDelivery: TfrSoftDelivery
  Caption = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
  ClientHeight = 538
  ClientWidth = 990
  ExplicitWidth = 1006
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 16
  object SpDelivery: TSplitter [0]
    Left = 385
    Top = 0
    Width = 5
    Height = 519
    ExplicitLeft = 297
    ExplicitHeight = 439
  end
  inherited SB: TStatusBar
    Top = 519
    Width = 990
    ExplicitTop = 519
    ExplicitWidth = 990
  end
  inherited dbgHost: TDBGridEh
    Width = 385
    Height = 519
    Align = alLeft
    OnDblClick = A_EditDeliveryExecute
    OnKeyDown = dbgHostKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'DOCUM_DATE'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1086#1095#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Width = 114
      end
      item
        EditButtons = <>
        FieldName = 'DOCUM_NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1086#1090#1075#1088#1091#1079#1086#1095#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'DOC_TYPE_LIST_TITLE'
        Footers = <>
        Title.Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Width = 136
      end
      item
        EditButtons = <>
        FieldName = 'AGREE_STATUS_LIST_TITLE'
        Footers = <>
        Title.Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Width = 119
      end
      item
        EditButtons = <>
        FieldName = 'AGREES_NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 150
      end
      item
        EditButtons = <>
        FieldName = 'CERTIFICATE'
        Footers = <>
        Title.Caption = #1057#1077#1088#1090#1080#1092#1080#1082#1072#1090
        Width = 145
      end
      item
        EditButtons = <>
        FieldName = 'FIRM_LIST_SHORT'
        Footers = <>
        Title.Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        Width = 164
      end
      item
        EditButtons = <>
        FieldName = 'FIRM_LIST_TITLE'
        Footers = <>
        Title.Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
        Visible = False
        Width = 150
      end
      item
        EditButtons = <>
        FieldName = 'DOCUM_COMMENT'
        Footers = <>
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 153
      end>
  end
  object dbgProductList: TDBGridEh [3]
    Left = 390
    Top = 0
    Width = 600
    Height = 519
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
    OnDblClick = A_EditProductExecute
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
        Width = 334
      end
      item
        EditButtons = <>
        FieldName = 'PRODUCT_VERSION'
        Footers = <>
        Title.Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072
        Width = 104
      end
      item
        EditButtons = <>
        FieldName = 'PRODUCT_COUNT'
        Footers = <>
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1082#1079#1077#1084#1087#1083#1103#1088#1086#1074
        Width = 119
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  inherited FontD: TFontDialog
    Left = 104
    Top = 96
  end
  inherited ActList: TActionList
    Left = 40
    Top = 96
    inherited A_Filtr: TFiltrActList
      SortingResult = True
    end
    object A_NewDelivery: TAction
      Category = #1054#1090#1075#1088#1091#1079#1082#1080
      Caption = #1053#1086#1074#1072#1103' '#1086#1090#1075#1088#1091#1079#1082#1072
      Hint = #1053#1086#1074#1072#1103' '#1086#1090#1075#1088#1091#1079#1082#1072
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewDeliveryExecute
    end
    object A_EditDelivery: TAction
      Category = #1054#1090#1075#1088#1091#1079#1082#1080
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditDeliveryExecute
    end
    object A_DelDelivery: TAction
      Category = #1054#1090#1075#1088#1091#1079#1082#1080
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelDeliveryExecute
    end
    object A_NewProduct: TAction
      Category = #1057#1087#1080#1089#1086#1082' '#1087#1088#1086#1076#1091#1082#1090#1086#1074' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088
      ImageIndex = 124
      ShortCut = 16429
      Visible = False
      OnExecute = A_NewProductExecute
    end
    object A_EditProduct: TAction
      Category = #1057#1087#1080#1089#1086#1082' '#1087#1088#1086#1076#1091#1082#1090#1086#1074' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
      ImageIndex = 126
      ShortCut = 116
      OnExecute = A_EditProductExecute
    end
    object A_DelProduct: TAction
      Category = #1057#1087#1080#1089#1086#1082' '#1087#1088#1086#1076#1091#1082#1090#1086#1074' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1076#1086#1075#1086#1074#1086#1088#1072
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1076#1086#1075#1086#1074#1086#1088#1072
      ImageIndex = 125
      Visible = False
      OnExecute = A_DelProductExecute
    end
    object A_AddCopyDelivery: TAction
      Category = #1054#1090#1075#1088#1091#1079#1082#1080
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1086#1090#1075#1088#1091#1079#1082#1091
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1086#1090#1075#1088#1091#1079#1082#1091
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopyDeliveryExecute
    end
    object A_NewAgrees: TAction
      Category = #1054#1090#1075#1088#1091#1079#1082#1080
      Caption = #1053#1086#1074#1099#1081' '#1076#1086#1075#1086#1074#1086#1088' '#1089' '#1082#1083#1080#1077#1085#1090#1086#1084
      Hint = #1053#1086#1074#1099#1081' '#1076#1086#1075#1086#1074#1086#1088' '#1089' '#1082#1083#1080#1077#1085#1090#1086#1084
      ImageIndex = 88
      Visible = False
      OnExecute = A_NewAgreesExecute
    end
  end
  inherited SleepTM: TTimer
    Left = 248
    Top = 96
  end
  inherited TmEnabled: TTimer
    Left = 168
    Top = 96
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 320
    Top = 96
  end
  inherited Q_Host: TpFIBDataSet
    RefreshSQL.Strings = (
      'select * from V_SOFT_DELIVERY'
      'where'
      '  SOFT_DELIVERY_ID = :OLD_SOFT_DELIVERY_ID')
    SelectSQL.Strings = (
      'select * from V_SOFT_DELIVERY'
      'order by'
      '  DOCUM_DATE')
    AfterOpen = Q_HostAfterScroll
  end
  inherited dsHost: TDataSource
    Left = 112
    Top = 248
  end
  object Q_Product: TpFIBDataSet
    RefreshSQL.Strings = (
      'select'
      
        '  S.SOFT_LIST_IN_DELIVERY_ID, S.SOFT_DELIVERY_ID, S.PRODUCT_LIST' +
        '_ID, S.PRODUCT_VERSION,'
      '  S.PRODUCT_COUNT, S.IS_DELETE,'
      '  L.PRODUCT_LIST_TITLE'
      'from SOFT_LIST_IN_DELIVERY S'
      
        '  left join PRODUCT_LIST L      on ( L.PRODUCT_LIST_ID = S.PRODU' +
        'CT_LIST_ID )'
      'where'
      '  S.IS_DELETE > 0 and'
      '  S.SOFT_DELIVERY_ID = :SOFT_DELIVERY_ID and'
      '  S.SOFT_LIST_IN_DELIVERY_ID = :OLD_SOFT_LIST_IN_DELIVERY_ID'
      ''
      '')
    SelectSQL.Strings = (
      'select'
      
        '  S.SOFT_LIST_IN_DELIVERY_ID, S.SOFT_DELIVERY_ID, S.PRODUCT_LIST' +
        '_ID, S.PRODUCT_VERSION,'
      '  S.PRODUCT_COUNT, S.IS_DELETE,'
      '  L.PRODUCT_LIST_TITLE'
      'from SOFT_LIST_IN_DELIVERY S'
      
        '  left join PRODUCT_LIST L      on ( L.PRODUCT_LIST_ID = S.PRODU' +
        'CT_LIST_ID )'
      'where'
      '  S.IS_DELETE > 0 and'
      '  S.SOFT_DELIVERY_ID = :SOFT_DELIVERY_ID'
      'order by'
      '  L.PRODUCT_LIST_TITLE'
      '')
    AfterOpen = Q_ProductAfterScroll
    AfterScroll = Q_ProductAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    DataSource = dsHost
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 440
    Top = 200
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object dsProduct: TDataSource
    DataSet = Q_Product
    Left = 440
    Top = 264
  end
end
