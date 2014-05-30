inherited frSpravFileImages: TfrSpravFileImages
  Caption = #1050#1072#1088#1090#1080#1085#1082#1080' '#1076#1083#1103' '#1096#1072#1073#1083#1086#1085#1086#1074
  ClientHeight = 515
  ClientWidth = 1072
  OnResize = FormResize
  ExplicitWidth = 1088
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 16
  object spImage: TSplitter [0]
    Left = 545
    Top = 29
    Width = 5
    Height = 467
    Beveled = True
    ExplicitLeft = 425
  end
  object imShowImage: TImage [1]
    Left = 550
    Top = 29
    Width = 522
    Height = 467
    Align = alClient
    ExplicitLeft = 672
    ExplicitTop = 168
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  inherited SB: TStatusBar
    Top = 496
    Width = 1072
    ExplicitTop = 496
    ExplicitWidth = 1072
  end
  inherited dbgHost: TDBGridEh
    Width = 545
    Height = 467
    Align = alLeft
    DrawGraphicData = True
  end
  inherited aTbSprav: TActionToolBar
    Width = 1072
    ExplicitWidth = 1072
  end
  inherited ActList: TActionList
    object A_ShowImage: TAction
      Category = #1044#1080#1072#1083#1086#1075#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1092#1072#1081#1083#1072
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1092#1072#1081#1083#1072
      ImageIndex = 108
      ShortCut = 16464
      Visible = False
      OnExecute = A_ShowImageExecute
    end
  end
  inherited Q_Host: TpFIBDataSet
    SelectSQL.Strings = (
      'select'
      
        '   FILE_IMAGES_ID, FILE_IMAGES_NAME,  FILE_IMAGES_BODY FILE_BODY' +
        ', '
      '   IS_USE, IS_DELETE'
      'from FILE_IMAGES '
      'where IS_DELETE > 0'
      'order by FILE_IMAGES_NAME')
  end
end
