unit ZendArray;

interface

uses ZendApi, ZendTypes;

type
  TZendArray = class(TObject)
  private
    ZArray: pzval;
    function GetCount: Integer;
  public
    constructor Create(arr: pzval);
    destructor Destroy; override;
    function GetIntegerValue(Index: Integer): Integer;
    function GetStringValue(Index: Integer): String;
    property Count: Integer read GetCount;
  end;

implementation

constructor TZendArray.Create;
begin
  ZArray := arr;
end;

destructor TZendArray.Destroy;
begin

  inherited;
end;

function TZendArray.GetIntegerValue;
var
  Tmp: pppzval;
begin
  Tmp := nil;
  zend_hash_index_find(ZArray^.value.ht, Index, Tmp);
  Result := Tmp^^^.value.lval;
end;

function TZendArray.GetStringValue;
var
  Tmp: pppzval;
begin
  Tmp := nil;
  zend_hash_index_find(ZArray^.value.ht, Index, Tmp);
  Result := String(Tmp^^^.value.str.val);
end;

function TZendArray.GetCount;
begin
  Result := zend_array_size(ZArray);
end;

end.
