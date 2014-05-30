{***************************************************************}
{    Компонент для формирования диалоговых окон SmartDlg        }
{    Copyright (c) 2012 - 2013 год             .                }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit RegSmartDlg;

interface

uses
  Windows, Classes, GridDlg, DlgExecute;

type
  TSmartDlg = class(TCustomSmartDlg)
  published
    property Align;
    property Anchors;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BevelKind;
    property Constraints;
    property Ctl3D;
    property ParentCtl3D;
    property Enabled;
    property ParentFont;
    property Font;
    property TabStop;
    property TabOrder;
    property Visible;
    property PopupMenu;

    property RowsList;
    property FormAutoHeight;
    property TabSet;
    property BorderStyle;
    property DividerPosition;

    property FolderFontColor;
    property FolderFontStyle;

    property LongTextHintTime;
    property LongEditHintTime;
    property AutoSelect;
    property DropDownCount;
    property TypeDialog;

    property OnShowDialog;
    property OnChangeRow;
    property OnSetEditText;
    property OnGetLookupList;
    property OnEditAcceptKey;
    property OnGetTabsTitle;
    property ReadOnly;

    // наследуемые события от TCustomControl и его родителей
    property OnContextPopup;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TFillRows = class( TCustomFillRows )
  published
    property SmartDialog;

    property OnGetDataBaseParam;
    property OnGetRowsListParam;
    property OnAfterFillRowList;
    property OnFilterGetHistory;
    property OnFillBetweenMenu;
    property OnGetLookupFieldValue;
  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('DLG', [ TSmartDlg, TFillRows ]);
end;


end.
