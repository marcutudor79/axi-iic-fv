//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 05:07:15 PM
// Design Name: 
// Module Name: base_test
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
`include "environment.sv"
`include "axi4Lite_baseSequence.sv"
import uvm_pkg::*;

class base_test extends uvm_test;
    // factory registration
    `uvm_component_utils (base_test)
    
    // INSTANTIATE the environment
    environment env;
    
    // constructor
    function new(string name="base_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase (uvm_phase phase);
        env = environment::type_id::create("env", this);
    endfunction
    
    virtual function void connect_phase (uvm_phase phase);
        // connect all sub-components
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        virtual axi4Lite_intf axi4Lite;
        axi4Lite_baseSequence baseSeq;
        
        // GET the interface signals
        uvm_config_db#(virtual axi4Lite_intf)::get(null, "", "axi4Lite_interface", axi4Lite);
        
        // GET the sequence
        baseSeq = axi4Lite_baseSequence::type_id::create("baseSeq");
        baseSeq.numberOfAccesses=5;

        phase.raise_objection(this);        
        
        baseSeq.start(env.agent.sequencer);
        
        phase.drop_objection(this);
    endtask
endclass

