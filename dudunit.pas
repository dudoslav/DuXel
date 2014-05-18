unit DudUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type

  TTextSettings = record
    text : string;
    size : integer;
  end;

  TDudPic = class
  private
    pic: TPicture;
    procedure fill(color: TColor);
  public
    constructor Create(Width, Height: integer);
    function getPicPixel(x, y: integer): TColor;
    procedure setPicPixel(x, y: integer; color: TColor);
    function getPicWidth(): integer;
    function getPicHeight(): integer;
    procedure loadPic(Path: string);
    procedure savePic(Path: string);
    function getPic(): TPicture;
    procedure setPic(picture : TPicture);
    procedure render(canvas : TCanvas);
    procedure renderPix(x,y : integer ;canvas: TCanvas);
    destructor Destroy();override;
  end;

var
  pixelA: integer;
  WireFrame: boolean;

implementation

{TDudPic Begin}

constructor TDudPic.Create(Width, Height: integer);
begin
  pic := TPicture.Create;
  pic.Bitmap.Width := Width;
  pic.Bitmap.Height := Height;
  pic.bitmap.PixelFormat:= pf32bit;
  pic.bitmap.TransparentMode:=tmfixed;

  fill(clwhite);
end;

function TDudPic.getPicPixel(x, y: integer): TColor;
begin
  Result := pic.Bitmap.Canvas.Pixels[x, y];
end;

procedure TDudPic.setPicPixel(x, y: integer; color: TColor);
begin
  pic.Bitmap.Canvas.Pixels[x, y] := color;
end;

function TDudPic.getPicWidth(): integer;
begin
  Result := pic.Width;
end;

function TDudPic.getPicHeight(): integer;
begin
  Result := pic.Height;
end;

procedure TDudPic.loadPic(Path: string);
begin
  pic.LoadFromFile(Path);
end;

procedure TDudPic.savePic(Path: string);
begin
  pic.SaveToFile(Path);
end;

procedure TDudPic.fill(color: TColor);
var
  i, j: integer;
begin
  for i := 0 to pic.Width - 1 do
    for j := 0 to pic.Height - 1 do
    begin
      pic.BitMap.Canvas.Pixels[i, j] := color;
    end;
end;

function TDudPic.getPic(): TPicture;
begin
  result := pic;
end;

procedure TDudPic.setPic(picture : TPicture);
begin
  pic := picture;
end;

procedure TDudPic.render(canvas : TCanvas);
var
  i,j : integer;
begin
  for i := 0 to getPicWidth() - 1 do
      for j := 0 to getPicHeight() - 1 do
      begin
        if wireframe then canvas.pen.color := clblack else canvas.pen.color := getPicPixel(i, j);
        canvas.brush.color := getPicPixel(i, j);
        canvas.rectangle(i * pixelA, j * pixelA, i * pixelA +
          pixelA, j * pixelA + pixelA);
      end;
end;

procedure TDudPic.renderPix(x,y : integer ;canvas: TCanvas);
begin
       if wireframe then canvas.pen.color := clblack else canvas.pen.color := getPicPixel(x, y);
        canvas.brush.color := getPicPixel(x, y);
        canvas.rectangle(x * pixelA, y * pixelA, x * pixelA +
          pixelA, y * pixelA + pixelA);
end;

destructor TDudPic.Destroy();
begin
  pic.Free;
end;

{TDudPic End}

end.


