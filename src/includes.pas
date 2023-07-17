unit Includes;

interface

uses
  SFP;

type
  Tick    = 0..3;
  Seconds = 0..60;
  Minutes = -1..60;
  Hours   = -1..24;

var
    { Startup Time }
  tik       : Tick       = 0;
  sec       : Seconds    = 9;
  min       : Minutes    = 0;
  hour      : Hours      = 0;
  DayTime   : FixedPoint = (int : 9; decimal : 0);

  grayCodes : array[0..9] of byte = (%0000, %0001, %0011, %0010, %0110, %0111, %0101, %0100, %1100, %1101);
  points : packed array[4..7, 3..6] of FixedPoint = (
    ((int : 43200; decimal : 0), (int : 21600; decimal : 0), (int : 10800; decimal : 0), (int : 5400; decimal : 0)),
    ((int : 2700; decimal : 0),  (int : 1350; decimal : 0),  (int : 675; decimal : 0),   (int : 337; decimal : 5)),
    ((int : 168; decimal : 7),   (int : 84; decimal : 3),    (int : 42; decimal : 1),    (int : 21; decimal : 0)),
    ((int : 10; decimal : 5),    (int : 5; decimal : 2),     (int : 2; decimal : 6),     (int : 1; decimal : 3))
  );

  _PORTB    : bitpacked array[0..7] of boolean absolute PORTB; {columns}
  _PORTD    : bitpacked array[0..7] of boolean absolute PORTD; {rows}
  _PINA     : bitpacked array[0..7] of boolean absolute PINA;  {inputs}

implementation


end.

