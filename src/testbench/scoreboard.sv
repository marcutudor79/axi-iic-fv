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
`include "../rtl/axi_iic_registers.svh"
import uvm_pkg::*;

`uvm_analysis_imp_decl(_axi4Lite_monitor)

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
    uvm_analysis_imp_axi4Lite_monitor #(axi4Lite_transaction, scoreboard) axi4Lite_imp_monitor;

    virtual axi4Lite_intf axi4Lite;
    virtual iic_intf iicIntf;

    // max reg address h144 == d324
    int registerBank[324];

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

        // WRITE: store the data in the register bank
        if (monitorItem.writeEnable == 1) begin

            case(monitorItem.addr)
                `ADR: registerBank[`ADR] = monitorItem.writeData[7:1];
                `GPO: registerBank[`GPO] = monitorItem.writeData[0];
                `CR: registerBank[`CR] = monitorItem.writeData[6:0];
                `GIE: registerBank[`GIE] = monitorItem.writeData[31];
                `IER: registerBank[`IER] = monitorItem.writeData[7:0];
                `SOFTR: registerBank[`SOFTR] = monitorItem.writeData[3:0];
                default: registerBank[monitorItem.addr] = monitorItem.writeData;
            endcase

        end

        // READ: verify the data in the register bank
        else begin

            case(monitorItem.addr)
                `ADR: begin
                    if (monitorItem.readData[7:1] != registerBank[monitorItem.addr]) begin
                        `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr], monitorItem.readData));
                    end
                end
                `GPO: begin
                    if (monitorItem.readData[0] != registerBank[monitorItem.addr]) begin
                        `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr], monitorItem.readData));
                    end
                end
                `CR: begin
                    if (monitorItem.readData[6:0] != registerBank[monitorItem.addr]) begin
                        `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr], monitorItem.readData));
                    end
                end
                `GIE: begin
                    if (monitorItem.readData[31] != registerBank[monitorItem.addr]) begin
                        `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr], monitorItem.readData));
                    end
                end
                `IER: begin
                    if (monitorItem.readData[7:0] != registerBank[monitorItem.addr]) begin
                        `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr], monitorItem.readData));
                    end
                end
                default: begin
                    if (monitorItem.readData != registerBank[monitorItem.addr]) begin
                        `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr], monitorItem.readData));
                    end
                end
            endcase

        end

    endfunction

    // model the way IIC regs behave
    task modelIICRegisters();
        forever begin
            @(posedge axi4Lite.s_axi_aclk);

            // if the SOFTR register is written with hA, then the IIC registers are reset
            if (registerBank[`SOFTR] == 4'hA) begin
                `uvm_info("scoreboard", "Resetting IIC registers", UVM_NONE)
                registerBank[`ADR] = 0;
                registerBank[`GPO] = 0;
                registerBank[`CR] = 0;
                registerBank[`GIE] = 0;
                registerBank[`IER] = 0;
            end
        end
    endtask


    virtual task run_phase(uvm_phase phase);
        fork
            modelIICRegisters();
        join
    endtask

endclass