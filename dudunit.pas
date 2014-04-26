unit DudUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type

  //TODO: dorob destructor

  TDudPic = class
  private
    pic: TPortableNetworkGraphic;
    procedure fill(color : TColor);
  public
    constructor Create(Width,Height : integer);
    function getPicPixel(x, y: integer): TColor;
    procedure setPicPixel(x, y: integer; color : TColor);
    function getPicWidth(): integer;
    function getPicHeight(): integer;
    procedure loadPic(Path : string);
    procedure savePic(Path : string);
  end;

implementation

const
  PIC_FORMAT = '.png';

{TDudPic Begin}

constructor TDudPic.Create(Width,Height : integer);
begin
  pic:= TPortableNetworkGraphic.Create;
  pic.Width:= Width;
  pic.Height:= Height;

  fill(clwhite);
end;

function TDudPic.getPicPixel(x, y: integer): TColor;
begin
  result := pic.Canvas.Pixels[x,y];
end;

procedure TDudPic.setPicPixel(x, y: integer; color: TColor);
begin
  pic.Canvas.Pixels[x,y] := color;
end;

function TDudPic.getPicWidth(): integer;
begin
  result := pic.Width;
end;

function TDudPic.getPicHeight(): integer;
begin
  result := pic.Height;
end;

procedure TDudPic.loadPic(Path : string);
begin
pic.LoadFromFile(Path);
end;

procedure TDudPic.savePic(Path : string);
begin
pic.SaveToFile(Path + PIC_FORMAT);
end;

procedure TDudPic.fill(color : TColor);
var
  i,j : integer;
begin
  for i := 0 to pic.Width do
      for j := 0 to pic.Height do
          begin
             pic.Canvas.Pixels[i,j] := color;
          end;
end;

{TDudPic End}

end.


