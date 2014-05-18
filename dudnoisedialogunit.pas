unit DudNoiseDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Math, Graphics, Dialogs,
  StdCtrls, Spin, ExtCtrls, DudUnit;

type

  { TDudNoiseDialog }

  TDudNoiseDialog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
  private
    thisCanvas: TCanvas;
    thisPicture: TDudPic;
    { private declarations }
  public
    { public declarations }
    procedure Init(var picture: TDudPic; argCanvas: TCanvas);
  end;

var
  DudNoiseDialog: TDudNoiseDialog;

implementation

{$R *.lfm}

{ TDudNoiseDialog }
procedure TDudNoiseDialog.Init(var picture: TDudPic; argCanvas: TCanvas);
begin
  thisCanvas := argCanvas;
  thisPicture := picture;
end;

procedure TDudNoiseDialog.Button1Click(Sender: TObject);
var
  i, j: integer;
  nowColor: TColor;
begin
  for i := 0 to thisPicture.getPicWidth() - 1 do
    for j := 0 to thisPicture.getPicHeight() - 1 do
    begin
      nowColor := RGBtoColor(round(sin(i * j) * SpinEdit1.Value),
        round(sin(i * j) * SpinEdit2.Value), round(sin(i * j) * SpinEdit3.Value));
      thisPicture.setPicPixel(i, j, nowColor);
    end;
  thisPicture.render(thisCanvas);
end;

procedure TDudNoiseDialog.Button2Click(Sender: TObject);
var
  i, j: integer;
  nowColor: TColor;
begin
  for i := 0 to thisPicture.getPicWidth() - 1 do
    for j := 0 to thisPicture.getPicHeight() - 1 do
    begin
      nowColor := RGBtoColor(round(sin(i * j) * SpinEdit1.Value),
        round(tan(i * j) * SpinEdit2.Value), round(sin(i * j) * SpinEdit3.Value));
      thisPicture.setPicPixel(i, j, nowColor);
    end;
  thisPicture.render(thisCanvas);
end;

procedure TDudNoiseDialog.Button3Click(Sender: TObject);
var
  i, j: integer;
  nowColor: TColor;
begin
  for i := 0 to thisPicture.getPicWidth() - 1 do
    for j := 0 to thisPicture.getPicHeight() - 1 do
    begin
      nowColor := RGBtoColor(Random(SpinEdit1.Value), Random(SpinEdit2.Value),
        Random(SpinEdit3.Value));
      thisPicture.setPicPixel(i, j, nowColor);
    end;
  thisPicture.render(thisCanvas);
end;

procedure TDudNoiseDialog.Button4Click(Sender: TObject);
var
  i, j: integer;
  nowColor: TColor;
begin
  for i := 0 to thisPicture.getPicWidth() - 1 do
    for j := 0 to thisPicture.getPicHeight() - 1 do
    begin
      nowColor := RGBtoColor(i * j mod (SpinEdit1.Value + 1), i *
        j mod (SpinEdit2.Value + 1), i * j mod (SpinEdit3.Value + 1));
      thisPicture.setPicPixel(i, j, nowColor);
    end;
  thisPicture.render(thisCanvas);
end;

procedure TDudNoiseDialog.Button5Click(Sender: TObject);
var
  i, j: integer;
  nowColor: TColor;
begin
  for i := 0 to thisPicture.getPicWidth() - 1 do
    for j := 0 to thisPicture.getPicHeight() - 1 do
    begin
      nowColor := RGBtoColor(SpinEdit1.Value - abs(
        (i - (thisPicture.getPicWidth() div 2)) * (j - (thisPicture.getPicHeight()) div 2)),
        SpinEdit2.Value - abs((i - (thisPicture.getPicWidth() div 2)) *
        (j - (thisPicture.getPicHeight()) div 2)), SpinEdit3.Value - abs(
        (i - (thisPicture.getPicWidth() div 2)) * (j - (thisPicture.getPicHeight()) div 2)));
      thisPicture.setPicPixel(i, j, nowColor);
    end;
  thisPicture.render(thisCanvas);
end;


procedure TDudNoiseDialog.ScrollBar1Change(Sender: TObject);
begin
  SpinEdit1.Value := ScrollBar1.Position;
  image1.canvas.brush.color := RGBtoColor(SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value);
  image1.canvas.pen.color := RGBtoColor(SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value);
  image1.canvas.Rectangle(0,0,image1.Width,image1.Height);
end;

procedure TDudNoiseDialog.ScrollBar2Change(Sender: TObject);
begin
  SpinEdit2.Value := ScrollBar2.Position;
  image1.canvas.brush.color := RGBtoColor(SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value);
  image1.canvas.pen.color := RGBtoColor(SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value);
  image1.canvas.Rectangle(0,0,image1.Width,image1.Height);
end;

procedure TDudNoiseDialog.ScrollBar3Change(Sender: TObject);
begin
  SpinEdit3.Value := ScrollBar3.Position;
  image1.canvas.brush.color := RGBtoColor(SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value);
  image1.canvas.pen.color := RGBtoColor(SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value);
  image1.canvas.Rectangle(0,0,image1.Width,image1.Height);
end;

end.
