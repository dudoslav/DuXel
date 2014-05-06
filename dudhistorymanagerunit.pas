unit DudHistoryManagerUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, DudUnit, Dialogs;

type

  TDudHistoryManager = class
  private
    Pictures: array of TBitMap;
  public
    constructor Create();
    function getLastPicture(): TBitMap;
    procedure addLastPicture(picture : TBitMap);
  end;

implementation

{TDudHistory begin}

constructor TDudHistoryManager.Create();
begin

end;

function TDudHistoryManager.getLastPicture(): TBitMap;
begin
  if length(pictures) > 1 then
  begin
  Result := pictures[length(pictures)-1];
  pictures[length(pictures)-1] :=  pictures[length(pictures)];
  setLength(pictures,length(pictures)-1);
  end else
  begin
  Result := pictures[length(pictures)-1];
  end;
end;

procedure TDudHistoryManager.addLastPicture(picture : TBitMap);
var
  clonePic : TBitMap;
  i,j : integer;
begin
  clonePic := TBitMap.Create;
  clonepic.SetSize(picture.Width,picture.Height);
  for i := 0 to picture.Width-1 do
      for j := 0 to picture.Height-1 do
          begin
          clonepic.Canvas.Pixels[i,j] := picture.Canvas.Pixels[i,j];
          end;
  setLength(pictures,length(pictures)+1);
  pictures[length(pictures)-1] := clonePic;
end;

{TDudHistory end}

end.

