object frDM: TfrDM
  OldCreateOrder = False
  Height = 545
  Width = 723
  object IBDB: TpFIBDatabase
    DBName = '192.168.0.111:Lsrm'
    DBParams.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'sql_role_name=RIGHT_TO_ACCESS'
      'lc_ctype=WIN1251')
    DefaultTransaction = IBTrRead
    DefaultUpdateTransaction = IBTrWrite
    SQLDialect = 3
    Timeout = 0
    UpperOldNames = True
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    SaveAliasParamsAfterConnect = False
    AfterConnect = IBDBAfterConnect
    Left = 48
    Top = 32
  end
  object IBTrRead: TpFIBTransaction
    DefaultDatabase = IBDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    AfterEnd = IBTrReadAfterEnd
    TPBMode = tpbDefault
    Left = 48
    Top = 104
  end
  object IBTrWrite: TpFIBTransaction
    DefaultDatabase = IBDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 48
    Top = 176
  end
  object Q_UserRight: TpFIBQuery
    Transaction = IBTrRead
    Database = IBDB
    SQL.Strings = (
      'select'
      '  FUNC_ITEM_RIGHT_ID, FUNC_NAME'
      'from GET_FUNC_RIGHT_ACCESS(:USER_ID, :PARENT_FUNC_NAME)')
    Left = 152
    Top = 32
  end
  object fibEvent: TSIBfibEventAlerter
    Events.Strings = (
      'ALL_JOB_STOP')
    OnEventAlert = fibEventEventAlert
    Database = IBDB
    AutoRegister = True
    Left = 152
    Top = 104
  end
  object IBTrGridSave: TpFIBTransaction
    DefaultDatabase = IBDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 48
    Top = 256
  end
end
