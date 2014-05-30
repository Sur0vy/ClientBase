object frClientsListBox: TfrClientsListBox
  Left = 387
  Top = 233
  BorderIcons = [biSystemMenu]
  Caption = #1050#1083#1080#1077#1085#1090#1099' '#1089' '#1089#1086#1074#1087#1072#1076#1072#1102#1097#1080#1084' E-Mail'
  ClientHeight = 287
  ClientWidth = 371
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ToolB: TToolBar
    Left = 0
    Top = 0
    Width = 371
    Height = 22
    AutoSize = True
    Caption = 'ToolB'
    Images = frPrima.ImList
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object TB_Save: TToolButton
      Left = 0
      Top = 0
      Action = A_Save
    end
    object TB_S: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'TB_S'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object TB_Close: TToolButton
      Left = 31
      Top = 0
      Action = A_Close
    end
  end
  object lbClients: TListBox
    Left = 0
    Top = 22
    Width = 371
    Height = 265
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 1
    OnDblClick = A_SaveExecute
  end
  object ActList: TActionList
    Images = frPrima.ImList
    Left = 40
    Top = 40
    object A_Save: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 5
      ShortCut = 16467
      OnExecute = A_SaveExecute
    end
    object A_Close: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 4
      ShortCut = 27
      OnExecute = A_CloseExecute
    end
  end
end
