unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, LCLType,
  ExtCtrls, Menus, StdCtrls, Math, Windows, Unit2, DudUnit;

type

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
    procedure CreatePic(argWidth,argHeight : integer);
  private
    pixelA : integer;
  public
    procedure renderDudPic(picture : TDudPic);
  end;

var
  Form1: TForm1;
  obr: TDudPic;
implementation

{$R *.lfm}

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
  obr := TDudPic.Create(16,16);
  pixelA := 60;
  //renderDudPic(obr);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if(obr <> nil) and (obr.getPicWidth()*pixelA <= image1.width) then
  scrollbar1.Visible := false else
    begin
    scrollbar1.Visible := true;
    scrollbar1.Width:= image1.Width;
    end;

  if(obr <> nil) and (obr.getPicHeight()*pixelA <= image1.height) then
  scrollbar2.Visible := false else
    begin
    scrollbar2.Visible := true;
    scrollbar2.height := image1.height;
    end;

  //renderDudPic(obr);
end;

procedure TForm1.CreatePic(argWidth,argHeight : integer);
begin
  obr := TDuDPic.Create(argwidth,argheight);
  image1.width := argwidth*pixelA;
  image1.height := argheight*pixelA;
  image1.Picture.Bitmap.SetSize(width*pixelA,height*pixelA);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var
  form2 : TForm2;
begin
  //creatni okno
  form2 := TForm2.Create(Self);
  form2.Init(obr);
  //okno.Visible:=true;
  form2.Show;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  image1.Left := -scrollbar1.Position;
  renderDudPic(obr);
end;

{TForm1 End}
end.

