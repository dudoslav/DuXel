unit DudDialogManagerUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DudNewFileDialogUnit, DudUnit, Dialogs, DudSettingsDialogUnit;

type

  TDudDialogManager = class
  private
  public
    function UseNewFileDialog(): TDudPic;
    function UseOpenFileDialog(): TDudPic;
    procedure UseSaveFileDialog(picture: TDudPic);
    procedure UseSettingsDialog();
  end;

implementation

function TDudDialogManager.UseNewFileDialog(): TDudPic;
var
  NewFileDialog: TDudNewFileDialog;
begin
  NewFileDialog := TDudNewFileDialog.Create(NewFileDialog);
  NewFileDialog.ShowModal;
  Result := NewFileDialog.getDudPic();
  NewFileDialog.Free;
end;

function TDudDialogManager.UseOpenFileDialog(): TDudPic;
var
  OpenFileDialog: TOpenDialog;
begin
  Result := TDudPic.Create(1, 1);
  OpenFileDialog := TOpenDialog.Create(OpenFileDialog);
  if (OpenFileDialog.Execute) then
    Result.loadPic(OpenFileDialog.FileName)
  else
    ShowMessage('Failed to execute OpenDialog');
  OpenFileDialog.Free;
end;

procedure TDudDialogManager.UseSaveFileDialog(picture: TDudPic);
var
  SaveFileDialog: TSaveDialog;
begin
  SaveFileDialog := TSaveDialog.Create(SaveFileDialog);
  SaveFileDialog.Filter := 'PortableNetworkGraphics|*.png|JPEG,JPG|*.jpg|Bitmap|*.bmp';
  SaveFileDialog.FilterIndex := 0;
  if (SaveFileDialog.Execute) then
    picture.savePic(SaveFileDialog.FileName)
  else
    ShowMessage('Failed to execute SaveDialog');
  SaveFileDialog.Free;
end;

procedure TDudDialogManager.UseSettingsDialog();
var
  SettingsDialog: TDudSettingsDialog;
begin
  SettingsDialog := TDudSettingsDialog.Create(SettingsDialog);
  SettingsDialog.ShowModal;
  SettingsDialog.Free;
end;

end.
