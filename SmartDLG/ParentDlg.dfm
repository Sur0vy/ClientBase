object frParentDlg: TfrParentDlg
  Left = 387
  Top = 233
  BorderIcons = [biSystemMenu]
  ClientHeight = 242
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ToolB: TToolBar
    Left = 0
    Top = 0
    Width = 371
    Height = 22
    AutoSize = True
    Caption = 'ToolB'
    Images = ImList
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object TB_Save: TToolButton
      Left = 0
      Top = 0
      Action = A_Save
    end
    object TB_Close: TToolButton
      Left = 23
      Top = 0
      Action = A_Close
    end
    object TB_S: TToolButton
      Left = 46
      Top = 0
      Width = 8
      Caption = 'TB_S'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object TB_Clear: TToolButton
      Left = 54
      Top = 0
      Action = A_Clear
    end
  end
  object ImList: TImageList
    Left = 16
    Top = 40
  end
  object ActList: TActionList
    Images = ImList
    Left = 72
    Top = 40
    object A_Save: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 0
      ShortCut = 16467
      OnExecute = A_SaveExecute
    end
    object A_Close: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 1
      ShortCut = 27
      OnExecute = A_CloseExecute
    end
    object A_Clear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 2
    end
  end
end
