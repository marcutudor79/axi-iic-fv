`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/18/2024 09:16:06 PM
// Design Name:
// Module Name: scoreboard
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

`uvm_analysis_imp_decl(_axi4Lite_monitor)

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
    uvm_analysis_imp_axi4Lite_monitor #(axi4Lite_transaction, scoreboard) axi4Lite_imp_monitor;

    virtual axi4Lite_intf axi4Lite;
    virtual iic_intf iicIntf;
    int registerBank[7];

    // constructor for the scoreboard
    function new(string name="", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    // connect phase
    virtual function void connect_phase(uvm_phase phase);
        uvm_config_db#(virtual axi4Lite_intf)::get(null, "", "axi4Lite_interface", axi4Lite);
        uvm_config_db#(virtual iic_intf)::get(null, "", "iic_interface", iicIntf);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        axi4Lite_imp_monitor = new("axi4Lite_imp_monitor", this);
    endfunction

    // this function must be implemented when using an analysis import
    // it is automatically called by the imp with the associated name
    virtual function void write_axi4Lite_monitor(axi4Lite_transaction monitorItem);
        if (monitorItem.writeEnable == 1) begin
            registerBank[monitorItem.addr] = monitorItem.writeData;
        end
        else begin
            if(monitorItem.readData != registerBank[monitorItem.addr])
                `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr], monitorItem.readData))
        end
    endfunction

    // model the way IIC regs behave
    task modelIICRegisters();
        // ToDo
    endtask


    virtual task run_phase(uvm_phase phase);
        fork
            modelIICRegisters();
        join
    endtask

endclass