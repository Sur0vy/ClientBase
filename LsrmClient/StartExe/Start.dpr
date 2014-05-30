program Start;

uses
  Vcl.Forms,
  ToBase in 'ToBase.pas' {frToBase};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Авторизация пользователя';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrToBase, frToBase);
  Application.Run;
end.
