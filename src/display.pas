unit Display;


interface
  procedure DisplayBCD;
  procedure DisplayBinary;
  procedure DisplayGrayCode;

implementation

uses
  Includes, delay;

procedure Decimal2Binary(time, output: integer);
var
  i : shortint;
begin
  _portb[output] := true;

   for i := 0 to 7 do
     _portd[7-i] := NOT(boolean((time) AND (1 << i)));

   portd := $FF;

   _portb[output] := false;
end;




{ For Display in BCD Format. }
procedure DisplayBCD;
begin

  Decimal2Binary((sec Mod 10), 6);

  Decimal2Binary((sec Div 10), 5);

  Decimal2Binary((min Mod 10), 4);

  Decimal2Binary((min Div 10), 3);

  Decimal2Binary((hour Mod 10), 2);

  Decimal2Binary((hour Div 10), 1);

  delay_ms(1);
end;



{ For Display in Binary Format. }
procedure DisplayBinary;
begin

  Decimal2Binary((sec), 4);

  Decimal2Binary((min), 3);

  Decimal2Binary((hour), 2);


  delay_ms(1);
end;

{ For Display in GrayCode Format. }
procedure DisplayGrayCode;
begin

  // You Can Change the Base by 16 if you want.

  Decimal2Binary(grayCodes[sec Mod 10], 6);

  Decimal2Binary(grayCodes[sec Div 10], 5);

  Decimal2Binary(grayCodes[min Mod 10], 4);

  Decimal2Binary(grayCodes[min Div 10], 3);

  Decimal2Binary(grayCodes[hour Mod 10], 2);

  Decimal2Binary(grayCodes[hour Div 10], 1);

  delay_ms(1);
end;

end.

