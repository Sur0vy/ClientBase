{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit GridSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomForm, DBActns, ActnList, ComCtrls, ToolWin, DBGridEh,
  AddActions, PrnDbgeh, FIBDatabase, pFIBDatabase, Vcl.ExtCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ActnPopup;

type
  TFrGridSetup = class(TFrCustomForm)
    LV_Columns: TListView;
    A_ReportView: TAction;
    A_ListView: TAction;
    A_ColumnProp: TAction;
    A_SetDefault: TAction;
    A_Save: TAction;
    aTbGridSetup: TActionToolBar;
    ppGridSetup: TPopupActionBar;
    procedure LV_ColumnsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LV_ColumnsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure LV_ColumnsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure A_ReportViewExecute(Sender: TObject);
    procedure A_ListViewExecute(Sender: TObject);
    procedure A_ColumnPropExecute(Sender: TObject);
    procedure A_ColumnPropUpdate(Sender: TObject);
    procedure LV_ColumnsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure A_PriorExecute(Sender: TObject);
    procedure A_NextExecute(Sender: TObject);
    procedure A_SetDefaultExecute(Sender: TObject);
    procedure A_SaveExecute(Sender: TObject);
  private
    { Private declarations }
    Grid: TDBGridEh;
    IsCreated: Boolean;
    procedure SetDataToListView;
  public
    { Public declarations }
    class procedure ShowGridSetup( Sender: TFrCustomForm; GurrGrid: TDBGridEh );
  end;

var
  FrGridSetup: TFrGridSetup;

implementation

uses Prima, Procs, System.Types;

{$R *.dfm}

{ TFrGridSetup }

class procedure TFrGridSetup.ShowGridSetup( Sender: TFrCustomForm; GurrGrid: TDBGridEh );
var
Panel: TPanel;
begin
  with TFrGridSetup.Create( Application ) do
    try
      If Assigned( GurrGrid ) and ( GurrGrid.Columns.Count > 0 ) then begin
        Height := ( Application.MainForm.ClientHeight div 4 ) * 3;
        Constraints.MinHeight := Height - 20;
        Width := ( Application.MainForm.ClientWidth div 3 ) * 2;
        Constraints.MinWidth := Width - 20;
        IsCreated := False;
        LV_Columns.ViewStyle := vsList;
        Grid := GurrGrid;
//        A_Save.Visible := Grid.Owner is TFrRepairJournal;

        Panel := TPanel( Grid.Owner.FindComponent( 'HostPanel' ));
        If Assigned( Panel ) then
          Panel.Visible := True;

        SetDataToListView;
      end;
      IsCreated := True;
      ShowModal;
    finally
      Release;
      TFrCustomForm( GurrGrid.Owner ).FormActivate( nil );
    end;
end;

procedure TFrGridSetup.SetDataToListView;
var
N: Integer;
begin
  try
    LV_Columns.Items.BeginUpdate;
    LV_Columns.Items.Clear;
    for N := 0 to Grid.Columns.Count - 1 do
      With LV_Columns.Items.Add do begin
        Caption := Grid.Columns[ N ].Title.Caption;
        Checked := Grid.Columns[ N ].Visible;

      end;
  finally
    IsCreated := True;
    LV_Columns.Items.EndUpdate;
  end;
end;

procedure TFrGridSetup.LV_ColumnsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
Ind: Integer;
begin
  inherited;
  LV_Columns.ItemFocused.Position := Point( X, Y );
  Ind := ( Sender as TListView ).Selected.Index;

  ( Source as TListView ).ItemIndex := Ind + 1;
end;

procedure TFrGridSetup.LV_ColumnsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := source = LV_Columns;
end;

procedure TFrGridSetup.LV_ColumnsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  inherited;
  If not IsCreated then
                     Exit;
                 //    item.SubItems.Strings[ 0 ];
  If ( Grid.VisibleColumns.Count = 1 ) and ( not Item.Checked ) then begin
    Item.Checked := True;
    raise Exception.Create( 'Нельзя скрывать все колонки!' );
  end;
  If Item.Index <= Grid.FrozenCols then begin
    A_Frozen.Checked := False;
    Grid.FrozenCols := 0;
  end;
  Grid.Columns[ Item.Index ].Visible := Item.Checked;
end;

procedure TFrGridSetup.FormShow(Sender: TObject);
begin
  inherited;
  With Application do begin
    Self.Constraints.MinWidth := MainForm.ClientWidth div 5;
    Self.Height := ( MainForm.ClientHeight div 3 ) * 2;
    Self.Width  := ( MainForm.ClientWidth div 4 ) * 1;
  end;

  With FrPrima do begin
   SetMainMenuList( nil, ppGridSetup,
     [ {A_Save, A_Sp,} A_Prior, A_Next, A_Sp, A_Close ] );
   SetFillActListInBar( aTbGridSetup,
     [ {A_Save, A_Sp,} A_Prior, A_Next, A_Sp, A_Close ] );
  end;
end;

procedure TFrGridSetup.A_ReportViewExecute(Sender: TObject);
begin
  inherited;
  LV_Columns.ViewStyle := vsReport;
end;

procedure TFrGridSetup.A_ListViewExecute(Sender: TObject);
begin
  inherited;
  LV_Columns.ViewStyle := vsList;
end;

procedure TFrGridSetup.A_ColumnPropExecute(Sender: TObject);
begin
  If not ( A_ColumnProp.Visible and A_ColumnProp.Enabled ) then
    Exit;
  inherited;
//  TFrDlgSetup.ShowSetupDGL( LV_Columns );
end;

procedure TFrGridSetup.A_ColumnPropUpdate(Sender: TObject);
begin
  inherited;
  A_ColumnProp.Enabled := Assigned( LV_Columns.Selected );
end;

procedure TFrGridSetup.LV_ColumnsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Shift = [] then
    case Key of
//      VK_RETURN: A_ColumnPropExecute( Self );
      VK_ESCAPE: A_CloseExecute( Self );
    end;
end;

procedure TFrGridSetup.A_PriorExecute(Sender: TObject);
var
CurrInd: Integer;
CurrItem: TListItem;
begin
  inherited;
  CurrItem := LV_Columns.Selected;
  If not Assigned( CurrItem ) then
    Exit;
  CurrInd := CurrItem.Index;
  If CurrInd <= 0 then
    Exit;

  IsCreated := False;
  try
    Grid.Columns.Items[ CurrInd ].Index := CurrInd - 1;
  finally
    SetDataToListView;
    LV_Columns.ItemIndex := CurrInd - 1;
  end;  
end;

procedure TFrGridSetup.A_NextExecute(Sender: TObject);
var
CurrInd: Integer;
CurrItem: TListItem;
begin
  inherited;
  CurrItem := LV_Columns.Selected;
  If not Assigned( CurrItem ) then
    Exit;
  CurrInd := CurrItem.Index;
  If ( CurrInd = -1 ) or ( CurrInd = LV_Columns.Items.Count - 1 ) then
    Exit;
  IsCreated := False;
  try
    Grid.Columns.Items[ CurrInd ].Index := CurrInd + 1;
  finally
    SetDataToListView;
    LV_Columns.ItemIndex := CurrInd + 1;
  end;  
end;

procedure TFrGridSetup.A_SetDefaultExecute(Sender: TObject);
var
ParentForm: TFrCustomForm;
begin
  inherited;
  ParentForm := TFrCustomForm( Grid.Parent );
  If not Assigned( ParentForm ) then
    Exit;
end;

procedure TFrGridSetup.A_SaveExecute(Sender: TObject);
begin
  inherited;
  If not ( A_Save.Enabled and A_Save.Visible ) then
    Exit;

end;

end.
