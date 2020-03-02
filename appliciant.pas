unit Appliciant;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TFeature = (c, cpp, csharp, delphi, tcp, unity, git);
  TFeatures = set of TFeature;

type
  TAppliciant = class

  private
    Name: string[16];
    Features: TFeatures;
  public
    constructor Create(_name: string);
    function DoInterview: TFeatures;
    function GetName: string;
    procedure AddFeature(new_feature: TFeature);
  end;

implementation

constructor TAppliciant.Create(_name: string);
begin
  self.Name := _name;
end;

function TAppliciant.DoInterview: TFeatures;
begin
  Result := Features;
end;

function TAppliciant.GetName: string;
begin
  Result := Name;
end;

procedure TAppliciant.AddFeature(new_feature: TFeature);
begin
  Include(Features, new_feature);
end;

end.
