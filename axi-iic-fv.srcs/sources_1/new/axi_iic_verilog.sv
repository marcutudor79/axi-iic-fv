`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 04:53:42 PM
// Design Name: 
// Module Name: axi_iic_verilog
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
// axi verilog wrapper 
module axi_iic_0_wrapper (
    input  logic                s_axi_aclk,
    input  logic                s_axi_aresetn,
    output logic                iic2intc_irpt,
    input  logic        [8:0]   s_axi_awaddr,
    input  logic                s_axi_awvalid,
    output logic                s_axi_awready,
    input  logic        [31:0]  s_axi_wdata,
    input  logic        [3:0]   s_axi_wstrb,
    input  logic                s_axi_wvalid,
    output logic                s_axi_wready,
    output logic        [1:0]   s_axi_bresp,
    output logic                s_axi_bvalid,
    input  logic                s_axi_bready,
    input  logic        [8:0]   s_axi_araddr,
    input  logic                s_axi_arvalid,
    output logic                s_axi_arready,
    output logic        [31:0]  s_axi_rdata,
    output logic        [1:0]   s_axi_rresp,
    output logic                s_axi_rvalid,
    input  logic                s_axi_rready,
    input  logic                sda_i,
    output logic                sda_o,
    output logic                sda_t,
    input  logic                scl_i,
    output logic                scl_o,
    output logic                scl_t,
    output logic        [0:0]   gpo
);

  // Instantiate the VHDL module inside the SystemVerilog wrapper
  axi_iic_0 vhdl_inst (
    .s_axi_aclk      (s_axi_aclk),
    .s_axi_aresetn   (s_axi_aresetn),
    .iic2intc_irpt   (iic2intc_irpt),
    .s_axi_awaddr    (s_axi_awaddr),
    .s_axi_awvalid   (s_axi_awvalid),
    .s_axi_awready   (s_axi_awready),
    .s_axi_wdata     (s_axi_wdata),
    .s_axi_wstrb     (s_axi_wstrb),
    .s_axi_wvalid    (s_axi_wvalid),
    .s_axi_wready    (s_axi_wready),
    .s_axi_bresp     (s_axi_bresp),
    .s_axi_bvalid    (s_axi_bvalid),
    .s_axi_bready    (s_axi_bready),
    .s_axi_araddr    (s_axi_araddr),
    .s_axi_arvalid   (s_axi_arvalid),
    .s_axi_arready   (s_axi_arready),
    .s_axi_rdata     (s_axi_rdata),
    .s_axi_rresp     (s_axi_rresp),
    .s_axi_rvalid    (s_axi_rvalid),
    .s_axi_rready    (s_axi_rready),
    .sda_i           (sda_i),
    .sda_o           (sda_o),
    .sda_t           (sda_t),
    .scl_i           (scl_i),
    .scl_o           (scl_o),
    .scl_t           (scl_t),
    .gpo             (gpo)
  );

endmodule