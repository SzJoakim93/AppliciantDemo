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
	Features : TFeatures;
public
	function DoInterview : TFeatures;
  procedure AddFeature(new_feature : TFeature);
end;

implementation

	function TAppliciant.DoInterview : TFeatures;
  begin
		Result := Features;
  end;

	procedure TAppliciant.AddFeature(new_feature : TFeature);
  begin
    Include(Features, new_feature);
  end;

end.

