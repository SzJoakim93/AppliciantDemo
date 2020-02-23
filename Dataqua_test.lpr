program Dataqua_test;

uses
	Classes,

  Appliciant,
  DataquaExample;

var
  appliciants : TList;
  dataqua : TDataquaExample;
  i : byte;
  feature : TFeature;

	procedure readAppliciants;
 	var
  	Input : Text;
  	Line : String[64];
  	Feature : String[4];
  	i : byte;
  	new_appliciant : TAppliciant;
	begin
		AssignFile(Input, 'appliciants.txt');
		Reset(Input);

		while not eof(Input) do
		begin
  	  new_appliciant := TAppliciant.Create();
      Readln(Input, Line);

      i := 1;
      while i <= Length(Line) do
      begin
			  Feature := '';

        while (Line[i] <> ' ') and (i <= Length(Line)) do
        begin
      	  Feature := Feature + Line[i];
          i := i + 1;
        end;

        if Feature = '0' then new_appliciant.AddFeature(c)
        else if Feature = '1' then new_appliciant.AddFeature(cpp)
        else if Feature = '2' then new_appliciant.AddFeature(csharp)
        else if Feature = '3' then new_appliciant.AddFeature(delphi)
        else if Feature = '4' then new_appliciant.AddFeature(unity)
        else if Feature = '5' then new_appliciant.AddFeature(tcp)
        else if Feature = '6' then new_appliciant.AddFeature(git);
        i := i + 1;

      end;

      appliciants.Add(new_appliciant);

		end;

	Close(Input);
end;

begin
  dataqua := TDataquaExample.Create([c, cpp, delphi]);
  appliciants := TList.Create();

  readAppliciants;

  for i := 0 to appliciants.Count-1 do
  	dataqua.startInterview(TAppliciant(appliciants[i]));

  readln();

  dataqua.Free;
  appliciants.Free;

end.
