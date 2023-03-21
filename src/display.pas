unit Display;


interface
  procedure DisplayBCD;
  procedure DisplayBinary;
  procedure DisplayGrayCode;

implementation

uses
  Includes,
  delay;

procedure CleanDisplay; inline;
begin
  PORTD := $FF;
end;

procedure Display(time, output: integer);
var
  i : shortint;
begin
  _PORTB[output] := true;

  for i := 0 to 7 do
    _PORTD[7-i] := NOT(boolean((time) AND (1 << i)));

  CleanDisplay;

  _PORTB[output] := false;
end;

{ For Display in BCD Format. }
procedure DisplayBCD;
begin

  Display((sec Mod 10), 6);

  Display((sec Div 10), 5);

  Display((min Mod 10), 4);

  Display((min Div 10), 3);

  Display((hour Mod 10), 2);

  Display((hour Div 10), 1);

  delay_ms(1);
end;



{ For Display in Binary Format. }
procedure DisplayBinary;
begin

  Display((sec), 4);

  Display((min), 3);

  Display((hour), 2);

  delay_ms(1);
end;

{ For Display in GrayCode Format. }
procedure DisplayGrayCode;
begin

  Display(grayCodes[sec Mod 10], 6);

  Display(grayCodes[sec Div 10], 5);

  Display(grayCodes[min Mod 10], 4);

  Display(grayCodes[min Div 10], 3);

  Display(grayCodes[hour Mod 10], 2);

  Display(grayCodes[hour Div 10], 1);

  delay_ms(1);
end;

end.

