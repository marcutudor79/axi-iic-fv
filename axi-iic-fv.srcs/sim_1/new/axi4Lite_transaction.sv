//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 05:45:35 PM
// Design Name: 
// Module Name: axi4Lite_transaction
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

class axi4Lite_transaction extends uvm_sequence_item;

		 logic [31:0] readData;
	rand logic [31:0] writeData;
	rand logic 		  writeEnable;
	rand logic [4:0]  addr;

	`uvm_object_utils(axi4Lite_transaction)

	function new(string name="axi4Lite_transaction");
		super.new(name);

		readData = 0;
		writeData = 0;
		writeEnable = 0;
		addr = 0;
	endfunction : new

	function string convert2string();
		string outputString = "";

		outputString = $psprintf("%s\n\t * readData=%0h", outputString, readData);
		outputString = $psprintf("%s\n\t * writeData=%0h", outputString, writeData);
		outputString = $psprintf("%s\n\t * addr=%0h", outputString, addr);
		outputString = $psprintf("%s\n\t * writeEnable=%0b", outputString, writeEnable);

		return outputString;
	endfunction

endclass : axi4Lite_transaction
