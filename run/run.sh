#!/bin/bash
/home/bl4ck/Xilinx/Vivado/2024.1/bin/xvhdl -incr ../src/rtl/axi_iic_0.vhd
/home/bl4ck/Xilinx/Vivado/2024.1/bin/xvlog -incr -sv -f compile_list.f -L uvm ;

/home/bl4ck/Xilinx/Vivado/2024.1/bin/xelab testbench -relax -s top -timescale 1ns/1ps;
/home/bl4ck/Xilinx/Vivado/2024.1/bin/xsim top -runall

# xelab testbench -debug all -relax -s top -timescale 1ns/1ps;
# xsim top -gui
