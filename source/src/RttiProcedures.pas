unit RttiProcedures;

interface

uses
  Vcl.Forms, Vcl.Controls,
  System.SysUtils,
  Vcl.Dialogs,
  TypInfo,
  Rtti,
  DelphiFunctions,
  AZendApi,
  ZendApi,
  PHPApi,
  HZendTypes,
  ZendTypes,
  Classes;

procedure gui_propget(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_propSet(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_propExists(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_methodsList(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_methodExists(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_propList(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure class_propGet(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_propGetEnum(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_propSetEnum(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

procedure gui_propGetEnum;
var
  IntObj: ppzval;
  PropName: ppzval;
  Value: String;
begin
  if ZvalArgsGet(ht, @IntObj, @PropName) = SUCCESS then
    begin
      Value := GetEnumProp(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName));
	  case DelphiFunctions.is_numeric(Value) of
      True:
        ZVAL_LONG(return_value, StrToInt(Value));
      False:
        ZVAL_STRINGW(return_value, PWideChar(WideString(Value)), False);
	  end;
  end;
end;

procedure gui_propSetEnum;
var
  IntObj, PropName, Value: ppzval;
begin
  if ZvalArgsGet(ht, @IntObj, @PropName, @Value) = SUCCESS then
	begin
    {if not IsWritable then
      ZVAL_FALSE(return_value);}

    case Value^._type of
      IS_LONG:
        SetEnumProp(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), IntToStr(Value^.value.lval));
			IS_STRING:
				SetEnumProp(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), String(Value^.value.str.val));
		end;
	end;
end;

procedure gui_propGet;
var
  IntObj: ppzval;
  PropName: ppzval;
  Value: String;
begin
  if ZvalArgsGet(ht, @IntObj, @PropName) = SUCCESS then
    begin
      Value := GetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName));
	  case DelphiFunctions.is_numeric(Value) of
      True:
        ZVAL_LONG(return_value, StrToInt(Value));
      False:
        ZVAL_STRINGW(return_value, PWideChar(WideString(Value)), False);
	  end;
  end;
end;

procedure class_propGet;
var
  IntObj: ppzval;
  PropName: ppzval;
  Value: String;
begin
  if ZvalArgsGet(ht, @IntObj, @PropName) = SUCCESS then
    begin
      //Value := GetPropValue(TComponentClass(TPersistentClass(IntObj^.value.lval)), String(PropName^.value.str.val), True);
	  case DelphiFunctions.is_numeric(Value) of
      True:
        ZVAL_LONG(return_value, StrToInt(Value));
      False:
        ZVAL_STRINGW(return_value, PWideChar(WideString(Value)), False);
	  end;
  end;
end;

procedure gui_propSet;
var
  IntObj, PropName, Value: ppzval;
begin
  if ZvalArgsGet(ht, @IntObj, @PropName, @Value) = SUCCESS then
	begin
    {if not IsWritable then
      ZVAL_FALSE(return_value);}

    case Value^._type of
			IS_LONG:
				SetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), Value^.value.lval);
			IS_STRING:
				SetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), String(Value^.value.str.val));
			IS_BOOL:
				SetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), zend_bool(Value^.value.lval));
		end;
	end;
end;

procedure gui_propExists;
var
  IntObj: ppzval;
  PropName: ppzval;
begin
  if ZvalArgsGet(ht, @IntObj, @PropName) = SUCCESS then
  begin
    if IsPublishedProp(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName)) = true then
      ZVAL_TRUE(return_value)
		else
      ZVAL_FALSE(return_value);
  end;
end;

procedure gui_methodsList;
var
  Id: ppzval;
  c: TRttiContext;
  m: TRttiMethod;
  res: TStringList;
begin
  if ZvalArgsGet(ht, @Id) = SUCCESS then
  begin
    try
      c := TRttiContext.Create;
      res := TStringList.Create;
      for m in c.GetType(TObject(Id^.value.lval)).GetMethods do
        res.Add(m.Name);
      ZVAL_STRINGW(return_value, PWideChar(res.Text), False);
    finally
      c.Free;
    end;
  end;
end;

procedure gui_methodExists;
var
  RContext : TRttiContext;
  RType : TRttiType;
  RMethod : TRttiMethod;
  Id: ppzval;
  MethodName: ppzval;
begin
  if ZvalArgsGet(ht, @Id, @MethodName) = SUCCESS then
  begin
    RContext := TRttiContext.Create;
    RType:= RContext.GetType(TObject(Id^.value.lval).ClassInfo);
    try
      if Assigned(RType) then
      begin
        RMethod := RType.GetMethod(String(MethodName^.value.str.val));
        if Assigned(RMethod) then
          ZVAL_TRUE(return_value);
      end;
    finally
      if Assigned(RType) then
        RType.Free;
      RContext.Free;
    end;
  end;
end;

function getProperties(id: integer): string;
var
  inf: PPropInfo;
  lst: PPropList;
  i: integer;
  res: TStrings;
begin
  GetPropList(TObject(Integer(id)), lst);
  res := TStringList.Create;
  i := 0;
  while True do
  begin
    inf := lst^[i];
    i := i + 1;
    if inf = nil then
      break;

    res.Add(String(inf^.Name));
  end;

  Result := res.Text;
  res.Free;
end;

procedure gui_propList;
var
  Id: ppzval;
begin
  if ZvalArgsGet(ht, @Id) = SUCCESS then
    ZVAL_STRINGW(return_value, PWideChar(getProperties(Id^.value.lval)), False);
end;

end.
