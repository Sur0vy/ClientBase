inherited FrMemoEdit: TFrMemoEdit
  Caption = 'FrMemoEdit'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo [1]
    Left = 0
    Top = 22
    Width = 371
    Height = 220
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
  inherited ActList: TActionList
    inherited A_Clear: TAction
      OnExecute = A_ClearExecute
    end
  end
end
