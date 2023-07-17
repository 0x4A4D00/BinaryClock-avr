unit SFP;
{ This File Contains Soft Fixed Point Type for Binary Time. }

interface

type
  FixedPoint = packed record
    int     : UInt16;
    decimal : ShortInt;
  end;

operator >= (a,b: FixedPoint): boolean;
operator - (a,b: FixedPoint): FixedPoint;

implementation

operator >= (a,b: FixedPoint): boolean;
begin
  if a.int > b.int then result := true
  else result := ((a.int = b.int) AND (a.decimal >= b.decimal));
end;

operator - (a,b: FixedPoint): FixedPoint;
begin
  result.int := a.int - b.int;
  result.decimal := a.decimal - b.decimal;
end;

end.

