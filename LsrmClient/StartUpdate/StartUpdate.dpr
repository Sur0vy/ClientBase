program StartUpdate;

{$APPTYPE CONSOLE}

uses
  vcl.Forms,
  SaveStartFile in 'SaveStartFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := false;
  Application.Title := 'Авто-обновление загрузочного файла';
  If ParamCount <> 6 then begin
    WriteLn( 'Incorrect parameters of start!' + #13#10 +
             'For start specify parameters:' + #13#10 +
             'StartUpdate.exe "File id in the table EXE_FILES_LIST" "Complete file name" "Name databse" "Login" "Password" "Role"' );
    Exit;
  end;
  TSaveStart.SaveExecute;
  Application.Run;
end.
