unit DudTextDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, DudUnit;

type

  { TDudTextDialog }

  TDudTextDialog = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    SpinEdit1: TSpinEdit;
    procedure Button1Click(Sender: TObject);
  private
    textsettings: TTextsettings;
    { private declarations }
  public
    { public declarations }
    function getTextSettings(): TTextSettings;
  end;

var
  DudTextDialog: TDudTextDialog;

implementation

{$R *.lfm}

{ TDudTextDialog }

function TDudTextDialog.getTextSettings(): TTextSettings;
begin
  Result := textsettings;
end;

procedure TDudTextDialog.Button1Click(Sender: TObject);
begin
  textsettings.Text := edit1.Text;
  textsettings.size := SpinEdit1.Value;
  Close;
end;

end.

