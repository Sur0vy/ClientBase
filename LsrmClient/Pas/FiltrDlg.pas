{***************************************************************}
{    Copyright (c) 2013 год             .                       }
{    Тетенев Леонид Петрович, ltetenev@yandex.ru                }
{                                                               }
{***************************************************************}

unit FiltrDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomDlg, Vcl.ActnList, DlgExecute, RegSmartDlg, Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, Vcl.ComCtrls, Vcl.ToolWin, GridDlg, pFIBClientDataSet,
  Vcl.ExtCtrls, DlgParams, FIBDataSet, pFIBDataSet, AddActions, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TfrFiltrDlg = class(TfrCustomDlg)
    procedure FormShow(Sender: TObject);
    procedure A_SaveExecute(Sender: TObject); override;
    procedure FillBeetwenMenu( FormDlg: TObject; Rows: TRowsList );
    procedure dlgFillRowsAfterFillRowList(Dlg: TObject; DlgID: Integer; ActionType: TStateDlg);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
    procedure A_SetBetweenExecute(Sender: TObject);
    procedure SmartDlgChangeRow(Sender: TObject; NewRow: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GreateSQLPickList(ValueID: Integer; FieldName: String; var StrText: String): Boolean;
    function GreateSQLBoolean(Value, FieldName: String; var StrText: String): Boolean;
    function GreateSQLText(Value, FieldName: String; var StrText: String): Boolean;
    procedure BetweenMenuClick(Sender: TObject);
    procedure FiltredSelectSQL(var DS: TpFIBDataSet; const OriginSQLText: String);
    procedure GetFiltredText(var WhereSQL: String; const OriginSQLText: String);
    function GreateBetweenSQLDateTime(Prop: TPropertyItem; var StrText: String): Boolean;
    function GreateBetweenSQLNumeric(Prop: TPropertyItem; var StrText: String): Boolean;
    procedure AddBetweenRow(Prop: TPropertyItem);
    procedure DeleteBetweenRow(Prop: TPropertyItem);
  public
    { Public declarations }
    FiltrDataSet: TpFIBDataSet;
    F_Caption, Filtr_Caption: String;
    SQL_FiltrText: String;
    procedure FillDialogMenu; override;
  end;


implementation

uses
  Tools, SqlTxtRtns, CustomForm, ClientDM, Prima;

const
StartTitle = '      Начало диапазона';
EndTitle = '      Конец диапазона';

{$R *.dfm}

procedure TfrFiltrDlg.FillBeetwenMenu( FormDlg: TObject; Rows: TRowsList );
var
N, L: Integer;
Prop: TPropertyItem;
ItemList: array of TAction;
begin
  A_Between.ClearAndFree;
  L := 0;
  Setlength( ItemList, L );
  try
    for N := 0 to Rows.Count - 1 do begin
      Prop := Rows.Items[ N ];
      if Prop.Style in [ psDateValue, psInteger, psNumeric ] then begin
        Inc( L );
        Setlength( ItemList, L );
        ItemList[ L - 1 ] := TAction.Create( Self );
        ItemList[ L - 1 ].Caption := Prop.Title;
        ItemList[ L - 1 ].Name := Prop.FieldName;
        ItemList[ L - 1 ].Tag := Prop.PrKeyID;
        ItemList[ L - 1 ].Checked := Prop.IsBetweenFiltr;
        ItemList[ L - 1 ].OnExecute := BetweenMenuClick;
      end;
    end;
  finally
    A_Between.SetMenuArray( ItemList );
    A_Between.Enabled := L > 0;
  end;
end;

procedure TfrFiltrDlg.FillDialogMenu;
begin
  inherited;
  //
end;

procedure TfrFiltrDlg.DeleteBetweenRow( Prop: TPropertyItem );
var
Ind: Integer;
begin
  Prop.IsBetweenFiltr := False;
  Prop.ShowAsReadOnly := False;
  Ind := Prop.Index;
  Prop.Style := SmartDlg.RowsList.Items[ Ind + 1 ].Style;

  SmartDlg.RowsList.Delete( Ind + 2 );
  SmartDlg.RowsList.Delete( Ind + 1 );
  SmartDlg.RowsRefresh;
end;


procedure TfrFiltrDlg.AddBetweenRow( Prop: TPropertyItem );
var
Ind: Integer;
begin
  Prop.IsBetweenFiltr := True;
  Ind := Prop.Index;

  With SmartDlg.RowsList.Insert( Ind + 1 ) do begin
    NoBetweenFiltr := True;
    FieldName := '';
    Style := Prop.Style;
    RowValue := Prop.RowValue;
    TabsID := Prop.TabsID;
    Title := StartTitle;
  end;
  With SmartDlg.RowsList.Insert( Ind + 2 ) do begin
    NoBetweenFiltr := True;
    FieldName := '';
    Style := Prop.Style;
    RowValue := Prop.RowValue;
    TabsID := Prop.TabsID;
    Title := EndTitle;
  end;

  Prop.RowValue := '';
  Prop.Style := psHeader;
end;

procedure TfrFiltrDlg.BetweenMenuClick(Sender: TObject);
var
Item: TAction;
Prop: TPropertyItem;
begin
  inherited;
  if not ( Sender is TAction ) then
    Exit;
  Item := TAction( Sender );
  Prop := SmartDlg.FindInRowsList( Item.Name );
  if not Assigned( prop ) then
    Exit;
  case Item.Checked of
    True:
      DeleteBetweenRow( Prop );
    else
      AddBetweenRow( Prop );
  end;

  Item.Checked := not Item.Checked;
  SmartDlg.SetFormHeight( False );
  SmartDlg.RowsRefresh;
end;

procedure TfrFiltrDlg.dlgFillRowsAfterFillRowList(Dlg: TObject; DlgID: Integer; ActionType: TStateDlg);
begin
  inherited;
  FillBeetwenMenu( Self, SmartDlg.RowsList );
end;

procedure TfrFiltrDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  A_Between.ClearAndFree;
end;

procedure TfrFiltrDlg.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrFiltrDlg.FormShow(Sender: TObject);
begin
  inherited;
  SmartDlg.Font := OwnerForm.Font;
  SmartDlg.Font.Size := 12;
end;

procedure TfrFiltrDlg.A_SaveExecute(Sender: TObject);
var
IsFiltr: Boolean;
begin
  if not ( A_Save.Enabled and A_Save.Visible ) then
    Exit;

  inherited;
  try
		FiltredSelectSQL( FiltrDataSet, SQL_FiltrText );
    If not FiltrDataSet.Transaction.InTransaction then
      FiltrDataSet.Transaction.StartTransaction;

    try
      FiltrDataSet.Open;
    except
      Raise;
    end;

    If Filtr_Caption > '' then begin
       OwnerForm.Caption := F_Caption + ' (' + Filtr_Caption + ')';
       IsFiltr := True;
    end
    else begin
       OwnerForm.Caption := F_Caption;
       IsFiltr := False;
    end;

    If Assigned( OwnerForm ) then begin
      with TfrCustomForm( OwnerForm ) do begin
        A_FiltrClear.Enabled := IsFiltr;
        
        if Assigned( A_Filtr.OnAfterExecFiltr ) then
          A_Filtr.OnAfterExecFiltr( Self, DlgIdent );
      end;
    end;
  finally
    Self.Close;
  end;
end;

procedure TfrFiltrDlg.A_SetBetweenExecute(Sender: TObject);
var
Prop, Host: TPropertyItem;
Ind: Integer;
begin
  inherited;
  if not ( A_SetBetween.Enabled and A_SetBetween.Visible ) then
    Exit;

  Prop := SmartDlg.SelectedInfo;
  try
    if Assigned( Prop ) then begin
      Ind := Prop.Index;
      if Prop.IsBetweenFiltr then
        DeleteBetweenRow( Prop )
      else
      if Prop.NoBetweenFiltr then begin
        if Prop.Title = StartTitle then
          Host := SmartDlg.RowsList.Items[ Ind - 1 ]
        else
        if Prop.Title = EndTitle then
          Host := SmartDlg.RowsList.Items[ Ind - 2 ]
        else
          Exit;

        if Assigned( Host ) then
          DeleteBetweenRow( Host )
      end
      else
        AddBetweenRow( Prop );
    end;
  finally
    SmartDlg.SetFormHeight( False );
    SmartDlg.RowsRefresh;
  end;
end;

procedure TFrFiltrDlg.GetFiltredText( var WhereSQL: String; const OriginSQLText: String );
var
N: Integer;
FiltrText: String;
Prop: TPropertyItem;

   procedure GetFiltrText( Ind: Integer );
   var
   Min, Max: TPropertyItem;
   begin
     if Prop.IsBetweenFiltr then begin
       if SmartDlg.RowsList.Count <= Ind + 2 then
         Exit;

       Min := SmartDlg.RowsList.Items[ Ind + 1 ];
       Max := SmartDlg.RowsList.Items[ Ind + 2 ];

       if ( Min.RowValue <> '' ) and ( Max.RowValue <> '' ) then
         FiltrText := Prop.Title + ' между "' + Min.RowValue + '" и "' + Max.RowValue + '"'
       else
       if ( Min.RowValue <> '' ) and ( Max.RowValue = '' ) then
         FiltrText := Prop.Title + ' больше "' + Min.RowValue + '"'
       else
       if ( Min.RowValue = '' ) and ( Max.RowValue <> '' ) then
         FiltrText := Prop.Title + ' меньше "' + Max.RowValue + '"';
     end
     else
       FiltrText := Prop.Title + ' = "' + Prop.RowValue + '"';
   end;

begin
	WhereSQL := '';
	Filtr_Caption := '';
	Application.ProcessMessages;

  For N := 0 to SmartDlg.RowsList.Count - 1 do begin
    Prop := SmartDlg.RowsList.Items[ N ];

    if ( not Prop.IsBetweenFiltr ) and
       ( Prop.Style = psHeader ) then
      Continue;
		If (( Prop.RowValue = '' ) and ( not Prop.IsBetweenFiltr )) or
			 ( Prop.FieldName = '' ) then
			Continue;
    if Prop.IsBetweenFiltr and
       ( SmartDlg.RowsList.Items[ N + 1 ].RowValue = '' ) and
       ( SmartDlg.RowsList.Items[ N + 2 ].RowValue = '' ) then
      Continue;

      case Prop.Style of
       psMultySelect:
         FiltrText := '"' + Prop.Title + '"';
       else
         GetFiltrText( N );
      end;

		If Filtr_Caption = '' then
		  Filtr_Caption := FiltrText
    else
			Filtr_Caption := Filtr_Caption + ',' + FiltrText;

		If ( Prop.SQL.FiltrSQL > '' ) then begin
			WhereSQLAppendAnd( WhereSQL );

			If Prop.Style in [ psMultySelect ] then begin
        If ( Prop.SQL.FiltrSQL > '' ) then
				  WhereSQL := Concat( WhereSQL, Format( Prop.SQL.FiltrSQL, [ Prop.CheckListID ] ));
      end
			else begin
        If Pos( '%D', AnsiUpperCase( Prop.SQL.FiltrSQL )) > 0    then
          WhereSQL := Concat( WhereSQL, Format( Prop.SQL.FiltrSQL, [ Prop.RowValueID ] ))
        else
        If Pos( '%S', AnsiUpperCase( Prop.SQL.FiltrSQL )) > 0    then
           WhereSQL := Concat( WhereSQL, Format( Prop.SQL.FiltrSQL, [ Prop.RowValue ] ))
        else
           WhereSQL := Concat( WhereSQL, Prop.SQL.FiltrSQL );
      end;
		end  //If ( Prop.SQL.FiltrSQL > '' ) then begin
    else begin
			Case Prop.Style of
        psHeader:
          If Prop.IsBetweenFiltr then
            case SmartDlg.RowsList.Items[ N + 1 ].Style of
              psDateValue:
                GreateBetweenSQLDateTime( Prop, WhereSQL );
              psNumeric, psInteger:
                GreateBetweenSQLNumeric( Prop, WhereSQL );
            end;
				psPickList:
          GreateSQLPickList( Prop.RowValueID, Prop.SQL.KeyID, WhereSQL );
				psComboBox:
          GreateSQLPickList( Prop.RowValueID, Prop.FieldName, WhereSQL );
				psDateValue:
          GreateBetweenSQLDateTime( Prop, WhereSQL );
        psNumeric, psInteger:
          GreateBetweenSQLNumeric( Prop, WhereSQL );
        psBoolean:
          GreateSQLBoolean( Prop.RowValue, Prop.FieldName, WhereSQL );
        psMultySelect: begin
          // Здесь пропускаем эти состояния
        end;
        else
          GreateSQLText( Prop.RowValue, Prop.FieldName, WhereSQL );
      end;
    end;
  end;
end;

function TFrFiltrDlg.GreateSQLPickList(ValueID: Integer; FieldName: String; var StrText: String): Boolean;
begin
  try
    WhereSQLAppendAnd( StrText );
    StrText := Concat( StrText, ' (', FieldName, ' = ', IntToStr( ValueID ), ')' );
    Result := True;
  except
    Result := False;
  end;
end;

function TFrFiltrDlg.GreateBetweenSQLDateTime( Prop: TPropertyItem; var StrText: String): Boolean;
  function GetDate( const Value: String ):String;
  begin
    Result := ' Cast( ' + QuotedStr( Value ) + ' as timestamp ) ';
  end;

var
Min, Max: TPropertyItem;
begin
  WhereSQLAppendAnd( StrText );
  try
    case Prop.IsBetweenFiltr of
      True: begin
        Min := SmartDlg.RowsList.Items[ Prop.Index + 1 ];
        Max := SmartDlg.RowsList.Items[ Prop.Index + 2 ];

        case Prop.SQL.IsFiltrDateTime of
          True:
            StrText :=
              StrText + '(' + Prop.FieldName + ' between' +
                GetDate( Min.RowValue ) + ' and ' + GetDate( Max.RowValue ) + '+ 1)';
          else
            StrText :=
              StrText + '(' + Prop.FieldName + ' between' +
                QuotedStr( Min.RowValue ) + ' and ' + QuotedStr( Max.RowValue ) + ')';
        end;
      end;
      else begin
        case Prop.SQL.IsFiltrDateTime of
          True:
            StrText :=
              StrText + '(' + Prop.FieldName + ' between' +
                GetDate( Prop.RowValue ) + 'and' + GetDate( Prop.RowValue ) + '+ 1)';
          else
            StrText := Concat( StrText, ' (', Prop.FieldName, ' = ', QuotedStr( Prop.RowValue ), ')' );
        end;
      end;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrFiltrDlg.GreateBetweenSQLNumeric( Prop: TPropertyItem; var StrText: String): Boolean;
  function ChangeSeparator( Value: String ): String;
  begin
    With FormatSettings do
      Result := StringReplace( StrSeparatorDelete( Value ), DecimalSeparator, '.', [] );
  end;

var
Min, Max: TPropertyItem;
begin
  WhereSQLAppendAnd( StrText );

  try
    case Prop.IsBetweenFiltr of
      True: begin
        Min := SmartDlg.RowsList.Items[ Prop.Index + 1 ];
        Max := SmartDlg.RowsList.Items[ Prop.Index + 2 ];

        StrText :=
          StrText + '(' + Prop.FieldName + ' between' +
                ChangeSeparator( Min.RowValue ) + ' and ' + ChangeSeparator( Max.RowValue ) + ')';

      end;
      else begin
        StrText := Concat( StrText, ' (', Prop.FieldName, ' = ', ChangeSeparator( Prop.RowValue ), ')' );
      end;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrFiltrDlg.GreateSQLBoolean(Value, FieldName: String; var StrText: String): Boolean;
var
IndBool: Word;
begin
  Result := False;
  If Trim( Value ) = '' then
    Exit;
  try
    if AnsiSameText( Value, BoolTitle[ 0 ]) then
      IndBool := 0
    else
    if AnsiSameText( Value, BoolTitle[ 1 ]) then
      IndBool := 1
    else
      Exit;

    WhereSQLAppendAnd( StrText );

    Value := IntToStr( IndBool );
    StrText := Concat( StrText, ' (', FieldName, ' = ', QuotedStr( Value ), ')' );
    Result := True;
  except
    Result := False;
  end;
end;

function TFrFiltrDlg.GreateSQLText(Value, FieldName: String; var StrText: String): Boolean;
  function SQLTextFind( Value, FieldName: String ): String;
  var
  N, M, L, LenV: Integer;
  Str: String;
  StrArr: array of String;
  begin
    M := 1;
    L := 0;
    LenV := Length( Value );
    For N := 1 to LenV do
      If IsDelimiter( #32, Value, N ) or ( N = LenV ) then begin
        Str := Trim( Copy( Value, M, N - M + 1 ));
        If Str > '' then begin
          SetLength( StrArr, L + 1 );
          StrArr[ L ] := Str;
          Inc( L );
        end;
        M := N;
      end;
    Result := '';
    For N := 0 to High( StrArr ) do
      try
        StrArr[ N ] := AnsiUpperCase( StrArr[ N ] );
        If Result = '' then
          Result := Concat( Result, ' (', FieldName, ' containing ', QuotedStr( StrArr[ N ] ), ')' )
                       else
          Result := Concat( Result, ' AND (', FieldName, ' containing ', QuotedStr( StrArr[ N ] ), ')' );
      except
        Raise;
      end;
  end;

begin
  try
    Value := Trim( Value );
    WhereSQLAppendAnd( StrText );
    StrText := Concat( StrText, SQLTextFind( Value, FieldName ));
    Result := True;
  except
    Result := False;
  end;
end;

procedure TfrFiltrDlg.SmartDlgChangeRow(Sender: TObject; NewRow: Integer);
var
Prop: TPropertyItem;
begin
  inherited;
  Prop := SmartDlg.GetPropByRowInd( NewRow );
  if Assigned( Prop ) then begin
    A_SetBetween.Enabled := Prop.Style in [ psDateValue, psInteger, psNumeric ];
    A_SetBetween.Checked := Prop.IsBetweenFiltr or Prop.NoBetweenFiltr;
  end
  else
    A_SetBetween.Enabled := False;
end;

procedure TFrFiltrDlg.FiltredSelectSQL( var DS: TpFIBDataSet; const OriginSQLText: String );
  function ChangeFiltrSqlText(StrSQL, SQLTextOrign: String): String;
  begin
    If StrSQL = '' then begin
      Result := SQLTextOrign;
      Exit;
    end;

    Result := AddToWhereClause( SQLTextOrign, StrSQL, False );
  end;

var
WhereSQL: String;
begin
	WhereSQL := '';
	Filtr_Caption := '';
	If DS.Active then begin
		DS.Close;
	end;
	DS.SelectSQL.Clear;
	Application.ProcessMessages;

	GetFiltredText( WhereSQL, OriginSQLText );

	DS.SelectSQL.Text := ChangeFiltrSqlText( WhereSQL, OriginSQLText );
end;



end.
