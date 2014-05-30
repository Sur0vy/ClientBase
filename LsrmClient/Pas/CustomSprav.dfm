inherited frCustomSprav: TfrCustomSprav
  Left = 500
  Top = 83
  Caption = #1060#1086#1088#1084#1072' '#1076#1083#1103' '#1087#1086#1082#1072#1079#1072' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074
  ClientHeight = 472
  ClientWidth = 772
  Position = poDesigned
  ExplicitWidth = 788
  ExplicitHeight = 510
  PixelsPerInch = 96
  TextHeight = 16
  inherited SB: TStatusBar
    Top = 453
    Width = 772
    ExplicitTop = 453
    ExplicitWidth = 772
  end
  inherited dbgHost: TDBGridEh
    Top = 29
    Width = 772
    Height = 424
    OnDblClick = A_SpravEditExecute
    OnKeyDown = dbgHostKeyDown
  end
  object aTbSprav: TActionToolBar [2]
    Left = 0
    Top = 0
    Width = 772
    Height = 29
    ActionManager = frPrima.ActManager
    Caption = 'aTbSprav'
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
  inherited ActList: TActionList
    inherited A_Filtr: TFiltrActList
      SortingResult = True
    end
    object A_SpravNew: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1089#1090#1088#1086#1082#1091
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1089#1090#1088#1086#1082#1091
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_SpravNewExecute
    end
    object A_SpravEdit: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'...'
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'...'
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_SpravEditExecute
    end
    object A_SpravDelete: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1079#1072#1087#1080#1089#1100' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      ImageIndex = 27
      Visible = False
      OnExecute = A_SpravDeleteExecute
    end
    object A_SpravAddCopy: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      ShortCut = 120
      Visible = False
      OnExecute = A_SpravAddCopyExecute
    end
    object A_ShowDelete: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 79
      Visible = False
      OnExecute = A_ShowDeleteExecute
    end
    object A_UpdateSysdba: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072' (sysdba)'
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072' (sysdba)'
      Visible = False
      OnExecute = A_UpdateSysdbaExecute
    end
  end
  inherited Q_Host: TpFIBDataSet
    AfterOpen = Q_HostAfterScroll
    AfterRefresh = Q_HostAfterScroll
    UpdateTransaction = frDM.IBTrGridSave
  end
end
