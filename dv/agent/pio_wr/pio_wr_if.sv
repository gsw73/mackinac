`include "defines.vh"

interface pio_wr_if (

   input wire         clk,
   input wire         reset_n,
   inout wire  [31:0] addr,
   inout wire         avalid,
   inout wire         aready,
   inout wire  [31:0] data,
   inout wire         dvalid,
   inout wire         dready,
   inout wire         strb,
   inout wire         bvalid,
   inout wire         bready
   );

   clocking drv_cb @(posedge clk);
      default input #10ps output #10ps;
      output        addr;
      output        avalid;
      input         aready;
      output        data;
      output        dvalid;
      input         dready;
      input         bvalid;
      output        bready;
      output        strb;
   endclocking: drv_cb

   clocking mon_cb @(posedge clk);
      default input #10ps output #10ps;
      input        addr;
      input        avalid;
      input         aready;
      input        data;
      input        dvalid;
      input         dready;
      input         bvalid;
      input        bready;
      input        strb;
   endclocking: mon_cb

endinterface
