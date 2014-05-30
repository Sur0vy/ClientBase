object FrFuncRight: TFrFuncRight
  Left = 348
  Top = 315
  BorderIcons = [biSystemMenu]
  Caption = #1055#1088#1072#1074#1072' '#1076#1086#1089#1090#1091#1087#1072' '#1082' '#1092#1091#1085#1082#1094#1080#1086#1085#1072#1083#1100#1085#1099#1084' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1103#1084
  ClientHeight = 421
  ClientWidth = 924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = CB_UserListDropDown
  PixelsPerInch = 96
  TextHeight = 13
  object TrView: TTreeView
    Left = 0
    Top = 55
    Width = 924
    Height = 366
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Indent = 19
    ParentFont = False
    PopupMenu = ppFuncItemRight
    ReadOnly = True
    RowSelect = True
    ShowButtons = False
    SortType = stText
    StateImages = CheckImage
    TabOrder = 0
    OnChange = TrViewChange
    OnCollapsing = TrViewCollapsing
    OnExpanding = TrViewExpanding
    OnKeyDown = TrViewKeyDown
    OnMouseDown = TrViewMouseDown
  end
  object ToolB: TToolBar
    Left = 0
    Top = 29
    Width = 924
    Height = 26
    AutoSize = True
    ButtonHeight = 24
    ButtonWidth = 25
    Caption = 'ToolB'
    EdgeBorders = [ebBottom]
    Images = frPrima.ImList
    TabOrder = 1
    Wrapable = False
    object TB_Group: TToolButton
      Left = 0
      Top = 0
      Hint = #1055#1088#1072#1074#1072' '#1076#1083#1103' '#1075#1088#1091#1087#1087' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      Caption = 'TB_Group'
      Down = True
      Grouped = True
      ImageIndex = 74
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = CB_UserListDropDown
    end
    object TB_User: TToolButton
      Left = 25
      Top = 0
      Hint = #1055#1088#1072#1074#1072' '#1076#1083#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Caption = 'TB_User'
      Enabled = False
      Grouped = True
      ImageIndex = 71
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = CB_UserListDropDown
    end
    object tb_All: TToolButton
      Left = 50
      Top = 0
      Hint = 'C'#1091#1084#1084#1072#1088#1085#1099#1077' '#1087#1088#1072#1074#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080' '#1075#1088#1091#1087#1087#1099' ('#1090#1086#1083#1100#1082#1086' '#1095#1090#1077#1085#1080#1077')'
      Caption = 'C'#1091#1084#1084#1072#1088#1085#1099#1077' '#1087#1088#1072#1074#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080' '#1075#1088#1091#1087#1087#1099' ('#1090#1086#1083#1100#1082#1086' '#1095#1090#1077#1085#1080#1077')'
      Enabled = False
      Grouped = True
      ImageIndex = 20
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = CB_UserListDropDown
    end
    object CB_UserList: TComboBox
      Left = 75
      Top = 0
      Width = 519
      Height = 24
      Hint = #1057#1087#1080#1089#1086#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      Style = csDropDownList
      DropDownCount = 30
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Sorted = True
      TabOrder = 0
      OnChange = CB_UserListChange
    end
    object P_Login: TLabel
      Left = 594
      Top = 0
      Width = 328
      Height = 24
      Margins.Left = 25
      Alignment = taCenter
      AutoSize = False
      Caption = 'P_Login'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
  end
  object aTbFuncIemRight: TActionToolBar
    Left = 0
    Top = 0
    Width = 924
    Height = 29
    ActionManager = frPrima.ActManager
    Caption = 'aTbFuncIemRight'
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
    ParentShowHint = False
    ShowHint = True
    Spacing = 0
  end
  object ActListRight: TActionList
    Images = frPrima.ImList
    Left = 32
    Top = 112
    object A_Collaps: TAction
      Category = 'Tree'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1091#1079#1083#1099
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1091#1079#1083#1099
      ImageIndex = 76
      OnExecute = A_CollapsExecute
    end
    object A_Expand: TAction
      Category = 'Tree'
      Caption = #1056#1072#1089#1082#1088#1099#1090#1100' '#1074#1089#1077' '#1091#1079#1083#1099
      Hint = #1056#1072#1089#1082#1088#1099#1090#1100' '#1074#1089#1077' '#1091#1079#1083#1099
      ImageIndex = 77
      OnExecute = A_ExpandExecute
    end
    object A_Find: TAction
      Category = 'Tree'
      Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102' ...'
      Hint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102' ...'
      ImageIndex = 10
      ShortCut = 16454
      OnExecute = A_FindExecute
    end
    object A_FindNext: TAction
      Category = 'Tree'
      Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077' ...'
      Enabled = False
      Hint = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077' ...'
      ImageIndex = 29
      ShortCut = 114
      OnExecute = A_FindNextExecute
    end
    object A_Refresh: TAction
      Category = 'Tree'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      ImageIndex = 25
      OnExecute = A_RefreshExecute
    end
    object A_Help: THelpContents
      Category = 'Help'
      Caption = #1057#1087#1088#1072#1074#1082#1072
      Hint = #1057#1087#1088#1072#1074#1082#1072
      ImageIndex = 3
    end
    object A_Close: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100
      ShortCut = 16499
      OnExecute = A_CloseExecute
    end
    object A_IsDelete: TAction
      Category = 'Tree'
      Caption = #1044#1086#1087#1091#1089#1082#1072#1077#1090#1089#1103' '#1091#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1077#1081
      Enabled = False
      Hint = #1044#1086#1087#1091#1089#1082#1072#1077#1090#1089#1103' '#1091#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 27
      OnExecute = SetSpravParam
    end
    object A_IsEdit: TAction
      Category = 'Tree'
      Caption = #1044#1086#1087#1091#1089#1082#1072#1077#1090#1089#1103' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Hint = #1044#1086#1087#1091#1089#1082#1072#1077#1090#1089#1103' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      ImageIndex = 28
      OnExecute = SetSpravParam
    end
    object A_IsInsert: TAction
      Category = 'Tree'
      Caption = #1044#1086#1087#1091#1089#1082#1072#1077#1090#1089#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1044#1086#1087#1091#1089#1082#1072#1077#1090#1089#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 30
      OnExecute = SetSpravParam
    end
  end
  object CheckImage: TImageList
    Left = 40
    Top = 192
    Bitmap = {
      494C0101030008005C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      00008080800080808000FFFFFF00000000000000000000000000808080000000
      0000808080000000000080808000000000008080800000000000808080000000
      00008080800080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF0080808000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFC001C0010000FFFFD551D5510000FFFFC001C0010000FFFFC005C0050000
      FFFFC001C0010000FFFFC005C0050000FFFFC001C0010000FFFFC005C0050000
      FFFFC001C0010000FFFFC005C0050000FFFFC001C0010000FFFFC005C0050000
      FFFFC001C0010000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object CBUserTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = CBUserTimerTimer
    Left = 104
    Top = 112
  end
  object IBTr_R: TpFIBTransaction
    DefaultDatabase = frDM.IBDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    UserKindTransaction = 'ReadCommitted'
    Left = 280
    Top = 120
  end
  object IBTr: TpFIBTransaction
    DefaultDatabase = frDM.IBDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    UserKindTransaction = 'ReadCommitted'
    Left = 224
    Top = 120
  end
  object IBSp: TpFIBStoredProc
    Transaction = IBTr
    Database = frDM.IBDB
    Description = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1072#1074' '#1076#1086#1089#1090#1091#1087#1072
    Left = 336
    Top = 120
    qoTrimCharFields = True
  end
  object ppFuncItemRight: TPopupActionBar
    Left = 120
    Top = 192
  end
end