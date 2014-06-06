unit DudHistoryManagerUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, DudUnit, Dialogs;

type

  TDudHistoryManager = class
  private
    pastPictures: array of TBitMap;
    futurePictures: array of TBitMap;
  public
    constructor Create();
    function getLastPastPicture(picture : TBitmap): TBitMap;
    procedure addLastPastPicture(picture : TBitMap);
    function getLastFuturePicture(picture : TBitmap): TBitMap;
    procedure addLastFuturePicture(picture : TBitMap);
  end;

implementation

{TDudHistory begin}

constructor TDudHistoryManager.Create();
begin

end;

function TDudHistoryManager.getLastPastPicture(picture : TBitmap): TBitMap;
begin
  if length(pastpictures) > 1 then
  begin
  addLastFuturePicture(picture);
  Result := pastpictures[length(pastpictures)-1];
  pastpictures[length(pastpictures)-1] :=  pastpictures[length(pastpictures)];
  setLength(pastpictures,length(pastpictures)-1);
  end else
  begin
  addLastFuturePicture(picture);
  Result := pastpictures[length(pastpictures)-1];
  end;
end;

procedure TDudHistoryManager.addLastPastPicture(picture : TBitMap);
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
  SetLength(futurePictures,0);
  setLength(pastpictures,length(pastpictures)+1);
  pastpictures[length(pastpictures)-1] := clonePic;
end;

function TDudHistoryManager.getLastFuturePicture(picture : TBitmap): TBitMap;
begin
   if length(futurepictures) > 0 then
  begin
  Result := futurepictures[length(futurepictures)-1];
  futurepictures[length(futurepictures)-1] :=  futurepictures[length(futurepictures)];
  setLength(futurepictures,length(futurepictures)-1);
  end else
  begin
  Result := picture;
  end;
end;

procedure TDudHistoryManager.addLastFuturePicture(picture : TBitMap);
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
  setLength(futurepictures,length(futurepictures)+1);
  futurepictures[length(futurepictures)-1] := clonePic;
end;

{TDudHistory end}

end.

