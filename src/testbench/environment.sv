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
import uvm_pkg::*;

class environment extends uvm_env;

	`uvm_component_utils(environment)

    // add to the environment the agent and scoreboard
	axi4Lite_agent agent;
	scoreboard sb;

	// constructor for the environment
	function new (string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	// build phase for the environment
	virtual function void build_phase(uvm_phase phase);
		agent = axi4Lite_agent::type_id::create("agent", this);
		sb = scoreboard::type_id::create("sb", this);
	endfunction

	// connect the scoreboard to the monitor
	virtual function void connect_phase(uvm_phase phase);
	   super.connect_phase(phase);

	   agent.monitor.analysisPort.connect(sb.axi4Lite_imp_monitor);
	endfunction

endclass : environment

