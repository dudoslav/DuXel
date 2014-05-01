unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus, DudUnit,
  ExtCtrls, DudDialogManagerUnit, DudToolsUnit;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    FileMenuItem: TMenuItem;
    SettingsMenuItem: TMenuItem;
    SaveFileMenuItem: TMenuItem;
    OpenFileMenuItem: TMenuItem;
    NewFileMenuItem: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure FileMenuItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure SettingsMenuItemClick(Sender: TObject);
    procedure NewFileMenuItemClick(Sender: TObject);
    procedure OpenFileMenuItemClick(Sender: TObject);
    procedure SaveFileMenuItemClick(Sender: TObject);
  private
    obr: TDudPic;
    DialogManager: TDudDialogManager;
    Tools: TDudTools;
    procedure RenderDudPic(picture: TDudPic);
    procedure RenderPixel(xPic, yPic: integer; argColor: TColor);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.RenderDudPic(picture: TDudPic);
var
  i, j: integer;
begin
  image1.Width:= obr.getPic().Width*pixelA;
  image1.Height:= obr.getPic().Height*pixelA;
  if (picture <> nil) then
  begin
    for i := 0 to picture.getPicWidth() - 1 do
      for j := 0 to picture.getPicHeight() - 1 do
      begin
        image1.canvas.pen.color := picture.getPicPixel(i,j);
        image1.canvas.brush.color := picture.getPicPixel(i, j);
        image1.canvas.rectangle(i * pixelA, j * pixelA, i * pixelA +
          pixelA, j * pixelA + pixelA);
      end;
  end
  else
    ShowMessage('Null Pointer Exception: obr>TDudPic is not created');
end;

procedure TForm1.RenderPixel(xPic, yPic: integer; argColor: TColor);
begin
  image1.canvas.pen.color := argColor;
  image1.canvas.brush.color := argColor;
  image1.canvas.rectangle(xPic * pixelA, yPic * pixelA, xPic * pixelA +
    pixelA, yPic * pixelA + pixelA);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  pixelA := 30;
  DialogManager := TDudDialogManager.Create;
  Tools := TDudTools.Create(nil);
  Tools.Show;
end;

procedure TForm1.FileMenuItemClick(Sender: TObject);
begin
  PopupMenu1.PopUp;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if shift = [ssleft] then
     begin
     tools.getTool().Draw(x,y,tools.getColor(),image1.canvas,obr);
     end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if shift = [ssleft] then
     begin
     tools.getTool().Draw(x,y,tools.getColor(),image1.canvas,obr);
     end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if shift = [ssleft] then
     begin
     tools.getTool().Draw(x,y,tools.getColor(),image1.canvas,obr);
     end;
end;

procedure TForm1.SettingsMenuItemClick(Sender: TObject);
begin
  DialogManager.UseSettingsDialog();
  RenderDudPic(obr);
end;

procedure TForm1.NewFileMenuItemClick(Sender: TObject);
begin
  obr := DialogManager.UseNewFileDialog();
  RenderDudPic(obr);
end;

procedure TForm1.OpenFileMenuItemClick(Sender: TObject);
begin
  obr := DialogManager.UseOpenFileDialog();
  RenderDudPic(obr);
end;

procedure TForm1.SaveFileMenuItemClick(Sender: TObject);
begin
  DialogManager.UseSaveFileDialog(obr);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  tools.free;
end;

end.
