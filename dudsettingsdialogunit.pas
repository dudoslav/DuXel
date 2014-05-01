unit DudSettingsDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, DudUnit;

type

  { TDudSettingsDialog }

  TDudSettingsDialog = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
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

procedure TDudSettingsDialog.Button1Click(Sender: TObject);
begin
  DudUnit.pixelA:= strtoint(Edit1.text);
end;

end.

