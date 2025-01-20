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

class axi4Lite_softResetSeq extends uvm_sequence #(axi4Lite_transaction);

	`uvm_object_utils (axi4Lite_softResetSeq)

	axi4Lite_transaction axi4Lite_item;

	function new(string name="axi4Lite_softResetSeq");
		super.new(name);
	endfunction : new


	virtual task body();
		axi4Lite_item = axi4Lite_transaction::type_id::create("axi4Lite_item");

        // Write random data to the registers
		start_item(axi4Lite_item);
		axi4Lite_item.addr = `GIE;
		axi4Lite_item.writeData = 32'hFFFFFFFE;
		axi4Lite_item.writeEnable = 1;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `IER;
		axi4Lite_item.writeData = 32'h000000FF;
		axi4Lite_item.writeEnable = 1;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `CR;
		axi4Lite_item.writeData = 32'h000000FF;
		axi4Lite_item.writeEnable = 1;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `ADR;
		axi4Lite_item.writeData = 32'h000000FE;
		axi4Lite_item.writeEnable = 1;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `GPO;
		axi4Lite_item.writeData = 32'h00000001;
		axi4Lite_item.writeEnable = 1;
		finish_item(axi4Lite_item);

        // Issue a soft reset
		start_item(axi4Lite_item);
		axi4Lite_item.addr = `SOFTR;
		axi4Lite_item.writeData = 32'h0000000A;
		axi4Lite_item.writeEnable = 1;
		finish_item(axi4Lite_item);

		// Read the registers one by one
		start_item(axi4Lite_item);
		axi4Lite_item.addr = `GIE;
		axi4Lite_item.writeEnable = 0;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `IER;
		axi4Lite_item.writeEnable = 0;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `CR;
		axi4Lite_item.writeEnable = 0;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `ADR;
		axi4Lite_item.writeEnable = 0;
		finish_item(axi4Lite_item);

		start_item(axi4Lite_item);
		axi4Lite_item.addr = `GPO;
		axi4Lite_item.writeEnable = 0;
		finish_item(axi4Lite_item);

		`uvm_info("axi4Lite_softResetSeq", $psprintf("Finished generating axi4Lite transactions"), UVM_NONE)
	endtask : body


endclass : axi4Lite_softResetSeq
