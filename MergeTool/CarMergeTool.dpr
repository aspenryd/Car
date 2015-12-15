program CarMergeTool;

uses
  ExceptionLog,
  Forms,
  main in 'main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Car Merge Tool';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
