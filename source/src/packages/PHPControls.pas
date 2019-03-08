unit PHPControls;

interface

uses Classes, Vcl.Forms, Vcl.Dialogs, Vcl.Controls, Vcl.StdCtrls, SysUtils,
  Windows, WideStrUtils, Variants, Rtti, ZendTypes, ZendApi,
  System.TypInfo, TPHPFunction, HZendTypes, System.RTLConsts;

procedure gui_componentToString(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_stringToComponent(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_componentFromFile(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure gui_componentToFile(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

procedure gui_componentToString;
var
  MemStream: TMemoryStream;
  StringStream: TStringStream;
  Id: ppzval;
begin
  if ZvalArgsGet(ht, @Id) = SUCCESS then
  begin
    StringStream := TStringStream.Create(' ');
    MemStream := TMemoryStream.Create;
    try
      MemStream.WriteComponent(TComponent(Id^.value.lval));
      MemStream.Position := 0;
      ObjectBinaryToText(MemStream, StringStream);
      StringStream.Position := 0;
      ZVAL_STRINGW(return_value, PWideChar(StringStream.DataString), False);
    finally
      MemStream.Free;
      StringStream.Free;
    end;
  end;
end;

procedure gui_stringToComponent;
var
  StrStream: TStringStream;
  MemStream: TMemoryStream;
  Text: ppzval;
begin
  if ZvalArgsGet(ht, @Text) = SUCCESS then
  begin
    StrStream := TStringStream.Create(Text^.value.str.val);
    try
      MemStream := TMemoryStream.Create;
      try
        ObjectTextToBinary(StrStream, MemStream);
        MemStream.Position := 0;
        ZVAL_LONG(return_value, Integer(MemStream.ReadComponent(nil)));
      finally
        MemStream.Free;
      end;
    finally
      StrStream.Free;
    end;
  end;
end;

procedure gui_componentFromFile;
var
  MemStream: TMemoryStream;
  FileStream: TFileStream;
  FileName: ppzval;
begin
  if ZvalArgsGet(ht, @FileName) = SUCCESS then
  begin
    MemStream := TMemoryStream.Create;
    FileStream := TFileStream.Create(String(FileName^.value.str.val), fmOpenRead);
    try
      ObjectTextToBinary(FileStream, MemStream);
      MemStream.Position := 0;
      ZVAL_LONG(return_value, Integer(MemStream.ReadComponent(nil)));
    finally
      MemStream.Free;
      FileStream.Free;
    end;
  end;
end;

procedure gui_componentToFile;
var
  MemStream: TMemoryStream;
  FileStream: TFileStream;
  Id: ppzval;
  FileName: ppzval;
begin
  if ZvalArgsGet(ht, @Id, @FileName) = SUCCESS then
  begin
    FileStream := TFileStream.Create(String(FileName^.value.str.val), fmCreate or fmOpenWrite);
    try
      MemStream := TMemoryStream.Create;
      try
        MemStream.WriteComponent(TComponent(Id^.value.lval));
        MemStream.Position := 0;
        ObjectBinaryToText(MemStream, FileStream);
      finally
        MemStream.Free;
      end;
    finally
      FileStream.Free;
    end;
  end;
end;

end.
