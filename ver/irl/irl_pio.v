//===========================================================================
// ===========================================================================================
// $File:$
// $Revision:$
// DESCRIPTION : 
//===========================================================================

`include "defines.vh"

module irl_pio(


input clk, 
input `RESET_SIG, 

input clk_div, 

input         reg_bs,
input         reg_wr,
input         reg_rd,
input [`PIO_RANGE] reg_addr,
input [`PIO_RANGE] reg_din,

input limiting_profile_cir_mem_ack,
input [`PIO_RANGE] limiting_profile_cir_mem_rdata,

input limiting_profile_eir_mem_ack,
input [`PIO_RANGE] limiting_profile_eir_mem_rdata,

output reg reg_ms_limiting_profile_cir,
output reg reg_ms_limiting_profile_eir,


output reg    pio_ack,
output reg    pio_rvalid,
output reg [`PIO_RANGE] pio_rdata

);

/***************************** LOCAL VARIABLES *******************************/
reg reg_rd_d1;

reg n_pio_ack, n_pio_rvalid;

reg n_none_selected_ack;
reg none_selected_ack;

wire rd_en = reg_rd|reg_rd_d1;

/***************************** NON REGISTERED OUTPUTS ************************/

always @(*) begin
	n_pio_ack = 1'b0;
	n_pio_rvalid = 1'b0;
	pio_rdata = {(`PIO_NBITS){1'b0}};
	reg_ms_limiting_profile_cir = 1'b0;
	reg_ms_limiting_profile_eir = 1'b0;

	case(reg_addr[`IRL_MEM_ADDR_RANGE])
            `IRL_LIMITING_PROFILE_CIR: begin
		n_pio_ack = limiting_profile_cir_mem_ack;
		n_pio_rvalid = reg_bs;
		pio_rdata = limiting_profile_cir_mem_rdata;
		reg_ms_limiting_profile_cir = reg_bs;
	    end
            `IRL_LIMITING_PROFILE_EIR: begin
		n_pio_ack = limiting_profile_eir_mem_ack;
		n_pio_rvalid = reg_bs;
		pio_rdata = limiting_profile_eir_mem_rdata;
		reg_ms_limiting_profile_eir = reg_bs;
	    end
            default: begin
		n_pio_ack = none_selected_ack;
	    end

	endcase
end

/***************************** REGISTERED OUTPUTS ****************************/

always @(`CLK_RST) begin
	if(`ACTIVE_RESET) begin
		pio_ack <= 1'b0;
		pio_rvalid <= 1'b0;
		n_none_selected_ack <= 1'b0;
		none_selected_ack <= 1'b0;
	end else begin
		pio_ack <= clk_div?n_pio_ack&~rd_en:pio_ack;
		pio_rvalid <= clk_div?n_pio_rvalid&reg_bs&rd_en&n_pio_ack:pio_rvalid;
		n_none_selected_ack <= (reg_rd|reg_wr)&reg_bs?1'b1:clk_div?1'b0:n_none_selected_ack;
		none_selected_ack <= clk_div?n_none_selected_ack:none_selected_ack;
	end
end

/***************************** PROGRAM BODY **********************************/

always @(`CLK_RST) 
	if(`ACTIVE_RESET) begin
		reg_rd_d1 <= 1'b0;
	end else begin
		reg_rd_d1 <= reg_rd?reg_bs:pio_rvalid?1'b0:reg_rd_d1;
	end


endmodule

