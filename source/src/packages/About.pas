unit About;

interface

uses Vcl.Dialogs, Vcl.Forms, Classes, ZendTypes, HZendTypes, AboutForm;

procedure core_about;

implementation

procedure core_about;
begin
  Application.CreateForm(TForm1, Form1);
  Form1.Show;
end;

end.
