inherited frClienstList: TfrClienstList
  Caption = #1057#1087#1080#1089#1086#1082' '#1082#1083#1080#1077#1085#1090#1086#1074
  ClientHeight = 557
  ClientWidth = 1206
  FormStyle = fsMDIChild
  Visible = True
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitWidth = 1222
  ExplicitHeight = 595
  PixelsPerInch = 96
  TextHeight = 16
  inherited SB: TStatusBar
    Top = 538
    Width = 1206
    ExplicitTop = 538
    ExplicitWidth = 1206
  end
  object PC: TPageControl [1]
    Left = 0
    Top = 0
    Width = 1206
    Height = 538
    ActivePage = tsTraining
    Align = alClient
    Images = frPrima.ImList
    TabOrder = 1
    OnChange = PCChange
    OnChanging = PCChanging
    object tsClients: TTabSheet
      Caption = #1050#1083#1080#1077#1085#1090#1099
      ImageIndex = 64
      object dbgClients: TDBGridEh
        Left = 0
        Top = 0
        Width = 1198
        Height = 507
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsClients
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDblClick = A_EditClientExecute
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgClientsEnter
        OnKeyDown = dbGridKeyDown
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'E_MAIL_LIST'
            Footers = <>
            Title.Caption = 'E-MAIL'
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_FIO'
            Footers = <>
            Title.Caption = #1060#1072#1084#1080#1083#1080#1103' '#1080' '#1080#1085#1080#1094#1080#1072#1083#1099
            Visible = False
            Width = 139
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_TITLE'
            Footers = <>
            Title.Caption = #1060#1048#1054' '#1082#1083#1080#1077#1085#1090#1072' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
            Width = 141
          end
          item
            EditButtons = <>
            FieldName = 'LAND_TITLE'
            Footers = <>
            Title.Caption = #1057#1090#1088#1072#1085#1072
            Visible = False
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'ADDRESS'
            Footers = <>
            Title.Caption = #1040#1076#1088#1077#1089
            Visible = False
            Width = 174
          end
          item
            EditButtons = <>
            FieldName = 'PHONE_LIST'
            Footers = <>
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085#1099
            Width = 178
          end
          item
            EditButtons = <>
            FieldName = 'FIRM_LIST_TITLE'
            Footers = <>
            Title.Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
            Visible = False
            Width = 219
          end
          item
            EditButtons = <>
            FieldName = 'FIRM_LIST_SHORT'
            Footers = <>
            Title.Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
            Width = 206
          end
          item
            EditButtons = <>
            FieldName = 'JOB_POSITION_TITLE'
            Footers = <>
            Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
            Visible = False
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'DESCRIB_TEXT'
            Footers = <>
            Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
            Visible = False
            Width = 124
            WordWrap = True
          end
          item
            EditButtons = <>
            FieldName = 'DATE_REGISTR'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Width = 114
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'IS_SEND_MAIL'
            Footers = <>
            KeyList.Strings = (
              '1'
              '0')
            PickList.Strings = (
              '1'
              '0')
            Title.Caption = #1057#1086#1075#1083#1072#1089#1077#1085' '#1087#1086#1083#1091#1095#1072#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1080
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'PERSONAL_TITLE'
            Footers = <>
            Title.Caption = #1050#1090#1086' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1083
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'GROUP_SUBSCRIBE_LIST'
            Footers = <>
            Title.Caption = #1043#1088#1091#1087#1087#1099
            Width = 179
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsDownload: TTabSheet
      Caption = #1057#1082#1072#1095#1072#1085#1086' '#1082#1083#1080#1077#1085#1090#1086#1084
      ImageIndex = 117
      object dbgDownLoad: TDBGridEh
        Left = 0
        Top = 0
        Width = 1198
        Height = 507
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsDownLoad
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgDownLoadEnter
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DATE_LOAD'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1103
            Width = 127
          end
          item
            EditButtons = <>
            FieldName = 'PRODUCT_LIST_TITLE'
            Footers = <>
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1076#1091#1082#1090#1072
            Width = 400
          end
          item
            EditButtons = <>
            FieldName = 'PRODUCT_VERSION'
            Footers = <>
            Title.Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072
            Width = 153
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsKeys: TTabSheet
      Caption = #1042#1099#1076#1072#1085#1099' '#1082#1083#1102#1095#1080
      ImageIndex = 54
      object spKeys: TSplitter
        Left = 0
        Top = 0
        Width = 5
        Height = 507
        ExplicitLeft = 377
        ExplicitHeight = 447
      end
      object dbgFillKey: TDBGridEh
        Left = 441
        Top = 0
        Width = 757
        Height = 507
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsFillKey
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgFillKeyEnter
        OnKeyDown = dbGridKeyDown
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
      object dbgKeyList: TDBGridEh
        Left = 5
        Top = 0
        Width = 436
        Height = 507
        Align = alLeft
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsKeyList
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
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgKeyListEnter
        OnKeyDown = dbGridKeyDown
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'FIRM_LIST_TITLE'
            Footers = <>
            Title.Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
            Width = 146
          end
          item
            EditButtons = <>
            FieldName = 'KEY_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'DATE_ISSUE'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080' '#1082#1083#1102#1095#1072
            Width = 111
          end
          item
            EditButtons = <>
            FieldName = 'COMMENT_TEXT'
            Footers = <>
            Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1082#1083#1102#1095#1072
            Width = 230
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsDelivery: TTabSheet
      Caption = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      ImageIndex = 7
      object SpDelivery: TSplitter
        Left = 441
        Top = 0
        Width = 5
        Height = 507
        ExplicitLeft = 377
        ExplicitHeight = 447
      end
      object dbgDelivery: TDBGridEh
        Left = 0
        Top = 0
        Width = 441
        Height = 507
        Align = alLeft
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsDelivery
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgDeliveryEnter
        OnKeyDown = dbGridKeyDown
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DOCUM_DATE'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1086#1095#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            Width = 129
          end
          item
            EditButtons = <>
            FieldName = 'DOCUM_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1086#1090#1075#1088#1091#1079#1086#1095#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'FIRM_LIST_TITLE'
            Footers = <>
            Title.Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
            Width = 161
          end
          item
            EditButtons = <>
            FieldName = 'AGREES_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 138
          end
          item
            EditButtons = <>
            FieldName = 'CERTIFICATE'
            Footers = <>
            Title.Caption = #1057#1077#1088#1090#1080#1092#1080#1082#1072#1090
            Width = 126
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object dbgProductOnAgrees: TDBGridEh
        Left = 446
        Top = 0
        Width = 752
        Height = 507
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsProductList
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
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgProductOnAgreesEnter
        OnKeyDown = dbGridKeyDown
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
    end
    object tsTraining: TTabSheet
      Caption = #1054#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 51
      object dbgTraining: TDBGridEh
        Left = 0
        Top = 0
        Width = 1198
        Height = 507
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsTraining
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDblClick = A_EditClientTrainingExecute
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgTrainingEnter
        OnKeyDown = dbGridKeyDown
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DATE_TRAINING'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1079#1072#1085#1103#1090#1080#1081
            Width = 139
          end
          item
            EditButtons = <>
            FieldName = 'TRAINING_LIST_TITLE'
            Footers = <>
            Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1091#1088#1089#1086#1074
            Width = 489
          end
          item
            EditButtons = <>
            FieldName = 'SERTIFICATE_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090#1072
            Width = 169
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsSubscribe: TTabSheet
      Caption = #1043#1088#1091#1087#1087#1099
      ImageIndex = 128
      object dbgSubscribe: TDBGridEh
        Left = 0
        Top = 0
        Width = 1198
        Height = 507
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsSuscribe
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDblClick = A_GroupSubscribeExecute
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgSubscribeEnter
        OnKeyDown = dbGridKeyDown
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'E_MAIL'
            Footers = <>
            Title.Caption = 'E-Mail '#1082#1083#1080#1077#1085#1090#1072
            Width = 370
          end
          item
            EditButtons = <>
            FieldName = 'GROUP_SUBSCRIBE_LIST'
            Footers = <>
            Title.Caption = #1057#1087#1080#1089#1086#1082' '#1075#1088#1091#1087#1087
            Width = 650
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsSendSubscribe: TTabSheet
      Caption = #1054#1090#1087#1088#1072#1074#1083#1077#1085#1085#1099#1077' '#1082#1083#1080#1077#1085#1090#1091' '#1088#1072#1089#1089#1099#1083#1082#1080
      ImageIndex = 6
      object spSendSubscribe: TSplitter
        Left = 553
        Top = 0
        Width = 5
        Height = 507
        Beveled = True
      end
      object dbgSendSubscribe: TDBGridEh
        Left = 0
        Top = 0
        Width = 553
        Height = 507
        Align = alLeft
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsSendSubscribe
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnCellClick = GridCellClick
        OnColEnter = GridColEnter
        OnDblClick = A_GroupSubscribeExecute
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbgSubscribeEnter
        OnKeyDown = dbGridKeyDown
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DATE_ENTER'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'DATE_SEND'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1086#1090#1087#1088#1072#1074#1082#1080
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'SUBJECT'
            Footers = <>
            Title.Caption = #1058#1077#1084#1072
            Width = 186
          end
          item
            EditButtons = <>
            FieldName = 'COPY_ADDRESS'
            Footers = <>
            Title.Caption = #1054#1090#1087#1088#1072#1074#1083#1077#1085#1072' '#1082#1086#1087#1080#1103
            Width = 139
          end
          item
            EditButtons = <>
            FieldName = 'REPLY_ADDRESS'
            Footers = <>
            Title.Caption = #1040#1076#1088#1077#1089' '#1076#1083#1103' '#1086#1090#1074#1077#1090#1072
            Width = 125
          end
          item
            EditButtons = <>
            FieldName = 'PERSONAL_TITLE'
            Footers = <>
            Title.Caption = #1050#1090#1086' '#1086#1090#1087#1088#1072#1074#1083#1103#1083
            Width = 166
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object WB: TWebBrowser
        Left = 558
        Top = 0
        Width = 640
        Height = 507
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 872
        ExplicitTop = 264
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C00000025420000663400000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  inherited FontD: TFontDialog
    Left = 112
    Top = 168
  end
  inherited ActList: TActionList
    Left = 48
    Top = 168
    inherited A_Filtr: TFiltrActList
      SortingResult = True
      DbGrid = dbgClients
      FiltredQuery = Q_Clients
      DlgIdent = 10000
    end
    object A_NewClient: TAction [23]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1053#1086#1074#1099#1081' '#1082#1083#1080#1077#1085#1090
      Hint = #1053#1086#1074#1099#1081' '#1082#1083#1080#1077#1085#1090
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewClientExecute
    end
    object A_EditClient: TAction [24]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditClientExecute
    end
    object A_DelClient: TAction [25]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelClientExecute
    end
    object A_ExportInCSV: TAction [26]
      Category = 'CSV'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1087#1080#1089#1082#1072' '#1082#1083#1080#1077#1085#1090#1086#1074' '#1074' CSV '#1092#1072#1081#1083
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1087#1080#1089#1082#1072' '#1082#1083#1080#1077#1085#1090#1086#1074' '#1074' CSV '#1092#1072#1081#1083
      ImageIndex = 106
      Visible = False
      OnExecute = A_ExportInCSVExecute
    end
    object A_GroupSubscribe: TAction [27]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' E-Mail '#1072#1076#1088#1077#1089' '#1074' '#1075#1088#1091#1087#1087#1091' '#1088#1072#1089#1089#1099#1083#1082#1080
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' E-Mail '#1072#1076#1088#1077#1089' '#1074' '#1075#1088#1091#1087#1087#1091' '#1088#1072#1089#1089#1099#1083#1082#1080
      ImageIndex = 78
      ShortCut = 115
      Visible = False
      OnExecute = A_GroupSubscribeExecute
    end
    object A_AddCopyClient: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopyClientExecute
    end
    object A_NewFirm: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1053#1086#1074#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      Hint = #1053#1086#1074#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      ImageIndex = 59
      Visible = False
      OnExecute = A_NewFirmExecute
    end
    object A_EditFirm: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
      ImageIndex = 80
      Visible = False
      OnExecute = A_EditFirmExecute
    end
    object A_NewClientTraining: TAction
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1053#1086#1074#1086#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1053#1086#1074#1086#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewClientTrainingExecute
    end
    object A_EditClientTraining: TAction
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditClientTrainingExecute
    end
    object A_DelClientTraining: TAction
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelClientTrainingExecute
    end
    object A_AddClientTraining: TAction
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      ShortCut = 120
      Visible = False
      OnExecute = A_AddClientTrainingExecute
    end
  end
  inherited SleepTM: TTimer
    Left = 256
    Top = 168
  end
  inherited TmEnabled: TTimer
    Left = 176
    Top = 168
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 320
    Top = 168
  end
  object Q_Clients: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      
        'select * from V_CLIENT_LIST where CLIENT_LIST_ID = :OLD_CLIENT_L' +
        'IST_ID')
    SelectSQL.Strings = (
      'select * from V_CLIENT_LIST')
    AfterOpen = Q_ClientsAfterScroll
    AfterScroll = Q_ClientsAfterScroll
    BeforeOpen = Q_ClientsBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    AfterRefresh = Q_ClientsAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 608
    Top = 152
    poUseBooleanField = False
  end
  object dsClients: TDataSource
    DataSet = Q_Clients
    Left = 664
    Top = 152
  end
  object Q_Download: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      
        '  D.DOWNLOADINGS_ID, D.DATE_LOAD, D.CLIENT_LIST_ID, D.PRODUCT_LI' +
        'ST_ID, D.PRODUCT_VERSION,'
      '  PL.PRODUCT_LIST_TITLE'
      'from DOWNLOADINGS D'
      
        '  left join PRODUCT_LIST PL      on ( PL.PRODUCT_LIST_ID   = D.P' +
        'RODUCT_LIST_ID )'
      'where'
      '  D.CLIENT_LIST_ID = :CLIENT_LIST_ID and'
      '  D.IS_DELETE > 0 and'
      '  D.DOWNLOADINGS_ID = :OLD_DOWNLOADINGS_ID')
    SelectSQL.Strings = (
      'select'
      
        '  D.DOWNLOADINGS_ID, D.DATE_LOAD, D.CLIENT_LIST_ID, D.PRODUCT_LI' +
        'ST_ID, D.PRODUCT_VERSION,'
      '  PL.PRODUCT_LIST_TITLE'
      'from DOWNLOADINGS D'
      
        '  left join PRODUCT_LIST PL      on ( PL.PRODUCT_LIST_ID   = D.P' +
        'RODUCT_LIST_ID )'
      'where'
      '  D.CLIENT_LIST_ID = :CLIENT_LIST_ID  and'
      '  PL.IS_DELETE > 0'
      'order by'
      '  D.DATE_LOAD desc')
    AfterScroll = Q_DownloadAfterScroll
    BeforeOpen = Q_DownloadBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 608
    Top = 208
    poUseBooleanField = False
  end
  object dsDownLoad: TDataSource
    DataSet = Q_Download
    Left = 672
    Top = 208
  end
  object dsKeyList: TDataSource
    DataSet = Q_KeyList
    Left = 832
    Top = 152
  end
  object Q_FillKey: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      '  K.KEYS_LIST_ID, K.PRODUCT_LIST_ID, K.TRACT_COUNT,'
      '  P.PRODUCT_LIST_TITLE'
      'from PRODUCT_LIST_IN_KEYS K'
      
        '  left join PRODUCT_LIST P        on ( P.PRODUCT_LIST_ID  = K.PR' +
        'ODUCT_LIST_ID )'
      'where'
      '  K.KEYS_LIST_ID = :KEYS_LIST_ID and'
      '  K.PRODUCT_LIST_ID = :OLD_PRODUCT_LIST_ID')
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
      '  P.PRODUCT_LIST_TITLE')
    AfterOpen = Q_FillKeyAfterScroll
    AfterScroll = Q_FillKeyAfterScroll
    BeforeOpen = Q_FillKeyBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    AfterRefresh = Q_FillKeyAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DataSource = dsKeyList
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 768
    Top = 216
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object dsFillKey: TDataSource
    DataSet = Q_FillKey
    Left = 832
    Top = 216
  end
  object Q_Delivery: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      '  D.AGREES_LIST_ID, A.FIRM_LIST_ID,'
      
        '  cast( DATE_FORMAT( A.AGREES_NUMBER || '#39' '#1086#1090' dd.mm.yyyy'#39', A.AGRE' +
        'ES_DATE ) as varchar( 48 )) as AGREES_NUMBER,'
      
        '  D.SOFT_DELIVERY_ID, D.DOCUM_NUMBER, D.DOCUM_DATE, D.CERTIFICAT' +
        'E,'
      '  F.FIRM_LIST_TITLE, F.FIRM_LIST_SHORT'
      'from SOFT_DELIVERY D'
      
        '       join AGREES_LIST A    on ( A.AGREES_LIST_ID = D.AGREES_LI' +
        'ST_ID )'
      
        '  left join FIRM_LIST F      on ( F.FIRM_LIST_ID   = A.FIRM_LIST' +
        '_ID )'
      'where'
      '  D.IS_DELETE > 0 and'
      '  A.FIRM_LIST_ID = :FIRM_LIST_ID and'
      '  D.SOFT_DELIVERY_ID = :OLD_SOFT_DELIVERY_ID'
      '')
    SelectSQL.Strings = (
      'select'
      '  D.AGREES_LIST_ID, A.FIRM_LIST_ID,'
      
        '  cast( DATE_FORMAT( A.AGREES_NUMBER || '#39' '#1086#1090' dd.mm.yyyy'#39', A.AGRE' +
        'ES_DATE ) as varchar( 48 )) as AGREES_NUMBER,'
      
        '  D.SOFT_DELIVERY_ID, D.DOCUM_NUMBER, D.DOCUM_DATE, D.CERTIFICAT' +
        'E,'
      '  F.FIRM_LIST_TITLE, F.FIRM_LIST_SHORT'
      'from SOFT_DELIVERY D'
      
        '       join AGREES_LIST A    on ( A.AGREES_LIST_ID = D.AGREES_LI' +
        'ST_ID )'
      
        '  left join FIRM_LIST F      on ( F.FIRM_LIST_ID   = A.FIRM_LIST' +
        '_ID )'
      'where'
      '  D.IS_DELETE > 0 and'
      '  A.FIRM_LIST_ID = :FIRM_LIST_ID'
      'order by'
      '  D.DOCUM_DATE')
    AfterOpen = Q_DeliveryAfterScroll
    AfterScroll = Q_DeliveryAfterScroll
    BeforeOpen = Q_DeliveryBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    AfterRefresh = Q_DeliveryAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 936
    Top = 152
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object dsDelivery: TDataSource
    DataSet = Q_Delivery
    Left = 1008
    Top = 152
  end
  object Q_ProductList: TpFIBDataSet
    MDTSQLExecutor = se_Server
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
      '  S.SOFT_LIST_IN_DELIVERY_ID = :OLD_SOFT_LIST_IN_DELIVERY_ID')
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
    AfterOpen = Q_ProductListAfterScroll
    AfterScroll = Q_ProductListAfterScroll
    BeforeOpen = Q_ProductListBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    AfterRefresh = Q_ProductListAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DataSource = dsDelivery
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 936
    Top = 216
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceOpen = True
    dcIgnoreMasterClose = True
  end
  object dsProductList: TDataSource
    DataSet = Q_ProductList
    Left = 1008
    Top = 216
  end
  object Q_Training: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      
        '  CT.CLIENT_TRAINING_ID, CT.TRAINING_LIST_ID, CT.CLIENT_LIST_ID,' +
        ' CT.IS_DELETE, CT.SERTIFICATE_NUMBER,'
      '  TL.TRAINING_LIST_TITLE, TL.DATE_TRAINING'
      'from CLIENT_TRAINING CT'
      
        '  left join TRAINING_LIST TL          on ( TL.TRAINING_LIST_ID  ' +
        '    = CT.TRAINING_LIST_ID )'
      'where'
      '  CT.CLIENT_LIST_ID  = :CLIENT_LIST_ID and'
      '  CT.IS_DELETE > 0 and'
      '  CT.CLIENT_TRAINING_ID = :OLD_CLIENT_TRAINING_ID')
    SelectSQL.Strings = (
      'select'
      
        '  CT.CLIENT_TRAINING_ID, CT.TRAINING_LIST_ID, CT.CLIENT_LIST_ID,' +
        ' CT.IS_DELETE, CT.SERTIFICATE_NUMBER,'
      '  TL.TRAINING_LIST_TITLE, TL.DATE_TRAINING'
      'from CLIENT_TRAINING CT'
      
        '  left join TRAINING_LIST TL          on ( TL.TRAINING_LIST_ID  ' +
        '    = CT.TRAINING_LIST_ID )'
      'where'
      '  CT.CLIENT_LIST_ID  = :CLIENT_LIST_ID and'
      '  CT.IS_DELETE > 0'
      'order by'
      '  TL.DATE_TRAINING desc')
    AfterOpen = Q_TrainingAfterScroll
    AfterScroll = Q_TrainingAfterScroll
    BeforeOpen = Q_TrainingBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    AfterRefresh = Q_TrainingAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 608
    Top = 272
    poUseBooleanField = False
  end
  object dsTraining: TDataSource
    DataSet = Q_Training
    Left = 672
    Top = 272
  end
  object Q_KeyList: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'Select'
      '  *'
      'from V_KEYS_LIST K'
      'where'
      '  K.IS_DELETE > 0 and'
      '  K.FIRM_LIST_ID = :FIRM_LIST_ID and'
      '  K.KEYS_LIST_ID = :OLD_KEYS_LIST_ID')
    SelectSQL.Strings = (
      'Select'
      '  *'
      'from V_KEYS_LIST K'
      'where'
      '  K.IS_DELETE > 0 and'
      '  K.FIRM_LIST_ID = :FIRM_LIST_ID'
      'order by'
      '  K.KEY_NUMBER'
      ''
      '')
    AfterOpen = Q_KeyListAfterScroll
    AfterScroll = Q_KeyListAfterScroll
    BeforeOpen = Q_KeyListBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    AfterRefresh = Q_KeyListAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 768
    Top = 152
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object Q_Subscribe: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      
        '  CM.CLIENTS_MAIL_LIST_ID, CM.CLIENT_LIST_ID, CM.FIRM_LIST_ID, C' +
        'M.E_MAIL,'
      '  ( select'
      '      list( distinct G.SUBSCRIBE_GROUP_TITLE )'
      '    from SUBSCRIBE_GROUP G'
      
        '      join SUBSCRIBE_GROUP_MAIL_LINK ML    on ( ML.SUBSCRIBE_GRO' +
        'UP_ID = G.SUBSCRIBE_GROUP_ID )'
      '    where'
      '      ML.CLIENTS_MAIL_LIST_ID = CM.CLIENTS_MAIL_LIST_ID and'
      '      G.IS_DELETE > 0 ) as GROUP_SUBSCRIBE_LIST'
      'from CLIENTS_MAIL_LIST CM'
      'where'
      '  CM.CLIENT_LIST_ID = :CLIENT_LIST_ID and'
      '  CM.CLIENTS_MAIL_LIST_ID = :OLD_CLIENTS_MAIL_LIST_ID'
      '')
    SelectSQL.Strings = (
      'select'
      
        '  CM.CLIENTS_MAIL_LIST_ID, CM.CLIENT_LIST_ID, CM.FIRM_LIST_ID, C' +
        'M.E_MAIL,'
      '  ( select'
      '      list( distinct G.SUBSCRIBE_GROUP_TITLE )'
      '    from SUBSCRIBE_GROUP G'
      
        '      join SUBSCRIBE_GROUP_MAIL_LINK ML    on ( ML.SUBSCRIBE_GRO' +
        'UP_ID = G.SUBSCRIBE_GROUP_ID )'
      '    where'
      '      ML.CLIENTS_MAIL_LIST_ID = CM.CLIENTS_MAIL_LIST_ID and'
      '      G.IS_DELETE > 0 ) as GROUP_SUBSCRIBE_LIST'
      'from CLIENTS_MAIL_LIST CM'
      'where'
      '  CM.CLIENT_LIST_ID = :CLIENT_LIST_ID'
      'order by'
      '  CM.E_MAIL')
    AfterOpen = Q_SubscribeAfterScroll
    AfterScroll = Q_SubscribeAfterScroll
    BeforeOpen = Q_SubscribeBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    AfterRefresh = Q_SubscribeAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 608
    Top = 344
    poUseBooleanField = False
  end
  object dsSuscribe: TDataSource
    DataSet = Q_Subscribe
    Left = 672
    Top = 344
  end
  object Q_SendSubscribe: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      '  S.SUBSCRIBE_LIST_ID, S.SUBSCRIBE_GROUP_ID,'
      
        '  S.MAIL_BODY, S.COPY_ADDRESS, S.REPLY_ADDRESS, S.SUBJECT, S.DAT' +
        'E_ENTER, SS.DATE_SEND, S.PERSONAL_ID,'
      
        '  P.PERSONAL_TITLE, ML.E_MAIL, ML.CLIENTS_MAIL_LIST_ID, ML.CLIEN' +
        'T_LIST_ID'
      'from SUBSCRIBE_LIST S'
      
        '       join SUBSCRIBE_SEND SS       on ( SS.SUBSCRIBE_LIST_ID   ' +
        ' = S.SUBSCRIBE_LIST_ID )'
      
        '       join V_CLIENTS_MAIL_LIST ML  on ( ML.CLIENTS_MAIL_LIST_ID' +
        ' = SS.CLIENTS_MAIL_LIST_ID )'
      
        '  left join PERSONAL P              on ( P.PERSONAL_ID          ' +
        ' = S.PERSONAL_ID )'
      ''
      'where'
      '  S.IS_DELETE > 0 and'
      '  S.IS_SEND = 1 and'
      '  SS.DATE_SEND is not null and'
      '  SS.IS_OK = 1 and'
      '  ML.CLIENT_LIST_ID = :CLIENT_LIST_ID and'
      '  ML.CLIENTS_MAIL_LIST_ID = :OLD_CLIENTS_MAIL_LIST_ID and'
      '  S.SUBSCRIBE_LIST_ID = :OLD_SUBSCRIBE_LIST_ID'
      '')
    SelectSQL.Strings = (
      'select'
      '  S.SUBSCRIBE_LIST_ID, S.SUBSCRIBE_GROUP_ID,'
      
        '  S.MAIL_BODY, S.COPY_ADDRESS, S.REPLY_ADDRESS, S.SUBJECT, S.DAT' +
        'E_ENTER, SS.DATE_SEND, S.PERSONAL_ID,'
      
        '  P.PERSONAL_TITLE, ML.E_MAIL, ML.CLIENTS_MAIL_LIST_ID, ML.CLIEN' +
        'T_LIST_ID'
      'from SUBSCRIBE_LIST S'
      
        '       join SUBSCRIBE_SEND SS       on ( SS.SUBSCRIBE_LIST_ID   ' +
        ' = S.SUBSCRIBE_LIST_ID )'
      
        '       join V_CLIENTS_MAIL_LIST ML  on ( ML.CLIENTS_MAIL_LIST_ID' +
        ' = SS.CLIENTS_MAIL_LIST_ID )'
      
        '  left join PERSONAL P              on ( P.PERSONAL_ID          ' +
        ' = S.PERSONAL_ID )'
      ''
      'where'
      '  S.IS_DELETE > 0 and'
      '  S.IS_SEND = 1 and'
      '  SS.DATE_SEND is not null and'
      '  SS.IS_OK = 1 and'
      '  ML.CLIENT_LIST_ID = :CLIENT_LIST_ID'
      'order by'
      '  SS.DATE_SEND')
    AfterScroll = Q_SendSubscribeAfterScroll
    BeforeOpen = Q_SendSubscribeBeforeOpen
    BeforeScroll = Q_ClientsBeforeScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = Q_SendSubscribeEndScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 768
    Top = 288
    poUseBooleanField = False
  end
  object dsSendSubscribe: TDataSource
    DataSet = Q_SendSubscribe
    Left = 832
    Top = 288
  end
end
