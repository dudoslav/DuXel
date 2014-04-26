unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus, DudUnit,
  ExtCtrls, DudDialogManagerUnit;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    FileMenuItem: TMenuItem;
    SaveFileMenuItem: TMenuItem;
    OpenFileMenuItem: TMenuItem;
    NewFileMenuItem: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure FileMenuItemClick(Sender: TObject);
    procedure NewFileMenuItemClick(Sender: TObject);
    procedure OpenFileMenuItemClick(Sender: TObject);
    procedure SaveFileMenuItemClick(Sender: TObject);
  private
    obr: TDudPic;
    pixelA: integer;
    DialogManager: TDudDialogManager;
    procedure RenderDudPic(picture: TDudPic);
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
  if (picture <> nil) then
  begin
    for i := 0 to picture.getPicWidth() do
      for j := 0 to picture.getPicHeight() do
      begin
        //image1.canvas.pen.color := picture.getPicPixel(i,j);
        image1.canvas.brush.color := picture.getPicPixel(i, j);
        image1.canvas.rectangle(i * pixelA, j * pixelA, i * pixelA + pixelA, j * pixelA + pixelA);
      end;
  end
  else
    ShowMessage('Null Pointer Exception: obr>TDudPic is not created');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  pixelA := 30;
  DialogManager := TDudDialogManager.Create;
end;

procedure TForm1.FileMenuItemClick(Sender: TObject);
begin
  PopupMenu1.PopUp;
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

end.
