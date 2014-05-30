inherited frFiltrDlg: TfrFiltrDlg
  Caption = #1044#1080#1072#1083#1086#1075' '#1092#1080#1083#1100#1090#1088#1072
  PixelsPerInch = 96
  TextHeight = 13
  inherited SmartDlg: TSmartDlg
    TabSet = SmartDlg.TabSet
    TypeDialog = isFiltr
  end
  inherited ActListDialog: TActionList
    Left = 40
    Top = 136
    inherited A_Save: TAction
      Caption = #1060#1080#1083#1100#1090#1088#1086#1074#1072#1090#1100
      Hint = #1060#1080#1083#1100#1090#1088#1086#1074#1072#1090#1100
      ImageIndex = 36
    end
    inherited A_Between: TPopMenuAction
      Visible = True
    end
    inherited A_SetBetween: TAction
      Visible = True
    end
  end
  inherited dlgFillRows: TFillRows
    OnAfterFillRowList = dlgFillRowsAfterFillRowList
    Left = 104
    Top = 81
  end
end
