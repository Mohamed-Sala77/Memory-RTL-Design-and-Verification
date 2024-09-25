interface intf1(input logic clk);

    logic [31:0] data_in;
    logic [3:0] address;
    logic enable;
    logic rst;
    logic read_write;
    logic [31:0] data_out;
    logic valid_out;

    

//     clocking cb @ (posedge clk);
//     default input #1step output #1step;

//     output data_in, address, enable, rst, read_write;
//     input negedata_out, valid_out;
// endclocking

endinterface