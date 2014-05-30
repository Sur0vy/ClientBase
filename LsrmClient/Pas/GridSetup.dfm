inherited FrGridSetup: TFrGridSetup
  Left = 264
  Top = 174
  BorderIcons = [biSystemMenu]
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1082#1086#1083#1086#1085#1086#1082' '
  ClientHeight = 466
  ClientWidth = 462
  OldCreateOrder = True
  ExplicitWidth = 478
  ExplicitHeight = 504
  PixelsPerInch = 96
  TextHeight = 16
  inherited SB: TStatusBar
    Top = 447
    Width = 462
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 447
    ExplicitWidth = 462
  end
  object LV_Columns: TListView [1]
    Left = 0
    Top = 29
    Width = 462
    Height = 418
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        AutoSize = True
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1086#1083#1086#1085#1082#1080
      end
      item
        AutoSize = True
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074' '#1090#1072#1073#1083#1080#1094#1077
      end>
    DragMode = dmAutomatic
    FlatScrollBars = True
    FullDrag = True
    GridLines = True
    PopupMenu = frPrima.PM
    TabOrder = 1
    ViewStyle = vsList
    OnChange = LV_ColumnsChange
    OnDblClick = A_ColumnPropExecute
    OnDragDrop = LV_ColumnsDragDrop
    OnDragOver = LV_ColumnsDragOver
    OnKeyDown = LV_ColumnsKeyDown
  end
  object aTbGridSetup: TActionToolBar [2]
    Left = 0
    Top = 0
    Width = 462
    Height = 29
    ActionManager = frPrima.ActManager
    Caption = 'aTbGridSetup'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
  inherited FontD: TFontDialog
    Left = 152
    Top = 168
  end
  inherited ActList: TActionList
    Top = 168
    inherited A_Prior: TDataSetPrior
      Caption = #1042#1087#1077#1088#1077#1076
      Hint = #1042#1087#1077#1088#1077#1076
      ImageIndex = 113
      OnExecute = A_PriorExecute
    end
    inherited A_Next: TDataSetNext
      Caption = #1053#1072#1079#1072#1076
      Hint = #1053#1072#1079#1072#1076
      ImageIndex = 114
      OnExecute = A_NextExecute
    end
    inherited A_Font: TAction
      Enabled = True
    end
    object A_ReportView: TAction
      Category = #1042#1080#1076
      AutoCheck = True
      Caption = #1058#1072#1073#1083#1080#1094#1072
      GroupIndex = 10
      Hint = #1058#1072#1073#1083#1080#1094#1072
      ImageIndex = 118
      OnExecute = A_ReportViewExecute
    end
    object A_ListView: TAction
      Category = #1042#1080#1076
      AutoCheck = True
      Caption = #1057#1087#1080#1089#1086#1082
      Checked = True
      GroupIndex = 10
      Hint = #1057#1087#1080#1089#1086#1082
      ImageIndex = 119
      OnExecute = A_ListViewExecute
    end
    object A_ColumnProp: TAction
      Category = 'Align'
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1082#1086#1083#1086#1085#1082#1080
      Hint = #1057#1074#1086#1081#1089#1090#1074#1072' '#1082#1086#1083#1086#1085#1082#1080
      ImageIndex = 87
      OnExecute = A_ColumnPropExecute
      OnUpdate = A_ColumnPropUpdate
    end
    object A_SetDefault: TAction
      Category = #1042#1080#1076
      Caption = #1054#1088#1080#1075#1080#1085#1072#1083#1100#1085#1099#1081' '#1087#1086#1088#1103#1076#1086#1082' '#1082#1086#1083#1086#1085#1086#1082
      Enabled = False
      Hint = #1054#1088#1080#1075#1080#1085#1072#1083#1100#1085#1099#1081' '#1087#1086#1088#1103#1076#1086#1082' '#1082#1086#1083#1086#1085#1086#1082
      ImageIndex = 32
      Visible = False
      OnExecute = A_SetDefaultExecute
    end
    object A_Save: TAction
      Category = #1042#1080#1076
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1086#1083#1086#1085#1086#1082
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1086#1083#1086#1085#1086#1082
      ImageIndex = 5
      OnExecute = A_SaveExecute
    end
  end
  inherited SleepTM: TTimer
    Left = 224
    Top = 88
  end
  inherited TmEnabled: TTimer
    Left = 152
    Top = 88
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 296
    Top = 88
  end
  object ppGridSetup: TPopupActionBar
    Left = 224
    Top = 168
  end
end
