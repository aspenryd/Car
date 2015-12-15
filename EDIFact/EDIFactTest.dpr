program EDIFactTest;

uses
  ExceptionLog,
  Forms,
  main in 'main.pas' {Form1},
  EDIFactClasses in 'EDIFactClasses.pas',
  EDIFactUtils in 'EDIFactUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
