program Start;

uses
  Vcl.Forms,
  ToBase in 'ToBase.pas' {frToBase};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����������� ������������';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrToBase, frToBase);
  Application.Run;
end.
