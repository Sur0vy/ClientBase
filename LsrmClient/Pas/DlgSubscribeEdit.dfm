inherited frDlgSubscribeEdit: TfrDlgSubscribeEdit
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1086#1095#1090#1086#1074#1086#1081' '#1088#1072#1089#1089#1099#1083#1082#1080
  ClientHeight = 568
  ClientWidth = 1023
  OnKeyDown = FormKeyDown
  ExplicitWidth = 1039
  ExplicitHeight = 606
  PixelsPerInch = 96
  TextHeight = 13
  object SpHtmlDlg: TSplitter [0]
    Left = 0
    Top = 129
    Width = 1023
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    ExplicitTop = 149
  end
  inherited SB: TStatusBar
    Top = 549
    Width = 1023
    ExplicitTop = 549
    ExplicitWidth = 1023
  end
  inherited SmartDlg: TSmartDlg
    Width = 1023
    Height = 100
    Align = alTop
    TabSet = SmartDlg.TabSet
    DividerPosition = 509
    ExplicitWidth = 1023
    ExplicitHeight = 100
  end
  inherited aTbSmartDLG: TActionToolBar
    Width = 1023
    ExplicitWidth = 1023
  end
  object pnlHtml: TPanel [4]
    Left = 0
    Top = 134
    Width = 1023
    Height = 415
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    OnMouseActivate = pnlHtmlMouseActivate
    object ControlB: TControlBar
      Left = 0
      Top = 0
      Width = 1023
      Height = 56
      Align = alTop
      AutoSize = True
      TabOrder = 0
      object tlbSaveOpen: TToolBar
        Left = 11
        Top = 2
        Width = 582
        Height = 22
        AutoSize = True
        Caption = 'tlbSaveOpen'
        Images = frPrima.HtmlImList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbWbIsEdit: TToolButton
          Left = 0
          Top = 0
          Action = A_WbIsEdit
        end
        object tbSpEdit: TToolButton
          Left = 23
          Top = 0
          Width = 8
          Caption = 'tbSpEdit'
          ImageIndex = 49
          Style = tbsSeparator
        end
        object tbSaveToFile: TToolButton
          Left = 31
          Top = 0
          Action = A_SaveToFile
        end
        object tbOpenFile: TToolButton
          Left = 54
          Top = 0
          Action = A_OpenFromFile
        end
        object tbSpFind: TToolButton
          Left = 77
          Top = 0
          Width = 8
          Caption = 'tbSpFind'
          ImageIndex = 48
          Style = tbsSeparator
        end
        object tbFindOfPage: TToolButton
          Left = 85
          Top = 0
          Action = A_FindOfPage
        end
        object tbSpCopyPaste: TToolButton
          Left = 108
          Top = 0
          Width = 8
          Caption = 'tbSpCopyPaste'
          ImageIndex = 26
          Style = tbsSeparator
        end
        object tbEditCut: TToolButton
          Left = 116
          Top = 0
          Action = A_CutFromWB
        end
        object tbEditCopy: TToolButton
          Left = 139
          Top = 0
          Action = A_CopyFromWB
        end
        object tbEditPaste: TToolButton
          Left = 162
          Top = 0
          Action = A_PasteToWB
        end
        object tbSpUndo: TToolButton
          Left = 185
          Top = 0
          Width = 8
          Caption = 'tbSpUndo'
          ImageIndex = 55
          Style = tbsSeparator
        end
        object tbEditUndo: TToolButton
          Left = 193
          Top = 0
          Action = A_EditUndo
        end
        object tbEditRedo: TToolButton
          Left = 216
          Top = 0
          Action = A_EditRedo
        end
        object tbSpLink: TToolButton
          Left = 239
          Top = 0
          Width = 8
          Caption = 'tbSpLink'
          ImageIndex = 24
          Style = tbsSeparator
        end
        object tbCreateLink: TToolButton
          Left = 247
          Top = 0
          Action = A_CreateLink
        end
        object tbInsertLine: TToolButton
          Left = 270
          Top = 0
          Action = A_InsertLine
        end
        object tbInsertImage: TToolButton
          Left = 293
          Top = 0
          Action = A_InsertImage
        end
        object tbInsertHtmlImage: TToolButton
          Left = 316
          Top = 0
          Action = A_InsertHtmlImage
        end
        object tbSpFontColor: TToolButton
          Left = 339
          Top = 0
          Width = 8
          Caption = 'tbSpFontColor'
          ImageIndex = 37
          Style = tbsSeparator
        end
        object tbFontBackColor: TToolButton
          Left = 347
          Top = 0
          Action = A_FontBackColor
        end
        object tbFontColor: TToolButton
          Left = 370
          Top = 0
          Action = A_FontColor
        end
        object tbSpColor: TToolButton
          Left = 393
          Top = 0
          Width = 8
          Caption = 'tbSpColor'
          ImageIndex = 36
          Style = tbsSeparator
        end
        object cbFontSize: TComboBox
          Left = 401
          Top = 0
          Width = 146
          Height = 21
          Style = csDropDownList
          ItemIndex = 2
          TabOrder = 0
          Text = #1064#1088#1080#1092#1090' 3 (12 '#1087#1090')'
          OnKeyDown = cbFontSizeKeyDown
          OnSelect = cbFontSizeSelect
          Items.Strings = (
            #1064#1088#1080#1092#1090' 1 ( 8 '#1087#1090')'
            #1064#1088#1080#1092#1090' 2 (10 '#1087#1090')'
            #1064#1088#1080#1092#1090' 3 (12 '#1087#1090')'
            #1064#1088#1080#1092#1090' 4 (14 '#1087#1090')'
            #1064#1088#1080#1092#1090' 5 (18 '#1087#1090')'
            #1064#1088#1080#1092#1090' 6 (24 '#1087#1090')'
            #1064#1088#1080#1092#1090' 7 (36 '#1087#1090')'
            #1064#1088#1080#1092#1090' '#1085#1077' '#1080#1079#1074#1077#1089#1090#1077#1085)
        end
      end
      object tlbFont: TToolBar
        Left = 12
        Top = 28
        Width = 501
        Height = 22
        AutoSize = True
        Caption = 'ToolBar1'
        Images = frPrima.HtmlImList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        object tbFontBold: TToolButton
          Left = 0
          Top = 0
          Action = A_FontBold
        end
        object tbFontItalic: TToolButton
          Left = 23
          Top = 0
          Action = A_FontItalic
        end
        object tbFontStrike: TToolButton
          Left = 46
          Top = 0
          Action = A_FontStrike
        end
        object tbFontUnderLine: TToolButton
          Left = 69
          Top = 0
          Action = A_FontUnderLine
        end
        object tbSpFont: TToolButton
          Left = 92
          Top = 0
          Width = 8
          Caption = 'tbSpFont'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object tbParleft: TToolButton
          Left = 100
          Top = 0
          Action = A_Parleft
        end
        object tbParCenter: TToolButton
          Left = 123
          Top = 0
          Action = A_ParCenter
        end
        object tbParRight: TToolButton
          Left = 146
          Top = 0
          Action = A_ParRight
        end
        object tbParJustifyFull: TToolButton
          Left = 169
          Top = 0
          Action = A_ParJustifyFull
        end
        object tbParLocation: TToolButton
          Left = 192
          Top = 0
          Width = 8
          Caption = 'tbParLocation'
          ImageIndex = 6
          Style = tbsSeparator
        end
        object tbSimpleList: TToolButton
          Left = 200
          Top = 0
          Action = A_SimpleList
        end
        object tbSmartList: TToolButton
          Left = 223
          Top = 0
          Action = A_SmartList
        end
        object tbList: TToolButton
          Left = 246
          Top = 0
          Width = 8
          Caption = 'tbList'
          ImageIndex = 8
          Style = tbsSeparator
        end
        object tbIdentleft: TToolButton
          Left = 254
          Top = 0
          Action = A_Identleft
        end
        object tbIdentRight: TToolButton
          Left = 277
          Top = 0
          Action = A_IdentRigth
        end
        object tbSpIdent: TToolButton
          Left = 300
          Top = 0
          Width = 8
          Caption = 'tbSpIdent'
          ImageIndex = 16
          Style = tbsSeparator
        end
        object cbParFormat: TComboBox
          Left = 308
          Top = 0
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = #1054#1089#1085#1086#1074#1085#1086#1081' '#1090#1077#1082#1089#1090
          OnSelect = cbParFormatSelect
          Items.Strings = (
            #1054#1089#1085#1086#1074#1085#1086#1081' '#1090#1077#1082#1089#1090
            #1040#1073#1079#1072#1094
            #1047#1072#1075#1086#1083#1086#1074#1086#1082' 1'
            #1047#1072#1075#1086#1083#1086#1074#1086#1082' 2'
            #1047#1072#1075#1086#1083#1086#1074#1086#1082' 3'
            #1047#1072#1075#1086#1083#1086#1074#1086#1082' 4'
            #1047#1072#1075#1086#1083#1086#1074#1086#1082' 5'
            #1047#1072#1075#1086#1083#1086#1074#1086#1082' 6'
            #1041#1077#1079' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1103)
        end
        object tbSpInsLabel: TToolButton
          Left = 429
          Top = 0
          Width = 8
          Caption = 'tbSpInsLabel'
          ImageIndex = 17
          Style = tbsSeparator
        end
        object tbInsBaseLabel: TToolButton
          Left = 437
          Top = 0
          Action = A_InsBaseLabel
          DropdownMenu = ppBaseLabel
          Style = tbsDropDown
        end
      end
      object bxAttach: TListBox
        Left = 720
        Top = 2
        Width = 296
        Height = 48
        Style = lbOwnerDrawFixed
        Align = alRight
        TabOrder = 2
        Visible = False
        OnKeyDown = bxAttachKeyDown
      end
    end
    object WB: TWebBrowser
      Left = 13
      Top = 62
      Width = 255
      Height = 251
      TabStop = False
      PopupMenu = ppMMBrowser
      TabOrder = 1
      OnBeforeNavigate2 = WBBeforeNavigate2
      OnDocumentComplete = WBDocumentComplete
      ControlData = {
        4C0000005B1A0000F11900000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  inherited FontD: TFontDialog
    Left = 56
    Top = 40
  end
  inherited ActListDialog: TActionList
    Left = 120
    Top = 40
    object A_AddAttach: TAction
      Category = #1044#1080#1072#1083#1086#1075
      Caption = #1042#1083#1086#1078#1080#1090#1100' '#1092#1072#1081#1083' '#1074' '#1088#1072#1089#1089#1099#1083#1082#1091
      Hint = #1042#1083#1086#1078#1080#1090#1100' '#1092#1072#1081#1083' '#1074' '#1088#1072#1089#1089#1099#1083#1082#1091
      ImageIndex = 95
      OnExecute = A_AddAttachExecute
    end
  end
  inherited dlgFillRows: TFillRows
    Left = 328
    Top = 40
  end
  inherited TmSave: TTimer
    Left = 264
    Top = 40
  end
  inherited ppDialog: TPopupActionBar
    Left = 256
    Top = 40
  end
  inherited SpEdit: TpFIBStoredProc
    Left = 200
    Top = 40
  end
  inherited IBTrWrite: TpFIBTransaction
    Left = 392
    Top = 41
  end
  object ActListHtml: TActionList
    Images = frPrima.HtmlImList
    Left = 328
    Top = 336
    object A_WbIsEdit: TAction
      Category = #1054#1090#1082#1088#1099#1090#1100', '#1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1085#1072#1081#1090#1080
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1088#1077#1078#1080#1084' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1088#1077#1078#1080#1084' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      ImageIndex = 50
      OnExecute = A_WbIsEditExecute
    end
    object A_SaveToFile: TAction
      Category = #1054#1090#1082#1088#1099#1090#1100', '#1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1085#1072#1081#1090#1080
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' Web-'#1089#1090#1088#1072#1085#1080#1094#1091' '#1074' '#1092#1072#1081#1083#1077
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' Web-'#1089#1090#1088#1072#1085#1080#1094#1091' '#1074' '#1092#1072#1081#1083#1077
      ImageIndex = 47
      OnExecute = A_SaveToFileExecute
    end
    object A_OpenFromFile: TAction
      Category = #1054#1090#1082#1088#1099#1090#1100', '#1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1085#1072#1081#1090#1080
      Caption = #1054#1090#1082#1088#1099#1090#1100' HTML-'#1092#1072#1081#1083
      Hint = 
        #1054#1090#1082#1088#1099#1090#1100' HTML-'#1092#1072#1081#1083'. '#1045#1089#1083#1080' '#1089#1090#1088#1072#1085#1080#1094#1072' '#1089#1086#1076#1077#1088#1078#1080#1090' '#1082#1072#1088#1090#1080#1085#1082#1080', '#1090#1086' '#1080#1093' '#1085#1072#1076#1086' '#1079 +
        #1072#1075#1088#1091#1079#1080#1090#1100' '#1074' '#1073#1072#1079#1091' '#1086#1090#1076#1077#1083#1100#1085#1086
      ImageIndex = 48
      OnExecute = A_OpenFromFileExecute
    end
    object A_FindOfPage: TAction
      Category = #1054#1090#1082#1088#1099#1090#1100', '#1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1085#1072#1081#1090#1080
      Caption = #1053#1072#1081#1090#1080' '#1085#1072' '#1089#1090#1088#1072#1085#1080#1094#1077
      Hint = #1053#1072#1081#1090#1080' '#1085#1072' '#1089#1090#1088#1072#1085#1080#1094#1077
      ImageIndex = 25
      ShortCut = 16460
      OnExecute = A_FindOfPageExecute
    end
    object A_CutFromWB: TAction
      Category = 'Copy - Paste'
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      Hint = #1042#1099#1088#1077#1079#1072#1090#1100
      ImageIndex = 0
      OnExecute = A_CutFromWBExecute
      OnUpdate = A_CutFromWBUpdate
    end
    object A_CopyFromWB: TAction
      Category = 'Copy - Paste'
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnExecute = A_CopyFromWBExecute
      OnUpdate = A_CopyFromWBUpdate
    end
    object A_PasteToWB: TAction
      Category = 'Copy - Paste'
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100
      ImageIndex = 2
      OnExecute = A_PasteToWBExecute
      OnUpdate = A_PasteToWBUpdate
    end
    object A_EditUndo: TAction
      Category = 'Copy - Paste'
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      ImageIndex = 3
      OnExecute = A_EditUndoExecute
      OnUpdate = A_EditUndoUpdate
    end
    object A_EditRedo: TAction
      Category = 'Copy - Paste'
      Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1100
      Hint = #1055#1086#1074#1090#1086#1088#1080#1090#1100
      ImageIndex = 23
      OnExecute = A_EditRedoExecute
      OnUpdate = A_EditRedoUpdate
    end
    object A_FontBold: TAction
      Category = #1064#1088#1080#1092#1090' '#1080' '#1077#1075#1086' '#1089#1074#1086#1081#1089#1090#1074#1072
      Caption = #1046#1080#1088#1085#1099#1081
      Hint = #1046#1080#1088#1085#1099#1081
      ImageIndex = 5
      OnExecute = A_FontBoldExecute
      OnUpdate = A_FontBoldUpdate
    end
    object A_FontItalic: TAction
      Category = #1064#1088#1080#1092#1090' '#1080' '#1077#1075#1086' '#1089#1074#1086#1081#1089#1090#1074#1072
      Caption = #1050#1091#1088#1089#1080#1074
      Hint = #1050#1091#1088#1089#1080#1074
      ImageIndex = 6
      OnExecute = A_FontItalicExecute
      OnUpdate = A_FontItalicUpdate
    end
    object A_FontStrike: TAction
      Category = #1064#1088#1080#1092#1090' '#1080' '#1077#1075#1086' '#1089#1074#1086#1081#1089#1090#1074#1072
      Caption = #1047#1072#1095#1077#1088#1082#1085#1091#1090#1099#1081
      Hint = #1047#1072#1095#1077#1088#1082#1085#1091#1090#1099#1081
      ImageIndex = 8
      OnExecute = A_FontStrikeExecute
      OnUpdate = A_FontStrikeUpdate
    end
    object A_FontUnderLine: TAction
      Category = #1064#1088#1080#1092#1090' '#1080' '#1077#1075#1086' '#1089#1074#1086#1081#1089#1090#1074#1072
      Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
      Hint = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
      ImageIndex = 7
      OnExecute = A_FontUnderLineExecute
      OnUpdate = A_FontUnderLineUpdate
    end
    object A_Parleft: TAction
      Category = #1040#1073#1079#1072#1094
      Caption = #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
      Hint = #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
      ImageIndex = 10
      OnExecute = A_ParleftExecute
      OnUpdate = A_ParleftUpdate
    end
    object A_ParCenter: TAction
      Category = #1040#1073#1079#1072#1094
      Caption = #1055#1086' '#1094#1077#1085#1090#1088#1091
      Hint = #1055#1086' '#1094#1077#1085#1090#1088#1091
      ImageIndex = 12
      OnExecute = A_ParCenterExecute
      OnUpdate = A_ParCenterUpdate
    end
    object A_ParRight: TAction
      Category = #1040#1073#1079#1072#1094
      Caption = #1055#1086' '#1087#1088#1072#1074#1086#1084#1091' '#1082#1088#1072#1102
      Hint = #1055#1086' '#1087#1088#1072#1074#1086#1084#1091' '#1082#1088#1072#1102
      ImageIndex = 11
      OnExecute = A_ParRightExecute
      OnUpdate = A_ParRightUpdate
    end
    object A_ParJustifyFull: TAction
      Category = #1040#1073#1079#1072#1094
      Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077' '#1089#1090#1088#1072#1085#1080#1094#1099
      Hint = #1055#1086' '#1096#1080#1088#1080#1085#1077' '#1089#1090#1088#1072#1085#1080#1094#1099
      ImageIndex = 19
      OnExecute = A_ParJustifyFullExecute
      OnUpdate = A_ParJustifyFullUpdate
    end
    object A_SimpleList: TAction
      Category = #1057#1087#1080#1089#1082#1080' '#1080' '#1086#1090#1089#1090#1091#1087#1099
      Caption = #1055#1088#1086#1089#1090#1086#1081' '#1089#1087#1080#1089#1086#1082
      Hint = #1055#1088#1086#1089#1090#1086#1081' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 9
      OnExecute = A_SimpleListExecute
      OnUpdate = A_SimpleListUpdate
    end
    object A_SmartList: TAction
      Category = #1057#1087#1080#1089#1082#1080' '#1080' '#1086#1090#1089#1090#1091#1087#1099
      Caption = #1053#1091#1084#1077#1088#1086#1074#1072#1085#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
      Hint = #1053#1091#1084#1077#1088#1086#1074#1072#1085#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 13
      OnExecute = A_SmartListExecute
      OnUpdate = A_SmartListUpdate
    end
    object A_Identleft: TAction
      Category = #1057#1087#1080#1089#1082#1080' '#1080' '#1086#1090#1089#1090#1091#1087#1099
      Caption = #1057#1076#1074#1080#1075' '#1074#1083#1077#1074#1086
      Hint = #1057#1076#1074#1080#1075' '#1074#1083#1077#1074#1086
      ImageIndex = 14
      OnExecute = A_IdentleftExecute
    end
    object A_IdentRigth: TAction
      Category = #1057#1087#1080#1089#1082#1080' '#1080' '#1086#1090#1089#1090#1091#1087#1099
      Caption = #1057#1076#1074#1080#1075' '#1074#1087#1088#1072#1074#1086
      Hint = #1057#1076#1074#1080#1075' '#1074#1087#1088#1072#1074#1086
      ImageIndex = 15
      OnExecute = A_IdentRigthExecute
    end
    object A_CreateLink: TAction
      Category = #1042#1089#1090#1072#1074#1082#1080
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1082#1091
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1082#1091
      ImageIndex = 21
      OnExecute = A_CreateLinkExecute
    end
    object A_InsertLine: TAction
      Category = #1042#1089#1090#1072#1074#1082#1080
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1091#1102' '#1083#1080#1085#1080#1102
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1091#1102' '#1083#1080#1085#1080#1102
      ImageIndex = 20
      OnExecute = A_InsertLineExecute
    end
    object A_InsertImage: TAction
      Category = #1042#1089#1090#1072#1074#1082#1080
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1080#1079' '#1092#1072#1081#1083#1072
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1080#1079' '#1092#1072#1081#1083#1072
      ImageIndex = 22
      OnExecute = A_InsertImageExecute
    end
    object A_FontBackColor: TAction
      Category = #1064#1088#1080#1092#1090' '#1080' '#1077#1075#1086' '#1089#1074#1086#1081#1089#1090#1074#1072
      Caption = #1062#1074#1077#1090' '#1092#1086#1085#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072
      Hint = #1062#1074#1077#1090' '#1092#1086#1085#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072
      ImageIndex = 52
      OnExecute = A_FontBackColorExecute
    end
    object A_FontColor: TAction
      Category = #1064#1088#1080#1092#1090' '#1080' '#1077#1075#1086' '#1089#1074#1086#1081#1089#1090#1074#1072
      Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072' '#1090#1077#1082#1089#1090#1072
      Hint = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1091#1095#1072#1089#1090#1082#1072' '#1090#1077#1082#1089#1090#1072
      ImageIndex = 53
      OnExecute = A_FontColorExecute
    end
    object A_InsBaseLabel: TAction
      Category = #1042#1089#1090#1072#1074#1082#1080
      Caption = #1042#1089#1090#1072#1074#1082#1072' '#1084#1077#1090#1082#1080' '#1076#1083#1103' '#1072#1074#1090#1086' '#1087#1086#1076#1089#1090#1072#1085#1086#1074#1082#1080' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1073#1072#1079#1099
      Hint = #1042#1089#1090#1072#1074#1082#1072' '#1084#1077#1090#1082#1080' '#1076#1083#1103' '#1072#1074#1090#1086' '#1087#1086#1076#1089#1090#1072#1085#1086#1074#1082#1080' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1073#1072#1079#1099
      ImageIndex = 29
      OnExecute = A_InsBaseLabelExecute
    end
    object A_InsertHtmlImage: TAction
      Category = #1042#1089#1090#1072#1074#1082#1080
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' HTML '#1089#1089#1099#1083#1082#1091' '#1085#1072' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' HTML '#1089#1089#1099#1083#1082#1091' '#1085#1072' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      ImageIndex = 54
      OnExecute = A_InsertHtmlImageExecute
    end
  end
  object TmRefresh: TTimer
    OnTimer = TmRefreshTimer
    Left = 392
    Top = 336
  end
  object ppBaseLabel: TPopupMenu
    Images = frPrima.ImList
    Left = 472
    Top = 336
  end
  object ppMMBrowser: TPopupMenu
    Images = frPrima.ImList
    Left = 552
    Top = 336
    object Web1: TMenuItem
      Action = A_SaveToFile
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Action = A_FindOfPage
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Action = A_CreateLink
    end
    object N5: TMenuItem
      Action = A_InsertImage
    end
    object N4: TMenuItem
      Action = A_InsBaseLabel
    end
  end
end
