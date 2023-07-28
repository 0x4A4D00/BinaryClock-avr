unit Includes;

interface

uses
  SFP;

type
  Tick    = 0..3;
  Seconds = 0..60;
  Minutes = -1..60;
  Hours   = -1..24;

const
  GRAY_CODES: packed array[0..9] of byte =
    (%0000, %0001, %0011, %0010, %0110, %0111, %0101, %0100, %1100, %1101);
  { Changing Array Ranges from 0..3 to 4..7 and 3..6 is Because of port Numbers. }
  BINARY_POINTS: packed array[4..7, 3..6] of TFixedPoint = (
    ((int: 43200; decimal: 00), (int: 21600; decimal: 00), (int: 10800; decimal: 00), (int: 5400;  decimal: 00)),
    ((int: 2700;  decimal: 00), (int: 1350;  decimal: 00), (int: 675;   decimal: 00), (int: 337;   decimal: 50)),
    ((int: 168;   decimal: 75), (int: 84;    decimal: 37), (int: 42;    decimal: 18), (int: 21;    decimal: 09)),
    ((int: 10;    decimal: 54), (int: 5;     decimal: 27), (int: 2;     decimal: 63), (int: 1;     decimal: 31)));

var
  { Startup Time }
  TickCount : Tick        = 0;
  Sec       : Seconds     = 0;
  Min       : Minutes     = 0;
  Hour      : Hours       = 0;
  DayTime   : TFixedPoint = (int : 0; decimal : 0);
  { I/O }
  _PORTB : bitpacked array[0..7] of boolean absolute PORTB; {columns}
  _PORTD : bitpacked array[0..7] of boolean absolute PORTD; {rows}
  _PINA  : bitpacked array[0..7] of boolean absolute PINA;  {inputs}

implementation


end.
