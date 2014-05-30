inherited frDownList: TfrDownList
  Caption = #1056#1077#1077#1089#1090#1088' '#1079#1072#1082#1072#1095#1077#1082' '#1089' '#1089#1072#1081#1090#1072
  ClientWidth = 762
  ExplicitWidth = 778
  PixelsPerInch = 96
  TextHeight = 16
  inherited SB: TStatusBar
    Width = 762
    ExplicitTop = -19
    ExplicitWidth = 762
  end
  inherited dbgHost: TDBGridEh
    Width = 762
    RowHeight = 50
    RowLines = 0
    Columns = <
      item
        EditButtons = <>
        FieldName = 'DATE_LOAD'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1079#1072#1075#1088#1091#1079#1082#1080
        Width = 107
      end
      item
        EditButtons = <>
        FieldName = 'CLIENT_LIST_TITLE'
        Footers = <>
        Title.Caption = #1050#1083#1080#1077#1085#1090
        Width = 324
      end
      item
        EditButtons = <>
        FieldName = 'E_MAIL_LIST'
        Footers = <>
        Title.Caption = 'E-Mail'
        Width = 216
      end
      item
        EditButtons = <>
        FieldName = 'PRODUCT_LIST_TITLE'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1076#1091#1082#1090#1072
        Width = 340
      end
      item
        EditButtons = <>
        FieldName = 'PRODUCT_VERSION'
        Footers = <>
        Title.Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072
        Width = 116
      end>
  end
  inherited FontD: TFontDialog
    Left = 112
    Top = 104
  end
  inherited ActList: TActionList
    Left = 48
    Top = 104
  end
  inherited SleepTM: TTimer
    Left = 232
    Top = 104
  end
  inherited TmEnabled: TTimer
    Left = 168
    Top = 104
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 288
    Top = 104
  end
  inherited Q_Host: TpFIBDataSet
    RefreshSQL.Strings = (
      
        'select * from V_DOWNLOADINGS where DOWNLOADINGS_ID = :OLD_DOWNLO' +
        'ADINGS_ID')
    SelectSQL.Strings = (
      'select * from V_DOWNLOADINGS')
  end
end
