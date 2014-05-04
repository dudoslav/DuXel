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
  Result := pictures[length(pictures)-2];
  pictures[length(pictures)-2] :=  pictures[length(pictures)-1];
  setLength(pictures,length(pictures)-1);

  pictures[length(pictures)-1].SaveToFile('test1.bmp');
  pictures[0].SaveToFile('test2.bmp');
end;

procedure TDudHistoryManager.addLastPicture(picture : TBitMap);
var
  clonePic : TBitMap;
begin
  setLength(pictures,length(pictures)+1);
  pictures[length(pictures)-1] := picture;
end;

{TDudHistory end}

end.

