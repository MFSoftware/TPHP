unit PHPConsole;

interface

uses ZendApi, ZendTypes, HZendTypes, AZendApi, Rtti, Vcl.Forms, WinApi.Windows, SysUtils,
     Classes;

procedure console_writeLn(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure console_readLn(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

procedure console_writeLn;
var
  Text: ppzval;
begin
  if ZvalArgsGet(ht, @Text) = SUCCESS then
    WriteLn(Text^.value.str.val);
end;

procedure console_readLn;
var tmp: string;
begin
  ReadLn(tmp);
  ZVAL_STRINGW(return_value, PWideChar(tmp), False);
end;

end.
