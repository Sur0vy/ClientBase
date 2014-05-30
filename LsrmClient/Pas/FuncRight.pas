{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit FuncRight;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ActnList, System.Variants,
  StdActns, ImgList, StdCtrls, ToolWin, ExtCtrls, Menus, Vcl.ComCtrls, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery,
  pFIBStoredProc, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup;

type
	PCommValue = ^TCommValue;
  TCommValue = record
    IsCheck: Boolean;
    ID: Integer;
    IsEditCheck: Boolean;
    IsDeleteCheck: Boolean;
    IsInsertCheck: Boolean;

    IsEditVisible: Boolean;
    IsDeleteVisible: Boolean;
    IsInsertVisible: Boolean;

    IsSprav: Boolean;
  end;

  TFrFuncRight = class(TForm)
    ActListRight: TActionList;
    A_Collaps: TAction;
    A_Expand: TAction;
    A_Find: TAction;
    A_FindNext: TAction;
    TrView: TTreeView;
    A_Refresh: TAction;
    A_Help: THelpContents;
    CheckImage: TImageList;
    ToolB: TToolBar;
    TB_Group: TToolButton;
    TB_User: TToolButton;
    CB_UserList: TComboBox;
    CBUserTimer: TTimer;
    A_Close: TAction;
		A_IsDelete: TAction;
    A_IsEdit: TAction;
    A_IsInsert: TAction;
    IBTr_R: TpFIBTransaction;
    IBTr: TpFIBTransaction;
    IBSp: TpFIBStoredProc;
    aTbFuncIemRight: TActionToolBar;
    ppFuncItemRight: TPopupActionBar;
    P_Login: TLabel;
    tb_All: TToolButton;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrViewCollapsing(Sender: TObject; Node: TTreeNode;    var AllowCollapse: Boolean);
    procedure TrViewExpanding(Sender: TObject; Node: TTreeNode;  var AllowExpansion: Boolean);
    procedure TrViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure A_CollapsExecute(Sender: TObject);
    procedure A_ExpandExecute(Sender: TObject);
    procedure A_FindExecute(Sender: TObject);
    procedure A_FindNextExecute(Sender: TObject);
    procedure TrViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CB_UserListDropDown(Sender: TObject);
    procedure CB_UserListChange(Sender: TObject);
    procedure CBUserTimerTimer(Sender: TObject);
    procedure A_RefreshExecute(Sender: TObject);
    procedure A_CloseExecute(Sender: TObject);
    procedure TrViewChange(Sender: TObject; Node: TTreeNode);
    procedure SetSpravParam(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    SQL_Text, SQL_Node: String;
    FindStr: String;
    CurrListID: Integer;
    procedure SetTreeData(IdParent: Integer; Node: TTreeNode;  var Exp: Boolean );
    procedure TrViewRefresh;
    procedure DisposeRootNode;
    function FindString(FindStr: String; Start: Integer): Boolean;
    procedure SetRightAccess(ActionType: String; IdNode: Integer; Node: TTreeNode );
    procedure GetNodeSpravParams(Node: TTreeNode);
    function SpravRightAccess(const IsRight, IsSpravValue: Integer): Boolean;
    procedure FillComboBoxItems(CBox: TComboBox; const SqlValue, TitleField, IDField: String);
  public
    { Public declarations }
  end;

var
  FrFuncRight: TFrFuncRight;


implementation

uses Prima, Procs, ConstList, ClientDM, SqlTools, ToolBarSetup;

{$R *.DFM}

const
rhSpravInsert: Integer =  4;     // В справочник возможна вставка записей
rhSpravUpdate: Integer =  8;     // В справочнике возможно редактирование записей
rhSpravDelete: Integer = 16;     // Из справочника можно удалять

SQL_TextUser =
  'SELECT * FROM GET_USER_YES_FUNC_RIGHT( %D, %D )';
SQL_TextGroup =
  'SELECT * FROM GET_GROUP_YES_FUNC_RIGHT( %D, %D )';
SQL_TextAll =
  'select' + #13#10 +
  '  FUNC_ITEM_RIGHT_ID, NODE, FUNC_TITLE, IS_SPRAV,' + #13#10 +
  '  max( RIGHT_ACTION ) as RIGHT_ACTION, max( IS_CHECK ) as IS_CHECK' + #13#10 +
  'from GET_USER_ALL_FUNC_RIGHT( %D, %D )' + #13#10 +
  'group by' + #13#10 +
  '  FUNC_ITEM_RIGHT_ID, NODE, FUNC_TITLE, IS_SPRAV' + #13#10 +
  'order by ' + #13#10 +
  '  FUNC_TITLE';

SQL_NodeParamGroup =
  'select RIGHT_ACTION, FUNC_ITEM_RIGHT_ID from FUNC_ITEM_RIGHT_GROUP ' +
  'where (RIGHT_GROUP_ID = %D) and (FUNC_ITEM_RIGHT_ID = %D)';
SQL_NodeParamUser =
  'select RIGHT_ACTION, FUNC_ITEM_RIGHT_ID from FUNC_ITEM_RIGHT_USER ' +
  'where (USER_LIST_ID = %D) and (FUNC_ITEM_RIGHT_ID = %D)';
SQL_NodeParamsAll =
  'select' + #13#10 +
  '  max( RIGHT_ACTION ) as RIGHT_ACTION, FUNC_ITEM_RIGHT_ID' + #13#10 +
  'from GET_ALL_NODE_PARAMS( %D, %D )' + #13#10 +
  'group by' + #13#10 +
  '  FUNC_ITEM_RIGHT_ID';

procedure TFrFuncRight.A_CloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrFuncRight.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  A_CollapsExecute( Self );
  DisposeRootNode;

  Action := caHide;
end;

procedure TFrFuncRight.FormCreate(Sender: TObject);
begin
  aTbFuncIemRight.Top := 0;
end;

procedure TFrFuncRight.FormActivate(Sender: TObject);
begin
  With FrPrima do begin
    SetMainMenuList( nil, ppFuncItemRight,
      [ A_Collaps, A_Expand, A_Sp, A_Refresh, A_Sp, A_IsDelete, A_IsEdit, A_IsInsert, A_Sp,
       A_Find, A_FindNext, A_Sp, {A_ToolBarSetup, A_Sp,} A_Close ] );
    FillActionBarFromDB( Self, aTbFuncIemRight, 'Права доступа',
      [ A_Collaps, A_Expand, A_Sp, A_Refresh, A_IsDelete, A_IsEdit, A_IsInsert, A_Sp,
       A_Find, A_FindNext ] );
  end;
end;

procedure TFrFuncRight.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ( Shift = []) and ( Key = VK_ESCAPE ) then
    Self.Close;
end;

function TFrFuncRight.SpravRightAccess( const IsRight, IsSpravValue: Integer ): Boolean;
begin
  Result := IsRight and IsSpravValue = IsRight;
end;

procedure TFrFuncRight.SetTreeData(IdParent: Integer; Node: TTreeNode; var Exp: Boolean );
var
TN: TTreeNode;
Query: TNewQuery;
CommID: PCommValue;
ID_Key: Integer;
SpravRight: String;
begin
  Query := TNewQuery.CreateNew( Self, IBTr_R );
  try
    Exp := True;
    Screen.Cursor := crSQLWait;
    TrView.Items.BeginUpdate;
    With Query do begin
      SQL.Clear;
      SQL.Text := Format( SQL_Text, [ CurrListID, IdParent ] );
      ExecQuery;

      If Assigned( Node ) then begin
        Node.DeleteChildren;
        If RecordCount = 0 then begin
          Exp := False;
           Close;
           Exit;
        end;
      end;

      While not EOF do begin
        New( CommID );
        SpravRight := '';
        ID_Key := FieldByName( 'FUNC_ITEM_RIGHT_ID' ).AsInteger;
        CommID^.ID := ID_Key;
        CommID^.IsCheck := FieldByName( 'IS_CHECK' ).AsInteger = 1;
        CommID^.IsSprav := not FieldByName( 'IS_SPRAV' ).IsNull;

        If CommID^.IsSprav then begin
          CommID^.IsDeleteCheck := SpravRightAccess( rhSpravDelete, FieldByName( 'RIGHT_ACTION' ).AsInteger );
          CommID^.IsDeleteVisible := SpravRightAccess( rhSpravDelete, FieldByName( 'IS_SPRAV' ).AsInteger );

          CommID^.IsEditCheck := SpravRightAccess( rhSpravUpdate, FieldByName( 'RIGHT_ACTION' ).AsInteger );
          CommID^.IsEditVisible := SpravRightAccess( rhSpravUpdate, FieldByName( 'IS_SPRAV' ).AsInteger );

          CommID^.IsInsertCheck := SpravRightAccess( rhSpravInsert, FieldByName( 'RIGHT_ACTION' ).AsInteger );
          CommID^.IsInsertVisible := SpravRightAccess( rhSpravInsert, FieldByName( 'IS_SPRAV' ).AsInteger );
        end
        else begin
          CommID^.IsDeleteCheck := False;
          CommID^.IsDeleteVisible := False;
          CommID^.IsEditCheck := False;
          CommID^.IsEditVisible := False;
          CommID^.IsInsertCheck := False;
          CommID^.IsInsertVisible := False;
        end;

        If ( Node = nil ) then
           TN := TrView.Items.AddObject( Node, FieldByName( 'FUNC_TITLE' ).AsString,  CommId )
        else
           TN := TrView.Items.AddChildObject( Node, FieldByName( 'FUNC_TITLE' ).AsString, CommId );

        Case CommID^.IsCheck of
          False:  TN.StateIndex := 2;
          True:   TN.StateIndex := 1;
        end;

        If CommID^.IsDeleteCheck then
          SpravRight := 'Удаление';

        If CommID^.IsEditCheck then
          If SpravRight = '' then
            SpravRight := 'Редактирование'
          else
            SpravRight := SpravRight + ', Редактирование';

        If CommID^.IsInsertCheck then
          If SpravRight = '' then
            SpravRight := 'Добавление'
          else
            SpravRight := SpravRight + ', Добавление';

        If SpravRight <> '' then
          TN.Text := TN.Text + '   /' + SpravRight + '/';

        TN.Selected;
        If FieldByName('NODE').AsInteger = 1 then
          TrView.Items.AddChildObject( TN, ' ', nil );

        Next;
      end;
      TrView.ShowButtons := True;
      Close;
    end;
  finally
     TrView.Items.EndUpdate;
     Query.FreeAndCommit;
     Screen.Cursor := crDefault;
  end;
end;

procedure TFrFuncRight.TrViewRefresh;
var
Exp: Boolean;
Node: TTreeNode;
begin
  TrView.Items.Clear;
  
  SetTreeData( 0, nil, Exp );
  Node := TrView.Items.GetFirstNode;
  If Node <> nil then
  With Node do begin
    MakeVisible;
    Selected := True;
    Focused := True;
  end;
end;

procedure TFrFuncRight.A_RefreshExecute(Sender: TObject);
begin
  TrViewRefresh;
end;

procedure TFrFuncRight.TrViewCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
var
TN: TTreeNode;
begin
  AllowCollapse := True;
  try
    Screen.Cursor := crHourGlass;
    TrView.Items.BeginUpdate;
    A_FindNext.Enabled := False;
    TN := Node.getFirstChild;
    While not ( TN = nil ) do begin
      try
        If TN.Data <> nil then begin
          If TN.HasChildren then
            TN.Collapse( True );
          Dispose( TN.Data );
          TN.Data := nil;
        end;
      except
        raise;
      end;
      TN := Node.GetNextChild( TN );
    end;
  finally
    Screen.Cursor := crDefault;
    TrView.Items.EndUpdate;
  end;
end;

procedure TFrFuncRight.DisposeRootNode;
var
Node: TTreeNode;
begin
  Node := TrVIew.Items.GetFirstNode;
  while Node <> nil do
  begin
    If Node.Data <> nil then begin
      Dispose( Node.Data );
      Node.Data := nil;
    end;
    Node := Node.GetNextSibling;
  end;
end;

procedure TFrFuncRight.TrViewExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
  SetTreeData( PCommValue( Node.Data )^.ID, Node, AllowExpansion );
end;

procedure TFrFuncRight.TrViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key of
    VK_SPACE :
      If TrView.Selected.Expanded then
        TrView.Selected.Collapse( True )
      else
        TrView.Selected.Expand( False );
  end;
end;

procedure TFrFuncRight.A_CollapsExecute(Sender: TObject);
begin
 try
   Screen.Cursor := crSQLWait;
   TrView.Items.BeginUpdate;
   TrView.FullCollapse;
   TrView.Items.EndUpdate;
 finally
   Screen.Cursor := crDefault;
 end;
end;

procedure TFrFuncRight.A_ExpandExecute(Sender: TObject);
begin
 try
   Screen.Cursor := crSQLWait;
   TrView.Items.BeginUpdate;
   TrView.FullExpand;
   TrView.Items.EndUpdate;
   Application.ProcessMessages;
 finally
   Screen.Cursor := crDefault;
 end;
end;

procedure TFrFuncRight.A_FindExecute(Sender: TObject);
begin
  If InputQuery('Поиск', 'Введите искомое значение', FindStr) then begin
    A_ExpandExecute( Self );
    FindStr := AnsiUpperCase( FindStr );
    If FindString ( FindStr, 0 ) then begin
       A_FindNext.Enabled := True;
       A_FindNext.Hint := 'Найти далее ( ' + FindStr + ' )';
    end
    else begin
       A_FindNext.Enabled := False;
       A_FindNext.Hint := 'Найти далее ...';
       ShowMessage('Искомое значение не найдено.');
    end;
  end;
end;

function TFrFuncRight.FindString( FindStr: String; Start: Integer ): Boolean;
var
N: Integer;
begin
  Result := False;
  try
    Screen.Cursor := crSQLWait;
    TrView.Items.BeginUpdate;
    For N := Start to TrView.Items.Count - 1 do begin
        If ( AnsiPos( FindStr, AnsiUpperCase( TrView.Items[ N ].Text )) > 0 ) then begin
          TrView.Items[ N ].MakeVisible;
          TrView.Items[ N ].Focused := True;
          TrView.Items[ N ].Selected := True;
          Application.ProcessMessages;
          Result := True;
          Exit;
        end;
    end;
  finally
    TrView.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrFuncRight.A_FindNextExecute(Sender: TObject);
begin
   If FindString ( FindStr, TrView.Selected.AbsoluteIndex + 1 ) then begin
     A_FindNext.Enabled := True;
     A_FindNext.Hint := 'Найти далее ( ' + FindStr + ' )';
   end
   else begin
     A_FindNext.Enabled := False;
     A_FindNext.Hint := 'Найти далее ...';
     ShowMessage('Искомое значение не найдено.');
   end;
end;

procedure TFrFuncRight.TrViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
Node: TTreeNode;
TextRect: TRect;
ImRect: Trect;
ImHeight: Integer;
begin
  If not ( Button = mbLeft ) then
    Exit;
  if tb_All.Down then
    Exit;

  Node := TrView.Selected;
  TextRect := Node.DisplayRect( True );
  ImHeight := TextRect.Bottom - TextRect.Top;
  ImRect :=
    Rect( TextRect.Left - TrView.Indent,TextRect.Top, TextRect.Left - TrView.Indent + Imheight, TextRect.Bottom );
  If PtInrect( ImRect, Point( X, Y )) then
    try
      TrView.Items.BeginUpdate;
      Case Node.StateIndex of
        1: begin      // UnCheck
           SetRightAccess( 'DEL', PCommValue( Node.Data )^.ID, Node );
           Node.StateIndex := 2;
           If Node.HasChildren then
             Node.Collapse( True );
        end;
        2: begin   // Check
           Node.StateIndex := 1;
           SetRightAccess( 'INS', PCommValue( Node.Data )^.ID, Node );
           While Node.Parent <> nil do begin
             Node := Node.Parent;
             Node.StateIndex := 1;
           end;
        end;
      end;
    finally
      Case Node.StateIndex of
        1: PCommValue( Node.Data )^.IsCheck := True;
        2: PCommValue( Node.Data )^.IsCheck := False;
      end;
      TrView.Items.EndUpdate;
    end;
end;

procedure TFrFuncRight.SetRightAccess( ActionType: String; IdNode: Integer; Node: TTreeNode );
begin
  Screen.Cursor := crSQLWait;
	If not IBTr.InTransaction then
    IBTr.StartTransaction;
  try
    Case TB_Group.Down of
      True: begin
        IBSp.StoredProcName := 'FUNC_RIGHT_GROUP_IUD';
        IBSp.ParamByName( 'RIGHT_GROUP_ID' ).AsInteger := CurrListID;
      end;
      False: begin
        IBSp.StoredProcName := 'FUNC_RIGHT_USER_IUD';
        IBSp.ParamByName( 'USER_LIST_ID' ).AsInteger := CurrListID;
      end;
    end;
    IBSp.ParamByName( 'ACTION_TYPE' ).AsString := ActionType;
    IBSp.ParamByName( 'FUNC_ITEM_RIGHT_ID' ).AsInteger := IdNode;

    try
      IBSp.ExecProc;
    except
      Raise;
    end;
  finally
    Screen.Cursor := crDefault;
    If IBTr.InTransaction then
      IBTr.Commit;
    try
      TrView.Items.BeginUpdate;
      GetNodeSpravParams( Node );
      TrViewChange( TrView, Node );
    finally
      TrView.Items.EndUpdate;
    end;
  end;
end;

procedure TFrFuncRight.GetNodeSpravParams( Node: TTreeNode );
var
Query: TNewQuery;
SpravRight: String;
N: integer;
begin
  N := Pos( '/', Node.Text );
  If N > 0 then
    Node.Text := Trim( Copy( Node.Text, 1, N - 1 ));

  Query := TNewQuery.CreateNew( Self, IBTr_R );
  try
    Query.SQL.Text := Format( SQL_Node, [ CurrListID, PCommValue( Node.Data )^.ID ] );
    try
      Query.ExecQuery;
    except
      Raise;
    end;
    PCommValue( Node.Data )^.IsCheck := not Query.FieldByName( 'FUNC_ITEM_RIGHT_ID' ).IsNull;

    PCommValue( Node.Data )^.IsDeleteCheck :=
      SpravRightAccess( rhSpravDelete, Query.FieldByName( 'RIGHT_ACTION' ).AsInteger );
    If PCommValue( Node.Data )^.IsDeleteCheck then
      SpravRight := 'Удаление';

    PCommValue( Node.Data )^.IsEditCheck :=
      SpravRightAccess( rhSpravUpdate, Query.FieldByName( 'RIGHT_ACTION' ).AsInteger );
    If PCommValue( Node.Data )^.IsEditCheck then
      If SpravRight = '' then
        SpravRight := 'Редактирование'
      else
        SpravRight := SpravRight + ', Редактирование';

    PCommValue( Node.Data )^.IsInsertCheck :=
      SpravRightAccess( rhSpravInsert, Query.FieldByName( 'RIGHT_ACTION' ).AsInteger );
    If PCommValue( Node.Data )^.IsInsertCheck then
      If SpravRight = '' then
        SpravRight := 'Добавление'
      else
        SpravRight := SpravRight + ', Добавление';

    If SpravRight <> '' then
      Node.Text := Node.Text + '   /' + SpravRight + '/';
  finally
    Query.FreeAndCommit;
  end;
end;

procedure TFrFuncRight.SetSpravParam(Sender: TObject);
const
sqlGroup =
' UPDATE FUNC_ITEM_RIGHT_GROUP G' + #13#10 +
'   set' + #13#10 +
'     G.RIGHT_ACTION = :RIGHT_ACTION' + #13#10 +
'   where' + #13#10 +
'     G.RIGHT_GROUP_ID = :RIGHT_GROUP_ID and' + #13#10 +
'     G.FUNC_ITEM_RIGHT_ID = :FUNC_ITEM_RIGHT_ID';

sqlUser =
' UPDATE FUNC_ITEM_RIGHT_USER U' + #13#10 +
'   set' + #13#10 +
'     U.RIGHT_ACTION = :RIGHT_ACTION' + #13#10 +
'   where' + #13#10 +
'     U.USER_LIST_ID = :USER_LIST_ID and' + #13#10 +
'     U.FUNC_ITEM_RIGHT_ID = :FUNC_ITEM_RIGHT_ID';

var
Node: TTreeNode;
RightAction: Integer;
begin
  Screen.Cursor := crSQLWait;
  Node := TrView.Selected;
  If Node = nil then
    Exit;
  TAction( Sender ).Checked := not TAction( Sender ).Checked;
  try
    RightAction := 0;
    if A_IsEdit.Checked then
      RightAction := RightAction or rhSpravUpdate;
    if A_IsInsert.Checked then
      RightAction := RightAction or rhSpravInsert;
    if A_IsDelete.Checked then
      RightAction := RightAction or rhSpravDelete;

    case TB_User.Down of
      True:
        ExecuteQuery( sqlUser, [ RightAction, CurrListID, PCommValue( Node.Data )^.ID ], IBTr );
      else
        ExecuteQuery( sqlGroup, [ RightAction, CurrListID, PCommValue( Node.Data )^.ID ], IBTr );
    end;

  finally
    Screen.Cursor := crDefault;
    If IBTr.InTransaction then
      IBTr.Commit;
    GetNodeSpravParams( Node );
  end;
end;

procedure TFrFuncRight.FillComboBoxItems( CBox: TComboBox; const SqlValue, TitleField, IDField: String );
var
Query: TNewQuery;
begin
	Query := TNewQuery.CreateNew( Self, IBTr_R );
	try
		Query.SQL.Text := SqlValue;
		try
			Query.ExecQuery;
		except
			Raise;
		end;
		CBox.Items.Clear;
		While not Query.Eof do begin
			If ( not Query.FieldByName( TitleField ).IsNull ) and
				 ( Query.FieldByName( TitleField ).AsString > '' ) then
				 try
					 CBox.Items.AddObject( Query.FieldByName( TitleField ).AsString,
														     TObject( Query.FieldByName( IDField ).AsInteger ));
				 except
					 raise;
				 end;
			Query.Next;
		end;
	finally
		Query.FreeAndCommit;
	end;
end;

procedure TFrFuncRight.CB_UserListDropDown(Sender: TObject);
const
sqlUserList =
'SELECT' + #13#10 +
'  U.PERSONAL_TITLE, U.PERSONAL_ID' + #13#10 +
'FROM PERSONAL U' + #13#10 +
'where' + #13#10 +
'  ( U.IS_DELETE > 0 )' + #13#10 +
'order by 1';

sqlGroupList =
'SELECT' + #13#10 +
'  G.RIGHT_GROUP_TITLE, G.RIGHT_GROUP_ID ' + #13#10 +
'FROM RIGHT_GROUP G' + #13#10 +
'where' + #13#10 +
'  ( G.IS_DELETE > 0 ) and ( G.IS_USE = 1 )' + #13#10 +
'order by 1';

var
OldUserID, Ind: Integer;
begin
  if ( SQL_Text = SQL_TextGroup ) or ( SQL_Text = '' ) then
    OldUserID := -1
  else
    OldUserID := CurrListID;

  if not IBTr_R.InTransaction then
    IBTr_R.StartTransaction;

  Self.Width := ( frPrima.ClientWidth div 10 ) * 9;
  Self.Height := ( frPrima.ClientHeight div 10 ) * 9;
  Self.Constraints.MinWidth := ( frPrima.ClientWidth div 10 ) * 8;
  Self.Constraints.MinHeight := ( frPrima.ClientHeight div 10 ) * 8;

  If TB_User.Down or tb_All.Down then begin
    FillComboBoxItems(  CB_UserList, sqlUserList, 'PERSONAL_TITLE', 'PERSONAL_ID' );

		CB_UserList.Hint := 'Список пользователей';
    if TB_User.Down then begin
      SQL_Text := SQL_TextUser;
      SQL_Node := SQL_NodeParamUser;
    end
    else
    if tb_All.Down then begin
      SQL_Text := SQL_TextAll;
      SQL_Node := SQL_NodeParamsAll;
    end;
	end
  else
	If TB_Group.Down then begin
    FillComboBoxItems(  CB_UserList, sqlGroupList, 'RIGHT_GROUP_TITLE', 'RIGHT_GROUP_ID' );

    CB_UserList.Hint := 'Группы пользователей';
    SQL_Text := SQL_TextGroup;
    SQL_Node := SQL_NodeParamGroup;
  end;

  if OldUserID <> -1 then begin
    Ind := CB_UserList.Items.IndexOfObject( TObject( OldUserID ));
    if Ind <> -1 then
      CB_UserList.ItemIndex :=  Ind;
  end;

  CB_UserListChange( Self );
end;

procedure TFrFuncRight.CB_UserListChange(Sender: TObject);
begin
  CBUserTimer.Enabled := False;
  try
    Screen.Cursor := crSQLWait;
    If CB_UserList.Items.Count = 0 then
      CurrListID := -1
    else begin
      If CB_UserList.ItemIndex = -1 then
        CB_UserList.ItemIndex := 0;
			CurrListID := Integer( CB_UserList.Items.Objects[ CB_UserList.ItemIndex ] );
		end;
  finally
		Screen.Cursor := crDefault;
    CBUserTimer.Enabled := True;
  end;
end;

procedure TFrFuncRight.CBUserTimerTimer(Sender: TObject);
const
sqlLogin =
'select CYR_LOGIN from USER_LIST where USER_LIST_ID = :ID';
sqlGroup =
'select' + #13#10 +
'  list( G.RIGHT_GROUP_TITLE ) as TITLE' + #13#10 +
'from RIGHT_GROUP G, USER_RIGHT_GROUP_LINK L' + #13#10 +
'where' + #13#10 +
'  G.RIGHT_GROUP_ID = L.RIGHT_GROUP_ID and' + #13#10 +
'  L.USER_LIST_ID = :ID';
begin
  try
    if TB_User.Down then
      P_Login.Caption :=
        GetQueryStrField( sqlLogin, 'CYR_LOGIN', [ CurrListID ], nil )
    else
    if tb_All.Down then
      P_Login.Caption :=
        GetQueryStrField( sqlGroup, 'TITLE', [ CurrListID ], nil )
    else
      P_Login.Caption := '';

    TrView.Items.BeginUpdate;
    TrView.FullCollapse;
  finally
    P_Login.Hint := P_Login.Caption;
    TrViewRefresh;
    TrView.Items.EndUpdate;
    Screen.Cursor := crDefault;
    CBUserTimer.Enabled := False;
  end;
end;

procedure TFrFuncRight.TrViewChange(Sender: TObject; Node: TTreeNode);
var
IsCheck: Boolean;
begin
  If PCommValue( Node.Data )^.IsSprav then begin
    A_IsDelete.Visible := PCommValue( Node.Data )^.IsDeleteVisible;
    A_IsEdit.Visible := PCommValue( Node.Data )^.IsEditVisible;
    A_IsInsert.Visible := PCommValue( Node.Data )^.IsInsertVisible;
    IsCheck := PCommValue( Node.Data )^.IsCheck;
    A_IsDelete.Enabled := IsCheck;
    A_IsEdit.Enabled := IsCheck;
    A_IsInsert.Enabled := IsCheck;
    A_IsDelete.Checked := PCommValue( Node.Data )^.IsDeleteCheck;
    A_IsEdit.Checked := PCommValue( Node.Data )^.IsEditCheck;
    A_IsInsert.Checked := PCommValue( Node.Data )^.IsInsertCheck;
  end
  else begin
    A_IsDelete.Visible := False;
    A_IsEdit.Visible := False;
    A_IsInsert.Visible := False;
  end;
end;



end.
