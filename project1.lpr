program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, DudUnit, DudDialogManagerUnit, DudNewFileDialogUnit, 
DudToolsUnit, DudSettingsDialogUnit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDudNewFileDialog, DudNewFileDialog);
  Application.CreateForm(TDudTools, DudTools);
  Application.CreateForm(TDudSettingsDialog, DudSettingsDialog);
  Application.Run;
end.

