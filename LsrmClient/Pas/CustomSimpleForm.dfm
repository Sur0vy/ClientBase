inherited frCustomSimpleForm: TfrCustomSimpleForm
  Caption = #1055#1088#1086#1089#1090#1072#1103' '#1092#1086#1088#1084#1072' '#1089' '#1086#1076#1085#1080#1084' TDBGrid'
  ClientHeight = 458
  ClientWidth = 753
  FormStyle = fsMDIChild
  Visible = True
  WindowState = wsMaximized
  ExplicitWidth = 769
  ExplicitHeight = 496
  PixelsPerInch = 96
  TextHeight = 16
  inherited SB: TStatusBar
    Top = 439
    Width = 753
    ExplicitTop = 439
    ExplicitWidth = 753
  end
  object dbgHost: TDBGridEh [1]
    Left = 0
    Top = 0
    Width = 753
    Height = 439
    Align = alClient
    AllowedOperations = []
    ColumnDefValues.EndEllipsis = True
    ColumnDefValues.Title.EndEllipsis = True
    ColumnDefValues.Title.TitleButton = True
    ColumnDefValues.Title.ToolTips = True
    ColumnDefValues.ToolTips = True
    DataGrouping.GroupLevels = <>
    DataSource = dsHost
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
    OnEnter = dbgHostEnter
    OnSortMarkingChanged = GridSortMarkingChanged
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  inherited ActList: TActionList
    inherited A_Filtr: TFiltrActList
      DbGrid = dbgHost
      FiltredQuery = Q_Host
    end
  end
  object Q_Host: TpFIBDataSet
    MDTSQLExecutor = se_Server
    RefreshSQL.Strings = (
      '')
    SelectSQL.Strings = (
      '')
    AfterScroll = Q_HostAfterScroll
    BeforeOpen = Q_HostBeforeOpen
    BeforeScroll = Q_HostBeforeScroll
    Transaction = frDM.IBTrRead
    Database = frDM.IBDB
    OnEndScroll = Q_HostEndScroll
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy hh:mm'
    DefaultFormats.DisplayFormatTime = 'hh:mm'
    Left = 112
    Top = 192
    poUseBooleanField = False
  end
  object dsHost: TDataSource
    DataSet = Q_Host
    Left = 168
    Top = 192
  end
end
