inherited frGroupSuscribeSprav: TfrGroupSuscribeSprav
  Caption = #1043#1088#1091#1087#1087#1099
  ClientHeight = 502
  ClientWidth = 1144
  OnResize = FormResize
  ExplicitWidth = 1160
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 16
  object SpGroup: TSplitter [0]
    Left = 546
    Top = 29
    Width = 6
    Height = 454
    Align = alRight
    Beveled = True
    ExplicitLeft = 425
    ExplicitTop = 0
    ExplicitHeight = 439
  end
  inherited dbgHost: TDBGridEh [1]
    Width = 546
    Height = 454
  end
  inherited SB: TStatusBar [2]
    Top = 483
    Width = 1144
    ExplicitTop = 483
    ExplicitWidth = 1144
  end
  object dbgClients: TDBGridEh [3]
    Left = 552
    Top = 29
    Width = 592
    Height = 454
    Align = alRight
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
    ReadOnly = True
    RowHeight = 26
    RowLines = 1
    RowSizingAllowed = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    OnCellClick = GridCellClick
    OnColEnter = GridColEnter
    OnDblClick = A_SpravEditExecute
    OnDrawColumnCell = GridDrawColumnCell
    OnEnter = DbGridEnter
    OnKeyDown = dbgHostKeyDown
    OnSortMarkingChanged = GridSortMarkingChanged
    Columns = <
      item
        EditButtons = <>
        FieldName = 'E_MAIL'
        Footers = <>
        Title.Caption = 'E-Mail'
        Width = 490
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  inherited aTbSprav: TActionToolBar
    Width = 1144
    ExplicitWidth = 1144
  end
  inherited FontD: TFontDialog
    Left = 120
    Top = 96
  end
  inherited ActList: TActionList
    Left = 56
    Top = 96
    inherited A_SpravNew: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
    end
    inherited A_SpravDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1075#1088#1091#1087#1087#1091'...'
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1075#1088#1091#1087#1087#1091'...'
    end
    inherited A_SpravAddCopy: TAction
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1075#1088#1091#1087#1087#1091
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1075#1088#1091#1087#1087#1091
    end
  end
  inherited SleepTM: TTimer
    Left = 264
    Top = 96
  end
  inherited TmEnabled: TTimer
    Left = 192
    Top = 96
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 328
    Top = 96
  end
  inherited Q_Host: TpFIBDataSet
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object Q_Clients: TpFIBDataSet
    RefreshSQL.Strings = (
      'select'
      '  CL.E_MAIL, CL.CLIENTS_MAIL_LIST_ID'
      'from V_CLIENTS_MAIL_LIST CL, SUBSCRIBE_GROUP_MAIL_LINK L'
      'where'
      '  L.SUBSCRIBE_GROUP_ID = :SUBSCRIBE_GROUP_ID and'
      '  L.CLIENTS_MAIL_LIST_ID = CL.CLIENTS_MAIL_LIST_ID and'
      '  L.CLIENTS_MAIL_LIST_ID = :OLD_CLIENTS_MAIL_LIST_ID'
      '')
    SelectSQL.Strings = (
      'select'
      '  CL.E_MAIL, CL.CLIENTS_MAIL_LIST_ID'
      'from V_CLIENTS_MAIL_LIST CL, SUBSCRIBE_GROUP_MAIL_LINK L'
      'where'
      '  L.SUBSCRIBE_GROUP_ID = :SUBSCRIBE_GROUP_ID and'
      '  L.CLIENTS_MAIL_LIST_ID = CL.CLIENTS_MAIL_LIST_ID'
      'order by'
      '  L.ORDER_BY')
    AfterOpen = Q_HostAfterScroll
    AfterScroll = Q_HostAfterScroll
    BeforeOpen = Q_HostBeforeOpen
    AfterRefresh = Q_HostAfterScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    UpdateTransaction = frDM.IBTrWrite
    OnEndScroll = DataSetAfterScroll
    DataSource = dsHost
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 112
    Top = 272
    poUseBooleanField = False
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object dsClients: TDataSource
    DataSet = Q_Clients
    Left = 168
    Top = 272
  end
end
