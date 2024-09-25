module memory (
    input wire [31:0] data_in,
    input wire [3:0] address,
    input wire enable,
    input wire clk,
    input wire rst,
    input wire read_write,
    output reg [31:0] data_out,
    output reg valid_out
);

    // Memory array of 32-bit width and 16-depth
    reg [31:0] mem [15:0];
    integer i;

    // Reset logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i < 16; i = i + 1) begin
                mem[i] <= 32'b0;
            end
            data_out <= 0;
            valid_out <= 1'b0;
        end else if (enable) begin
            if (read_write) begin
                // Write operation
                mem[address] <= data_in;
                valid_out <= 1'b0;
            end else begin
                // Read operation
                data_out <= mem[address];
                valid_out <= 1'b1;
            end
        end else begin
            data_out <= 0;
            valid_out <= 1'b0;
        end
    end

endmodule