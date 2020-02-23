unit DataquaExample;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Appliciant;

type TDataquaExample = class
private
  NewEmployedMinRequestedFeatures : TFeatures;

public
  constructor create(features : TFeatures);
  procedure startInterview(Appliciant:TAppliciant);
end;

implementation
	constructor TDataquaExample.create(features : TFeatures);
  begin
  	NewEmployedMinRequestedFeatures := features;
  end;

	procedure TDataquaExample.startInterview(Appliciant : TAppliciant);
  var feature : TFeature;
  begin
    for feature in NewEmployedMinRequestedFeatures do
      if not (feature in Appliciant.DoInterview) then
      begin
        Writeln('The appliciant is not success :(');
        Exit;
      end;

       Writeln('The appliciant success :)');
  end;

end.

