unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, DudUnit;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    obr : TDudPic;
  public
    procedure Init(var argObr : TDudPic);
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Init(var argObr : TDudPic);
begin
obr := argObr;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
obr := TDudPic.Create(strtoint(Edit1.text),strtoint(Edit2.text));
self.Destroy;
end;

end.

