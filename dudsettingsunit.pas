unit DudSettingsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DudUnit;

type
  TDudSettings = class
  private
    SPixelA: integer;
    SIsTilesViewerDialogOn: boolean;
  public
    procedure Default();
    property PixelA: integer read SPixelA write SPixelA;
  end;

  var
    Settings: TDudSettings;

implementation

procedure TDudSettings.Default();
begin
   PixelA := 30;
end;

end.

