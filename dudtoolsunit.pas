unit DudToolsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  Buttons, StdCtrls, Spin, Math, DudUnit;

type

  TToolSettings = record
    Radius : integer;
  end;

  TTool = class
  public
    settings : TToolSettings;
    procedure Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); virtual; abstract;
  end;

  TPen = class(TTool)
  public
    constructor Create(argRadius: integer);
    procedure Draw(x, y: integer; color: TColor; argCanvas: TCanvas;
      var picture: TDudPic); override;
  end;

  { TDudTools }

  TDudTools = class(TForm)
    BitBtn1: TBitBtn;
    ColorButton1: TColorButton;
    SpinEdit1: TSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    useTool: integer;
    useColor: Tcolor;
  public
    tools: array [0..0] of TTool;
    function getTool(): TTool;
    function getColor(): TColor;
  end;

var
  DudTools: TDudTools;

implementation

{$R *.lfm}

{TTool begin}

{TTool end}

{TPen begin}

constructor TPen.Create(argRadius: integer);
begin
  settings.Radius := argRadius;
end;

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
        picture.setPicPixel(x div DudUnit.pixelA+i, y div
          DudUnit.pixelA+ j, color);
        argcanvas.brush.color := color;
        argcanvas.rectangle(x div DudUnit.pixelA * DudUnit.pixelA + i*DudUnit.pixelA, y div
          DudUnit.pixelA * DudUnit.pixelA + j*DudUnit.pixelA, x div DudUnit.pixelA * DudUnit.pixelA +
          DudUnit.pixelA+ i*DudUnit.pixelA, y div DudUnit.pixelA * DudUnit.pixelA + DudUnit.pixelA + j*DudUnit.pixelA);
      end;
    end;
end;

{TPen end}

{TDudTools begin}

function TDudTools.getTool(): TTool;
begin
  Result := tools[useTool];
end;

procedure TDudTools.FormCreate(Sender: TObject);
begin
  useTool := 0;
  useColor := clblack;

  tools[0] := TPen.Create(2);
end;

procedure TDudTools.SpinEdit1Change(Sender: TObject);
begin
  tools[0].settings.Radius := SpinEdit1.Value;
end;

procedure TDudTools.BitBtn1Click(Sender: TObject);
begin
  useTool := 0;
end;

function TDudTools.getColor(): TColor;
begin
  Result := useColor;
end;

procedure TDudTools.ColorButton1ColorChanged(Sender: TObject);
begin
  useColor := ColorButton1.ButtonColor;
end;


{TDudTools end}

end.
