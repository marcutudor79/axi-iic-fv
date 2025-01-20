//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/09/2024 05:27:40 PM
// Design Name:
// Module Name: axi4Lite_baseSequence
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
`include "../../rtl/axi_iic_registers.svh"

import uvm_pkg::*;

class axi4Lite_baseSequence extends uvm_sequence #(axi4Lite_transaction);

	`uvm_object_utils (axi4Lite_baseSequence)


	axi4Lite_transaction axi4Lite_item;
	int numberOfAccesses;


	function new(string name="axi4Lite_baseSequence");
		super.new(name);
	endfunction : new


	virtual task body();
		axi4Lite_item = axi4Lite_transaction::type_id::create("axi4Lite_item");

		`uvm_info("axi4Lite_baseSequence", $psprintf("Going to generate %d axi4Lite transactions", numberOfAccesses), UVM_NONE)

		// in the sequencer, send the axi4Lite items sequencially
		repeat(numberOfAccesses) begin
			start_item(axi4Lite_item);
			axi4Lite_item.randomize();

			// do not start the ip
			if (axi4Lite_item.writeEnable == 1) begin
				if (axi4Lite_item.addr == `CR) begin
					// set bit 0 to 0 (EN bit)
					axi4Lite_item.writeData = axi4Lite_item.writeData & 32'hFFFFFFFE;
				end
			end

			finish_item(axi4Lite_item);
		end

		`uvm_info("axi4Lite_baseSequence", $psprintf("Finished generating axi4Lite transactions"), UVM_NONE)
	endtask : body


endclass : axi4Lite_baseSequence
