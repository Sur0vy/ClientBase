inherited frAgreesList: TfrAgreesList
  Caption = #1054#1073#1091#1095#1077#1085#1080#1077' '#1082#1083#1080#1077#1085#1090#1086#1074
  ClientHeight = 500
  ClientWidth = 966
  ExplicitWidth = 982
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 16
  inherited SB: TStatusBar
    Top = 481
    Width = 966
    ExplicitTop = 481
    ExplicitWidth = 966
  end
  inherited dbgHost: TDBGridEh
    Width = 966
    Height = 481
    OnDblClick = A_EditAgreesExecute
    OnKeyDown = dbgHostKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'AGREES_NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 178
      end
      item
        EditButtons = <>
        FieldName = 'AGREES_DATE'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 223
      end
      item
        EditButtons = <>
        FieldName = 'FIRM_LIST_TITLE'
        Footers = <>
        Title.Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        Width = 256
      end
      item
        EditButtons = <>
        FieldName = 'FIRM_LIST_SHORT'
        Footers = <>
        Title.Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
        Width = 175
      end
      item
        EditButtons = <>
        FieldName = 'CONTRACT_TYPE_LIST_TITLE'
        Footers = <>
        Title.Caption = #1058#1080#1087' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 155
      end
      item
        EditButtons = <>
        FieldName = 'AGREE_STATUS_LIST_TITLE'
        Footers = <>
        Title.Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 150
      end
      item
        EditButtons = <>
        FieldName = 'AGREES_COMMENT'
        Footers = <>
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      end>
  end
  inherited FontD: TFontDialog
    Left = 160
    Top = 128
  end
  inherited ActList: TActionList
    Left = 96
    Top = 128
    object A_NewAgrees: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1053#1086#1074#1099#1081' '#1076#1086#1075#1086#1074#1086#1088
      Hint = #1053#1086#1074#1099#1081' '#1076#1086#1075#1086#1074#1086#1088
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewAgreesExecute
    end
    object A_EditAgrees: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' ...'
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' ...'
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditAgreesExecute
    end
    object A_DelAgrees: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1075#1086#1074#1086#1088
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1075#1086#1074#1086#1088
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelAgreesExecute
    end
    object A_AddCopyAgrees: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1076#1086#1075#1086#1074#1086#1088#1072
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1076#1086#1075#1086#1074#1086#1088#1072
      ShortCut = 120
      Visible = False
      OnExecute = A_AddCopyAgreesExecute
    end
  end
  inherited SleepTM: TTimer
    Left = 312
    Top = 128
  end
  inherited TmEnabled: TTimer
    Left = 232
    Top = 128
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 384
    Top = 128
  end
  inherited Q_Host: TpFIBDataSet
    RefreshSQL.Strings = (
      'select * from V_AGREES_LIST'
      'where AGREES_LIST_ID = :OLD_AGREES_LIST_ID')
    SelectSQL.Strings = (
      'select * from V_AGREES_LIST')
    AfterOpen = Q_HostAfterScroll
  end
end
