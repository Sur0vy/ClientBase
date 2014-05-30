unit AddActions;

interface

uses
  ActnList, Classes, Menus, Contnrs, DB, Grids, DBGridEh;

type
  TArrayAction = array of TAction;
  TOnSetDefaultValue   = procedure( Sender: TObject ) of Object;
  TOnFilterParam       = procedure( Sender: TObject; const DialogIdent: Integer ) of Object;

  TPopMenuAction = Class( TAction )
  private
		FPM: TPopupMenu;
		FPopItemCount: Integer;
		FList: TArrayAction;
    FHideOfEmptyList: Boolean;
		procedure SetPM(const Value: TPopupMenu);
		procedure SetList(const Value: TArrayAction);
    procedure SetPopItemCount(const Value: Integer);
    procedure SetHideOfEmptyList(const Value: Boolean);
	protected
		procedure Notification(AComponent: TComponent; Operation: TOperation); override;
	public
		property	PM: TPopupMenu read FPM write SetPM;
		property List: TArrayAction read FList write SetList;
		property PopItemCount: Integer read FPopItemCount write SetPopItemCount;
		function HandlesTarget(Target: TObject): Boolean; override;
		constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;
		procedure SetMenuArray( Item: array of TAction );
    procedure Clear;
    procedure ClearAndFree;
		procedure UpdateTarget(Target: TObject); override;
  published
    property HideOfEmptyList: Boolean read FHideOfEmptyList write SetHideOfEmptyList default True;
	end;

  TFiltrActList = class( TAction )
  private
    FNoShow: Integer;
    FOnShowParam: TOnFilterParam;
    FFiltredQuery: TDataSet;
    FShowDlg: Boolean;
    FDlgIdent: Integer;
    FSortingResult: Boolean;
    FFiltrClear: Boolean;
    FDbGrid: TDBGridEh;
    FOnSetDefaultValue: TOnSetDefaultValue;
    FFiltrSQLText: String;
    FOnBeforeFillParams: TOnFilterParam;
    FOnAfterExecFiltr: TOnFilterParam;
    procedure SetDlgIdent(const Value: Integer);
    procedure SetFiltredQuery(const Value: TDataSet);
    procedure SetNoShow(const Value: Integer);
    procedure SetOnShowParam(const Value: TOnFilterParam);
    procedure SetShowDlg(const Value: Boolean);
    procedure SetSortingResult(const Value: Boolean);
    procedure SetFiltrClear(const Value: Boolean);
    procedure SetDbGrid(const Value: TDBGridEh);
    procedure SetOnSetDefaultValue(const Value: TOnSetDefaultValue);
    procedure SetFiltrSQLText(const Value: String);
    procedure SetOnBeforeFillParams(const Value: TOnFilterParam);
    procedure SetOnAfterExecFiltr(const Value: TOnFilterParam);

  public
    property FiltrClear: Boolean read FFiltrClear write SetFiltrClear  default False;
    property FiltrSQLText: String read FFiltrSQLText write SetFiltrSQLText;
  published
    property ShowDlg: Boolean read FShowDlg write SetShowDlg  default False;
    property SortingResult: Boolean read FSortingResult write SetSortingResult  default False;
    property DbGrid: TDBGridEh read FDbGrid write SetDbGrid;
    property OnShowParam: TOnFilterParam read FOnShowParam write SetOnShowParam;
    property OnSetDefaultValue: TOnSetDefaultValue read FOnSetDefaultValue write SetOnSetDefaultValue;
    property FiltredQuery: TDataSet read FFiltredQuery write SetFiltredQuery;
    property DlgIdent: Integer read FDlgIdent write SetDlgIdent;
    property NoShow: Integer read FNoShow write SetNoShow;
    property OnBeforeFillParams: TOnFilterParam read FOnBeforeFillParams write SetOnBeforeFillParams;
    property OnAfterExecFiltr: TOnFilterParam read FOnAfterExecFiltr write SetOnAfterExecFiltr;
  end;

	procedure Register;

implementation

{ TPopMenuAction }



procedure Register;
begin
	RegisterActions( 'PopupAction', [ TPopMenuAction, TFiltrActList ], nil );
end;

procedure TPopMenuAction.Clear;
begin
  SetLength( FList, 0 );
  if Assigned( FPM ) then
    FPM.Items.Clear;
end;

procedure TPopMenuAction.ClearAndFree;
var
N: Integer;
begin
  for N := 0 to High( FList ) do begin
    FList[ N ].Free;
    FList[ N ] := nil;
  end;
  Clear;
end;

constructor TPopMenuAction.Create(AOwner: TComponent);
begin
	inherited;
	FHideOfEmptyList := True;
end;

destructor TPopMenuAction.Destroy;
begin
	If Assigned( FPM ) then
		FPM.Free;
	inherited;
end;

function TPopMenuAction.HandlesTarget(Target: TObject): Boolean;
begin
	Result := FPopItemCount > 0;
end;

procedure TPopMenuAction.Notification(AComponent: TComponent; Operation: TOperation);
begin
	inherited Notification(AComponent, Operation);
	if (Operation = opRemove) and (AComponent = PM) then PM := nil;
end;

procedure TPopMenuAction.SetPM(const Value: TPopupMenu);
begin
	FPM := Value;
end;

procedure TPopMenuAction.SetHideOfEmptyList(const Value: Boolean);
begin
  FHideOfEmptyList := Value;
end;

procedure TPopMenuAction.SetList(const Value: TArrayAction);
var
N: Integer;
CurrItem: TMenuItem;
begin
	FList := Value;
	If Assigned( FPM ) then
		FPM.Items.Clear
	else begin
		FPM := TPopupMenu.Create( Self );
		FPM.Items.Clear;
	end;

	For N := 0 to High( FList ) do begin
		If not FList[ N ].Visible then
	    Continue;
		CurrItem := TMenuItem.Create( FPM.Items );
    if ( FList[ N ].Caption = '-' ) or
       ( FList[ N ].Caption = '|' )  then begin
      CurrItem.Caption := '-';
    end
    else
		  CurrItem.Action := FList[ N ];
		FPM.Items.Add( CurrItem );
	end;
	FPopItemCount := FPM.Items.Count;
  if FHideOfEmptyList then
	  Visible := FPopItemCount > 0;
end;

procedure TPopMenuAction.SetPopItemCount(const Value: Integer);
begin
	FPopItemCount := Value;
	SetLength( FList, Value );
end;

procedure TPopMenuAction.SetMenuArray(Item: array of TAction);
var
N: Integer;
begin
	PopItemCount := Length( Item );
	For N := 0 to High( Item ) do
		List[ N ] := Item[ N ];
  SetList( List );
end;

procedure TPopMenuAction.UpdateTarget(Target: TObject);
begin
	//
end;

{ TFiltrActList }

procedure TFiltrActList.SetDbGrid(const Value: TDBGridEh);
begin
  FDbGrid := Value;
end;

procedure TFiltrActList.SetDlgIdent(const Value: Integer);
begin
  FDlgIdent := Value;
end;

procedure TFiltrActList.SetFiltrClear(const Value: Boolean);
begin
  FFiltrClear := Value;
end;

procedure TFiltrActList.SetFiltredQuery(const Value: TDataSet);
begin
  FFiltredQuery := Value;
end;

procedure TFiltrActList.SetFiltrSQLText(const Value: String);
begin
  FFiltrSQLText := Value;
end;

procedure TFiltrActList.SetNoShow(const Value: Integer);
begin
  FNoShow := Value;
end;

procedure TFiltrActList.SetOnAfterExecFiltr(const Value: TOnFilterParam);
begin
  FOnAfterExecFiltr := Value;
end;

procedure TFiltrActList.SetOnBeforeFillParams(const Value: TOnFilterParam);
begin
  FOnBeforeFillParams := Value;
end;

procedure TFiltrActList.SetOnSetDefaultValue(const Value: TOnSetDefaultValue);
begin
  FOnSetDefaultValue := Value;
end;

procedure TFiltrActList.SetOnShowParam(const Value: TOnFilterParam);
begin
  FOnShowParam := Value;
end;

procedure TFiltrActList.SetShowDlg(const Value: Boolean);
begin
  FShowDlg := Value;
end;

procedure TFiltrActList.SetSortingResult(const Value: Boolean);
begin
  FSortingResult := Value;
end;

end.




