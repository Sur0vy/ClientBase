inherited frRecordClients: TfrRecordClients
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1083#1080#1077#1085#1090#1086#1074
  PixelsPerInch = 96
  TextHeight = 13
  inherited SmartDlg: TSmartDlg
    TabSet = SmartDlg.TabSet
    OnShowDialog = SmartDlgShowDialog
  end
  inherited ActListDialog: TActionList
    object A_NewFirm: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1053#1086#1074#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      Hint = #1053#1086#1074#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      ImageIndex = 59
      Visible = False
      OnExecute = A_NewFirmExecute
    end
    object A_EditFirm: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
      ImageIndex = 80
      Visible = False
      OnExecute = A_EditFirmExecute
    end
  end
  object IBTr_Clients: TpFIBTransaction
    DefaultDatabase = frDM.IBDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 184
    Top = 192
  end
end
