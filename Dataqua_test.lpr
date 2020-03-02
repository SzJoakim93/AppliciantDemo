program Dataqua_test;

uses
  Classes,
  DataquaExample,
  Appliciant,
  AppliciantManager;

var
	dataqua : TDataquaExample;
  appliciant_manager : TAppliciantManager;
  option : byte;
  quit : boolean;

begin
  dataqua := TDataquaExample.Create([c, cpp, delphi]);
  appliciant_manager := TAppliciantManager.Create;
  appliciant_manager.ReadAppliciants;
  quit := false;

  while not quit do
  begin
    Writeln('Add number of option');
    Writeln('1. List applications');
    Writeln('2. Interview an appliciant');
    Writeln('3. Add new appliciant');
    Writeln('4. Delete appliciant');
    Writeln('5. Quit');
    Readln(option);

    case option of
      1: appliciant_manager.ListAppliciants;
      2: appliciant_manager.Interview(dataqua);
      3: appliciant_manager.AddAppliciant;
      4: appliciant_manager.DeleteAppliciant;
      5: quit := true;
    end;
  end;

  appliciant_manager.WriteAppliciants;
  dataqua.Free;
  appliciant_manager.Destroy;

end.
