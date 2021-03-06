unit AppliciantManager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  Appliciant,
  DataquaExample;

type
  PAppliciant = ^TAppliciant;

type
  TAppliciantManager = class
  private
    appliciants: TList;
    function stringToEnum(feature_str: string; out Value: TFeature): boolean;
    function EnumToString(feature_value: TFeature): string;
    function findByName(Name: string): PAppliciant;
  public
    constructor Create;
    destructor Destroy;
    procedure ReadAppliciants;
    procedure WriteAppliciants;
    procedure ListAppliciants;
    procedure Interview(dataqua: TDataquaExample);
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

function TAppliciantManager.stringToEnum(feature_str: string;
  out Value: TFeature): boolean;
begin
  Result := True;
  if (feature_str = '0') or (feature_str = 'c') then
    Value := c
  else if (feature_str = '1') or (feature_str = 'cpp') then
    Value := cpp
  else if (feature_str = '2') or (feature_str = 'csharp') then
    Value := csharp
  else if (feature_str = '3') or (feature_str = 'delphi') then
    Value := delphi
  else if (feature_str = '4') or (feature_str = 'unity') then
    Value := unity
  else if (feature_str = '5') or (feature_str = 'tcp') then
    Value := tcp
  else if (feature_str = '6') or (feature_str = 'git') then
    Value := git
  else
    Result := False;
end;

function TAppliciantManager.EnumToString(feature_value: TFeature): string;
begin
  case feature_value of
    c: Result := '0';
    cpp: Result := '1';
    csharp: Result := '2';
    delphi: Result := '3';
    unity: Result := '4';
    tcp: Result := '5';
    git: Result := '6';

  end;
end;

function TAppliciantManager.findByName(Name: string): PAppliciant;
var
  i: byte;
begin
  for i := 0 to appliciants.Count - 1 do
    if TAppliciant(appliciants[i]).GetName = Name then
    begin
      Result := appliciants[i];
      exit;
    end;

  Result := nil;

end;

procedure TAppliciantManager.ReadAppliciants;
var
  input: Text;
  line: string[64];
  feature_str: string[4];
  feature_val: TFeature;
  Name: string[16];
  i: byte;
  new_appliciant: TAppliciant;
begin
  AssignFile(input, 'appliciants.txt');
  Reset(input);

  while not EOF(input) do
  begin
    Readln(input, line);

    i := 1;

    Name := '';
    while (line[i] <> ' ') and (i <= Length(line)) do
    begin
      Name := Name + line[i];
      i := i + 1;
    end;

    new_appliciant := TAppliciant.Create(Name);

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

  Close(input);
end;

procedure TAppliciantManager.WriteAppliciants;
var
  i: byte;
  output: Text;
  features: TFeatures;
  feature: TFeature;
begin
  AssignFile(output, 'appliciants.txt');
  Rewrite(output);

  for i := 0 to appliciants.Count - 1 do
  begin
    Write(output, TAppliciant(appliciants[i]).GetName);
    features := TAppliciant(appliciants[i]).DoInterview;
    for feature in features do
    begin
      Write(output, ' ');
      Write(output, EnumToString(feature));
    end;

    Writeln(output, '');

  end;

  Close(output);
end;

procedure TAppliciantManager.ListAppliciants;
var
  i: byte;
begin
  for i := 0 to appliciants.Count - 1 do
    Writeln(TAppliciant(appliciants[i]).GetName);
  Writeln('');
end;

procedure TAppliciantManager.Interview(dataqua: TDataquaExample);
var
  Name: string[16];
  appliciant: PAppliciant;
begin
  Writeln('Add name of the appliciant');
  Readln(Name);

  appliciant := FindByName(Name);

  if appliciant <> nil then
    dataqua.startInterview(TAppliciant(appliciant))
  else
    Writeln('Appliciant not found');

  Writeln('');
end;

procedure TAppliciantManager.AddAppliciant;
var
  input: string[16];
  appliciant: TAppliciant;
  feature: TFeature;
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
  input: string[16];
  appliciant: PAppliciant;
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
