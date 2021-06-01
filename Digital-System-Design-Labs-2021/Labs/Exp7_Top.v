/*----------------------------------------------------------------------
File: Exp7_Top.v - Top-level module to implement bidirectional data
transfer through an 8-bit bus.

Cyclone FPGAs do not support internal tri-state output connections.
Quartus-II Verilog compiler replaces tri-state drivers with logic
operations that arbitrate net signals according to the driver status. 
------------------------------------------------------------------------
Revision History:
14 Mar 15 - Barbaros Ozdemirel
Created the module.
----------------------------------------------------------------------*/
module Exp7Top(Clock, Sel1, RnW1, Sel2, RnW2, Sel3, RnW3, DioExt);
input Clock;  // clock input for all modules
input Sel1, Sel2, Sel3;  // module select inputs
input RnW1, RnW2, RnW3;  // module read/write control inputs
inout [7:0] DioExt; // IO connection to external data pins

tri [7:0] Dbus;  // internal data bus connecting all modules and
                 // DioExt[7:0] external data pins
Reg8bit R1(Clock, Sel1, RnW1, Dbus);  // register modules
Reg8bit R2(Clock, Sel2, RnW2, Dbus);
Reg8bit R3(Clock, Sel3, RnW3, Dbus);

// DioExt[7:0] drive Dbus[7:0] while writing to a register module.
assign Dbus[7:0] = ( (RnW1 | RnW2 | RnW3) == 1'b0 ) ?
                   DioExt[7:0] : 8'bZ;
// Dbus[7:0] drive DioExt[7:0] while reading from a register module.
assign DioExt[7:0] = ( (RnW1 | RnW2 | RnW3) == 1'b1 ) ?
                     Dbus[7:0] : 8'bZ;

endmodule
//----------------------------------------------------------------------
