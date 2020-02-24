unit Appliciant;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
	TFeature = (c, cpp, csharp, delphi, tcp, unity, git);
  TFeatures = Set of TFeature;

type TAppliciant = class

private
  Name : String[16];
	Features : TFeatures;
public
  constructor Create(_name : String);
	function DoInterview : TFeatures;
  function GetName : String;
  procedure AddFeature(new_feature : TFeature);
end;

implementation
	constructor TAppliciant.Create(_name : String);
  begin
    self.Name := _name;
  end;

	function TAppliciant.DoInterview : TFeatures;
  begin
		Result := Features;
  end;

  function TAppliciant.GetName : String;
  begin
    Result := name;
  end;

	procedure TAppliciant.AddFeature(new_feature : TFeature);
  begin
    Include(Features, new_feature);
  end;

end.

