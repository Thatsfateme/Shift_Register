// gtkwave
`timescale 1ns/1ps
`include "Shift_Register.v"
module Shift_Register_tb;
    
    // Define inputs as reg since they change during simulation
    reg D;
    reg S_in;
    reg clk;
    reg select;
    
    //  Define outputs as wire since they are driven by the module
    wire Q;
    wire S_out;
    
    // Instance of Shift_Register module
    Shift_Register uut (
        .D(D),
        .S_in(S_in),
        .clk(clk),
        .select(select),
        .Q(Q),
        .S_out(S_out)
    );
    
    // Create clock signal with 10 nanosecond periodDD
    always #5 clk = ~clk;

    initial 
    begin
        // Setup for GTKWAVE
        $dumpfile("Shift_Register_tb.vcd");
        $dumpvars(0, Shift_Register_tb);

        // Initialize signals
        clk = 0;
        D = 0;
        S_in = 0;
        select = 0;
        
        // Test 1: Check data transfer from D to Q when select = 0
        #10 D = 1; select = 0;
        #10;
        if (Q !== D) 
            $display("Error: Q does not match D. (select=0), Time = %0t", $time);

        // Test 2: Check data transfer from S_in to Q when select = 1
        #10 S_in = 1; select = 1;
        #10;
        if (Q !== S_in) 
            $display("Error: Q does not match S_in. (select=1), Time = %0t", $time);
        
        // Test 3: Check if Q updates correctly with clk and select changes
        #10 D = 0; S_in = 1; select = 0;
        #10;
        if (Q !== D) 
            $display("Error: Q does not match D. (select=0), Time = %0t", $time);
        
        // end of simulation
        #10;
        $stop;
    end

endmodule