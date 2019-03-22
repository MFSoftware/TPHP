unit PHPMessages;

interface

uses
  System.SysUtils,
  WinApi.Windows,
  Vcl.Forms,
  Vcl.Dialogs,
  HZendTypes,
  TPHPFunction,
  ZendTypes,
  ZendAPI;

procedure gui_messagebox_show(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_showmessage(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

procedure gui_messagebox_show;
var
  Caption: ppzval;
  Text: ppzval;
  Inf: ppzval;
begin
  if (ZvalArgsGet(ht, @Text, @Caption, @Inf) = SUCCESS) then
    ZVAL_LONG(return_value, MessageBoxA(Application.Handle, PAnsiChar(Text^.value.str.val), PAnsiChar(Caption^.value.str.val), Inf^.value.lval));
end;

procedure gui_showmessage;
var
  Text: ppzval;
begin
  if (ZvalArgsGet(ht, @Text) = SUCCESS) then
  begin
    case Text^._type of
			IS_STRING:
				ShowMessage(String(Text^.value.str.val));
			IS_LONG:
				ShowMessage(IntToStr(Text^.value.lval));
			IS_BOOL:
				ShowMessage(BoolToStr(zend_bool(Text^.value.str.val), True));
		end;
  end;
end;

end.
