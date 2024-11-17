# i2c IP verification plan project

This project contains a verification plan for the IIC IP provided by AMD Vivado suite. It is based on the UVM library and aims to prove the functionality of the IP is as per the specification sheet.
The plan verification suite is written in SystemVerilog and can be run with Vivado.

# How to run the project

## Prerequisites
```
Vivado 2024.1 suite
```

## Open the project
Just open the .xpr file in the your Vivado IDE and run the simulation.

## Development status 
✅ Testbench and UVM environment definition [as here](https://gitlab.upb.ro/Teaching/aces/functional-verification/-/tree/master/lab1?ref_type=heads)

✅ Sequencer and Agent integration [as here](https://gitlab.upb.ro/Teaching/aces/functional-verification/-/tree/master/lab2?ref_type=heads)

✅ Monitor and Driver integration [as here](https://gitlab.upb.ro/Teaching/aces/functional-verification/-/tree/master/lab3?ref_type=heads)

❌ Scoreboard integration [as here](https://gitlab.upb.ro/Teaching/aces/functional-verification/-/tree/master/lab4?ref_type=heads)
