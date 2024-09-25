module my_top;
    import uvm_pkg::*;
    `include "pack1.sv";

    bit clk;
    logic rst;

    parameter clk_period   = 10;

    // Instantiate the interface
    intf1 intf (clk);

    // Instantiate the DUT with the interface modport
    memory dut1 (
        .data_in(intf.data_in),
        .address(intf.address),
        .enable(intf.enable),
        .clk(intf.clk),
        .rst(intf.rst),
        .read_write(intf.read_write),
        .data_out(intf.data_out),
        .valid_out(intf.valid_out)
    );


    initial begin
        uvm_config_db#(virtual intf1)::set(null, "uvm_test_top", "my_inf", intf);
        run_test("my_test");
    end

    always #(clk_period/2) clk = ~clk;



endmodule

module my_top;
    import uvm_pkg::*;
    `include "pack1.sv";

    bit clk;
    logic rst;

    parameter clk_period   = 10;

    // Instantiate the interface
    intf1 intf (clk);

    // Instantiate the DUT with the interface modport
     (
    );

    initial begin
        uvm_config_db#(virtual intf1)::set(null, "uvm_test_top", "my_inf", intf);
        run_test("my_test");
    end

    always #(clk_period/2) clk = ~clk;

endmodule

