unit DudSettingsDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, DudUnit;

type

  { TDudSettingsDialog }

  TDudSettingsDialog = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Init();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DudSettingsDialog: TDudSettingsDialog;

implementation

{$R *.lfm}

{ TDudSettingsDialog }

procedure TDudSettingsDialog.Init();
begin
CheckBox1.Checked := WireFrame;
SpinEdit1.Value := PixelA;
end;

procedure TDudSettingsDialog.Button1Click(Sender: TObject);
begin
  DudUnit.pixelA:= SpinEdit1.Value;
end;

procedure TDudSettingsDialog.CheckBox1Click(Sender: TObject);
begin
  WireFrame:= CheckBox1.Checked;
end;

end.

