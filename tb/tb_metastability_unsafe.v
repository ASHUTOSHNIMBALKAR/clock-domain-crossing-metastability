// tb/tb_metastability_unsafe.v
// Testbench to simulate metastability risks. We transition an asynchronous signal
// close to the destination clock edge, illustrating potential setup/hold violations.

`timescale 1ns/1ps

module tb_metastability_unsafe;

    reg clk;
    reg async_in;
    wire sampled;

    // Instantiate Device Under Test (DUT)
    metastability_unsafe uut (
        .clk(clk),
        .async_in(async_in),
        .sampled(sampled)
    );

    // Clock Generation: 100MHz clock (10ns period)
    always begin
        #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Initialize inputs
        clk = 0;
        async_in = 0;

        // VCD dumping for GTKWave visualization
        $dumpfile("metastability_unsafe.vcd");
        $dumpvars(0, tb_metastability_unsafe);

        $display("----------------------------------------------------------------");
        $display("Starting simulation for Unsynchronized CDC (Unsafe)...");
        $display("----------------------------------------------------------------");

        // Case 1: Synchronous transition (Safe)
        // Transition happens far from the clock rising edge.
        #15 async_in = 1; // Clk rose at 10ns, next is 20ns. This is midway (15ns)
        #10 async_in = 0; // Midway (25ns)

        // Case 2: Asynchronous transition violating setup/hold times
        // Clock rose edge is at 30ns.
        // Transition async_in at 29.9ns, only 0.1ns before the clock edge.
        #4.9 async_in = 1; 
        
        // Next clock edge is at 40ns.
        // Transition async_in at 39.9ns, violating timing again.
        #10 async_in = 0;

        // Case 3: Transition exactly on the clock edge at 50ns.
        #10.1 async_in = 1; // This transitions at 50.0ns, right on the clock edge!

        #30;
        $display("Simulation complete. VCD dumped to metastability_unsafe.vcd");
        $display("----------------------------------------------------------------");
        $finish;
    end

endmodule
