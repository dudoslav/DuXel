unit DudTilesViewerDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, DudUnit;

type

  { TDudTilesViewerDialog }

  TDudTilesViewerDialog = class(TForm)
    Image1: TImage;
  private

  public
    procedure render(picture : TDudPic);
  end;

var
  DudTilesViewerDialog: TDudTilesViewerDialog;

implementation

{$R *.lfm}

  procedure TDudTilesViewerDialog.render(picture : TDudPic);
  var
    i,j : integer;
  begin
    for i := 0 to (image1.Width div picture.getPicWidth()) do
        for j := 0 to (image1.Height div picture.getPicHeight()) do
            begin
              image1.canvas.Draw(i*picture.getPicWidth(),j*picture.getPicWidth(),picture.getPic().Bitmap);
            end;
  end;

end.

