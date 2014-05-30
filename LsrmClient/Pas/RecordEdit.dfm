inherited frRecordEdit: TfrRecordEdit
  Caption = #1060#1086#1088#1084#1072' '#1088#1077#1076#1072#1082#1090#1086#1088#1072
  ExplicitWidth = 702
  ExplicitHeight = 335
  PixelsPerInch = 96
  TextHeight = 13
  inherited SmartDlg: TSmartDlg
    TabSet = SmartDlg.TabSet
    TypeDialog = isEditor
    OnSetEditText = SmartDlgSetEditText
  end
  inherited ActListDialog: TActionList
    inherited A_Between: TPopMenuAction
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Caption = #1057#1087#1080#1089#1086#1082' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1093' '#1074' '#1076#1080#1072#1083#1086#1075#1077
      Hint = #1057#1087#1080#1089#1086#1082' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1093' '#1074' '#1076#1080#1072#1083#1086#1075#1077
      ImageIndex = 93
    end
  end
  inherited dlgFillRows: TFillRows
    OnGetLookupFieldValue = dlgFillRowsGetLookupFieldValue
  end
  inherited TmSave: TTimer
    Left = 248
  end
  object SpEdit: TpFIBStoredProc
    Transaction = IBTrWrite
    Database = frDM.IBDB
    Left = 184
    Top = 80
  end
  object IBTrWrite: TpFIBTransaction
    DefaultDatabase = frDM.IBDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 184
    Top = 137
  end
end
