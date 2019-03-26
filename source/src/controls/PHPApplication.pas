unit PHPApplication;

interface

uses ZendApi, ZendTypes, HZendTypes, AZendApi, Rtti, Vcl.Forms, WinApi.Windows, SysUtils,
     Classes, TypInfo;

function GetConsoleWindow: HWND; stdcall; external 'kernel32.dll';

procedure application_showConsoleWindow(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure application_setterHandler(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;
  
procedure application_getterHandler(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure application_invokeMethod(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure application_formSetMain(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

procedure application_showConsoleWindow;
var
  Value: ppzval;
begin
  if ZvalArgsGet(ht, @Value) = SUCCESS then
  begin
    case zend_bool(Value^.value.lval) of
      True:
        ShowWindow(GetConsoleWindow, SW_SHOW);
      False:
        ShowWindow(GetConsoleWindow, SW_HIDE);
    end;
  end;
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
		ZVAL_STRINGW(return_value, PWideChar(RttiProperty.GetValue(Application).ToString), False);
	end;
end;

procedure application_invokeMethod;
var
  MethodName: ppzval;
  Args: ppzval;
  RContext: TRttiContext;
  RType: TRttiType;
  I: Integer;
  ArgsArray: array of TValue;
  Tmp: pppzval;
begin
  if ZvalArgsGet(ht, @MethodName, @Args) = SUCCESS then
  begin
    RType := RContext.GetType(Application.ClassInfo);
    if not Args^._type = IS_NULL then
    begin
      Tmp := nil;
      I := -1;
      while True do
      begin
        I := I + 1;
        SetLength(ArgsArray, I);
        zend_hash_index_find(Args^.value.ht, I, Tmp);

        if Tmp^^^._type = IS_NULL then
          Break;

        case Tmp^^^._type of
          IS_STRING:
            ArgsArray[I] := String(Tmp^^^.value.str.val);
          IS_LONG:
            ArgsArray[I] := Tmp^^^.value.lval;
          IS_BOOL:
            ArgsArray[I] := zend_bool(Tmp^^^.value.lval);
        end;
      end;
      RType.GetMethod(String(MethodName^.value.str.val)).Invoke(Application, ArgsArray);
    end
    else
      RType.GetMethod(String(MethodName^.value.str.val)).Invoke(Application, []);
  end;
end;

procedure application_formSetMain;
var
  Id: ppzval;
  Obj: TObject;
  P: Pointer;
begin
  if ZvalArgsGet(ht, @Id) = SUCCESS then
  begin
    Obj := TObject(Id^.value.lval);
    if (Obj = nil) or not (Obj is TForm) then
      ZVAL_FALSE(return_value)
    else
    begin
      P := @Application.Mainform;
      Pointer(P^) := TForm(Obj);
    end;
  end;
end;


end.
