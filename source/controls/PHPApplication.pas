unit PHPApplication;

interface

uses ZendApi, ZendTypes, HZendTypes, AZendApi, Rtti, Vcl.Forms;

procedure application_initialize();
procedure application_minimize();
procedure application_restore();
procedure application_terminate();

procedure application_set_title(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure application_get_title(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure application_run();

procedure application_setterHandler(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;
  
procedure application_getterHandler(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

procedure application_initialize;
begin
  Application.Initialize;
end;

procedure application_minimize;
begin
  Application.Minimize;
end;

procedure application_restore;
begin
  Application.Restore;
end;

procedure application_get_title;
begin
  ZVAL_STRINGW(return_value, PWideChar(Application.Title), False);
end;

procedure application_set_title;
var
  Title: ppzval;
begin
  if ZvalArgsGet(ht, @Title) = SUCCESS then
    Application.Title := String(Title^.value.str.val);
end;

procedure application_terminate;
begin
  Application.Terminate;
end;

procedure application_run;
begin
  Application.Run;
end;
  
procedure application_setterHandler;
var
  PropName: ppzval;
  PropValue: ppzval;
  RttiProperty: TRttiProperty;
begin
  if ZvalArgsGet(ht, @PropName, @PropValue) = SUCCESS then
	begin
		RttiProperty := TRttiContext
		.Create
		.GetType(TApplication)
		.GetProperty(String(PropName^.value.str.val));
		case PropValue^._type of
			IS_STRING:
				RttiProperty.SetValue(Application, String(PropValue^.value.str.val));
			IS_LONG:
				RttiProperty.SetValue(Application, PropValue^.value.lval);
			IS_BOOL:
				RttiProperty.SetValue(Application, zend_bool(PropValue^.value.lval));
		end;
	end;
end;
  
procedure application_getterHandler;
var
  PropName: ppzval;
  RttiProperty: TRttiProperty;
begin
  if ZvalArgsGet(ht, @PropName) = SUCCESS then
	begin
		RttiProperty := TRttiContext
		.Create
		.GetType(TApplication)
		.GetProperty(String(PropName^.value.str.val));
		ZVAL_STRINGW(return_value, PWideChar(RttiProperty.GetValue(Application).ToString), false);
	end;
end;

end.
