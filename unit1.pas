unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, LCLType, Controls, Graphics,
  Dialogs, Menus, DudUnit,
  ExtCtrls, DudDialogManagerUnit, DudToolsUnit, DudHistoryManagerUnit, types;

type

  TMouse = record
    x, y: integer;
    shift: TShiftState;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    FileMenuItem: TMenuItem;
    SaveCurrentCanvasManuItem: TMenuItem;
    TilesViewerMenuItem: TMenuItem;
    SettingsMenuItem: TMenuItem;
    NewFileMenuItem: TMenuItem;
    SaveFileMenuItem: TMenuItem;
    OpenFileMenuItem: TMenuItem;
    ToolsMenuItem: TMenuItem;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure Image1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure Image1Resize(Sender: TObject);
    procedure SaveCurrentCanvasManuItemClick(Sender: TObject);
    procedure SettingsMenuItemClick(Sender: TObject);
    procedure TilesViewerMenuItemClick(Sender: TObject);
    procedure NewFileMenuItemClick(Sender: TObject);
    procedure OpenFileMenuItemClick(Sender: TObject);
    procedure SaveFileMenuItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    keys: array[word] of boolean;
    obr: TDudPic;
    DialogManager: TDudDialogManager;
    HistoryManager: TDudHistoryManager;
    Tools: TDudTools;
    Mouse: TMouse;
    procedure ResizeImage();
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
    image1.Picture.bitmap.SetSize(obr.getPicWidth() * pixelA,
      obr.getPicHeight() * pixelA);
    image1.Width := image1.Picture.Bitmap.Width;
    image1.Height := image1.Picture.Bitmap.Height;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  randomize;
  DoubleBuffered := True;

  pixelA := 30;
  WireFrame := False;

  DialogManager := TDudDialogManager.Create;
  HistoryManager := TDudHistoryManager.Create;
  Tools := TDudTools.Create(nil);

  //writeln('ide');
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if (shift = [ssleft]) and (obr <> nil) then
  begin
    HistoryManager.addLastPastPicture(obr.getPic().Bitmap);
    mouse.shift := shift;
    mouse.x := x;
    mouse.y := y;
    Tools.getTool().OnMouseDown(mouse.x, mouse.y, tools.useColor1, image1.canvas, obr);
    timer1.Interval := tools.getTool().settings.Frequecy;
    timer1.Enabled := True;
  end;

  if (shift = [ssright]) and (obr <> nil) then
  begin
    HistoryManager.addLastPastPicture(obr.getPic().Bitmap);
    mouse.shift := shift;
    mouse.x := x;
    mouse.y := y;
    Tools.getTool().OnMouseDown(mouse.x, mouse.y, tools.useColor2, image1.canvas, obr);
    timer1.Interval := tools.getTool().settings.Frequecy;
    timer1.Enabled := True;
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  Tools.Label5.Caption := 'x : ' + IntToStr(x div pixelA);
  Tools.Label6.Caption := 'y : ' + IntToStr(y div pixelA);

  if (shift = [ssleft]) and (obr <> nil) then
  begin
    mouse.shift := shift;
    mouse.x := x;
    mouse.y := y;
    Tools.getTool().OnMouseMove(mouse.x, mouse.y, tools.useColor1, image1.canvas, obr);
    //DialogManager.RenderTilesViewerDialog(obr);
  end;

  if (shift = [ssright]) and (obr <> nil) then
  begin
    mouse.shift := shift;
    mouse.x := x;
    mouse.y := y;
    Tools.getTool().OnMouseMove(mouse.x, mouse.y, tools.useColor2, image1.canvas, obr);
    //DialogManager.RenderTilesViewerDialog(obr);
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if (mouse.shift = [ssleft]) and (obr <> nil) then
  begin
    mouse.x := x;
    mouse.y := y;
    timer1.Enabled := False;
    Tools.getTool().OnMouseUp(mouse.x, mouse.y, tools.useColor1, image1.canvas, obr);
    DialogManager.RenderTilesViewerDialog(obr);
  end;

  if (mouse.shift = [ssright]) and (obr <> nil) then
  begin
    mouse.x := x;
    mouse.y := y;
    timer1.Enabled := False;
    Tools.getTool().OnMouseUp(mouse.x, mouse.y, tools.useColor2, image1.canvas, obr);
    DialogManager.RenderTilesViewerDialog(obr);
  end;
end;

procedure TForm1.Image1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: boolean);
begin
  if keys[VK_CONTROL] then
  begin
    if (pixelA > 2) and (obr <> nil) then
    begin
      pixelA := pixelA - 1;
      ResizeImage();
      obr.render(image1.canvas);
    end;
  end
  else
    VertScrollBar.Position := VertScrollBar.Position + VertScrollBar.Range div 20;

end;

procedure TForm1.Image1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: boolean);
begin
  if keys[VK_CONTROL] then
  begin
    if (obr <> nil) then
    begin
      pixelA := pixelA + 1;
      ResizeImage();
      obr.render(image1.canvas);
    end;
  end
  else
    VertScrollBar.Position := VertScrollBar.Position - VertScrollBar.Range div 20;

end;

procedure TForm1.Image1Resize(Sender: TObject);
begin
  //ResizeImage();
  if obr <> nil then
    obr.render(image1.canvas);
end;

procedure TForm1.SaveCurrentCanvasManuItemClick(Sender: TObject);
var
  nowDudPic: TDudPic;
begin
  if obr <> nil then
  begin
    nowDudPic := TDudPic.Create(image1.Picture.Bitmap.Width,
      image1.Picture.Bitmap.Height);
    nowDudPic.setPic(image1.Picture);
    DialogManager.UseSaveFileDialog(nowDudPic);
  end;
end;

procedure TForm1.SettingsMenuItemClick(Sender: TObject);
begin
  DialogManager.UseSettingsDialog();
  if obr <> nil then
  begin
    obr.render(image1.canvas);
    ResizeImage();
  end;
end;

procedure TForm1.TilesViewerMenuItemClick(Sender: TObject);
begin
  if obr <> nil then
    DialogManager.UseTilesViewerDialog(obr)
  else
    ShowMessage('there is no image to tile');
end;

procedure TForm1.NewFileMenuItemClick(Sender: TObject);
begin
  obr := DialogManager.UseNewFileDialog();
  if obr <> nil then
  begin
    obr.render(image1.canvas);
    ResizeImage();
    Tools.Show;
    HistoryManager.addLastPastPicture(obr.getPic().Bitmap);
  end;
end;

procedure TForm1.OpenFileMenuItemClick(Sender: TObject);
begin
  obr := DialogManager.UseOpenFileDialog();
  if obr <> nil then
  begin
    obr.render(image1.canvas);
    ResizeImage();
    Tools.Show;
    HistoryManager.addLastPastPicture(obr.getPic().Bitmap);
  end;
end;

procedure TForm1.SaveFileMenuItemClick(Sender: TObject);
begin
  DialogManager.UseSaveFileDialog(obr);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (mouse.shift = [ssleft]) and (obr <> nil) then
  begin
    Tools.getTool().onTimerDo(mouse.x, mouse.y, tools.useColor1, image1.canvas, obr);
    tools.ColorButton1.ButtonColor := Tools.useColor1;
  end;

  if (mouse.shift = [ssright]) and (obr <> nil) then
  begin
    Tools.getTool().onTimerDo(mouse.x, mouse.y, tools.useColor2, image1.canvas, obr);
    tools.ColorButton2.ButtonColor := Tools.useColor2;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  tools.Free;
  obr.Free;
  DialogManager.Free;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  keys[key] := True;

  if (keys[VK_Z]) and (keys[VK_CONTROL]) and (obr <> nil) then
  begin
    obr.getPic().Bitmap := HistoryManager.getLastPastPicture(obr.getPic().Bitmap);
    obr.render(image1.canvas);
  end;

  if (keys[VK_Y]) and (keys[VK_CONTROL]) and (obr <> nil) then
  begin
    obr.getPic().Bitmap := HistoryManager.getLastFuturePicture(obr.getPic().Bitmap);
    obr.render(image1.canvas);
  end;

  if (keys[VK_B]) and (keys[VK_CONTROL]) and (obr <> nil) then
  begin
    Tools.setTool(BRUSH_TOOL);
  end;

  if (keys[VK_R]) and (keys[VK_CONTROL]) and (obr <> nil) then
  begin
    Tools.setTool(RECTANGLE_TOOL);
  end;

  if (keys[VK_E]) and (keys[VK_CONTROL]) and (obr <> nil) then
  begin
    Tools.setTool(ERASER_TOOL);
  end;

end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  keys[key] := False;
end;

procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: boolean);
begin
  if keys[VK_CONTROL] then
  begin
    if (pixelA > 2) and (obr <> nil) then
    begin
      pixelA := pixelA - 1;
      ResizeImage();
      obr.render(image1.canvas);
    end;
  end
  else
    VertScrollBar.Position := VertScrollBar.Position + VertScrollBar.Range div 20;

end;

procedure TForm1.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: boolean);
begin
  if keys[VK_CONTROL] then
  begin
    if (obr <> nil) then
    begin
      pixelA := pixelA + 1;
      ResizeImage();
      obr.render(image1.canvas);
    end;
  end
  else
    VertScrollBar.Position := VertScrollBar.Position - VertScrollBar.Range div 20;

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if (MessageDlg('Warning', 'Are you sure you want to quit',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes) then
    CloseAction := caNone;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin

end;

end.
