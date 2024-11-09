//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 05:18:14 PM
// Design Name: 
// Module Name: environment
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

`include "uvm_macros.svh"
`include "axi4Lite_agent.sv"
import uvm_pkg::*;

class environment extends uvm_env;
	
	`uvm_component_utils(environment)


	axi4Lite_agent agent;


	function new (string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction


	virtual function void build_phase(uvm_phase phase);
		agent = axi4Lite_agent::type_id::create("agent", this);
	endfunction

endclass : environment

