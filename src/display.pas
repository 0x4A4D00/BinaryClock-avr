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
  now : TFixedPoint;
  cNumber ,
  rNumber : integer;
begin
  now := DayTime;
  for rNumber := Low(BINARY_POINTS) to High(BINARY_POINTS) do
  begin
    for cNumber := Low(BINARY_POINTS[i]) to High(BINARY_POINTS[i]) do
    begin
      if now >= BINARY_POINTS[rNumber,cNumber] then
      begin
        _PORTD[rNumber] := false;
        now := now - BINARY_POINTS[rNumber,cNumber];
        _PORTB[cNumber] := true;
      end
      else
        _PORTB[cNumber] := false;
    end;
    delay_ms(5);
    _PORTD[rNumber] := true;
  end;

  CleanDisplay;
  delay_ms(1);
end;

{ For Display in GrayCode Format. }
procedure DisplayGrayCode;
begin
  Display(GRAY_CODES[sec Mod 10], 6);

  Display(GRAY_CODES[sec Div 10], 5);

  Display(GRAY_CODES[min Mod 10], 4);

  Display(GRAY_CODES[min Div 10], 3);

  Display(GRAY_CODES[hour Mod 10], 2);

  Display(GRAY_CODES[hour Div 10], 1);

  delay_ms(1);
end;

end.

