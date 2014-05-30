inherited frSubscribeJournal: TfrSubscribeJournal
  Caption = #1056#1072#1089#1089#1099#1083#1082#1072' '#1082#1083#1080#1077#1085#1090#1072#1084
  ClientHeight = 498
  ClientWidth = 1158
  OnResize = FormResize
  ExplicitWidth = 1174
  ExplicitHeight = 536
  PixelsPerInch = 96
  TextHeight = 16
  object SpSub: TSplitter [0]
    Left = 585
    Top = 0
    Width = 6
    Height = 479
    Beveled = True
    ExplicitLeft = 393
    ExplicitHeight = 439
  end
  inherited SB: TStatusBar
    Top = 479
    Width = 1158
    ExplicitTop = 479
    ExplicitWidth = 1158
  end
  inherited dbgHost: TDBGridEh
    Width = 585
    Height = 479
    Align = alLeft
    OnDblClick = A_EditSubscribeExecute
    OnKeyDown = dbgHostKeyDown
    Columns = <
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'IS_SEND'
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
        PickList.Strings = (
          '1'
          '0')
        Title.Caption = #1054#1090#1087#1088#1072#1074#1083#1077#1085#1086
        Width = 91
      end
      item
        EditButtons = <>
        FieldName = 'SUBSCRIBE_GROUP_TITLE'
        Footers = <>
        Title.Caption = #1043#1088#1091#1087#1087#1072' '#1088#1072#1089#1089#1099#1083#1082#1080
        Width = 185
      end
      item
        EditButtons = <>
        FieldName = 'SUBJECT'
        Footers = <>
        Title.Caption = #1058#1077#1084#1072' '#1087#1080#1089#1100#1084#1072
        Width = 163
      end
      item
        EditButtons = <>
        FieldName = 'COPY_ADDRESS'
        Footers = <>
        Title.Caption = #1050#1091#1076#1072' '#1086#1090#1087#1088#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1080' '#1087#1080#1089#1077#1084
        Width = 192
      end
      item
        EditButtons = <>
        FieldName = 'REPLY_ADDRESS'
        Footers = <>
        Title.Caption = #1040#1076#1088#1077#1089' '#1076#1083#1103' '#1086#1090#1074#1077#1090#1072
        Width = 161
      end
      item
        EditButtons = <>
        FieldName = 'DATE_ENTER'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
        Width = 126
      end>
  end
  object PC: TPageControl [3]
    Left = 591
    Top = 0
    Width = 567
    Height = 479
    ActivePage = tsWebEMail
    Align = alClient
    Images = frPrima.ImList
    TabOrder = 2
    OnChange = PCChange
    OnChanging = PCChanging
    object tsWebEMail: TTabSheet
      Caption = #1058#1077#1082#1089#1090' '#1088#1072#1089#1089#1099#1083#1082#1080
      ImageIndex = 110
      object WB: TWebBrowser
        Left = 0
        Top = 0
        Width = 559
        Height = 448
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C000000C63900004D2E00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object tsAttachment: TTabSheet
      Caption = #1060#1072#1081#1083#1099' '#1074#1083#1086#1078#1077#1085#1080#1103
      ImageIndex = 95
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dbgAttachment: TDBGridEh
        Left = 0
        Top = 0
        Width = 559
        Height = 448
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsAttachment
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
        OnEnter = dbgHostEnter
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'FILE_NAME'
            Footers = <>
            Title.Caption = #1048#1084#1103' '#1087#1088#1080#1082#1088#1077#1087#1083#1077#1085#1085#1086#1075#1086' '#1092#1072#1081#1083#1072
            Width = 416
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object tsSubscribe: TTabSheet
      Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1087#1080#1089#1077#1084' '#1082#1083#1080#1077#1085#1090#1072#1084
      ImageIndex = 128
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dbgSubscribe: TDBGridEh
        Left = 0
        Top = 0
        Width = 559
        Height = 448
        Align = alClient
        AllowedOperations = []
        ColumnDefValues.EndEllipsis = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsSubscribe
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
        OnEnter = dbgHostEnter
        OnSortMarkingChanged = GridSortMarkingChanged
        Columns = <
          item
            EditButtons = <>
            FieldName = 'E_MAIL'
            Footers = <>
            Title.Caption = 'E-Mail'
            Width = 251
          end
          item
            EditButtons = <>
            FieldName = 'DATE_SEND'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1086#1090#1087#1088#1072#1074#1082#1080
            Width = 134
          end
          item
            EditButtons = <>
            FieldName = 'ERROR_TEXT'
            Footers = <>
            Title.Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1086#1090#1087#1088#1072#1074#1082#1080
            Width = 190
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited FontD: TFontDialog
    Left = 144
    Top = 112
  end
  inherited ActList: TActionList
    Left = 48
    Top = 112
    object A_NewSubscribe: TAction [23]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1053#1086#1074#1072#1103' '#1088#1072#1089#1089#1099#1083#1082#1072
      Hint = #1053#1086#1074#1072#1103' '#1088#1072#1089#1089#1099#1083#1082#1072
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewSubscribeExecute
    end
    object A_EditSubscribe: TAction [24]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1091
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1091
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditSubscribeExecute
    end
    object A_DelSubscribe: TAction [25]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1091
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelSubscribeExecute
    end
    object A_SendMail: TAction [26]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1080#1089#1100#1084#1072' '#1072#1076#1088#1077#1089#1072#1090#1072#1084
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1080#1089#1100#1084#1072' '#1072#1076#1088#1077#1089#1072#1090#1072#1084
      ImageIndex = 123
      Visible = False
      OnExecute = A_SendMailExecute
    end
    object A_AddAttachment: TAction [27]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1042#1083#1086#1078#1080#1090#1100' '#1092#1072#1081#1083' '#1074' '#1088#1072#1089#1089#1099#1083#1082#1091
      Hint = #1042#1083#1086#1078#1080#1090#1100' '#1092#1072#1081#1083' '#1074' '#1088#1072#1089#1089#1099#1083#1082#1091
      ImageIndex = 95
      Visible = False
      OnExecute = A_AddAttachmentExecute
    end
    object A_RepeatSend: TAction [28]
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1055#1086#1074#1090#1086#1088#1085#1086' '#1086#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1080#1089#1100#1084#1072' '#1089' "'#1087#1083#1086#1093#1080#1084' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1084'"'
      Hint = #1055#1086#1074#1090#1086#1088#1085#1086' '#1086#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1080#1089#1100#1084#1072' '#1089' "'#1087#1083#1086#1093#1080#1084' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1084'"'
      ImageIndex = 34
      Visible = False
      OnExecute = A_RepeatSendExecute
    end
    object A_AddCopySubscribe: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1088#1072#1089#1089#1099#1083#1082#1091
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1088#1072#1089#1089#1099#1083#1082#1091
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopySubscribeExecute
    end
    object A_MailPreview: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088' '#1087#1080#1089#1077#1084' '#1088#1072#1089#1089#1099#1083#1082#1080
      Hint = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088' '#1087#1080#1089#1077#1084' '#1088#1072#1089#1089#1099#1083#1082#1080
      ImageIndex = 102
      ShortCut = 122
      Visible = False
      OnExecute = A_MailPreviewExecute
    end
  end
  inherited SleepTM: TTimer
    Left = 288
    Top = 112
  end
  inherited TmEnabled: TTimer
    Left = 216
    Top = 112
  end
  inherited PrintDBG: TPrintDBGridEh
    Top = 112
  end
  inherited Q_Host: TpFIBDataSet
    RefreshSQL.Strings = (
      'select * from V_SUBSCRIBE_LIST'
      'where'
      '  SUBSCRIBE_LIST_ID = :OLD_SUBSCRIBE_LIST_ID')
    SelectSQL.Strings = (
      'select * from V_SUBSCRIBE_LIST')
    AfterOpen = Q_HostAfterScroll
    AfterRefresh = Q_HostAfterRefresh
  end
  inherited dsHost: TDataSource
    Left = 184
  end
  object Q_Subscribe: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      
        '  SS.SUBSCRIBE_LIST_ID, SS.CLIENTS_MAIL_LIST_ID, SS.DATE_SEND, S' +
        'S.ERROR_TEXT,'
      '  ML.E_MAIL'
      'from SUBSCRIBE_SEND SS'
      
        '  left join V_CLIENTS_MAIL_LIST ML        on ( ML.CLIENTS_MAIL_L' +
        'IST_ID      = SS.CLIENTS_MAIL_LIST_ID )'
      'where'
      '  SS.SUBSCRIBE_LIST_ID = :SUBSCRIBE_LIST_ID and'
      '  SS.CLIENTS_MAIL_LIST_ID = :OLD_CLIENTS_MAIL_LIST_ID'
      '')
    SelectSQL.Strings = (
      'select'
      
        '  SS.SUBSCRIBE_LIST_ID, SS.CLIENTS_MAIL_LIST_ID, SS.DATE_SEND, S' +
        'S.ERROR_TEXT,'
      '  ML.E_MAIL'
      'from SUBSCRIBE_SEND SS'
      
        '  left join V_CLIENTS_MAIL_LIST ML        on ( ML.CLIENTS_MAIL_L' +
        'IST_ID      = SS.CLIENTS_MAIL_LIST_ID )'
      'where'
      '  SS.SUBSCRIBE_LIST_ID = :SUBSCRIBE_LIST_ID'
      'order by'
      '  SS.DATE_SEND')
    BeforeOpen = Q_SubscribeBeforeOpen
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 112
    Top = 264
    poUseBooleanField = False
  end
  object dsSubscribe: TDataSource
    DataSet = Q_Subscribe
    Left = 184
    Top = 264
  end
  object Q_Attachment: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      'select'
      '  MAIL_ATTACHMENT_ID, SUBSCRIBE_LIST_ID, FILE_NAME'
      'from MAIL_ATTACHMENT'
      'where'
      '  SUBSCRIBE_LIST_ID = :SUBSCRIBE_LIST_ID and'
      '  MAIL_ATTACHMENT_ID = :OLD_MAIL_ATTACHMENT_ID'
      '')
    SelectSQL.Strings = (
      'select'
      '  MAIL_ATTACHMENT_ID, SUBSCRIBE_LIST_ID, FILE_NAME'
      'from MAIL_ATTACHMENT'
      'where'
      '  SUBSCRIBE_LIST_ID = :SUBSCRIBE_LIST_ID'
      'order by'
      '  FILE_NAME')
    BeforeOpen = Q_AttachmentBeforeOpen
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    OnEndScroll = DataSetAfterScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 112
    Top = 328
    poUseBooleanField = False
  end
  object dsAttachment: TDataSource
    DataSet = Q_Attachment
    Left = 184
    Top = 328
  end
end
