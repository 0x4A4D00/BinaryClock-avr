program clock;

uses includes,Display, Delay, intrinsics;

{$define BCD}

procedure TIMER2_COMP_ISR; Alias: 'TIMER2_COMP_ISR'; Interrupt; Public;
begin
  sec += 1;
  if (sec = 60) then
  begin
    sec := 0;
    min += 1;
  end;
end;

procedure loop;
var
  Show : boolean = true;
begin
  while true do
  begin

    // Update Time
    if (min = 60) then
    begin
      min  := 0;
      hour += 1;
      if (hour = 24) then
        hour  := 0;
    end;

    // Check Input Buttons
    if _PINA[0] = LOW then  // Turn Display OFF
    begin
      if show then
      begin
        DDRB := $00;
        show := false
      end
      else
      begin
        DDRB := $FF;
        show := true;
      end;

      delay_ms(500);
    end
    else
    if _PINA[2] = LOW then // Minute + 1
    begin
      min += 1;
      if min = 60 then
         min := 0;
       delay_ms(100);
    end
    else
    if _PINA[4] = LOW then // Minute - 1
    begin
      min -= 1;
      if min = -1 then
         min := 59;
       delay_ms(100);
    end
    else
    if _PINA[5] = LOW then // Hour + 1
    begin
      hour += 1;
      if hour = 24 then
         hour := 0;
       delay_ms(100);
    end
    else
    if _PINA[7] = LOW then // Hour - 1
    begin
      hour -= 1;
      if hour = -1 then
         hour := 23;
       delay_ms(100);
    end;

    PortD := $FF;

    // Display Time
    if Show then
      begin


        {$ifdef BCD}
        DisplayBCD;
        {$endif}

        {$ifdef Binary}
        DisplayBinary;
        {$endif}

        {$ifdef GrayCode}
        DisplayGrayCode;
        {$endif}

      end;

  end;
end;

procedure initialize;
begin
  ASSR  := $08;
  TCCR2 := $0D;
  TCNT2 := $10;
  OCR2  := $FF;
  TIMSK := $80;

  DDRB := $FF; // Set PortB as Output
  DDRD := $FF; // Set PortD as Output
end;

begin
  avr_sei; // Enable Interrupts
  initialize;
  loop; // Start Main Loop
end.

