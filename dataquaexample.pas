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

	procedure TDataquaExample.startInterview(appliciant : TAppliciant);
  var feature : TFeature;
  begin
    for feature in NewEmployedMinRequestedFeatures do
      if not (feature in appliciant.DoInterview) then
      begin
        Writeln(appliciant.GetName, ': The appliciant is not success :(');
        Exit;
      end;

       Writeln(appliciant.GetName, ': The appliciant success :)');
  end;

end.

