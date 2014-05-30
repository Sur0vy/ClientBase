object frImportFromWWW: TfrImportFromWWW
  Left = 0
  Top = 0
  Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1089' '#1089#1072#1081#1090#1072
  ClientHeight = 582
  ClientWidth = 1065
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object WB: TWebBrowser
    Left = 0
    Top = 0
    Width = 1065
    Height = 582
    Align = alClient
    TabOrder = 0
    OnBeforeNavigate2 = WBBeforeNavigate2
    OnDocumentComplete = WBDocumentComplete
    ExplicitTop = 29
    ExplicitWidth = 665
    ExplicitHeight = 553
    ControlData = {
      4C000000126E0000273C00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Q_Down: TpFIBQuery
    Transaction = frDM.IBTrWrite
    Database = frDM.IBDB
    SQL.Strings = (
      'insert into DOWNLOADINGS ('
      '  DATE_LOAD, CLIENT_LIST_ID, PRODUCT_LIST_ID, PRODUCT_VERSION,'
      '   LOAD_FROM_ADDRESS, WWW_ID )'
      'values ('
      
        '  :DATE_LOAD, :CLIENT_LIST_ID, :PRODUCT_LIST_ID, :PRODUCT_VERSIO' +
        'N,'
      '  :LOAD_FROM_ADDRESS, :WWW_ID )')
    MDTSQLExecutor = se_Server
    Left = 72
    Top = 352
  end
  object Q_Product: TpFIBQuery
    Transaction = frDM.IBTrWrite
    Database = frDM.IBDB
    SQL.Strings = (
      'execute block ('
      '  PRODUCT_LIST_TITLE varchar(100) = ?TITLE )'
      'returns('
      '  PRODUCT_LIST_ID int )'
      'as'
      'begin'
      '  select'
      '    first 1 PRODUCT_LIST_ID'
      '  from PRODUCT_LIST'
      '  where'
      '    PRODUCT_LIST_TITLE = :PRODUCT_LIST_TITLE'
      '  into'
      '    :PRODUCT_LIST_ID;'
      ''
      '  if ( :PRODUCT_LIST_ID is null ) then'
      '      insert into PRODUCT_LIST ('
      '          PRODUCT_LIST_TITLE)'
      '        values ('
      '          :PRODUCT_LIST_TITLE )'
      '        returning'
      '          PRODUCT_LIST_ID'
      '        into'
      '          :PRODUCT_LIST_ID;'
      ''
      '  suspend;'
      'end')
    MDTSQLExecutor = se_Server
    Left = 144
    Top = 352
  end
  object Q_FindClient: TpFIBQuery
    Transaction = frDM.IBTrWrite
    Database = frDM.IBDB
    SQL.Strings = (
      'select'
      '  L.CLIENT_LIST_ID'
      'from CLIENTS_MAIL_LIST L'
      'where'
      '  L.E_MAIL = :E_MAIL')
    MDTSQLExecutor = se_Server
    Left = 224
    Top = 352
  end
  object Q_SaveClient: TpFIBStoredProc
    Transaction = frDM.IBTrWrite
    Database = frDM.IBDB
    Left = 80
    Top = 416
  end
  object Q_findDown: TpFIBQuery
    Transaction = frDM.IBTrWrite
    Database = frDM.IBDB
    SQL.Strings = (
      'select'
      '  DOWNLOADINGS_ID'
      'from DOWNLOADINGS'
      'where'
      '  WWW_ID = :WWW_ID')
    MDTSQLExecutor = se_Server
    Left = 296
    Top = 352
  end
  object ActWWW: TActionList
    Images = frPrima.ImList
    Left = 56
    Top = 64
    object A_OpenWWW: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1089#1090#1088#1072#1085#1080#1094#1091' '#1089#1072#1081#1090#1072' '#1076#1083#1103' '#1080#1084#1087#1086#1088#1090#1072
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1090#1088#1072#1085#1080#1094#1091' '#1089#1072#1081#1090#1072' '#1076#1083#1103' '#1080#1084#1087#1086#1088#1090#1072
      ImageIndex = 0
      OnExecute = A_OpenWWWExecute
    end
    object A_Close: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1092#1086#1088#1084#1091' '#1080#1084#1087#1086#1088#1090#1072
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1092#1086#1088#1084#1091' '#1080#1084#1087#1086#1088#1090#1072
      ImageIndex = 4
      OnExecute = A_CloseExecute
    end
    object A_Back: TAction
      Caption = #1055#1077#1088#1077#1093#1086#1076' '#1085#1072' '#1087#1088#1077#1076#1099#1076#1091#1097#1091#1102' '#1089#1090#1088#1072#1085#1080#1094#1091
      Hint = #1055#1077#1088#1077#1093#1086#1076' '#1085#1072' '#1087#1088#1077#1076#1099#1076#1091#1097#1091#1102' '#1089#1090#1088#1072#1085#1080#1094#1091
      ImageIndex = 47
      OnExecute = A_BackExecute
    end
    object A_Forward: TAction
      Caption = #1055#1077#1088#1077#1093#1086#1076' '#1085#1072' '#1089#1083#1077#1076#1091#1102#1097#1091#1102' '#1089#1090#1088#1072#1085#1080#1094#1091
      Hint = #1055#1077#1088#1077#1093#1086#1076' '#1085#1072' '#1089#1083#1077#1076#1091#1102#1097#1091#1102' '#1089#1090#1088#1072#1085#1080#1094#1091
      ImageIndex = 46
      OnExecute = A_ForwardExecute
    end
    object A_RefreshWWW: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1089#1090#1088#1072#1085#1080#1094#1091
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1091#1102' '#1089#1090#1088#1072#1085#1080#1094#1091
      ImageIndex = 107
      OnExecute = A_RefreshWWWExecute
    end
    object A_ExecImport: TAction
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1080#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1089' '#1089#1072#1081#1090#1072
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1080#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1089' '#1089#1072#1081#1090#1072
      ImageIndex = 34
      Visible = False
      OnExecute = A_ExecImportExecute
    end
  end
end
