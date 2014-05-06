unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, LCLType, Controls, Graphics,
  Dialogs, Menus, DudUnit,
  ExtCtrls, DudDialogManagerUnit, DudToolsUnit, DudHistoryManagerUnit;

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
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FileMenuItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1Resize(Sender: TObject);
    procedure SettingsMenuItemClick(Sender: TObject);
    procedure NewFileMenuItemClick(Sender: TObject);
    procedure OpenFileMenuItemClick(Sender: TObject);
    procedure SaveFileMenuItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    obr: TDudPic;
    DialogManager: TDudDialogManager;
    HistoryManager: TDudHistoryManager;
    Tools: TDudTools;
    Mouse: TPoint;
    procedure ResizeImage();
    procedure RenderPixel(xPic, yPic: integer; argColor: TColor);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ResizeImage();
var
  i, j: integer;
begin
  if (obr <> nil) then
  begin
    image1.Picture.bitmap.SetSize(obr.getPicWidth() * pixelA, obr.getPicHeight() * pixelA);
    image1.Width := image1.Picture.Bitmap.Width;
    image1.Height := image1.Picture.Bitmap.Height;
  end;
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
  HistoryManager := TDudHistoryManager.Create;
  Tools := TDudTools.Create(nil);
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
    mouse.x := x;
    mouse.y := y;
    HistoryManager.addLastPicture(obr.getPic().Bitmap);
    timer1.Interval := tools.getTool().settings.Frequecy;
    timer1.Enabled := True;
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if shift = [ssleft] then
  begin
    mouse.x := x;
    mouse.y := y;
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  mouse.x := x;
  mouse.y := y;
  timer1.Enabled := False;
end;

procedure TForm1.Image1Resize(Sender: TObject);
begin
  ResizeImage();
  if obr <> nil then
    obr.render(image1.canvas);
end;

procedure TForm1.SettingsMenuItemClick(Sender: TObject);
begin
  DialogManager.UseSettingsDialog();
  obr.render(image1.canvas);
  ResizeImage();
end;

procedure TForm1.NewFileMenuItemClick(Sender: TObject);
begin
  obr := DialogManager.UseNewFileDialog();
  obr.render(image1.canvas);
  ResizeImage();
  Tools.Show;
  HistoryManager.addLastPicture(obr.getPic().Bitmap);
end;

procedure TForm1.OpenFileMenuItemClick(Sender: TObject);
begin
  obr := DialogManager.UseOpenFileDialog();
  obr.render(image1.canvas);
  ResizeImage();
  Tools.Show;
  HistoryManager.addLastPicture(obr.getPic().Bitmap);
end;

procedure TForm1.SaveFileMenuItemClick(Sender: TObject);
begin
  DialogManager.UseSaveFileDialog(obr);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  tools.getTool().Draw(mouse.x, mouse.y, tools.useColor, image1.canvas, obr);
  tools.ColorButton1.ButtonColor := Tools.getColor();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  tools.Free;
  obr.Free;
  //DialogManager.Free;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = VK_Z then
  begin
    obr.getPic().Bitmap := HistoryManager.getLastPicture();
    obr.render(image1.canvas);
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

end.
