unit AppliciantManager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Appliciant,
  DataquaExample;

type PAppliciant = ^TAppliciant;

type TAppliciantManager = class
private
	appliciants : TList;
  function stringToEnum(feature_str : String; out Value : TFeature) : Boolean;
  function findByName(name : String) : PAppliciant;
public
  constructor Create;
  destructor Destroy;
  procedure readAppliciants;
  procedure ListAppliciants;
  procedure Interview(dataqua : TDataquaExample);
  procedure AddAppliciant;
  procedure DeleteAppliciant;
end;

implementation
  constructor TAppliciantManager.Create;
  begin
    appliciants := TList.Create();
  end;

  destructor TAppliciantManager.Destroy;
  begin
  	appliciants.Free;
  end;

	function TAppliciantManager.stringToEnum(feature_str : String;
    	out Value : TFeature) : Boolean;
	begin
    Result := true;
    if feature_str = '0' then Value := c
    else if feature_str = '1' then Value := cpp
    else if feature_str = '2' then Value := csharp
    else if feature_str = '3' then Value := delphi
    else if feature_str = '4' then Value := unity
    else if feature_str = '5' then Value := tcp
    else if feature_str = '6' then Value := git
    else Result := false;
  end;

  function TAppliciantManager.findByName(name : String) : PAppliciant;
  var
    i : byte;
  begin
    for i := 0 to appliciants.Count-1 do
    if TAppliciant(appliciants[i]).GetName = name then
    begin
      Result := appliciants[i];
    	exit;
  	end;

    Result := nil;

  end;

	procedure TAppliciantManager.readAppliciants;
 	var
  	input : Text;
  	line : String[64];
  	feature_str : String[4];
    feature_val : TFeature;
    name : String[16];
  	i : byte;
  	new_appliciant : TAppliciant;
	begin
		AssignFile(input, 'appliciants.txt');
		Reset(input);

		while not eof(input) do
		begin
      Readln(input, line);

      i := 1;

      name := '';
      while (line[i] <> ' ') and (i <= Length(line)) do
      begin
      	name := name + line[i];
        i := i + 1;
      end;

      new_appliciant := TAppliciant.Create(name);

      while i <= Length(line) do
      begin
			  feature_str := '';
        while (line[i] <> ' ') and (i <= Length(line)) do
        begin
      	  feature_str := feature_str + line[i];
          i := i + 1;
        end;

        stringToEnum(feature_str, feature_val);
        new_appliciant.AddFeature(feature_val);
        i := i + 1;

      end;

      appliciants.Add(new_appliciant);

		end;

	Close(Input);
end;

procedure TAppliciantManager.ListAppliciants;
	var
    i : byte;
begin
  for i := 0 to appliciants.Count-1 do
  	Writeln(TAppliciant(appliciants[i]).GetName);
  Writeln('');
end;

procedure TAppliciantManager.Interview(dataqua : TDataquaExample);
var
  name : String[16];
  appliciant : PAppliciant;
begin
  Writeln('Add name of the appliciant');
  Readln(name);

  appliciant := FindByName(name);

  if appliciant <> nil then
  	dataqua.startInterview(TAppliciant(appliciant))
  else
    Writeln('Appliciant not found');

  Writeln('');
end;

procedure TAppliciantManager.AddAppliciant;
var
  input : String[16];
  appliciant : TAppliciant;
  feature : TFeature;
begin
  Writeln('Add name of the appliciant');
  Readln(input);

  appliciant := TAppliciant.Create(input);

  repeat
    Writeln('Add name of the feature. Type * to finish.');
    Readln(input);

    if StringToEnum(input, feature) then
    	appliciant.AddFeature(feature)
    else
      Writeln('Invalid feature');

  until input = '*';

  appliciants.Add(appliciant);
end;

procedure TAppliciantManager.DeleteAppliciant;
var
  input : String[16];
  appliciant : PAppliciant;
begin
  Writeln('Add name of the appliciant');
  Readln(input);

  appliciant := FindByName(input);

  if appliciant <> nil then
  	appliciants.Remove(appliciant)
  else
    Writeln('Appliciant not found');

	Writeln('');

end;
end.

