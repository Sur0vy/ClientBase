inherited frFirmList: TfrFirmList
  Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
  ClientHeight = 596
  ClientWidth = 1168
  FormStyle = fsMDIChild
  Visible = True
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitWidth = 1184
  ExplicitHeight = 634
  PixelsPerInch = 96
  TextHeight = 16
  inherited SB: TStatusBar
    Top = 577
    Width = 1168
    ExplicitTop = 577
    ExplicitWidth = 1452
  end
  object PC: TPageControl [1]
    Left = 0
    Top = 0
    Width = 1168
    Height = 577
    ActivePage = tsTraining
    Align = alClient
    Images = frPrima.ImList
    TabOrder = 1
    OnChange = PCChange
    OnChanging = PCChanging
    ExplicitWidth = 1452
    object tsFirmList: TTabSheet
      Caption = #1057#1087#1080#1089#1086#1082' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
      ImageIndex = 97
      ExplicitWidth = 1444
      object dbgFirmList: TDBGridEh
        Left = 0
        Top = 0
        Width = 1160
        Height = 546
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsFirmList
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
        OnDblClick = A_EditFirmExecute
        OnDrawColumnCell = GridDrawColumnCell
        OnEnter = dbGridEnter
        OnKeyDown = dbGridKeyDown
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'FIRM_LIST_TITLE'
            Footers = <>
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
            Width = 188
          end
          item
            EditButtons = <>
            FieldName = 'FIRM_LIST_SHORT'
            Footers = <>
            Title.Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'E_MAIL_LIST'
            Footers = <>
            Title.Caption = 'E-Mail'
            Width = 126
          end
          item
            EditButtons = <>
            FieldName = 'LAND_TITLE'
            Footers = <>
            Title.Caption = #1057#1090#1088#1072#1085#1072
            Visible = False
            Width = 108
          end
          item
            EditButtons = <>
            FieldName = 'POST_ADDRESS'
            Footers = <>
            Title.Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
            Visible = False
            Width = 166
          end
          item
            EditButtons = <>
            FieldName = 'LEGAL_ADDRESS'
            Footers = <>
            Title.Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
            Visible = False
            Width = 127
          end
          item
            EditButtons = <>
            FieldName = 'BANK_TITLE'
            Footers = <>
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1073#1072#1085#1082#1072
            Visible = False
            Width = 142
          end
          item
            EditButtons = <>
            FieldName = 'BANK_BIK'
            Footers = <>
            Title.Caption = #1041#1048#1050' '#1073#1072#1085#1082#1072
            Visible = False
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'SETT_ACCOUNT'
            Footers = <>
            Title.Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
            Visible = False
            Width = 122
          end
          item
            EditButtons = <>
            FieldName = 'CORRESP_ACCOUNT'
            Footers = <>
            Title.Caption = #1050#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1089#1082#1080#1081' '#1089#1095#1077#1090
            Visible = False
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'INN'
            Footers = <>
            Title.Caption = #1048#1053#1053
            Visible = False
            Width = 123
          end
          item
            EditButtons = <>
            FieldName = 'KPP'
            Footers = <>
            Title.Caption = #1050#1055#1055
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'FAX_NUMBER'
            Footers = <>
            Title.Caption = #1060#1072#1082#1089
            Width = 115
          end
          item
            EditButtons = <>
            FieldName = 'PHONE_LIST'
            Footers = <>
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085#1099
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'WWW_TEXT'
            Footers = <>
            Title.Caption = #1057#1072#1081#1090
            Width = 127
          end
          item
            EditButtons = <>
            FieldName = 'DIRECTOR_NAME'
            Footers = <>
            Title.Caption = #1060#1048#1054' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
            Width = 118
          end
          item
            EditButtons = <>
            FieldName = 'JOB_POSITION_TITLE'
            Footers = <>
            Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
            Width = 134
          end
          item
            EditButtons = <>
            FieldName = 'DESCRIB_TEXT'
            Footers = <>
            Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
            Visible = False
            Width = 181
          end
          item
            EditButtons = <>
            FieldName = 'DATE_REGISTR'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Visible = False
            Width = 171
          end
          item
            EditButtons = <>
            FieldName = 'PERSONAL_TITLE'
            Footers = <>
            Title.Caption = #1050#1090#1086' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1083
            Visible = False
            Width = 165
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsEmployee: TTabSheet
      Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1080' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      ImageIndex = 71
      ExplicitWidth = 1444
      object dbgEmployee: TDBGridEh
        Left = 0
        Top = 0
        Width = 1160
        Height = 546
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsEmployee
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
        OnEnter = dbGridEnter
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
            FieldName = 'CLIENT_TITLE'
            Footers = <>
            Title.Caption = #1060#1048#1054' '#1082#1083#1080#1077#1085#1090#1072' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
            Width = 141
          end
          item
            EditButtons = <>
            FieldName = 'MOBIL_NUMBER'
            Footers = <>
            Title.Caption = #1052#1086#1073#1080#1083#1100#1085#1099#1081' '#1090#1077#1083#1077#1092#1086#1085
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'JOB_PHONE_NUMBER'
            Footers = <>
            Title.Caption = #1056#1072#1073#1086#1095#1080#1081' '#1090#1077#1083#1077#1092#1086#1085
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'PHONE_NUMBER'
            Footers = <>
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085
            Width = 102
          end
          item
            EditButtons = <>
            FieldName = 'JOB_POSITION_TITLE'
            Footers = <>
            Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'DESCRIB_TEXT'
            Footers = <>
            Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
            Width = 124
            WordWrap = True
          end
          item
            EditButtons = <>
            FieldName = 'DATE_REGISTR'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Width = 90
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
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'GROUP_SUBSCRIBE_LIST'
            Footers = <>
            Title.Caption = #1043#1088#1091#1087#1087#1099
            Width = 100
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsKeys: TTabSheet
      Caption = #1042#1099#1076#1072#1085#1099' '#1082#1083#1102#1095#1080
      ImageIndex = 54
      ExplicitWidth = 1444
      object spKeys: TSplitter
        Left = 337
        Top = 0
        Width = 5
        Height = 546
        ExplicitLeft = 377
        ExplicitHeight = 447
      end
      object dbgFillKey: TDBGridEh
        Left = 342
        Top = 0
        Width = 818
        Height = 546
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
        OnDblClick = A_EditProdInKeyExecute
        OnEnter = dbGridEnter
        OnKeyDown = dbGridKeyDown
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
        Left = 0
        Top = 0
        Width = 337
        Height = 546
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
        OnDblClick = A_EditKeyExecute
        OnEnter = dbGridEnter
        OnKeyDown = dbGridKeyDown
        Columns = <
          item
            EditButtons = <>
            FieldName = 'KEY_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072
            Width = 251
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsAgreesList: TTabSheet
      Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      ImageIndex = 63
      ExplicitWidth = 1444
      object dbgAgreesList: TDBGridEh
        Left = 0
        Top = 0
        Width = 1160
        Height = 546
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsAgreesList
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
        OnDblClick = A_EditAgreesExecute
        OnEnter = dbGridEnter
        OnKeyDown = dbGridKeyDown
        Columns = <
          item
            EditButtons = <>
            FieldName = 'AGREES_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 155
          end
          item
            EditButtons = <>
            FieldName = 'AGREES_DATE'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 134
          end
          item
            EditButtons = <>
            FieldName = 'CONTRACT_TYPE_LIST_TITLE'
            Footers = <>
            Title.Caption = #1058#1080#1087' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'AGREE_STATUS_LIST_TITLE'
            Footers = <>
            Title.Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 164
          end
          item
            EditButtons = <>
            FieldName = 'AGREES_COMMENT'
            Footers = <>
            Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
            Width = 211
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsDeliveryList: TTabSheet
      Caption = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      ImageIndex = 7
      ExplicitWidth = 1444
      object SpAgrees: TSplitter
        Left = 449
        Top = 0
        Width = 5
        Height = 546
        ExplicitLeft = 377
        ExplicitHeight = 447
      end
      object dbgDelivery: TDBGridEh
        Left = 0
        Top = 0
        Width = 449
        Height = 546
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
        OnEnter = dbGridEnter
        OnKeyDown = dbGridKeyDown
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DOCUM_DATE'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1086#1095#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'DOCUM_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1086#1090#1075#1088#1091#1079#1086#1095#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            Width = 119
          end
          item
            EditButtons = <>
            FieldName = 'DOC_TYPE_LIST_TITLE'
            Footers = <>
            Title.Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'AGREE_STATUS_LIST_TITLE'
            Footers = <>
            Title.Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'CERTIFICATE'
            Footers = <>
            Title.Caption = #1057#1077#1088#1090#1080#1092#1080#1082#1072#1090
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'AGREES_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'AGREES_DATE'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 134
          end
          item
            EditButtons = <>
            FieldName = 'DOCUM_COMMENT'
            Footers = <>
            Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
            Width = 200
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object dbgProductOnAgrees: TDBGridEh
        Left = 454
        Top = 0
        Width = 706
        Height = 546
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
        OnDblClick = A_EditProductExecute
        OnEnter = dbGridEnter
        OnKeyDown = dbGridKeyDown
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
      ExplicitWidth = 1444
      object dbgTraining: TDBGridEh
        Left = 0
        Top = 0
        Width = 1160
        Height = 546
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
        OnEnter = dbGridEnter
        OnKeyDown = dbGridKeyDown
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DATE_TRAINING'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1079#1072#1085#1103#1090#1080#1081
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'TRAINING_LIST_TITLE'
            Footers = <>
            Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1091#1088#1089#1086#1074
            Width = 471
          end
          item
            EditButtons = <>
            FieldName = 'SERTIFICATE_NUMBER'
            Footers = <>
            Title.Caption = #1053#1086#1084#1077#1088' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090#1072
            Width = 169
          end
          item
            EditButtons = <>
            FieldName = 'CLIENT_TITLE'
            Footers = <>
            Title.Caption = #1050#1083#1080#1077#1085#1090
            Width = 250
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited FontD: TFontDialog
    Left = 112
    Top = 272
  end
  inherited ActList: TActionList
    Left = 48
    Top = 272
    inherited A_Filtr: TFiltrActList
      SortingResult = True
      DbGrid = dbgFirmList
      FiltredQuery = Q_FirmList
    end
    object A_NewFirm: TAction [23]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1053#1086#1074#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      Hint = #1053#1086#1074#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewFirmExecute
    end
    object A_EditFirm: TAction [24]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditFirmExecute
    end
    object A_DelFirm: TAction [25]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelFirmExecute
    end
    object A_NewKey: TAction [26]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1053#1086#1074#1099#1081' '#1082#1083#1102#1095
      Hint = #1053#1086#1074#1099#1081' '#1082#1083#1102#1095
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewKeyExecute
    end
    object A_EditKey: TAction [27]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditKeyExecute
    end
    object A_DelKey: TAction [28]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1102#1095
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1102#1095
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelKeyExecute
    end
    object A_NewProdToKey: TAction [29]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095
      ImageIndex = 124
      ShortCut = 16429
      Visible = False
      OnExecute = A_NewProdToKeyExecute
    end
    object A_EditProdInKey: TAction [30]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095#1077
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1082#1083#1102#1095#1077
      ImageIndex = 126
      ShortCut = 116
      Visible = False
      OnExecute = A_EditProdInKeyExecute
    end
    object A_DelProdFromKey: TAction [31]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1082#1083#1102#1095#1072
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1082#1083#1102#1095#1072
      ImageIndex = 125
      Visible = False
      OnExecute = A_DelProdFromKeyExecute
    end
    object A_NewAgrees: TAction [32]
      Category = #1057#1087#1080#1089#1086#1082' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      Caption = #1053#1086#1074#1099#1081' '#1076#1086#1075#1086#1074#1086#1088' '#1085#1072' '#1087#1086#1082#1091#1087#1082#1091
      Hint = #1053#1086#1074#1099#1081' '#1076#1086#1075#1086#1074#1086#1088' '#1085#1072' '#1087#1086#1082#1091#1087#1082#1091
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewAgreesExecute
    end
    object A_EditAgrees: TAction [33]
      Category = #1057#1087#1080#1089#1086#1082' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1075#1086#1074#1086#1088
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1075#1086#1074#1086#1088
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditAgreesExecute
    end
    object A_DelAgrees: TAction [34]
      Category = #1057#1087#1080#1089#1086#1082' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1075#1086#1074#1086#1088' '#1085#1072' '#1087#1086#1082#1091#1087#1082#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1075#1086#1074#1086#1088' '#1085#1072' '#1087#1086#1082#1091#1087#1082#1091
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelAgreesExecute
    end
    object A_NewDelivery: TAction [35]
      Category = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      Caption = #1053#1086#1074#1072#1103' '#1086#1090#1075#1088#1091#1079#1082#1072
      Hint = #1053#1086#1074#1072#1103' '#1086#1090#1075#1088#1091#1079#1082#1072
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewDeliveryExecute
    end
    object A_EditDelivery: TAction [36]
      Category = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditDeliveryExecute
    end
    object A_DelDelivery: TAction [37]
      Category = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1086#1090#1075#1088#1091#1079#1082#1091
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelDeliveryExecute
    end
    object A_NewProduct: TAction [38]
      Category = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088
      ImageIndex = 124
      ShortCut = 16429
      Visible = False
      OnExecute = A_NewProductExecute
    end
    object A_EditProduct: TAction [39]
      Category = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
      ImageIndex = 126
      ShortCut = 116
      Visible = False
      OnExecute = A_EditProductExecute
    end
    object A_DelProduct: TAction [40]
      Category = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1076#1086#1075#1086#1074#1086#1088#1072
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090' '#1080#1079' '#1076#1086#1075#1086#1074#1086#1088#1072
      ImageIndex = 125
      Visible = False
      OnExecute = A_DelProductExecute
    end
    object A_NewClientTraining: TAction [41]
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1053#1086#1074#1086#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1053#1086#1074#1086#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 30
      ShortCut = 45
      Visible = False
    end
    object A_EditClientTraining: TAction [42]
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 60
      ShortCut = 115
      Visible = False
    end
    object A_DelClientTraining: TAction [43]
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 27
      Visible = False
    end
    object A_AddCopyAgrees: TAction
      Category = #1057#1087#1080#1089#1086#1082' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1075#1086#1074#1086#1088
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1075#1086#1074#1086#1088
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopyAgreesExecute
    end
    object A_AddCopyFirm: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      ShortCut = 120
      OnExecute = A_AddCopyFirmExecute
    end
    object A_AddCopyKey: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1102#1095#1077#1081
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1082#1083#1102#1095
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1082#1083#1102#1095
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopyKeyExecute
    end
    object A_AddClientTraining: TAction
      Category = #1054#1073#1091#1095#1077#1085#1080#1077
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      ShortCut = 120
      Visible = False
    end
    object A_AddCopyDelivery: TAction
      Category = #1054#1090#1075#1088#1091#1079#1082#1080' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1086#1090#1075#1088#1091#1079#1082#1091
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1086#1090#1075#1088#1091#1079#1082#1091
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopyDeliveryExecute
    end
    object A_NewClient: TAction
      Category = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1080
      Caption = #1053#1086#1074#1099#1081' '#1089#1086#1090#1088#1091#1076#1085#1080#1082
      Hint = #1053#1086#1074#1099#1081' '#1089#1086#1090#1088#1091#1076#1085#1080#1082
      ImageIndex = 30
      Visible = False
      OnExecute = A_NewClientExecute
    end
    object A_EditClient: TAction
      Category = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1080
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'...'
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'...'
      ImageIndex = 60
      Visible = False
      OnExecute = A_EditClientExecute
    end
  end
  inherited SleepTM: TTimer
    Left = 256
    Top = 272
  end
  inherited TmEnabled: TTimer
    Left = 176
    Top = 272
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 320
    Top = 272
  end
  object Q_FirmList: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select * from V_FIRM_LIST where FIRM_LIST_ID = :OLD_FIRM_LIST_ID')
    SelectSQL.Strings = (
      'select * from V_FIRM_LIST')
    AfterOpen = Q_FirmListAfterScroll
    AfterScroll = Q_FirmListAfterScroll
    BeforeOpen = Q_FirmListBeforeOpen
    BeforeScroll = Q_FirmListBeforeScroll
    AfterRefresh = Q_FirmListAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 440
    Top = 216
    poUseBooleanField = False
  end
  object dsFirmList: TDataSource
    DataSet = Q_FirmList
    Left = 512
    Top = 216
  end
  object Q_Training: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      
        '  T.CLIENT_TRAINING_ID, T.TRAINING_LIST_ID, T.CLIENT_LIST_ID, T.' +
        'IS_DELETE, T.SERTIFICATE_NUMBER,'
      '  TL.TRAINING_LIST_TITLE, TL.DATE_TRAINING,'
      
        '  coalesce( V.CLIENT_TITLE || iif( V.E_MAIL_LIST is not null, '#39',' +
        ' '#39', '#39#39' ), '#39#39' ) ||'
      '    coalesce( V.E_MAIL_LIST, '#39#39' ) as CLIENT_TITLE'
      'from CLIENT_TRAINING T'
      
        '       join V_CLIENT_LIST_MAIL V      on ( V.CLIENT_LIST_ID     ' +
        '    = T.CLIENT_LIST_ID )'
      
        '  left join TRAINING_LIST TL          on ( TL.TRAINING_LIST_ID  ' +
        '    = T.TRAINING_LIST_ID )'
      'where'
      '  V.FIRM_LIST_ID  = :FIRM_LIST_ID'
      ' and'
      '  T.IS_DELETE > 0 and'
      '  T.CLIENT_TRAINING_ID = :OLD_CLIENT_TRAINING_ID')
    SelectSQL.Strings = (
      'select'
      
        '  T.CLIENT_TRAINING_ID, T.TRAINING_LIST_ID, T.CLIENT_LIST_ID, T.' +
        'IS_DELETE, T.SERTIFICATE_NUMBER,'
      '  TL.TRAINING_LIST_TITLE, TL.DATE_TRAINING,'
      
        '  coalesce( V.CLIENT_TITLE || iif( V.E_MAIL_LIST is not null, '#39',' +
        ' '#39', '#39#39' ), '#39#39' ) ||'
      '    coalesce( V.E_MAIL_LIST, '#39#39' ) as CLIENT_TITLE'
      'from CLIENT_TRAINING T'
      
        '       join V_CLIENT_LIST_MAIL V      on ( V.CLIENT_LIST_ID     ' +
        '    = T.CLIENT_LIST_ID )'
      
        '  left join TRAINING_LIST TL          on ( TL.TRAINING_LIST_ID  ' +
        '    = T.TRAINING_LIST_ID )'
      'where'
      '  V.FIRM_LIST_ID  = :FIRM_LIST_ID and'
      '  T.IS_DELETE > 0'
      'order by'
      '  TL.DATE_TRAINING desc')
    AfterOpen = Q_TrainingAfterScroll
    AfterScroll = Q_TrainingAfterScroll
    BeforeOpen = Q_TrainingBeforeOpen
    BeforeScroll = Q_FirmListBeforeScroll
    AfterRefresh = Q_TrainingAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 440
    Top = 288
    poUseBooleanField = False
  end
  object dsTraining: TDataSource
    DataSet = Q_Training
    Left = 512
    Top = 288
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
    BeforeScroll = Q_FirmListBeforeScroll
    AfterRefresh = Q_FillKeyAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DataSource = dsKeyList
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 600
    Top = 280
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object dsFillKey: TDataSource
    DataSet = Q_FillKey
    Left = 664
    Top = 280
  end
  object dsKeyList: TDataSource
    DataSet = Q_KeyList
    Left = 664
    Top = 216
  end
  object Q_KeyList: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'Select'
      '  K.KEYS_LIST_ID, K.KEY_NUMBER, K.FIRM_LIST_ID, K.IS_DELETE'
      'from KEYS_LIST K'
      'where'
      '  K.IS_DELETE > 0 and'
      '  K.FIRM_LIST_ID = :FIRM_LIST_ID and'
      '  K.KEYS_LIST_ID = :OLD_KEYS_LIST_ID')
    SelectSQL.Strings = (
      'Select'
      '  K.KEYS_LIST_ID, K.KEY_NUMBER, K.FIRM_LIST_ID, K.IS_DELETE'
      'from KEYS_LIST K'
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
    BeforeScroll = Q_FirmListBeforeScroll
    AfterRefresh = Q_KeyListAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 600
    Top = 216
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
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
    BeforeScroll = Q_FirmListBeforeScroll
    AfterRefresh = Q_ProductListAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DataSource = dsDelivery
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 768
    Top = 280
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceOpen = True
    dcIgnoreMasterClose = True
  end
  object dsProductList: TDataSource
    DataSet = Q_ProductList
    Left = 848
    Top = 280
  end
  object dsDelivery: TDataSource
    DataSet = Q_Delivery
    Left = 848
    Top = 216
  end
  object Q_Delivery: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      
        '  A.AGREES_LIST_ID, A.FIRM_LIST_ID, A.AGREES_NUMBER, A.AGREES_DA' +
        'TE,'
      
        '  D.SOFT_DELIVERY_ID, D.DOCUM_NUMBER, D.DOCUM_DATE, D.CERTIFICAT' +
        'E, D.IS_DELETE,'
      
        '  SL.AGREE_STATUS_LIST_TITLE, TL.DOC_TYPE_LIST_TITLE,  D.DOCUM_C' +
        'OMMENT'
      'from AGREES_LIST A'
      
        '  join SOFT_DELIVERY D    on ( D.AGREES_LIST_ID = A.AGREES_LIST_' +
        'ID )'
      
        '      left join AGREE_STATUS_LIST SL      on ( SL.AGREE_STATUS_L' +
        'IST_ID   = D.AGREE_STATUS_LIST_ID )'
      
        '      left join DOC_TYPE_LIST TL      on ( TL.DOC_TYPE_LIST_ID  ' +
        ' = D.DOC_TYPE_LIST_ID )'
      'where'
      '  D.IS_DELETE > 0 and'
      '  A.FIRM_LIST_ID = :FIRM_LIST_ID and'
      '  D.SOFT_DELIVERY_ID = :OLD_SOFT_DELIVERY_ID')
    SelectSQL.Strings = (
      'select'
      
        '  A.AGREES_LIST_ID, A.FIRM_LIST_ID, A.AGREES_NUMBER, A.AGREES_DA' +
        'TE,'
      
        '  D.SOFT_DELIVERY_ID,  D.DOCUM_NUMBER, D.DOCUM_DATE, D.CERTIFICA' +
        'TE, D.IS_DELETE,'
      
        '  SL.AGREE_STATUS_LIST_TITLE, TL.DOC_TYPE_LIST_TITLE,  D.DOCUM_C' +
        'OMMENT'
      'from AGREES_LIST A'
      
        '      join SOFT_DELIVERY D    on ( D.AGREES_LIST_ID = A.AGREES_L' +
        'IST_ID )'
      
        '      left join AGREE_STATUS_LIST SL      on ( SL.AGREE_STATUS_L' +
        'IST_ID   = D.AGREE_STATUS_LIST_ID )'
      
        '      left join DOC_TYPE_LIST TL      on ( TL.DOC_TYPE_LIST_ID  ' +
        ' = D.DOC_TYPE_LIST_ID )'
      'where'
      '  D.IS_DELETE > 0 and'
      '  A.FIRM_LIST_ID = :FIRM_LIST_ID'
      'order by'
      '  A.AGREES_NUMBER, D.DOCUM_NUMBER')
    AfterInsert = Q_DeliveryAfterScroll
    AfterOpen = Q_DeliveryAfterScroll
    AfterScroll = Q_DeliveryAfterScroll
    BeforeOpen = Q_DeliveryBeforeOpen
    BeforeScroll = Q_FirmListBeforeScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 768
    Top = 216
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
    object Q_DeliveryAGREES_LIST_ID: TFIBIntegerField
      FieldName = 'AGREES_LIST_ID'
    end
    object Q_DeliveryFIRM_LIST_ID: TFIBIntegerField
      FieldName = 'FIRM_LIST_ID'
    end
    object Q_DeliveryAGREES_NUMBER: TFIBStringField
      FieldName = 'AGREES_NUMBER'
      Size = 64
      EmptyStrToNull = True
    end
    object Q_DeliveryAGREES_DATE: TFIBDateField
      DefaultExpression = 'current_date'
      FieldName = 'AGREES_DATE'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object Q_DeliverySOFT_DELIVERY_ID: TFIBIntegerField
      FieldName = 'SOFT_DELIVERY_ID'
    end
    object Q_DeliveryDOCUM_NUMBER: TFIBStringField
      FieldName = 'DOCUM_NUMBER'
      EmptyStrToNull = True
    end
    object Q_DeliveryDOCUM_DATE: TFIBDateField
      DefaultExpression = 'current_date'
      FieldName = 'DOCUM_DATE'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object Q_DeliveryCERTIFICATE: TFIBStringField
      FieldName = 'CERTIFICATE'
      Size = 32
      EmptyStrToNull = True
    end
    object Q_DeliveryIS_DELETE: TFIBIntegerField
      FieldName = 'IS_DELETE'
    end
    object Q_DeliveryDOCUM_COMMENT: TFIBStringField
      FieldName = 'DOCUM_COMMENT'
      Size = 2048
      EmptyStrToNull = True
    end
    object Q_DeliveryAGREE_STATUS_LIST_TITLE: TFIBStringField
      FieldName = 'AGREE_STATUS_LIST_TITLE'
      Size = 100
      EmptyStrToNull = True
    end
    object Q_DeliveryDOC_TYPE_LIST_TITLE: TFIBStringField
      FieldName = 'DOC_TYPE_LIST_TITLE'
      Size = 100
      EmptyStrToNull = True
    end
  end
  object Q_Employee: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      '  *'
      'from V_CLIENT_LIST CL'
      'where'
      '  CL.FIRM_LIST_ID = :FIRM_LIST_ID and'
      '  CL.CLIENT_LIST_ID = :OLD_CLIENT_LIST_ID'
      '')
    SelectSQL.Strings = (
      'select'
      '  *'
      'from V_CLIENT_LIST CL'
      'where'
      '  CL.FIRM_LIST_ID = :FIRM_LIST_ID'
      'order by'
      '  CL.CLIENT_TITLE')
    AfterOpen = Q_EmployeeAfterScroll
    AfterScroll = Q_EmployeeAfterScroll
    BeforeOpen = Q_EmployeeBeforeOpen
    BeforeScroll = Q_FirmListBeforeScroll
    AfterRefresh = Q_EmployeeAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 440
    Top = 360
    poUseBooleanField = False
  end
  object dsEmployee: TDataSource
    DataSet = Q_Employee
    Left = 512
    Top = 360
  end
  object Q_AgreesList: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      
        '  A.AGREES_LIST_ID, A.FIRM_LIST_ID, A.AGREES_NUMBER, A.AGREES_DA' +
        'TE, A.IS_DELETE,'
      
        '  CT.CONTRACT_TYPE_LIST_TITLE, SL.AGREE_STATUS_LIST_TITLE, A.AGR' +
        'EES_COMMENT'
      'from AGREES_LIST A'
      
        '  left join AGREE_STATUS_LIST SL on ( A.AGREE_STATUS_LIST_ID = S' +
        'L.AGREE_STATUS_LIST_ID)'
      
        '  left join CONTRACT_TYPE_LIST CT on ( A.CONTRACT_TYPE_LIST_ID =' +
        ' CT.CONTRACT_TYPE_LIST_ID)'
      'where'
      '  A.IS_DELETE > 0 and'
      '  A.FIRM_LIST_ID = :FIRM_LIST_ID and'
      '  A.AGREES_LIST_ID = :OLD_AGREES_LIST_ID')
    SelectSQL.Strings = (
      'select'
      
        '  A.AGREES_LIST_ID, A.FIRM_LIST_ID, A.AGREES_NUMBER, A.AGREES_DA' +
        'TE, A.IS_DELETE,'
      
        '  CT.CONTRACT_TYPE_LIST_TITLE, SL.AGREE_STATUS_LIST_TITLE, A.AGR' +
        'EES_COMMENT'
      'from AGREES_LIST A'
      
        '  left join AGREE_STATUS_LIST SL on ( A.AGREE_STATUS_LIST_ID = S' +
        'L.AGREE_STATUS_LIST_ID)'
      
        '  left join CONTRACT_TYPE_LIST CT on ( A.CONTRACT_TYPE_LIST_ID =' +
        ' CT.CONTRACT_TYPE_LIST_ID)'
      'where'
      '  A.IS_DELETE > 0 and'
      '  A.FIRM_LIST_ID = :FIRM_LIST_ID'
      'order by'
      '  A.AGREES_NUMBER')
    AfterOpen = Q_AgreesListAfterScroll
    AfterScroll = Q_AgreesListAfterScroll
    BeforeOpen = Q_AgreesListBeforeOpen
    BeforeScroll = Q_FirmListBeforeScroll
    AfterRefresh = Q_AgreesListAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.NumericDisplayFormat = '#,0.'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 600
    Top = 360
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object dsAgreesList: TDataSource
    DataSet = Q_AgreesList
    Left = 680
    Top = 360
  end
end
