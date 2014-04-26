unit DudDialogManagerUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DudNewFileDialogUnit, DudUnit, Dialogs;

type

  TDudDialogManager = class
  private
    NewFileDialog: TDudNewFileDialog;
    OpenFileDialog: TOpenDialog;
    SaveFileDialog: TSaveDialog;
  public
    function UseNewFileDialog(): TDudPic;
    function UseOpenFileDialog(): TDudPic;
    procedure UseSaveFileDialog(picture: TDudPic);
  end;

implementation

function TDudDialogManager.UseNewFileDialog(): TDudPic;
begin
  NewFileDialog := TDudNewFileDialog.Create(nil);     //TOASK: opitaj peta!
  NewFileDialog.ShowModal;
  Result := NewFileDialog.getDudPic();
  NewFileDialog.Free;
end;

function TDudDialogManager.UseOpenFileDialog(): TDudPic;
begin
  Result := TDudPic.Create(1, 1);
  OpenFileDialog := TOpenDialog.Create(nil);
  if (OpenFileDialog.Execute) then
    Result.loadPic(OpenFileDialog.FileName)
  else
    ShowMessage('Failed to execute OpenDialog');
  OpenFileDialog.Free;
end;

procedure TDudDialogManager.UseSaveFileDialog(picture: TDudPic);
begin
  SaveFileDialog := TSaveDialog.Create(nil);
  if (SaveFileDialog.Execute) then
    picture.savePic(SaveFileDialog.FileName)
  else
    ShowMessage('Failed to execute SaveDialog');
  SaveFileDialog.Free;
end;

end.
