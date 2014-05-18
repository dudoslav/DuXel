unit DudNoiseDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Math, Graphics, Dialogs, StdCtrls, DudUnit;

type

  { TDudNoiseDialog }

  TDudNoiseDialog = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    thisCanvas : TCanvas;
    thisPicture : TDudPic;
    { private declarations }
  public
    { public declarations }
    procedure Init(var picture : TDudPic; argCanvas: TCanvas);
  end;

var
  DudNoiseDialog: TDudNoiseDialog;

implementation

{$R *.lfm}

{ TDudNoiseDialog }
procedure TDudNoiseDialog.Init(var picture : TDudPic; argCanvas: TCanvas);
begin
 thisCanvas := argCanvas;
 thisPicture := picture;
end;

procedure TDudNoiseDialog.Button1Click(Sender: TObject);
var
  i,j : integer;
  nowColor : TColor;
begin
for i := 0 to thisPicture.getPicWidth()-1 do
    for j := 0 to thisPicture.getPicHeight()-1 do
        begin
          nowColor := RGBtoColor(round(sin(i*j)*256),round(sin(i*j)*256),round(sin(i*j)*256));
          thisPicture.setPicPixel(i,j,nowColor);
        end;
thisPicture.render(thisCanvas);
end;

end.

