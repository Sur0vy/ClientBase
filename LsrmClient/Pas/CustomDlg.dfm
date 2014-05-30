object frCustomDlg: TfrCustomDlg
  Left = 0
  Top = 0
  ActiveControl = SmartDlg
  BorderIcons = [biSystemMenu]
  Caption = #1064#1072#1073#1083#1086#1085' '#1092#1086#1088#1084' '#1076#1080#1072#1083#1086#1075#1086#1074' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1080#1083#1080' '#1092#1080#1083#1100#1090#1088#1072
  ClientHeight = 297
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SB: TStatusBar
    Left = 0
    Top = 278
    Width = 686
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end>
  end
  object SmartDlg: TSmartDlg
    Left = 0
    Top = 29
    Width = 686
    Height = 249
    Align = alClient
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    TabOrder = 1
    PopupMenu = ppDialog
    RowsList = <>
    FormAutoHeight = True
    TabSet = SmartDlg.TabSet
    DividerPosition = 341
    DropDownCount = 25
    TypeDialog = isNo
    OnChangeRow = SmartDlgChangeRow
    OnGetLookupList = SmartDlgGetLookupList
    ReadOnly = False
    OnKeyDown = SmartDlgKeyDown
  end
  object aTbSmartDLG: TActionToolBar
    Left = 0
    Top = 0
    Width = 686
    Height = 29
    ActionManager = frPrima.ActManager
    Caption = 'aTbSmartDLG'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    DragKind = dkDrag
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Spacing = 0
  end
  object FontD: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OnApply = FontDApply
    Left = 40
    Top = 80
  end
  object ActListDialog: TActionList
    Images = frPrima.ImList
    Left = 104
    Top = 80
    object A_Save: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      ImageIndex = 22
      OnExecute = A_SaveExecute
    end
    object A_Close: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1080#1072#1083#1086#1075
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1080#1072#1083#1086#1075
      ImageIndex = 4
      OnExecute = A_CloseExecute
    end
    object A_ClearAll: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      ImageIndex = 35
      OnExecute = A_ClearAllExecute
    end
    object A_Clear: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      ImageIndex = 41
      SecondaryShortCuts.Strings = (
        'Ctrl+Del')
      OnExecute = A_ClearExecute
    end
    object A_Font: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1064#1088#1080#1092#1090' ...'
      Hint = #1064#1088#1080#1092#1090' ...'
      ImageIndex = 15
      ShortCut = 16454
      OnExecute = A_FontExecute
    end
    object A_Between: TPopMenuAction
      Category = #1060#1080#1083#1100#1090#1088
      Caption = #1042#1099#1073#1086#1088' '#1076#1080#1072#1087#1072#1079#1086#1085#1072' '#1079#1085#1072#1095#1077#1085#1080#1081
      Enabled = False
      Hint = #1042#1099#1073#1086#1088' '#1076#1080#1072#1087#1072#1079#1086#1085#1072' '#1079#1085#1072#1095#1077#1085#1080#1081
      ImageIndex = 57
      Visible = False
      OnExecute = A_BetweenExecute
    end
    object A_SetBetween: TAction
      Category = #1060#1080#1083#1100#1090#1088
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1099#1073#1086#1088' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1080#1079' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1099#1073#1086#1088' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1080#1079' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      ImageIndex = 57
      Visible = False
      OnExecute = A_SetBetweenExecute
    end
    object A_AddAction: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1082#1085#1086#1087#1082#1072
      Hint = #1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1082#1085#1086#1087#1082#1072
      Visible = False
    end
    object A_AddAction_1: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1082#1085#1086#1087#1082#1072' 2'
      Hint = #1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1082#1085#1086#1087#1082#1072' 2'
      Visible = False
    end
  end
  object dlgFillRows: TFillRows
    SmartDialog = SmartDlg
    OnGetDataBaseParam = dlgFillRowsGetDataBaseParam
    OnGetRowsListParam = dlgFillRowsGetRowsListParam
    Left = 40
    Top = 136
  end
  object TmSave: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TmSaveTimer
    Left = 176
    Top = 80
  end
  object ppDialog: TPopupActionBar
    Left = 240
    Top = 80
  end
end
