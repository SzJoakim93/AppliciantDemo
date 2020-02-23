program Dataqua_test;

uses Appliciant, DataquaExample;

var
  myAppliciant : TAppliciant;
  dataqua : TDataquaExample;
begin
     dataqua := TDataquaExample.create([c, cpp, delphi]);

     myAppliciant := TAppliciant.Create();

     myAppliciant.AddFeature(c);
     myAppliciant.AddFeature(cpp);
     myAppliciant.AddFeature(delphi);

     dataqua.startInterview(myAppliciant);

     readln();
end.

