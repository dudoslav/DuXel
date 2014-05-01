unit DudUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type

  //TODO: dorob destructor

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
  end;

var
  pixelA: integer;

implementation

{TDudPic Begin}

constructor TDudPic.Create(Width, Height: integer);
begin
  pic := TPicture.Create;
  pic.Bitmap.Width := Width;
  pic.Bitmap.Height := Height;

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

{TDudPic End}

end.


