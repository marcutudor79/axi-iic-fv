interface iic_intf ();
    // DUT inputs
    logic         sda_i;
    logic         scl_i;

    // DUT outputs
    logic         sda_o;
    logic         sda_t;
    logic         scl_o;
    logic         scl_t;
    logic [0:0]   gpo;
endinterface : iic_intf