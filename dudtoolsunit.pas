unit DudToolsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  Buttons, StdCtrls, Spin, Math, DudUnit, DudDialogManagerUnit;

type

  TToolSettings = record
    Radius: integer;
    Frequecy: integer;
    oldX: integer;
    oldy: integer;
  end;

  TTool = class
  public
    settings: TToolSettings;
    constructor Create(argRadius: integer; argFrequency: integer);
    procedure OnMouseDown(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); virtual;
    procedure OnMouseMove(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); virtual;
    procedure OnMouseUp(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); virtual;
    procedure onTimerDo(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); virtual;
  end;

  TEraser = class(TTool)
    procedure OnMouseMove(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  TPen = class(TTool)
  public
    procedure OnMouseDown(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
    procedure OnMouseMove(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  TBrush = class(TTool)
  public
    procedure OnTimerDO(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  TBucket = class(TTool)
  public
    procedure OnMouseDown(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  TColorPicker = class(TTool)
  public
    procedure OnMouseDown(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  TText = class(TTool)
  public
    procedure OnMouseDown(x, y: integer; var color: TColor;
      argCanvas: TCanvas; var picture: TDudPic); override;
  end;

  TNoiseGenerator = class(TTool)
  public
    procedure OnMouseDown(x, y: integer; var color: TColor;
      argCanvas: TCanvas; var picture: TDudPic); override;
  end;

  TSmoothTool = class(TTool)
    public
      procedure OnMouseMove(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  { TDudTools }

  TDudTools = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    ColorButton1: TColorButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
  private
    useTool: integer;
  public
    useColor: TColor;
    tools: array [0..7] of TTool;
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

procedure TTool.OnMouseDown(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
begin

end;

procedure TTool.OnMouseMove(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
begin

end;

procedure TTool.OnMouseUp(x, y: integer; var color: TColor; argCanvas: TCanvas;
  var picture: TDudPic);
begin

end;

procedure TTool.onTimerDo(x, y: integer; var color: TColor; argCanvas: TCanvas;
  var picture: TDudPic);
begin

end;

{TTool end}

{TEraser begin}
procedure TEraser.OnMouseMove(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
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
        argcanvas.pen.color := clwhite;
        argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA +
          i * DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA +
          j * DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
          DudUnit.pixelA + i * DudUnit.pixelA, y div DudUnit.pixelA *
          DudUnit.pixelA + DudUnit.pixelA + j * DudUnit.pixelA);
      end;
    end;
end;

{TEraser end}

{TBrush begin}

procedure TBrush.OnTimerDo(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
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
        //argCanvas.Pixels[x div pixelA,y div pixelA] := color;
        argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA +
          i * DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA +
          j * DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
          DudUnit.pixelA + i * DudUnit.pixelA, y div DudUnit.pixelA *
          DudUnit.pixelA + DudUnit.pixelA + j * DudUnit.pixelA);
      end;
    end;
end;

{TBrush end}

{TBucket begin}

procedure TBucket.OnMouseDown(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
begin
  picture.getPic().BitMap.Canvas.Brush.color := color;
  picture.getPic().Bitmap.Canvas.FloodFill(x div DudUnit.pixelA, y div
    DudUnit.pixelA, picture.getPicPixel(x div DudUnit.pixelA, y div DudUnit.pixelA),
    fsSurface);
  picture.render(argcanvas);
end;

{TBucket end}

{TColorPicker begin}

procedure TColorPicker.OnMouseDown(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
begin
  color := picture.getPicPixel(x div pixelA, y div pixelA);
end;

{TColorPicker end}

{TPen begin}

procedure TPen.OnMouseDown(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
begin
  settings.oldX := x;
  settings.oldY := y;
  picture.setPicPixel(x div DudUnit.pixelA, y div DudUnit.pixelA, color);
  argcanvas.brush.color := color;
  argcanvas.pen.color := color;
  argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA, y div
    DudUnit.pixelA * DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
    DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA +
    DudUnit.pixelA);
end;

procedure TPen.OnMouseMove(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
begin
  picture.getPic().bitmap.canvas.pen.Color := color;
  picture.getPic().bitmap.canvas.MoveTo(settings.oldX div pixelA,
    settings.oldY div pixelA);
  picture.getPic().bitmap.canvas.LineTo(x div pixelA, y div pixelA);
  settings.oldX := x;
  settings.oldY := y;
  argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA, y div
    DudUnit.pixelA * DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
    DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA +
    DudUnit.pixelA);
end;

{TPen end}

{TText begin}

procedure TText.OnMouseDown(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
var
  DialogManager: TDudDialogManager;
  TextSettings: TTextSettings;
begin
  DialogManager := TDudDialogManager.Create();
  TextSettings := DialogManager.UseTextDialog();
  picture.getPic().Bitmap.canvas.Font.Size := TextSettings.size;
  picture.getPic().Bitmap.canvas.TextOut(x div pixelA, y div pixelA, TextSettings.Text);
  picture.render(argCanvas);
end;

{TText end}

{TNoiseGenerator begin}

procedure TNoiseGenerator.OnMouseDown(x, y: integer; var color: TColor;
  argCanvas: TCanvas; var picture: TDudPic);
var
  DialogManager: TDudDialogManager;
begin
  DialogManager := TDudDialogManager.Create();
  DialogManager.UseDudNoiseDialog(picture, argcanvas);
end;

{TNoiseGenerator end}

{TSmoothTool begin}

procedure TSmoothTool.OnMouseMove(x, y: integer; var color: TColor; argCanvas: TCanvas;
      var picture: TDudPic);
var
  i,j : integer;
  nowcolor : TColor;
begin
  settings.Radius:= 2;
   for i := -settings.Radius to settings.Radius do
    for j := -settings.Radius to settings.Radius do
    begin
      if (sqrt(sqr(i) + sqr(j)) <= settings.Radius) then
      begin

        nowColor := (picture.getPicPixel(x div DudUnit.pixelA+i+1,y div DudUnit.pixelA+j+1)
        + picture.getPicPixel(x div DudUnit.pixelA+i-1,y div DudUnit.pixelA+j+1)
        + picture.getPicPixel(x div DudUnit.pixelA+i-1,y div DudUnit.pixelA+j-1)
        + picture.getPicPixel(x div DudUnit.pixelA+i+1,y div DudUnit.pixelA+j-1)) div 4;

        picture.setPicPixel(x div DudUnit.pixelA + i, y div
          DudUnit.pixelA + j, nowColor);
        argcanvas.brush.color := nowcolor;
        argcanvas.pen.color := nowcolor;
        argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA +
          i * DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA +
          j * DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
          DudUnit.pixelA + i * DudUnit.pixelA, y div DudUnit.pixelA *
          DudUnit.pixelA + DudUnit.pixelA + j * DudUnit.pixelA);
      end;
    end;
end;

{TSmoothTool end}

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
  tools[1] := TBrush.Create(0, 10);
  tools[2] := TBucket.Create(0, 10);
  tools[3] := TColorPicker.Create(0, 10);
  tools[4] := TPen.Create(0, 10);
  tools[5] := TText.Create(0, 10);
  tools[6] := TNoiseGenerator.Create(0, 10);
  tools[7] := TSmoothTool.Create(0,10);
end;

procedure TDudTools.SpinEdit1Change(Sender: TObject);
begin
  tools[0].settings.Radius := SpinEdit1.Value;
end;

procedure TDudTools.SpinEdit2Change(Sender: TObject);
begin
  tools[1].settings.Radius := SpinEdit2.Value;
end;

procedure TDudTools.SpinEdit3Change(Sender: TObject);
begin
  tools[0].settings.Frequecy := SpinEdit3.Value;
end;

procedure TDudTools.SpinEdit4Change(Sender: TObject);
begin
  tools[1].settings.Frequecy := SpinEdit3.Value;
end;

procedure TDudTools.BitBtn1Click(Sender: TObject);
begin
  useTool := 0;
end;

procedure TDudTools.BitBtn2Click(Sender: TObject);
begin
  useTool := 1;
end;

procedure TDudTools.BitBtn3Click(Sender: TObject);
begin
  useTool := 2;
end;

procedure TDudTools.BitBtn4Click(Sender: TObject);
begin
  useTool := 3;
end;

procedure TDudTools.BitBtn5Click(Sender: TObject);
begin
  useTool := 4;
end;

procedure TDudTools.BitBtn6Click(Sender: TObject);
begin
  useTool := 5;
end;

procedure TDudTools.BitBtn7Click(Sender: TObject);
begin
  useTool := 6;
end;

procedure TDudTools.BitBtn8Click(Sender: TObject);
begin
  useTool := 7;
end;

procedure TDudTools.ColorButton1ColorChanged(Sender: TObject);
begin
  useColor := ColorButton1.ButtonColor;
end;

function TDudTools.getColor(): TColor;
begin
  Result := useColor;
end;

procedure TDudTools.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to length(tools) - 1 do
  begin
    tools[i].Free;
  end;
  {ColorButton1.Destroy;
  SpeedButton1.Destroy;
  SpeedButton2.Destroy;
  SpeedButton3.Destroy;}
end;


{TDudTools end}

end.
