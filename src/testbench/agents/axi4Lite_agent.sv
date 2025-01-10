//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/09/2024 05:43:49 PM
// Design Name:
// Module Name: axi4Lite_agent
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

class axi4Lite_agent extends uvm_agent;

	`uvm_component_utils(axi4Lite_agent)

	axi4Lite_driver driver;
	axi4Lite_monitor monitor;
	uvm_sequencer #(axi4Lite_transaction) sequencer;


	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction


	virtual function void build_phase(uvm_phase phase);
		sequencer = uvm_sequencer#(axi4Lite_transaction)::type_id::create("sequencer", this);
		driver 	  = axi4Lite_driver::type_id::create("driver", this);
		monitor   = axi4Lite_monitor::type_id::create("monitor", this);
	endfunction


	virtual function void connect_phase(uvm_phase phase);
		driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction


endclass
