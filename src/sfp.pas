unit SFP;
{ This File Contains Soft Fixed Point Type for Binary Time. }

interface

type
  PFixedPoint = ^TFixedPoint;
  TFixedPoint = packed record
    int     : UInt16;
    decimal : ShortInt;
  end;

  Fixed = TFixedPoint;

operator >= (a,b: TFixedPoint): boolean;
operator - (a,b: TFixedPoint): TFixedPoint;

implementation

operator >= (a,b: TFixedPoint): boolean;
begin
  if a.int > b.int then result := true
  else result := ((a.int = b.int) AND (a.decimal >= b.decimal));
end;

operator - (a,b: TFixedPoint): TFixedPoint;
begin
  result.int := a.int - b.int;
  if b.decimal > a.decimal then
  begin
    dec(result.int);
    result.decimal := a.decimal - b.decimal + 100;
  end
  else
    result.decimal := a.decimal - b.decimal;
end;

end.

