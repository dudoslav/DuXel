unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, LCLType,
  ExtCtrls, Menus, StdCtrls, Math, windows;

type

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
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    pixelA : integer;
  public
    procedure renderDudPic(picture : TDudPic);
  end;

var
  Form1: TForm1;
  obr: TDudPic;
implementation

procedure CreatePic(width,height : integer);
begin
  obr := TDuDPic.Create(width,height);
  image1.width := width*pixelA;
  image1.height := height*pixelA;
  image1.Picture.Bitmap.SetSize(width*pixelA,height*pixelA);
end;

{$R *.lfm}

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

{TForm1 Begin}

procedure TForm1.renderDudPic(picture : TDudPic);
var
  i,j : integer;
begin
  for i := 0 to picture.getPicWidth() do
      for j := 0 to picture.getPicHeight() do
          begin
             //image1.canvas.pen.color := picture.getPicPixel(i,j);
             image1.canvas.brush.color := picture.getPicPixel(i,j);
             image1.canvas.rectangle(i*pixelA,j*pixelA,i*pixelA+pixelA,j*pixelA+pixelA);
          end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //obr := TDudPic.Create(16,16);
  pixelA := 60;
  //renderDudPic(obr);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if(obr <> nil) and (obr.pic.Width*pixelA <= image1.width) then
  scrollbar1.Visible := false else
    begin
    scrollbar1.Visible := true;
    scrollbar1.Width:= image1.Width;
    end;

  if(obr <> nil) and (obr.pic.Height*pixelA <= image1.height) then
  scrollbar2.Visible := false else
    begin
    scrollbar2.Visible := true;
    scrollbar2.height := image1.height;
    end;

  renderDudPic(obr);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  renderDudPic(obr);
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  image1.Left := -scrollbar1.Position;
  renderDudPic(obr);
end;

{TForm1 End}
end.

