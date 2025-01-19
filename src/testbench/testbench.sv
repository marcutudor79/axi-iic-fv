`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/09/2024 04:55:01 PM
// Design Name:
// Module Name: testbench
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
import uvm_pkg::*;

module testbench();

// ------ Signals declaration ------ //
// inputs
logic         s_axi_aclk;
logic         s_axi_aresetn;
logic [8:0]   s_axi_awaddr;
logic         s_axi_awvalid;
logic [31:0]  s_axi_wdata;
logic [3:0]   s_axi_wstrb;
logic         s_axi_wvalid;
logic         s_axi_bready;
logic [8:0]   s_axi_araddr;
logic         s_axi_arvalid;
logic         s_axi_rready;
logic         sda_i;
logic         scl_i;

// outputs
logic         iic2intc_irpt;
logic         s_axi_awready;
logic         s_axi_wready;
logic [1:0]   s_axi_bresp;
logic         s_axi_bvalid;
logic         s_axi_arready;
logic [31:0]  s_axi_rdata;
logic [1:0]   s_axi_rresp;
logic         s_axi_rvalid;
logic         sda_o;
logic         sda_t;
logic         scl_o;
logic         scl_t;
logic [0:0]   gpo;

// ------- DUT instantiation ------- //
axi_iic_0_wrapper dut_inst(.*);

// ------- Interfaces instantiation ------- //
axi4Lite_intf axi4Lite();
iic_intf iicIntf();

// ------- Clock generation ------- //
initial begin
    s_axi_aclk = 0;
    forever begin
        #5 s_axi_aclk = ~s_axi_aclk;
    end
end

// ------- Signals assignments ------- //
assign axi4Lite.s_axi_aclk      = s_axi_aclk;
assign axi4Lite.s_axi_awready   = s_axi_awready;
assign axi4Lite.s_axi_wready    = s_axi_wready;
assign axi4Lite.s_axi_bresp     = s_axi_bresp;
assign axi4Lite.s_axi_bvalid    = s_axi_bvalid;
assign axi4Lite.s_axi_arready   = s_axi_arready;
assign axi4Lite.s_axi_rdata     = s_axi_rdata;
assign axi4Lite.s_axi_rresp     = s_axi_rresp;
assign axi4Lite.s_axi_rvalid    = s_axi_rvalid;

assign s_axi_aresetn    = axi4Lite.s_axi_aresetn;
assign s_axi_awaddr     = axi4Lite.s_axi_awaddr;
assign s_axi_awvalid    = axi4Lite.s_axi_awvalid;
assign s_axi_wdata      = axi4Lite.s_axi_wdata;
assign s_axi_wstrb      = axi4Lite.s_axi_wstrb;
assign s_axi_wvalid     = axi4Lite.s_axi_wvalid;
assign s_axi_bready     = axi4Lite.s_axi_bready;
assign s_axi_araddr     = axi4Lite.s_axi_araddr;
assign s_axi_arvalid    = axi4Lite.s_axi_arvalid;
assign s_axi_rready     = axi4Lite.s_axi_rready;

// ------- Run a test ------- //
initial begin
    uvm_config_db#(virtual axi4Lite_intf)::set(null, "", "axi4Lite_interface", axi4Lite);
    uvm_config_db#(virtual iic_intf)::set(null, "", "iic_interface", iicIntf);

    // run the sim for 1k clock cycles
    fork
        begin
            run_test("base_test");
        end
        begin
            int clkLimit = 1000;
            repeat(clkLimit) @(posedge axi4Lite.s_axi_aclk);
            `uvm_fatal("SIM_END", $psprintf("Reached the simulation limit of %0d s_axi_aclk cycles", clkLimit))
        end
    join_any

end

endmodule
