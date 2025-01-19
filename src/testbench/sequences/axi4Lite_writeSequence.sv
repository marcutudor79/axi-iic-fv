`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4Lite_writeSequence extends uvm_sequence #(axi4Lite_writeSequence);

    `uvm_object_utils (axi4Lite_writeSequence)

    axi4Lite_transaction axi4Lite_item;
    int writeData;
    int addr;
    bit writeEnable;

    function new(string name="axi4Lite_writeSequence");
        super.new(name);
    endfunction : new

    virtual task body();
        axi4Lite_item = axi4Lite_transaction::type_id::create("axi4Lite_item");

        start_item(axi4Lite_item);
        axi4Lite_item.writeData = writeData;
        axi4Lite_item.addr = addr;
        axi4Lite_item.writeEnable = writeEnable;
    endtask : body

endclass