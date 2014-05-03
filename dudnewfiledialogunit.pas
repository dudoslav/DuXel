unit DudNewFileDialogUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, DudUnit;

type

  { TDudNewFileDialog }

  TDudNewFileDialog = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    obr : TDudPic;
  public
    function getDudPic(): TDudPic;
  end;

var
  DudNewFileDialog: TDudNewFileDialog;

implementation

{$R *.lfm}

{ TDudNewFileDialog }

function TDudNewFileDialog.getDudPic(): TDudPic;
begin
  Result := obr;
end;

procedure TDudNewFileDialog.Button1Click(Sender: TObject);
begin
  obr := TDudPic.Create(StrToInt(Edit1.Text), StrToInt(Edit2.Text));
  Close;
end;


end.

