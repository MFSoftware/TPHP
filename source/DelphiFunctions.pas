unit DelphiFunctions;

interface

uses System.SysUtils;

function is_numeric(const st:string): boolean;

implementation

function is_numeric;
var i: Integer;
begin
  Result := True;
  for i := 1 to Length(st) do
    if not CharInSet(st[i], ['0'..'9']) then Result := False;
end;

end.
