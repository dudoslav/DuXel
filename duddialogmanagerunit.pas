unit DudDialogManagerUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DudNewFileDialogUnit, DudUnit, Dialogs, Graphics,
  DudSettingsDialogUnit, DudTilesViewerDialogUnit, DudTextDialogUnit, DudNoiseDialogUnit;

type

  TDudDialogManager = class
  private
    TilesViewerDialog: TDudTilesViewerDialog;
  public
    function UseNewFileDialog(): TDudPic;
    function UseOpenFileDialog(): TDudPic;
    procedure UseSaveFileDialog(picture: TDudPic);
    procedure UseSettingsDialog();
    procedure UseTilesViewerDialog(var picture: TDudPic);
    procedure RenderTilesViewerDialog(picture: TDudPic);
    function UseTextDialog(): TTextSettings;
    procedure UseDudNoiseDialog(var picture : TDudPic; argCanvas: TCanvas);
    constructor Create();
  end;

implementation

constructor TDudDialogManager.Create();
begin
  TilesViewerDialog := TDudTilesViewerDialog.Create(nil);
end;

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
    Result.loadPic(OpenFileDialog.FileName);
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
    picture.savePic(SaveFileDialog.FileName);
  SaveFileDialog.Free;
end;

procedure TDudDialogManager.UseSettingsDialog();
var
  SettingsDialog: TDudSettingsDialog;
begin
  SettingsDialog := TDudSettingsDialog.Create(nil);
  SettingsDialog.ShowModal;
  SettingsDialog.Free;
end;

procedure TDudDialogManager.UseTilesViewerDialog(var picture: TDudPic);
begin
  if not TilesViewerDialog.Visible then
  begin
    TilesViewerDialog.render(picture);
    TilesViewerDialog.Show;
  end;
end;

procedure TDudDialogManager.RenderTilesViewerDialog(picture: TDudPic);
begin
  TilesViewerDialog.render(picture);
end;

function TDudDialogManager.UseTextDialog(): TTextSettings;
var
  TextDialog: TDudTextDialog;
begin
  TextDialog := TDudTextDialog.Create(nil);
  TextDialog.showModal;
  Result := textdialog.getTextSettings();
  TextDialog.Free;
end;

procedure TDudDialogManager.UseDudNoiseDialog(var picture : TDudPic; argCanvas: TCanvas);
var
  NoiseDialog : TDudNoiseDialog;
begin
  NoiseDialog := TDudNoiseDialog.Create(nil);
  NoiseDialog.Init(picture,argCanvas);
  NoiseDialog.Show;
end;

end.
