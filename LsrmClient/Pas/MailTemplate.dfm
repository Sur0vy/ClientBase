inherited frMailTemplate: TfrMailTemplate
  Caption = #1064#1072#1073#1083#1086#1085#1099' '#1076#1083#1103' '#1088#1072#1089#1089#1099#1083#1086#1082
  ClientHeight = 657
  ClientWidth = 1021
  OnResize = FormResize
  ExplicitWidth = 1037
  ExplicitHeight = 695
  PixelsPerInch = 96
  TextHeight = 16
  object spWeb: TSplitter [0]
    Left = 409
    Top = 29
    Width = 5
    Height = 609
    Beveled = True
    ExplicitTop = 0
    ExplicitHeight = 638
  end
  inherited SB: TStatusBar
    Top = 638
    Width = 1021
    ExplicitTop = 638
    ExplicitWidth = 1021
  end
  inherited dbgHost: TDBGridEh
    Width = 409
    Height = 609
    Align = alLeft
  end
  object WB: TWebBrowser [3]
    Left = 414
    Top = 29
    Width = 607
    Height = 609
    Align = alClient
    TabOrder = 2
    ExplicitHeight = 638
    ControlData = {
      4C000000BC3E0000F13E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  inherited aTbSprav: TActionToolBar
    Width = 1021
    ExplicitWidth = 1021
  end
  inherited ActList: TActionList
    object A_HostTemplateEdit: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = 
        #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' "'#1055#1088#1086#1089#1090#1086#1081' '#1096#1072#1073#1083#1086#1085'", '#1086#1089#1085#1086#1074#1072' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1086#1089#1090#1072#1083#1100#1085#1099#1093' '#1096#1072 +
        #1073#1083#1086#1085#1086#1074
      Hint = 
        #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' "'#1055#1088#1086#1089#1090#1086#1081' '#1096#1072#1073#1083#1086#1085'", '#1086#1089#1085#1086#1074#1072' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1086#1089#1090#1072#1083#1100#1085#1099#1093' '#1096#1072 +
        #1073#1083#1086#1085#1086#1074
      Visible = False
      OnExecute = A_HostTemplateEditExecute
    end
  end
  inherited PrintDBG: TPrintDBGridEh
    Left = 72
    Top = 72
  end
  inherited Q_Host: TpFIBDataSet
    AfterOpen = Q_HostAfterOpen
    AfterRefresh = Q_HostAfterRefresh
  end
end
