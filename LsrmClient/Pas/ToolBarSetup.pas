{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit ToolBarSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ActnList, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ActnMan, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ActnPopup, AddActions, SqlTools, ClientDM, ConstList,
  Vcl.ImgList;

type
  TfrToolBarSetup = class(TForm)
    ActListSetup: TActionList;
    lvChBox: TListView;
    tbSetup: TToolBar;
    A_Save: TAction;
    A_Close: TAction;
    A_Sp: TAction;
    A_First: TAction;
    A_Last: TAction;
    A_Prior: TAction;
    A_Next: TAction;
    tbSave: TToolButton;
    tbSep1: TToolButton;
    tbFirst: TToolButton;
    tbPrior: TToolButton;
    tbNext: TToolButton;
    tbLast: TToolButton;
    tbSep2: TToolButton;
    tbClose: TToolButton;
    A_SelectAll: TAction;
    A_ClearAll: TAction;
    A_Invert: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    tbSep3: TToolButton;
    A_RestoreDefault: TAction;
    tbRestoreDefault: TToolButton;
    tbSep4: TToolButton;
    A_AddSeparator: TAction;
    tbAddSeparator: TToolButton;
    tbAddAction: TToolButton;
    ToolButton6: TToolButton;
    ppAddAction: TPopupActionBar;
    N111: TMenuItem;
    N221: TMenuItem;
    N331: TMenuItem;
    ppSetup: TPopupActionBar;
    A_AddAction: TPopMenuAction;
    A_DelAction: TAction;
    tbDelAction: TToolButton;
    procedure A_FirstExecute(Sender: TObject);
    procedure A_LastExecute(Sender: TObject);
    procedure A_PriorExecute(Sender: TObject);
    procedure A_NextExecute(Sender: TObject);
    procedure A_InvertExecute(Sender: TObject);
    procedure A_ClearAllExecute(Sender: TObject);
    procedure A_SelectAllExecute(Sender: TObject);
    procedure A_SaveExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure A_RestoreDefaultExecute(Sender: TObject);
    procedure A_CloseExecute(Sender: TObject);
    procedure lvChBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure A_AddActionExecute(Sender: TObject);
    procedure A_AddSeparatorExecute(Sender: TObject);
    procedure A_DelActionExecute(Sender: TObject);
    procedure A_FirstUpdate(Sender: TObject);
    procedure A_PriorUpdate(Sender: TObject);
    procedure A_LastUpdate(Sender: TObject);
    procedure A_NextUpdate(Sender: TObject);
    procedure lvChBoxItemChecked(Sender: TObject; Item: TListItem);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    tbBarName: String;
    OwnerFr: TCustomForm;
    SetupBar: TActionBarItem;
    IsFillItems: Boolean;
    IsEdit: Boolean;
    procedure FillChBox(Bar: TActionBarItem);
    procedure MoveActionInBar( OldIndex: Integer; Step: Integer );
    procedure ShowHideInBarItem(Ind: Integer);
    procedure FillPopupMenu;
    procedure FillAddAction;
    procedure ppAddActionOnClick(Sender: TObject);
    procedure SetSelectChBoxItem(Ind: Integer);
    procedure MoveActionInBarToBorder(CurrIndex: Integer; ToEnd: Boolean);
    procedure MoveItemPosition( CurrInd, NewInd: Integer );
    procedure MoveItemPositionToBorder(CurrInd: Integer; ToEnd: Boolean);
  public
    { Public declarations }
    class procedure ShowToolBarSetup( Act: TAction; OwnerForm: TCustomForm; const ActionBarName: String; Bar: TActionBarItem  );
  end;


implementation

{$R *.dfm}

uses
  Prima, Math, Winapi.CommCtrl;

const
  sepText = 'Сепаратор';

procedure TfrToolBarSetup.A_SaveExecute(Sender: TObject);
const
sqlBarList =
'execute block (' + #13#10 +
'  USER_LIST_ID type of column ACTION_BAR_LIST.USER_LIST_ID = ?USER_LIST_ID,' + #13#10 +
'  FORM_CLASS type of column ACTION_BAR_LIST.FORM_CLASS = ?FORM_CLASS,' + #13#10 +
'  BAR_NAME type of column ACTION_BAR_LIST.BAR_NAME = ?BAR_NAME)' + #13#10 +
'returns(' + #13#10 +
' ACTION_BAR_LIST_ID type of column ACTION_BAR_LIST.ACTION_BAR_LIST_ID )' + #13#10 +
'as' + #13#10 +
'begin' + #13#10 +
'  update or insert into ACTION_BAR_LIST (' + #13#10 +
'      USER_LIST_ID, FORM_CLASS, BAR_NAME )' + #13#10 +
'    values (' + #13#10 +
'      :USER_LIST_ID, :FORM_CLASS, :BAR_NAME )' + #13#10 +
'    matching (' + #13#10 +
'      USER_LIST_ID, FORM_CLASS, BAR_NAME )' + #13#10 +
'    returning (' + #13#10 +
'      ACTION_BAR_LIST_ID )' + #13#10 +
'    into' + #13#10 +
'      :ACTION_BAR_LIST_ID;' + #13#10 +
' ' + #13#10 +
'  delete from ACTION_BAR_PARAMS' + #13#10 +
'  where' + #13#10 +
'    ACTION_BAR_LIST_ID = :ACTION_BAR_LIST_ID and' + #13#10 +
'    ORDER_BY >= 0; ' + #13#10 +
' ' + #13#10 +
'  suspend;' + #13#10 +
'end';

sqlParams =
'update or insert into ACTION_BAR_PARAMS (' + #13#10 +
'    ACTION_BAR_LIST_ID, ORDER_BY, ACTION_NAME )' + #13#10 +
'  values (' + #13#10 +
'    :ACTION_BAR_LIST_ID, :ORDER_BY, :ACTION_NAME)' + #13#10 +
'  matching (' + #13#10 +
'    ACTION_BAR_LIST_ID, ORDER_BY )';

var
Query: TNewQuery;
BarID: Integer;
N: Integer;
ActClient: TActionClientItem;
begin
	If not ( A_Save.Enabled and A_Save.Visible ) then
    Exit;

  BarID := -1;
  Query := TNewQuery.CreateNew( Self, frDM.IBTrWrite );
  try
    try
      Query.SQL.Text := sqlBarList;
      If not Query.Prepared then
        Query.Prepare;

      try
        Query.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrentUserID;
        Query.ParamByName( 'FORM_CLASS' ).AsString := OwnerFr.ClassName;
        Query.ParamByName( 'BAR_NAME' ).AsString := tbBarName;

        Query.ExecQuery;
      except
        raise;
      end;
      BarID := Query.FieldByName( 'ACTION_BAR_LIST_ID' ).AsInteger;
    finally
      Query.Close;
    end;

    if BarID = -1 then
      Exit;

    try
      Query.SQL.Text := sqlParams;
      If not Query.Prepared then
        Query.Prepare;

      for N := 0 to lvChBox.Items.Count - 1 do begin
        if not lvChBox.Items[ N ].Checked then
          Continue;

        try
          Query.Close;
          Query.ParamByName( 'ACTION_BAR_LIST_ID' ).AsInteger := BarID;
          Query.ParamByName( 'ORDER_BY' ).AsInteger := N;
          ActClient := TActionClientItem( lvChBox.Items[ N ].Data );

          if Assigned( ActClient.Action ) then
            Query.ParamByName( 'ACTION_NAME' ).AsString := TAction( ActClient.Action ).Name
          else
            Query.ParamByName( 'ACTION_NAME' ).AsString := frPrima.A_Sp.Name;

          Query.ExecQuery;
        except
          raise;
        end;
      end;
    finally
      Query.Close;
    end;
  finally
    Query.FreeAndCommit;
    ModalResult := mrOk;
  end;
end;

procedure TfrToolBarSetup.A_CloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrToolBarSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
    if IsEdit and
       ( MessageBox( Self.Handle, 'Сохранить изменения?', 'Закрыть диалог настройки',
         MB_APPLMODAL or MB_DEFBUTTON1 or MB_YESNO or MB_ICONQUESTION ) = mrYes ) then
      A_SaveExecute( A_Save );
end;

procedure TfrToolBarSetup.MoveActionInBar( OldIndex: Integer; Step: Integer );
var
Ind: Integer;
Act: TActionClientItem;
begin
  if ( OldIndex < 0 ) or ( OldIndex >= lvChBox.Items.Count ) then
    Exit;

  IsEdit := True;
  Act := TActionClientItem( lvChBox.Items[ OldIndex ].Data );
  Ind := Act.Index;
  Act.Index := Ind + Step;
end;

procedure TfrToolBarSetup.MoveActionInBarToBorder( CurrIndex: Integer; ToEnd: Boolean );
var
Act: TActionClientItem;
begin
  if ( CurrIndex < 0 ) or ( CurrIndex >= lvChBox.Items.Count ) then
    Exit;

  Act := TActionClientItem( lvChBox.Items[ CurrIndex ].Data );
  if ToEnd then
    Act.Index := SetupBar.Items.Count - 1
  else
    Act.Index := 0;
end;

procedure TfrToolBarSetup.A_FirstExecute(Sender: TObject);
var
Ind: Integer;
begin
	If not ( A_First.Enabled and A_First.Visible ) then
    Exit;

  Ind := lvChBox.ItemIndex;
  if Ind <> -1 then begin
    MoveActionInBarToBorder( Ind, False );
    MoveItemPositionToBorder( Ind, False );
  end;

  SetSelectChBoxItem( 0 );
end;

procedure TfrToolBarSetup.A_FirstUpdate(Sender: TObject);
begin
  A_First.Enabled := lvChBox.ItemIndex > 0;
end;

procedure TfrToolBarSetup.A_LastExecute(Sender: TObject);
var
Ind: Integer;
begin
	If not ( A_Last.Enabled and A_Last.Visible ) then
    Exit;

  Ind := lvChBox.ItemIndex;
  if Ind <> -1 then begin
    MoveActionInBarToBorder( Ind, True );
    MoveItemPositionToBorder( Ind, True );
  end;

  SetSelectChBoxItem( lvChBox.Items.Count - 1 );
end;

procedure TfrToolBarSetup.A_LastUpdate(Sender: TObject);
begin
  A_Last.Enabled := lvChBox.ItemIndex < lvChBox.Items.Count - 1;
end;

procedure TfrToolBarSetup.A_NextExecute(Sender: TObject);
var
Ind: Integer;
begin
	If not ( A_Next.Enabled and A_Next.Visible ) then
    Exit;

	Ind := lvChBox.ItemIndex;
  if Ind = lvChBox.Items.Count - 1 then
    Exit;

  if Ind <> -1 then begin
    MoveActionInBar( Ind, 1 );
    MoveItemPosition( Ind, Ind + 1 );
  end;

  SetSelectChBoxItem( Ind + 1 );
end;

procedure TfrToolBarSetup.A_NextUpdate(Sender: TObject);
begin
  A_Next.Enabled := lvChBox.ItemIndex < lvChBox.Items.Count - 1;
end;

procedure TfrToolBarSetup.A_PriorExecute(Sender: TObject);
var
Ind: Integer;
begin
	If not ( A_Prior.Enabled and A_Prior.Visible ) then
    Exit;
	Ind := lvChBox.ItemIndex;
  if Ind = 0 then
    Exit;

  if Ind <> -1 then begin
    MoveActionInBar( Ind, -1 );
    MoveItemPosition( Ind, Ind - 1 );
  end;

  SetSelectChBoxItem( Ind - 1 );
end;

procedure TfrToolBarSetup.A_PriorUpdate(Sender: TObject);
begin
  A_Prior.Enabled := lvChBox.ItemIndex > 0;
end;

procedure TfrToolBarSetup.A_RestoreDefaultExecute(Sender: TObject);
var
N: Integer;
Act: TAction;
LastAction: TActionClientItem;
begin
  With frPrima do
    SetupBar := ShowAssignToolBar( aTbTransact, True );
  if not Assigned( SetupBar ) then
    Exit;
  SetupBar.Items.Clear;

  lvChBox.Items.BeginUpdate;
  try
    LastAction := nil;
    for N := 0 to frPrima.CurrToolBarDefaultList.Count - 1 do begin
      Act := TAction( frPrima.CurrToolBarDefaultList.Items[ N ]);
      if Act.Visible then
        frPrima.AddActionInToolBar( SetupBar, Act, LastAction );
    end;
  finally
    SetupBar.ActionBar.Visible := SetupBar.Items.Count > 0;
//    frPrima.SetWithActionBar( SetupBar );
    PostMessage( frPrima.Handle, CM_SetActionbarWidth, Integer( Pointer( SetupBar )), 0 );
    FillChBox( SetupBar );
    IsEdit := True;
    lvChBox.Items.EndUpdate;
  end;

  SetSelectChBoxItem( 0 );
end;

procedure TfrToolBarSetup.A_SelectAllExecute(Sender: TObject);
var
N: Integer;
begin
  lvChBox.Items.BeginUpdate;
  try
    For N := 0 to lvChBox.Items.Count - 1 do begin
      lvChBox.Items[ N ].Checked := True;
      ShowHideInBarItem( N );
    end;
  finally
    lvChBox.Items.EndUpdate;
  end;
  SetSelectChBoxItem( 0 );
end;

procedure TfrToolBarSetup.A_AddActionExecute(Sender: TObject);
begin
  //    is empty
end;

procedure TfrToolBarSetup.A_AddSeparatorExecute(Sender: TObject);
var
Ind: Integer;
BeforeBtn, Btn: TActionClientItem;
begin
  Ind := lvChBox.ItemIndex;
  if Ind = -1 then
    Exit;

  IsEdit := True;
  BeforeBtn := TActionClientItem( lvChBox.Items[ Ind ].Data );
  Btn := frPrima.ActManager.AddSeparator( BeforeBtn, True );
  With lvChBox.Items.Insert( Ind + 1 ) do begin
    Caption := SepText;
    Data := Btn;
    ImageIndex := spSeparatorImage;
    Checked := True;
  end;

  SetSelectChBoxItem( Ind + 1 );
end;

procedure TfrToolBarSetup.A_ClearAllExecute(Sender: TObject);
var
N: Integer;
begin
  lvChBox.Items.BeginUpdate;
  try
    For N := 0 to lvChBox.Items.Count - 1 do begin
      lvChBox.items[ N ].Checked := False;
      ShowHideInBarItem( N );
    end;
  finally
    lvChBox.Items.EndUpdate;
  end;
  SetSelectChBoxItem( 0 );
end;

procedure TfrToolBarSetup.A_InvertExecute(Sender: TObject);
var
N: Integer;
begin
  lvChBox.Items.BeginUpdate;
  try
    For N := 0 to lvChBox.Items.Count - 1 do begin
      lvChBox.items[ N ].Checked :=  not lvChBox.items[ N ].Checked;
      ShowHideInBarItem( N );
    end;
  finally
    lvChBox.Items.EndUpdate;
  end;
  SetSelectChBoxItem( 0 );
end;

procedure TfrToolBarSetup.lvChBoxItemChecked(Sender: TObject; Item: TListItem);
var
Ind: Integer;
begin
  if IsFillItems then
    Exit;

  Ind := Item.Index;
  if Ind = -1 then
    Exit;

  IsEdit := True;
  ShowHideInBarItem( Ind );
end;

procedure TfrToolBarSetup.ShowHideInBarItem(Ind: Integer);
var
Btn, BeforeBtn: TActionClientItem;
begin
  try
    Btn := TActionClientItem( lvChBox.Items[ Ind ].Data );
    if not Assigned( Btn ) then
      Exit;

    if not Btn.Separator then
      Btn.Visible := lvChBox.items[ Ind ].Checked
    else
      case lvChBox.items[ Ind ].Checked of
        False:
          SetupBar.Items.Delete( Btn.Index );
        else begin
          BeforeBtn := TActionClientItem( lvChBox.Items[ IfThen( Ind = 0, Ind + 1, Ind - 1 )].Data );
          frPrima.ActManager.AddSeparator( BeforeBtn, Ind > 0 );
        end;
      end;
  finally
//    frPrima.SetWithActionBar( SetupBar );
    PostMessage( frPrima.Handle, CM_SetActionbarWidth, Integer( Pointer( SetupBar )), 0 );
  end;
end;

procedure TfrToolBarSetup.A_DelActionExecute(Sender: TObject);
var
Ind: Integer;
Btn: TActionClientItem;
begin
  Ind := lvChBox.ItemIndex;
  if Ind = -1 then
    Exit;

  IsEdit := True;
  try
    Btn := TActionClientItem( lvChBox.Items[ Ind ].Data );
      if not Assigned( Btn ) then
        Exit;
    SetupBar.Items.Delete( Btn.Index );
    lvChBox.Items.Delete( Ind );
  finally
    FillAddAction;
  end;

  SetSelectChBoxItem( Ind );
end;

procedure TfrToolBarSetup.lvChBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift <> [] then
    Exit;

  case Key of
    VK_RETURN:
      A_SaveExecute( A_Save );
    VK_ESCAPE:
      A_CloseExecute( A_Close );
  end;
end;

procedure TfrToolBarSetup.FormCreate(Sender: TObject);
begin
  IsFillItems := True;
  IsEdit := False;
end;

procedure TfrToolBarSetup.FormShow(Sender: TObject);
begin
  Self.Left := frPrima.aTbTransact.Left;
  Self.Top := frPrima.ControlB.Height * 4;
  lvChBox.SetFocus;
end;

procedure TfrToolBarSetup.FillChBox( Bar: TActionBarItem );
var
N, LTextMax, L: Integer;
AddHeight, AddWidth: Integer;
Btn: TActionClientItem;
CaptionText, ActName: String;
IsVisible: Boolean;
begin
  CaptionText := '';
  ActName := '';
  lvChBox.Items.Clear;
  IsVisible := False;
  LTextMax := 0;
  L := 0;
  SetupBar := Bar;
  AddHeight := Self.Height - lvChBox.ClientHeight;
  AddWidth := Self.Width - lvChBox.ClientWidth;
  IsFillItems := True;
  lvChBox.Items.BeginUpdate;

  try
    for N := 0 to Bar.Items.Count - 1 do begin
      Btn := TActionClientItem( Bar.Items[ N ]);

      if Assigned( Btn ) then begin
        if not Btn.Control.Visible then
          Continue;

        if Bar.Items[ N ].Separator then begin
          CaptionText := sepText;
          ActName := 'A_Sp';
          IsVisible := Btn.Control.Visible;
        end
        else
        if Assigned( Btn.Action ) then begin
          CaptionText := TAction( Btn.Action ).Caption;
          ActName := TAction( Btn.Action ).Name;
          IsVisible := Btn.Control.Visible;
        end;
      end;

      if ( CaptionText <> '' ) and ( ActName <> '' ) then begin
        With lvChBox.Items.Add do begin
          if not AnsiSameText( CaptionText, sepText ) then
            ImageIndex := TAction( Btn.Action ).ImageIndex
          else
            ImageIndex := spSeparatorImage;

          Caption := CaptionText;
          Data := Btn;
          Checked := IsVisible;
          L := lvChBox.Canvas.TextWidth( CaptionText );
        end;
      end;

      if L > LTextMax then
        LTextMax := L;

      CaptionText := '';
      ActName := '';
    end;
  finally
    IsFillItems := False;
    lvChBox.Items.EndUpdate;
  end;

  if lvChBox.Items.Count > 0 then begin
    Self.ClientHeight := ( lvChBox.Items.Count * lvChBox.Items[ 0 ].DisplayRect( drLabel ).Height ) + AddHeight;
    Self.ClientWidth := LTextMax + AddWidth + 20;
  end;
end;

procedure TfrToolBarSetup.ppAddActionOnClick( Sender: TObject );
var
NewAct: TAction;
MItem: TMenuItem;
BeforeBtn: TActionClientItem;
Ind: Integer;
begin
  Ind := lvChBox.ItemIndex;
  if Ind = -1 then
    Exit;

  if Sender is TMenuItem then
    MItem := TMenuItem( Sender )
  else
    Exit;

  try
    try
      NewAct := TAction( frPrima.CurrToolBarDefaultList.Items[ MItem.Tag ]);
      BeforeBtn := TActionClientItem( lvChBox.Items[ Ind ].Data );
      frPrima.ActManager.AddAction( NewAct, BeforeBtn, True );
    finally
      FillChBox( SetupBar );
      FillAddAction;
    end;
  finally
//    frPrima.SetWithActionBar( SetupBar );
    PostMessage( frPrima.Handle, CM_SetActionbarWidth, Integer( Pointer( SetupBar )), 0 );
  end;
end;

procedure TfrToolBarSetup.FillAddAction;
var
N, Ind: Integer;
Act: TAction;

  function GetItemOfCaption( const Value: String ): Integer;
  var
  N: Integer;
  begin
    Result := -1;
    for N := 0 to lvChBox.Items.Count - 1 do begin
      if AnsiSameText( lvChBox.Items[ N ].Caption, Value ) then begin
        Result := N;
        Break;
      end;
    end;
  end;

  procedure AddActionInPopup( IndexInTList: Integer );
  var
  MenuItem: TMenuItem;
  begin
    MenuItem := TMenuItem.Create( Self );
    MenuItem.Caption := Act.Caption;
    MenuItem.Hint := Act.Hint;
    MenuItem.ImageIndex := Act.ImageIndex;
    MenuItem.Tag := N;
    MenuItem.OnClick := ppAddActionOnClick;
    ppAddAction.Items.Add( MenuItem );
  end;

begin
  ppAddAction.Items.Clear;
  for N := 0 to frPrima.CurrToolBarDefaultList.Count - 1 do begin
    Act := TAction( frPrima.CurrToolBarDefaultList.Items[ N ]);
    if not Assigned( Act ) then
      Continue;
    if AnsiSameText( Act.Name, A_Sp.Name ) or
       AnsiSameText( Act.Name, '-' ) then
      Continue;
    if not Act.Visible then
      Continue;

    Ind := GetItemOfCaption( Act.Caption );
    if Ind <> -1 then
      Continue;

    AddActionInPopup( N );
  end;
end;

procedure TfrToolBarSetup.FillPopupMenu;
begin
  with frPrima do
		SetMainMenuList( nil, ppSetup,
						[ A_Save, A_Sp, A_First, A_Prior, A_Next, A_Last, A_Sp,
              A_SelectAll, A_ClearAll, A_Invert, A_Sp,
              A_RestoreDefault, A_Sp, A_DelAction, A_AddSeparator, A_AddAction, A_Sp, A_Close ] );
end;

class procedure TfrToolBarSetup.ShowToolBarSetup( Act: TAction; OwnerForm: TCustomForm; const ActionBarName: String; Bar: TActionBarItem );
var
CurrSetup: TfrToolBarSetup;
begin
  Act.Enabled := False;
  CurrSetup := TfrToolBarSetup.Create( OwnerForm );
  With CurrSetup do
    try
      Caption := Act.Caption;
      tbBarName := ActionBarName;
      OwnerFr := OwnerForm;
      lvChBox.ViewStyle := vsList;
      FillChBox( Bar );
      FillPopupMenu;
      FillAddAction;

      ShowModal;
    finally
      CurrSetup.Release;
      Act.Enabled := True;
    end;
end;

procedure TfrToolBarSetup.MoveItemPosition( CurrInd, NewInd: Integer );
var
TempInd: Integer;
begin
  lvChBox.Items.BeginUpdate;
  try
    lvChBox.Items.Add;
    TempInd := lvChBox.Items.Count - 1;
    lvChBox.Items.Item[ TempInd ] := lvChBox.Items.Item[ CurrInd ];
    lvChBox.Items.Item[ CurrInd ] := lvChBox.Items.Item[ NewInd ];
    lvChBox.Items.Item[ NewInd ] := lvChBox.Items.Item[ TempInd ];
    lvChBox.Items.Delete( TempInd );
  finally
    IsEdit := True;
    lvChBox.Items.EndUpdate;
  end;
  lvChBox.ItemIndex := NewInd;
end;

procedure TfrToolBarSetup.MoveItemPositionToBorder( CurrInd: Integer; ToEnd: Boolean );
var
NewInd: Integer;
begin
  lvChBox.Items.BeginUpdate;
  try
    case ToEnd of
      True:
        NewInd := lvChBox.Items.Count;
      else begin
        NewInd := 0;
        Inc( CurrInd );
      end;
    end;

    lvChBox.Items.Insert( NewInd );
    lvChBox.Items.Item[ NewInd ] := lvChBox.Items.Item[ CurrInd ];
    lvChBox.ItemIndex := NewInd;
    lvChBox.Items.Delete( CurrInd );
  finally
    IsEdit := True;
    lvChBox.Items.EndUpdate;
  end;
end;

procedure TfrToolBarSetup.SetSelectChBoxItem(Ind: Integer);
begin
  if ( Ind >= 0 ) and ( Ind < lvChBox.Items.Count ) then
    lvChBox.Items[ Ind ].Selected := True;

  IsEdit := True;
end;



end.
