program same_file2;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  SameFileScan in 'SameFileScan.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
