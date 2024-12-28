module Shift_Register (
    input wire D,          // data input
    input wire S_in,       // shift input
    input wire clk,        // clk input
    input wire select,     // multiplexer selection signal
    output reg Q,          // register output
    output wire S_out      // shift output
);

    // Choice of multiplexer between  D , S_in
    wire mux_out;
    assign mux_out = (select) ? S_in : D;

    // flip flop along with clk
    always @(posedge clk) begin
        Q <= mux_out;
    end

    // shift output
    assign S_out = Q;

endmodule