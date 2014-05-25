unit DudTilesViewerDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, DudUnit;

type

  { TDudTilesViewerDialog }

  TDudTilesViewerDialog = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    pic : TDudPic;
  public
    procedure render(picture : TDudPic);
  end;

var
  DudTilesViewerDialog: TDudTilesViewerDialog;

implementation

{$R *.lfm}

procedure TDudTilesViewerDialog.MenuItem1Click(Sender: TObject);
var
  SaveFileDialog: TSaveDialog;
begin
  SaveFileDialog := TSaveDialog.Create(nil);
  SaveFileDialog.Filter := 'PortableNetworkGraphics|*.png|JPEG,JPG|*.jpg|Bitmap|*.bmp';
  SaveFileDialog.FilterIndex := 0;
  if (SaveFileDialog.Execute) then
    image1.Picture.SaveToFile(SaveFileDialog.FileName);
  SaveFileDialog.Free;
end;

procedure TDudTilesViewerDialog.FormResize(Sender: TObject);
begin
  image1.Picture.bitmap.SetSize(Width,Height);
  image1.Width := Width;
  image1.Height := Height;
  render(pic);
end;

  procedure TDudTilesViewerDialog.render(picture : TDudPic);
  var
    i,j : integer;
  begin
    pic := picture;
    for i := 0 to (image1.Width div picture.getPicWidth()) do
        for j := 0 to (image1.Height div picture.getPicHeight()) do
            begin
              image1.canvas.Draw(i*picture.getPicWidth(),j*picture.getPicWidth(),picture.getPic().Bitmap);
            end;
  end;

end.

