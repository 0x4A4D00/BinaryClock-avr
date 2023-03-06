unit Delay;


interface

procedure delay_ms(t: uint16); assembler;

implementation

(*Delay procedure by ccrause
https://github.com/ccrause/fpc-avr *)
procedure delay_ms(t: uint16); assembler;
const
  count = ((F_CPU div 1000 - 3) div 4);
label
  inner, outer, finish;
asm
outer:
  // load 1 ms counter value
  ldi R26, lo8(count)
  ldi R27, hi8(count)

inner:
  // inner loop, 1 ms  4cycles/loop + 1
  sbiw R26, 1      // 2 cycles
  brne inner       // 2 cycles to branch, 1 to continue

  // outer loop, count ms, 4 cycles/loop + 1
  sbiw R24,1       // 2 cycles
  brne outer       // 2 cycles to branch, 1 to continue
finish:
end;

end.

