//===========================================================================
// ===========================================================================================
// $File:$
// $Revision:$
// DESCRIPTION : 
//===========================================================================

`include "defines.vh"

module ecdsa_reg (


input clk, 
input `RESET_SIG, 

input clk_div, 

input         reg_bs,
input         reg_rd,
input         reg_wr,
input [`PIO_RANGE] reg_addr,
input [`PIO_RANGE] reg_din,

output reg    pio_ack,
output reg    pio_rvalid,
output reg [`PIO_RANGE] pio_rdata,

output reg [`REAL_TIME_NBITS-1:0]  default_exp_time

);

/***************************** LOCAL VARIABLES *******************************/
reg reg_rd_d1;

reg n_pio_ack;
reg n_pio_rvalid;

reg sel_default_exp_time;

wire wr_default_exp_time = reg_wr&reg_bs&sel_default_exp_time;

wire rd_en = reg_rd|reg_rd_d1;

/***************************** NON REGISTERED OUTPUTS ************************/

always @(*) begin
	n_pio_rvalid = 1'b0;
	sel_default_exp_time = 1'b0;
	pio_rdata = {(`PIO_NBITS){1'b0}};

	case(reg_addr[`ECDSA_REG_ADDR_RANGE])
		`ECDSA_DEFAULT_EXP_TIME: begin
			n_pio_rvalid = 1'b1;
			sel_default_exp_time = 1'b1;
			pio_rdata = {{(`PIO_NBITS-`REAL_TIME_NBITS){1'b0}}, default_exp_time};
		end
		default: n_pio_rvalid = 1'b0;
	endcase
end

/***************************** REGISTERED OUTPUTS ****************************/

always @(`CLK_RST) begin
	if(`ACTIVE_RESET) begin
		pio_ack <= 1'b0;
		pio_rvalid <= 1'b0;

		default_exp_time <= {(`EXP_TIME_NBITS){1'b1}};
	end else begin
		pio_ack <= clk_div?n_pio_ack&~rd_en:pio_ack;
		pio_rvalid <= clk_div?n_pio_rvalid&reg_bs&rd_en&n_pio_ack:pio_rvalid;

		default_exp_time <= wr_default_exp_time?reg_din[`REAL_TIME_NBITS-1:0]:default_exp_time;
	end
end

/***************************** PROGRAM BODY **********************************/

always @(`CLK_RST) begin
	if(`ACTIVE_RESET) begin
		n_pio_ack <= 1'b0;
		reg_rd_d1 <= 1'b0;
	end else begin
		n_pio_ack <= (reg_rd|reg_wr)&reg_bs?1'b1:clk_div?1'b0:n_pio_ack;
		reg_rd_d1 <= reg_rd?reg_bs:pio_rvalid?1'b0:reg_rd_d1;
	end
end

endmodule

