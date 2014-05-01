unit DudToolsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, DudUnit;

type

  TTool = class
  private

  public
    procedure Draw();
  end;

  TPen = class(TTool)
  private

  public
    procedure Draw(x, y: integer; argCanvas: TCanvas; var picture: TDudPic);
  end;

  { TDudTools }

  TDudTools = class(TForm)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

    useColor: Tcolor;
    useTool: integer;
  public
    tools: array [0..1] of TTool;
    function getTool(): TTool;
  end;

var
  DudTools: TDudTools;

implementation

{$R *.lfm}

{TTool begin}

procedure TTool.Draw();
begin

end;

{TTool begin}

{TPen begin}

procedure TPen.Draw(x, y: integer; argCanvas: TCanvas; var picture: TDudPic);
begin
  picture.setPicPixel(x div 30, y div 30, clblack);
  argcanvas.brush.color := clBlack;
  argcanvas.rectangle(x div 30 * 30, y div 30 * 30, x div 30 * 30 +
    30, y div 30 * 30 + 30);
  ShowMessage('ide');
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

  tools[0] := TPen.Create;
end;

procedure TDudTools.BitBtn1Click(Sender: TObject);
begin
  useTool := 0;
end;

{TDudTools end}

end.
