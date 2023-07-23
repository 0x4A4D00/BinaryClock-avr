program clock;

uses
  includes,
  Display,
  Delay,
  intrinsics, SFP;

// External Interrupt by 32Khz Crystal
procedure TIMER2_COMP_ISR; Alias: 'TIMER2_COMP_ISR'; Interrupt; Public;
begin
  inc(TickCount);
  inc(DayTime.decimal, 3);
  if (TickCount = 3) then
  begin
    inc(sec);
    TickCount := 0;
    inc(DayTime.int);
    DayTime.decimal := 0;
    if (DayTime.int >= 86400) then DayTime.int := 0; // Range is low
  end;
  if (sec = 60) then
  begin
    sec := 0;
    inc(min);
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
      inc(hour);
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
      inc(min);
      inc(DayTime.int, 60);
      if min = 60 then
         min := 0;

       delay_ms(100);
    end
    else
    if _PINA[4] = LOW then // Minute - 1
    begin
      dec(min);
      dec(DayTime.int, 60);
      if min = -1 then
         min := 59;

       delay_ms(100);
    end
    else
    if _PINA[5] = LOW then // Hour + 1
    begin
      inc(hour);
      inc(DayTime.int, 3600);
      if hour = 24 then
         hour := 0;

       delay_ms(100);
    end
    else
    if _PINA[7] = LOW then // Hour - 1
    begin
      dec(hour);
      dec(DayTime.int, 3600);
      if hour = -1 then
        hour := 23;

      delay_ms(100);
    end;

    PortD := $FF;

    // Display Time
    if Show then
    begin
    {$IFDEF BCD}
    DisplayBCD;
    {$ELSE}
      {$IFDEF BCS}
      DisplayBCS;
      {$ELSE}
        {$IFDEF Binary}
        DisplayBinary;
        {$ELSE}
           {$IFDEF GrayCode}
           DisplayGrayCode;
           {$ENDIF GrayCode}
        {$ENDIF Binary}
      {$ENDIF BCS}
    {$ENDIF BCD}
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

