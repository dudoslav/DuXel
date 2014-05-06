unit DudDialogManagerUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DudNewFileDialogUnit, DudUnit, Dialogs, DudSettingsDialogUnit, DudTilesViewerDialogUnit;

type

  TDudDialogManager = class
  private
    procedure OpenTilesViewerDialog();
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
  NewFileDialog := TDudNewFileDialog.Create(nil);
  NewFileDialog.ShowModal;
  Result := NewFileDialog.getDudPic();
  NewFileDialog.Free;
end;

function TDudDialogManager.UseOpenFileDialog(): TDudPic;
var
  OpenFileDialog: TOpenDialog;
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
var
  SaveFileDialog: TSaveDialog;
begin
  SaveFileDialog := TSaveDialog.Create(nil);
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
  SettingsDialog := TDudSettingsDialog.Create(nil);
  SettingsDialog.ShowModal;
  if settingsDialog.CheckBox1.Checked then OpenTilesViewerDialog();
  SettingsDialog.Free;
end;

procedure TDudDialogManager.OpenTilesViewerDialog();
var
  TilesViewerDialog : TDudTilesViewerDialog;
begin
  TilesViewerDialog := TDudTilesViewerDialog.Create(nil);
  //TilesViewerDialog.render();
  TilesViewerDialog.Show;
end;

end.
