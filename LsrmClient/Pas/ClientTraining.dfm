inherited frClientTraining: TfrClientTraining
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
    OnDblClick = A_EditClientTrainingExecute
    OnKeyDown = dbgHostKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'DATE_TRAINING'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1079#1072#1085#1103#1090#1080#1081
        Width = 113
      end
      item
        EditButtons = <>
        FieldName = 'TRAINING_LIST_TITLE'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1091#1088#1089#1086#1074
        Width = 223
      end
      item
        EditButtons = <>
        FieldName = 'SERTIFICATE_NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090#1072
        Width = 146
      end
      item
        EditButtons = <>
        FieldName = 'CLIENT_TITLE'
        Footers = <>
        Title.Caption = #1050#1083#1080#1077#1085#1090
        Width = 297
      end>
  end
  inherited FontD: TFontDialog
    Left = 160
    Top = 128
  end
  inherited ActList: TActionList
    Left = 96
    Top = 128
    object A_NewClientTraining: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1053#1086#1074#1086#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1053#1086#1074#1086#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 30
      ShortCut = 45
      Visible = False
      OnExecute = A_NewClientTrainingExecute
    end
    object A_EditClientTraining: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' ...'
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' ...'
      ImageIndex = 60
      ShortCut = 115
      Visible = False
      OnExecute = A_EditClientTrainingExecute
    end
    object A_DelClientTraining: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      ImageIndex = 27
      Visible = False
      OnExecute = A_DelClientTrainingExecute
    end
    object A_AddClientTraining: TAction
      Category = #1056#1077#1076#1072#1082#1090#1086#1088
      Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      Hint = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      ShortCut = 120
      Visible = False
      OnExecute = A_AddClientTrainingExecute
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
      'select * from V_CLIENT_TRAINING'
      'where CLIENT_TRAINING_ID = :OLD_CLIENT_TRAINING_ID')
    SelectSQL.Strings = (
      'select * from V_CLIENT_TRAINING')
    AfterOpen = Q_HostAfterScroll
  end
end
