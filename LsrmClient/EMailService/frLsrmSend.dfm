object LsrmMailSend: TLsrmMailSend
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'LsrmMailSend'
  OnExecute = ServiceExecute
  OnShutdown = ServiceShutdown
  OnStop = ServiceStop
  Height = 322
  Width = 468
  object IBDB: TIBDatabase
    DatabaseName = 'DOM-L:LsrmUser--'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTr_Read
    ServerType = 'IBServer'
    Left = 48
    Top = 48
  end
  object IBTr_Read: TIBTransaction
    DefaultDatabase = IBDB
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait'
      'read')
    Left = 120
    Top = 48
  end
  object IBTr_Write: TIBTransaction
    DefaultDatabase = IBDB
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait'
      'write')
    Left = 192
    Top = 48
  end
  object SMTP: TIdSMTP
    IOHandler = OpenSSL
    Port = 465
    SASLMechanisms = <>
    UseTLS = utUseImplicitTLS
    Left = 328
    Top = 48
  end
  object Mess: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CharSet = 'utf-8'
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 392
    Top = 48
  end
  object OpenSSL: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':465'
    MaxLineAction = maException
    Port = 465
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 328
    Top = 112
  end
  object TM: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = TMTimer
    Left = 48
    Top = 112
  end
  object Q_Mess: TIBQuery
    Database = IBDB
    Transaction = IBTr_Read
    SQL.Strings = (
      'select * from V_SUBSCRIBE_SEND')
    Left = 56
    Top = 248
  end
  object Q_Save: TIBQuery
    Database = IBDB
    Transaction = IBTr_Write
    SQL.Strings = (
      'update SUBSCRIBE_SEND SS'
      'set'
      '  SS.DATE_SEND = :DATE_SEND,'
      '  SS.ERROR_TEXT = :ERROR_TEXT,'
      '  SS.IS_OK = :IS_OK'
      'where'
      '  SS.SUBSCRIBE_LIST_ID = :SUBSCRIBE_LIST_ID and'
      '  SS.CLIENTS_MAIL_LIST_ID = :CLIENTS_MAIL_LIST_ID')
    Left = 200
    Top = 248
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'DATE_SEND'
        ParamType = ptInput
        Value = 0d
      end
      item
        DataType = ftString
        Name = 'ERROR_TEXT'
        ParamType = ptInput
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'IS_OK'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SUBSCRIBE_LIST_ID'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'CLIENTS_MAIL_LIST_ID'
        ParamType = ptInput
        Value = 0
      end>
  end
  object Q_MessAttach: TIBQuery
    Database = IBDB
    Transaction = IBTr_Read
    SQL.Strings = (
      'select'
      '  FILE_NAME, FILE_BODY, IS_RELATED'
      'from MAIL_ATTACHMENT_LIST(:SUBSCRIBE_LIST_ID)')
    Left = 128
    Top = 248
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SUBSCRIBE_LIST_ID'
        ParamType = ptInput
        Value = -1
      end>
  end
  object IBEvent: TIBEvents
    AutoRegister = True
    Database = IBDB
    Events.Strings = (
      'SET_MAIL_SUBSCRIBE_LIST')
    Registered = False
    OnEventAlert = IBEventEventAlert
    Left = 120
    Top = 112
  end
  object Q_LabelList: TIBQuery
    Database = IBDB
    Transaction = IBTr_Read
    SQL.Strings = (
      'select'
      
        '  MAIL_BASE_LABEL_TITLE, MAIL_BASE_LABEL_NAME, MAIL_BASE_LABEL_I' +
        'D'
      'from MAIL_BASE_LABEL'
      'where'
      '  IS_DELETE > 0 and IS_USE = 1'
      'order by'
      '  1')
    Left = 272
    Top = 248
  end
  object Q_LabelValue: TIBQuery
    Database = IBDB
    Transaction = IBTr_Read
    BeforeOpen = Q_LabelValueBeforeOpen
    SQL.Strings = (
      
        'select * from SUBSCRIBE_PREVIEW_S( :SUBSCRIBE_LIST_ID, :CLIENTS_' +
        'MAIL_LIST_ID )')
    Left = 336
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SUBSCRIBE_LIST_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CLIENTS_MAIL_LIST_ID'
        ParamType = ptUnknown
      end>
  end
end
