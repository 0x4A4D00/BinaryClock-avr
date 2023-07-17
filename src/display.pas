unit Display;


interface

procedure DisplayBCD;
procedure DisplayBCS;
procedure DisplayBinary;
procedure DisplayGrayCode;

implementation

uses
  Includes,
  delay,
  SFP;

procedure CleanDisplay; inline;
begin
  PORTD := $FF;
  PORTB := $00;
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

{ For Display in BCS Format. }
procedure DisplayBCS;
begin
  Display(sec, 6);

  Display(min, 4);

  Display(hour, 2);

  delay_ms(1);
end;

{ For Display in Binary Time Format. }
procedure DisplayBinary;
var
  a   : FixedPoint;
  i,j : integer;
begin
  a := DayTime;
  for i := 4 to 7 do
  begin
    for j := 3 to 6 do
    begin
      _PORTD[i] := false;

      if a >= points[i,j] then
      begin
        a := a - points[i,j];
        _PORTB[9-j] := true;
      end;
      _PORTD[i] := true;
    end;
    CleanDisplay;
  end;

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

