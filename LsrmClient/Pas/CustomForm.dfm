object frCustomForm: TfrCustomForm
  Left = 353
  Top = 419
  Caption = #1064#1072#1073#1083#1086#1085
  ClientHeight = 298
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object SB: TStatusBar
    Left = 0
    Top = 279
    Width = 578
    Height = 19
    AutoHint = True
    Panels = <>
    Visible = False
  end
  object FontD: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OnApply = FontDApply
    Left = 136
    Top = 16
  end
  object ActList: TActionList
    Images = frPrima.ImList
    Left = 72
    Top = 16
    object A_FiltrClear: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 37
      OnExecute = A_FiltrClearExecute
    end
    object A_First: TDataSetFirst
      Category = 'DataSet'
      Caption = #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
      Hint = #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 48
    end
    object A_Prior: TDataSetPrior
      Category = 'DataSet'
      Caption = #1053#1072' '#1087#1088#1077#1076#1099#1076#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      Hint = #1053#1072' '#1087#1088#1077#1076#1099#1076#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 47
    end
    object A_Next: TDataSetNext
      Category = 'DataSet'
      Caption = #1053#1072' '#1089#1083#1077#1076#1091#1102#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      Hint = #1053#1072' '#1089#1083#1077#1076#1091#1102#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 46
    end
    object A_Last: TDataSetLast
      Category = 'DataSet'
      Caption = #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
      Hint = #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 45
    end
    object A_Refresh: TAction
      Category = 'DataSet'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 25
      OnExecute = A_RefreshExecute
      OnUpdate = A_RefreshUpdate
    end
    object A_RefreshFull: TAction
      Category = 'Dataset'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1074#1089#1102' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1074#1089#1102' '#1090#1072#1073#1083#1080#1094#1091
      ImageIndex = 107
      OnExecute = A_RefreshFullExecute
      OnUpdate = A_RefreshFullUpdate
    end
    object A_Close: TAction
      Category = 'Form'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 4
      ShortCut = 16499
      OnExecute = A_CloseExecute
    end
    object A_Help: TAction
      Category = 'Form'
      Caption = #1057#1087#1088#1072#1074#1082#1072
      Hint = #1057#1087#1088#1072#1074#1082#1072
      ImageIndex = 3
      ShortCut = 112
      OnExecute = A_HelpExecute
    end
    object A_AutoWidth: TAction
      Category = 'Align'
      Caption = #1055#1086#1084#1077#1089#1090#1080#1090#1100' '#1074#1089#1077' '#1082#1086#1083#1086#1085#1082#1080' '#1074' '#1101#1082#1088#1072#1085
      Hint = #1055#1086#1084#1077#1089#1090#1080#1090#1100' '#1074#1089#1077' '#1082#1086#1083#1086#1085#1082#1080' '#1074' '#1101#1082#1088#1072#1085
      ImageIndex = 8
      OnExecute = A_AutoWidthExecute
      OnUpdate = A_AutoWidthUpdate
    end
    object A_Left: TAction
      Category = 'Align'
      AutoCheck = True
      Caption = #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
      Enabled = False
      Hint = #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
      ImageIndex = 42
      OnExecute = A_LeftExecute
    end
    object A_Right: TAction
      Category = 'Align'
      AutoCheck = True
      Caption = #1055#1086' '#1087#1088#1072#1074#1086#1084#1091' '#1082#1088#1072#1102
      Enabled = False
      Hint = #1055#1086' '#1087#1088#1072#1074#1086#1084#1091' '#1082#1088#1072#1102
      ImageIndex = 43
      OnExecute = A_RightExecute
    end
    object A_Centr: TAction
      Category = 'Align'
      AutoCheck = True
      Caption = #1055#1086' '#1094#1077#1085#1090#1088#1091
      Enabled = False
      Hint = #1055#1086' '#1094#1077#1085#1090#1088#1091
      ImageIndex = 44
      OnExecute = A_CentrExecute
    end
    object A_Frozen: TAction
      Category = 'Align'
      Caption = #1047#1072#1082#1088#1077#1087#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1082#1086#1083#1086#1085#1082#1091
      Hint = #1047#1072#1082#1088#1077#1087#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1082#1086#1083#1086#1085#1082#1091
      ImageIndex = 55
      OnExecute = A_FrozenExecute
    end
    object A_FontOfList: TPopMenuAction
      Category = 'Align'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1096#1088#1080#1092#1090#1086#1074' ...'
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1096#1088#1080#1092#1090#1086#1074' ...'
      ImageIndex = 15
    end
    object A_Font: TAction
      Category = 'Align'
      Caption = #1064#1088#1080#1092#1090' '#1090#1077#1082#1091#1097#1077#1081' '#1082#1086#1083#1086#1085#1082#1080' '#1090#1072#1073#1083#1080#1094#1099' ...'
      Enabled = False
      Hint = #1064#1088#1080#1092#1090' '#1090#1077#1082#1091#1097#1077#1081' '#1082#1086#1083#1086#1085#1082#1080' '#1090#1072#1073#1083#1080#1094#1099' ...'
      ImageIndex = 15
      OnExecute = A_FontExecute
      OnUpdate = A_FontUpdate
    end
    object A_Print: TAction
      Category = 'Form'
      Caption = #1055#1077#1095#1072#1090#1100' ...'
      Hint = #1055#1077#1095#1072#1090#1100' ...'
      ImageIndex = 19
      OnExecute = A_PrintExecute
      OnUpdate = A_PrintUpdate
    end
    object A_GridAllFont: TAction
      Category = 'Align'
      Caption = #1064#1088#1080#1092#1090' '#1074#1089#1077#1093' '#1082#1086#1083#1086#1085#1082' '#1090#1072#1073#1083#1080#1094#1099' ...'
      Hint = #1064#1088#1080#1092#1090' '#1074#1089#1077#1093' '#1082#1086#1083#1086#1085#1082' '#1090#1072#1073#1083#1080#1094#1099' ...'
      OnExecute = A_GridAllFontExecute
      OnUpdate = A_GridAllFontUpdate
    end
    object A_HostGridSetup: TAction
      Category = 'Grid'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1082#1086#1083#1086#1085#1086#1082
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1082#1086#1083#1086#1085#1086#1082
      ImageIndex = 87
      OnExecute = A_HostGridSetupExecute
    end
    object A_DsLocation: TPopMenuAction
      Category = 'DataSet'
      Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' '#1090#1072#1073#1083#1080#1094#1077
      Hint = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' '#1090#1072#1073#1083#1080#1094#1077
    end
    object A_Align: TPopMenuAction
      Category = 'Align'
      Caption = #1064#1088#1080#1092#1090' '#1080' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Hint = #1064#1088#1080#1092#1090' '#1080' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077
    end
    object A_ExcelExport: TAction
      Category = 'Form'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      ImageIndex = 86
      Visible = False
      OnExecute = A_PrintExecute
      OnUpdate = A_PrintUpdate
    end
    object A_Filtr: TFiltrActList
      Category = #1055#1086#1080#1089#1082
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088
      ImageIndex = 36
      ShortCut = 16454
      OnExecute = A_FiltrExecute
      ShowDlg = True
      OnShowParam = A_FiltrShowParam
      DlgIdent = 0
      NoShow = 0
      OnAfterExecFiltr = A_FiltrAfterExecFiltr
    end
    object A_ShowOfStart: TAction
      Category = #1055#1086#1080#1089#1082
      AutoCheck = True
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1080#1072#1083#1086#1075' '#1092#1080#1083#1100#1090#1088#1072' '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' '#1078#1091#1088#1085#1072#1083#1072' '#1080#1083#1080' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Checked = True
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1080#1072#1083#1086#1075' '#1092#1080#1083#1100#1090#1088#1072' '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' '#1078#1091#1088#1085#1072#1083#1072' '#1080#1083#1080' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      OnExecute = A_ShowOfStartExecute
    end
    object A_ToolBarSetup: TAction
      Category = 'Grid'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1082#1085#1086#1087#1086#1082' '#1085#1072' '#1090#1091#1083#1073#1072#1088#1077
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1082#1085#1086#1087#1086#1082' '#1085#1072' '#1090#1091#1083#1073#1072#1088#1077
      ShortCut = 16497
      OnExecute = A_ToolBarSetupExecute
    end
  end
  object SleepTM: TTimer
    Enabled = False
    Interval = 200
    OnTimer = SleepTMTimer
    Left = 280
    Top = 16
  end
  object TmEnabled: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TmEnabledTimer
    Left = 200
    Top = 16
  end
  object PrintDBG: TPrintDBGridEh
    Options = []
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'Tahoma'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'Tahoma'
    PageHeader.Font.Style = []
    Units = MM
    Left = 344
    Top = 16
  end
end
