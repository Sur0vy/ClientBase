object frToolBarSetup: TfrToolBarSetup
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1079#1084#1077#1097#1077#1085#1080#1103' '#1082#1085#1086#1087#1086#1082' '#1085#1072' ToolBar'
  ClientHeight = 262
  ClientWidth = 434
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tbSetup: TToolBar
    Left = 0
    Top = 0
    Width = 434
    Height = 29
    Caption = 'tbSetup'
    Images = frPrima.ImList
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object tbSave: TToolButton
      Left = 0
      Top = 0
      Action = A_Save
    end
    object tbSep1: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = '-'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object tbFirst: TToolButton
      Left = 31
      Top = 0
      Action = A_First
    end
    object tbPrior: TToolButton
      Left = 54
      Top = 0
      Action = A_Prior
    end
    object tbNext: TToolButton
      Left = 77
      Top = 0
      Action = A_Next
    end
    object tbLast: TToolButton
      Left = 100
      Top = 0
      Action = A_Last
    end
    object tbSep2: TToolButton
      Left = 123
      Top = 0
      Width = 8
      Caption = '-'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 131
      Top = 0
      Action = A_SelectAll
    end
    object ToolButton2: TToolButton
      Left = 154
      Top = 0
      Action = A_ClearAll
    end
    object ToolButton3: TToolButton
      Left = 177
      Top = 0
      Action = A_Invert
    end
    object tbSep3: TToolButton
      Left = 200
      Top = 0
      Width = 8
      Caption = 'tbSep3'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object tbRestoreDefault: TToolButton
      Left = 208
      Top = 0
      Action = A_RestoreDefault
    end
    object tbSep4: TToolButton
      Left = 231
      Top = 0
      Width = 8
      Caption = 'tbSep4'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object tbDelAction: TToolButton
      Left = 239
      Top = 0
      Action = A_DelAction
    end
    object tbAddSeparator: TToolButton
      Left = 262
      Top = 0
      Action = A_AddSeparator
    end
    object tbAddAction: TToolButton
      Left = 285
      Top = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
      DropdownMenu = ppAddAction
      ImageIndex = 66
      Style = tbsDropDown
      OnClick = A_AddActionExecute
    end
    object ToolButton6: TToolButton
      Left = 323
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object tbClose: TToolButton
      Left = 331
      Top = 0
      Action = A_Close
    end
  end
  object lvChBox: TListView
    Left = 0
    Top = 29
    Width = 434
    Height = 233
    Align = alClient
    Checkboxes = True
    Columns = <>
    FlatScrollBars = True
    HideSelection = False
    LargeImages = frPrima.ImList
    ReadOnly = True
    PopupMenu = ppSetup
    ShowWorkAreas = True
    SmallImages = frPrima.ImList
    TabOrder = 0
    ViewStyle = vsList
    OnKeyDown = lvChBoxKeyDown
    OnItemChecked = lvChBoxItemChecked
  end
  object ActListSetup: TActionList
    Images = frPrima.ImList
    Left = 64
    Top = 152
    object A_Sp: TAction
      Caption = '-'
      Hint = '-'
    end
    object A_Save: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1091
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1091
      ImageIndex = 5
      ShortCut = 16467
      OnExecute = A_SaveExecute
    end
    object A_Close: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100' ....'
      Hint = #1047#1072#1082#1088#1099#1090#1100' ....'
      ImageIndex = 4
      ShortCut = 16499
      OnExecute = A_CloseExecute
    end
    object A_First: TAction
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1086
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1086
      ImageIndex = 112
      ShortCut = 16454
      OnExecute = A_FirstExecute
      OnUpdate = A_FirstUpdate
    end
    object A_Last: TAction
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1082#1086#1085#1077#1094
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1082#1086#1085#1077#1094
      ImageIndex = 111
      ShortCut = 16460
      OnExecute = A_LastExecute
      OnUpdate = A_LastUpdate
    end
    object A_Prior: TAction
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1074#1077#1088#1093
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1074#1077#1088#1093
      ImageIndex = 113
      ShortCut = 16464
      OnExecute = A_PriorExecute
      OnUpdate = A_PriorUpdate
    end
    object A_Next: TAction
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1085#1080#1079
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1085#1080#1079
      ImageIndex = 114
      ShortCut = 16462
      OnExecute = A_NextExecute
      OnUpdate = A_NextUpdate
    end
    object A_SelectAll: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1105
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1105
      ImageIndex = 129
      ShortCut = 16449
      OnExecute = A_SelectAllExecute
    end
    object A_ClearAll: TAction
      Caption = #1059#1073#1088#1072#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      Hint = #1059#1073#1088#1072#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      ImageIndex = 130
      ShortCut = 16453
      OnExecute = A_ClearAllExecute
    end
    object A_Invert: TAction
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1084#1077#1090#1082#1080
      Hint = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1084#1077#1090#1082#1080
      ImageIndex = 131
      ShortCut = 16457
      OnExecute = A_InvertExecute
    end
    object A_RestoreDefault: TAction
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      ImageIndex = 24
      ShortCut = 16466
      OnExecute = A_RestoreDefaultExecute
    end
    object A_AddSeparator: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1077#1087#1072#1088#1072#1090#1086#1088
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1077#1087#1072#1088#1072#1090#1086#1088
      ImageIndex = 132
      ShortCut = 16467
      OnExecute = A_AddSeparatorExecute
    end
    object A_AddAction: TPopMenuAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1077' '#1076#1077#1081#1089#1090#1074#1080#1077' '#1087#1086#1089#1083#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1089#1090#1088#1086#1082#1080
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1077' '#1076#1077#1081#1089#1090#1074#1080#1077' '#1087#1086#1089#1083#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1089#1090#1088#1086#1082#1080
      ImageIndex = 66
      ShortCut = 16452
      OnExecute = A_AddActionExecute
    end
    object A_DelAction: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 27
      OnExecute = A_DelActionExecute
    end
  end
  object ppAddAction: TPopupActionBar
    Images = frPrima.ImList
    Left = 208
    Top = 152
    object N111: TMenuItem
      Caption = '11'
    end
    object N221: TMenuItem
      Caption = '22'
    end
    object N331: TMenuItem
      Caption = '33'
    end
  end
  object ppSetup: TPopupActionBar
    Images = frPrima.ImList
    Left = 296
    Top = 152
  end
end
