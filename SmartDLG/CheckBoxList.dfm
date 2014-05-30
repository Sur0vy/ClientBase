inherited FrCheckBoxList: TFrCheckBoxList
  Left = 612
  Top = 154
  ClientHeight = 166
  ClientWidth = 392
  Constraints.MinHeight = 200
  Constraints.MinWidth = 400
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 408
  ExplicitHeight = 204
  PixelsPerInch = 96
  TextHeight = 13
  inherited ToolB: TToolBar
    Width = 392
    ExplicitWidth = 392
    object TB_SelAll: TToolButton
      Left = 77
      Top = 0
      Action = A_SellAll
    end
    object TB_Invert: TToolButton
      Left = 100
      Top = 0
      Action = A_SelInvert
    end
    object TB_Order: TToolButton
      Left = 123
      Top = 0
      Width = 8
      Caption = 'TB_Order'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object TB_First: TToolButton
      Left = 131
      Top = 0
      Action = A_First
    end
    object TB_Prior: TToolButton
      Left = 154
      Top = 0
      Action = A_Prior
    end
    object TB_Next: TToolButton
      Left = 177
      Top = 0
      Action = A_Next
    end
    object TB_Last: TToolButton
      Left = 200
      Top = 0
      Action = A_Last
    end
  end
  object ChBox: TCheckListBox [1]
    Left = 0
    Top = 44
    Width = 392
    Height = 103
    OnClickCheck = ChBoxClickCheck
    Align = alClient
    Ctl3D = True
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 1
    OnClick = ChBoxClick
    OnKeyDown = ChBoxKeyDown
    OnKeyPress = ChBoxKeyPress
    OnMouseUp = ChBoxMouseUp
  end
  object SB: TStatusBar [2]
    Left = 0
    Top = 147
    Width = 392
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 22
    Width = 392
    Height = 22
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 3
    DesignSize = (
      392
      22)
    object Label1: TLabel
      Left = 6
      Top = 4
      Width = 40
      Height = 13
      Caption = #1060#1080#1083#1100#1090#1088
    end
    object FiltrEdit: TEdit
      Left = 52
      Top = 1
      Width = 335
      Height = 20
      Hint = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103' '#1079#1072#1087#1080#1089#1077#1081
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      TabOrder = 0
      OnChange = A_FiltrExecute
    end
  end
  inherited ImList: TImageList
    Left = 8
    Top = 88
  end
  inherited ActList: TActionList
    Left = 64
    Top = 80
    inherited A_Clear: TAction
      Category = 'Check'
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1077#1089#1100' '#1074#1099#1073#1086#1088
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1077#1089#1100' '#1074#1099#1073#1086#1088
      ImageIndex = 4
      OnExecute = A_ClearExecute
    end
    object A_SellAll: TAction
      Category = 'Check'
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      ImageIndex = 3
      OnExecute = A_SellAllExecute
    end
    object A_SelInvert: TAction
      Category = 'Check'
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      Hint = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      ImageIndex = 5
      OnExecute = A_SelInvertExecute
    end
    object A_First: TAction
      Category = 'Order_By'
      Caption = #1042' '#1085#1072#1095#1072#1083#1086' '#1089#1087#1080#1089#1082#1072
      Hint = #1042' '#1085#1072#1095#1072#1083#1086' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 8
      ShortCut = 16420
      OnExecute = A_FirstExecute
    end
    object A_Last: TAction
      Category = 'Order_By'
      Caption = #1042' '#1082#1086#1085#1077#1094' '#1089#1087#1080#1089#1082#1072
      Hint = #1042' '#1082#1086#1085#1077#1094' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 7
      ShortCut = 16419
      OnExecute = A_LastExecute
    end
    object A_Next: TAction
      Category = 'Order_By'
      Caption = #1042#1085#1080#1079
      Hint = #1042#1085#1080#1079
      ImageIndex = 10
      ShortCut = 16424
      OnExecute = A_NextExecute
    end
    object A_Prior: TAction
      Category = 'Order_By'
      Caption = #1042#1074#1077#1088#1093
      Hint = #1042#1074#1077#1088#1093
      ImageIndex = 9
      ShortCut = 16422
      OnExecute = A_PriorExecute
    end
  end
end
