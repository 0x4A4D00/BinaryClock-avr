unit Includes;

interface

type
  Seconds = 0..60;
  Minutes = -1..60;
  Hours   = -1..24;

var
    { Startup Time }
  sec       : Seconds = 0;
  min       : Minutes = 58;
  hour      : Hours   = 0;

  grayCodes : array[0..9] of byte = (%0000, %0001, %0011, %0010, %0110, %0111, %0101, %0100, %1100, %1101);
  _PORTB    : bitpacked array[0..7] of boolean absolute PORTB; {columns}
  _PORTD    : bitpacked array[0..7] of boolean absolute PORTD; {rows}
  _PINA     : bitpacked array[0..7] of boolean absolute PINA;  {inputs}

implementation


end.

