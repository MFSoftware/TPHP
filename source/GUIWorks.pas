unit GUIWorks;

interface

uses
  TypInfo,
  Vcl.Forms,
  SysUtils,
  Vcl.Controls,
  ZendTypes,
  HZendTypes,
  ZendApi,
  PHPApi,
  RttiProcedures,
  System.Classes;

procedure gui_parent(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_destroy(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_create(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_class(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_getHandle(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_formSetMain(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_setParent(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation
  
procedure gui_destroy;
var Obj: ppzval;
begin
  if ZvalArgsGet(ht, @Obj) = SUCCESS then
		TControl(Obj^.value.lval).Free;
end;

procedure gui_parent;
var
  Obj: ppzval;
  Owner: ppzval;
begin
  if ZvalArgsGet(ht, @Obj, @Owner) = SUCCESS then
  begin
    if Owner^._type = IS_NULL then
      ZVAL_LONG(return_value, Integer(TControl(Obj^.value.lval).Parent))
    else
      TControl(Obj^.value.lval).Parent := TWinControl(Owner^.value.lval)
  end;
end;

procedure gui_getHandle;
var
  Id: ppzval;
begin
  if ZvalArgsGet(ht, @Id) = SUCCESS then
  begin
    if TObject(Id^.value.lval) is TWinControl then
      ZVAL_LONG(return_value, TWinControl(Id^.value.lval).Handle)
    else
      ZVAL_LONG(return_value, 0);
  end;
end;

function createComponent(aClass: ansistring; aOwner: integer): integer;
var
  Owner: TComponent;
  Component: TComponentClass;
begin
  try
    if aOwner = 0 then
      Owner := nil
    else
      Owner := TComponent(TObject(aOwner));
    Component := TComponentClass(GetClass(String(aClass)));
    if (Component <> nil) then
      Result := Integer(TComponentClass(Component).Create(Owner))
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

procedure gui_create;
var
  ClassName: ppzval;
begin
  if ZvalArgsGet(ht, @ClassName) = SUCCESS then
  begin
    ZVAL_LONG(return_value, createComponent(ClassName^.value.str.val, Integer(Application)));
  end;
end;

procedure gui_class;
var
  Id: ppzval;
begin
  if ZvalArgsGet(ht, @Id) = SUCCESS then
  begin
    if TObject(Id^.value.lval) is TForm then
      ZVAL_STRINGW(return_value, PWideChar('TForm'), False)
    else
      ZVAL_STRINGW(return_value, PWideChar(TObject(Id^.value.lval).ClassName), False);
  end;
end;

procedure gui_setParent;
var
  Id: ppzval;
  Owner: ppzval;
begin
  if ZvalArgsGet(ht, @Id, @Owner) = SUCCESS then
  begin
    TControl(Id^.value.lval).Parent := TWinControl(Owner^.value.lval);
  end;
end;

procedure gui_formSetMain;
var
  Id: ppzval;
  Obj: TObject;
  P: Pointer;
begin
  if ZvalArgsGet(ht, @Id) = SUCCESS then
  begin
    Obj := TObject(Id^.value.lval);
    if (Obj = nil) or not (Obj is TForm) then
      ZVAL_BOOL(return_value, False)
    else
    begin
      P := @Application.Mainform;
      Pointer(P^) := TForm(Obj);
    end;
  end;
end;

end.
