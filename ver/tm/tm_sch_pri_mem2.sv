//===========================================================================
// ===========================================================================================
// $File:$
// $Revision:$
// DESCRIPTION : 
//===========================================================================

`include "defines.vh"

module tm_sch_pri_mem2 #(
parameter WIDTH = (`THIRD_LVL_QUEUE_ID_NBITS<<1),
parameter DEPTH_NBITS = `THIRD_LVL_SCH_ID_NBITS
) (

input clk, `RESET_SIG, 

input clk_div,

input [`PIO_RANGE] reg_addr,
input [`PIO_RANGE] reg_din,
input         reg_rd,
input         reg_wr,
input [7:0] reg_ms_pri_sch_ctrl,

input pri_sch_ctrl0_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl0_raddr,
input pri_sch_ctrl1_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl1_raddr,
input pri_sch_ctrl2_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl2_raddr,
input pri_sch_ctrl3_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl3_raddr,
input pri_sch_ctrl4_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl4_raddr,
input pri_sch_ctrl5_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl5_raddr,
input pri_sch_ctrl6_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl6_raddr,
input pri_sch_ctrl7_rd, 
input [DEPTH_NBITS-1:0] pri_sch_ctrl7_raddr,

output [7:0]  pri_sch_ctrl_mem_ack,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata0,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata1,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata2,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata3,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata4,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata5,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata6,
output [`PIO_RANGE] pri_sch_ctrl_mem_rdata7,

output reg [7:0] pri_sch_ctrl_wr,
output reg [DEPTH_NBITS-1:0] pri_sch_ctrl_waddr,
output reg [WIDTH-1:0] pri_sch_ctrl_wdata,

output pri_sch_ctrl0_ack, 
output [WIDTH-1:0] pri_sch_ctrl0_rdata,
output pri_sch_ctrl1_ack, 
output [WIDTH-1:0] pri_sch_ctrl1_rdata,
output pri_sch_ctrl2_ack, 
output [WIDTH-1:0] pri_sch_ctrl2_rdata,
output pri_sch_ctrl3_ack, 
output [WIDTH-1:0] pri_sch_ctrl3_rdata,
output pri_sch_ctrl4_ack, 
output [WIDTH-1:0] pri_sch_ctrl4_rdata,
output pri_sch_ctrl5_ack, 
output [WIDTH-1:0] pri_sch_ctrl5_rdata,
output pri_sch_ctrl6_ack, 
output [WIDTH-1:0] pri_sch_ctrl6_rdata,
output pri_sch_ctrl7_ack, 
(* keep = "true" *) output [WIDTH-1:0] pri_sch_ctrl7_rdata  

);

/***************************** LOCAL VARIABLES *******************************/

logic [`PIO_RANGE] pri_sch_ctrl_mem_rdata[7:0];
assign pri_sch_ctrl_mem_rdata0 = pri_sch_ctrl_mem_rdata[0];
assign pri_sch_ctrl_mem_rdata1 = pri_sch_ctrl_mem_rdata[1];
assign pri_sch_ctrl_mem_rdata2 = pri_sch_ctrl_mem_rdata[2];
assign pri_sch_ctrl_mem_rdata3 = pri_sch_ctrl_mem_rdata[3];
assign pri_sch_ctrl_mem_rdata4 = pri_sch_ctrl_mem_rdata[4];
assign pri_sch_ctrl_mem_rdata5 = pri_sch_ctrl_mem_rdata[5];
assign pri_sch_ctrl_mem_rdata6 = pri_sch_ctrl_mem_rdata[6];
assign pri_sch_ctrl_mem_rdata7 = pri_sch_ctrl_mem_rdata[7];

/***************************** NON REGISTERED OUTPUTS ************************/

/***************************** REGISTERED OUTPUTS ****************************/

always @(posedge clk) begin
	pri_sch_ctrl_waddr <= reg_addr[DEPTH_NBITS-1+2:0+2];
	pri_sch_ctrl_wdata <= reg_din[WIDTH-1:0];
end

always @(`CLK_RST) 
    if (`ACTIVE_RESET) begin
	pri_sch_ctrl_wr <= 8'b0;
    end else begin
	pri_sch_ctrl_wr <= {(8){reg_wr}}&reg_ms_pri_sch_ctrl;
    end


/***************************** PROGRAM BODY **********************************/

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f0(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[0]),

        .app_mem_rd(pri_sch_ctrl0_rd),
        .app_mem_raddr(pri_sch_ctrl0_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[0]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[0]),

        .app_mem_ack(pri_sch_ctrl0_ack),
        .app_mem_rdata(pri_sch_ctrl0_rdata)
);

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f1(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[1]),

        .app_mem_rd(pri_sch_ctrl1_rd),
        .app_mem_raddr(pri_sch_ctrl1_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[1]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[1]),

        .app_mem_ack(pri_sch_ctrl1_ack),
        .app_mem_rdata(pri_sch_ctrl1_rdata)
);

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f2(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[2]),

        .app_mem_rd(pri_sch_ctrl2_rd),
        .app_mem_raddr(pri_sch_ctrl2_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[2]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[2]),

        .app_mem_ack(pri_sch_ctrl2_ack),
        .app_mem_rdata(pri_sch_ctrl2_rdata)
);

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f3(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[3]),

        .app_mem_rd(pri_sch_ctrl3_rd),
        .app_mem_raddr(pri_sch_ctrl3_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[3]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[3]),

        .app_mem_ack(pri_sch_ctrl3_ack),
        .app_mem_rdata(pri_sch_ctrl3_rdata)
);

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f4(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[4]),

        .app_mem_rd(pri_sch_ctrl4_rd),
        .app_mem_raddr(pri_sch_ctrl4_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[4]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[4]),

        .app_mem_ack(pri_sch_ctrl4_ack),
        .app_mem_rdata(pri_sch_ctrl4_rdata)
);

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f5(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[5]),

        .app_mem_rd(pri_sch_ctrl5_rd),
        .app_mem_raddr(pri_sch_ctrl5_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[5]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[5]),

        .app_mem_ack(pri_sch_ctrl5_ack),
        .app_mem_rdata(pri_sch_ctrl5_rdata)
);

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f6(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[6]),

        .app_mem_rd(pri_sch_ctrl6_rd),
        .app_mem_raddr(pri_sch_ctrl6_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[6]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[6]),

        .app_mem_ack(pri_sch_ctrl6_ack),
        .app_mem_rdata(pri_sch_ctrl6_rdata)
);

pio_mem_f #(WIDTH, DEPTH_NBITS) u_pio_mem_f7(
        .clk(clk),
        .`RESET_SIG(`RESET_SIG),

        .clk_div(clk_div),

        .reg_addr(reg_addr),
        .reg_din(reg_din),
        .reg_rd(reg_rd),
        .reg_wr(reg_wr),
        .reg_ms(reg_ms_pri_sch_ctrl[7]),

        .app_mem_rd(pri_sch_ctrl7_rd),
        .app_mem_raddr(pri_sch_ctrl7_raddr),
	
        .mem_ack(pri_sch_ctrl_mem_ack[7]),
        .mem_rdata(pri_sch_ctrl_mem_rdata[7]),

        .app_mem_ack(pri_sch_ctrl7_ack),
        .app_mem_rdata(pri_sch_ctrl7_rdata)
);


/***************************** DIAGNOSTICS **********************************/
// synopsys translate_off


// synopsys translate_on

endmodule

