unit DudToolsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  Buttons, StdCtrls, Spin, Math, DudUnit;

type

  TToolSettings = record
    Radius: integer;
    Frequecy: integer;
  end;

  TTool = class
  public
    settings: TToolSettings;
    constructor Create(argRadius: integer; argFrequency: integer);
    procedure Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); virtual; abstract;
  end;

  TEraser = class(TTool)
    procedure Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  TPen = class(TTool)
  public
    procedure Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  TBucket = class(TTool)
  public
    procedure Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  { TDudTools }

  TDudTools = class(TForm)
    ColorButton1: TColorButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
  private
    useTool: integer;
    useColor: TColor;
  public
    tools: array [0..1] of TTool;
    function getTool(): TTool;
    function getColor(): TColor;
  end;

var
  DudTools: TDudTools;

implementation

{$R *.lfm}

{TTool begin}

constructor TTool.Create(argRadius: integer; argFrequency: integer);
begin
  settings.Radius := argRadius;
  settings.Frequecy := argFrequency;
end;

{TTool end}

{TEraser begin}

procedure TEraser.Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
  var picture: TDudPic);
var
  i, j: integer;
begin
  for i := -settings.Radius to settings.Radius do
    for j := -settings.Radius to settings.Radius do
    begin
      if (sqrt(sqr(i) + sqr(j)) <= settings.Radius) then
      begin
        picture.setPicPixel(x div DudUnit.pixelA + i, y div
          DudUnit.pixelA + j, clwhite);
        argcanvas.brush.color := clwhite;
        argcanvas.pen.color := color;
        argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA +
          i * DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA +
          j * DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
          DudUnit.pixelA + i * DudUnit.pixelA, y div DudUnit.pixelA *
          DudUnit.pixelA + DudUnit.pixelA + j * DudUnit.pixelA);
      end;
    end;
end;

{TEraser end}

{TPen begin}

procedure TPen.Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
  var picture: TDudPic);
var
  i, j: integer;
begin
  for i := -settings.Radius to settings.Radius do
    for j := -settings.Radius to settings.Radius do
    begin
      if (sqrt(sqr(i) + sqr(j)) <= settings.Radius) then
      begin
        picture.setPicPixel(x div DudUnit.pixelA + i, y div
          DudUnit.pixelA + j, color);
        argcanvas.brush.color := color;
        argcanvas.pen.color := color;
        argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA +
          i * DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA +
          j * DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
          DudUnit.pixelA + i * DudUnit.pixelA, y div DudUnit.pixelA *
          DudUnit.pixelA + DudUnit.pixelA + j * DudUnit.pixelA);
      end;
    end;
end;

{TPen end}

{TBucket begin}

procedure TBucket.Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
  var picture: TDudPic);
begin
  picture.getPic().BitMap.Canvas.Brush.color := color;
  picture.getPic().Bitmap.Canvas.FloodFill(x div DudUnit.pixelA, y div
    DudUnit.pixelA, picture.getPicPixel(x div DudUnit.pixelA, y div DudUnit.pixelA),
    fsSurface);
  picture.render(argcanvas);
end;

{TBucket end}

{TDudTools begin}

function TDudTools.getTool(): TTool;
begin
  Result := tools[useTool];
end;

procedure TDudTools.FormCreate(Sender: TObject);
begin
  useTool := 1;
  useColor := clblack;

  tools[0] := TEraser.Create(0, 10);
  tools[1] := TPen.Create(0, 10);
  tools[2] := TBucket.Create(0, 10);
end;

procedure TDudTools.SpinEdit1Change(Sender: TObject);
begin
  tools[1].settings.Radius := SpinEdit1.Value;
end;

procedure TDudTools.SpinEdit2Change(Sender: TObject);
begin
  tools[0].settings.Radius := SpinEdit2.Value;
end;

procedure TDudTools.SpinEdit3Change(Sender: TObject);
begin
  tools[1].settings.Frequecy := SpinEdit3.Value;
end;

procedure TDudTools.SpinEdit4Change(Sender: TObject);
begin
  tools[0].settings.Frequecy := SpinEdit3.Value;
end;

procedure TDudTools.SpeedButton1Click(Sender: TObject);
begin
  useTool := 1;
end;

procedure TDudTools.SpeedButton2Click(Sender: TObject);
begin
  useTool := 0;
end;

procedure TDudTools.SpeedButton3Click(Sender: TObject);
begin
  useTool := 2;
end;

function TDudTools.getColor(): TColor;
begin
  Result := useColor;
end;

procedure TDudTools.ColorButton1ColorChanged(Sender: TObject);
begin
  useColor := ColorButton1.ButtonColor;
end;

procedure TDudTools.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to length(tools)-1 do
      begin
        tools[i].free;
      end;
  {ColorButton1.Destroy;
  SpeedButton1.Destroy;
  SpeedButton2.Destroy;
  SpeedButton3.Destroy;}
end;


{TDudTools end}

end.
