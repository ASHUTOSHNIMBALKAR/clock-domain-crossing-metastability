// tb/tb_metastability_safe.v
// Testbench to verify the 2-stage Flip-Flop (2FF) synchronizer. Even with
// asynchronous inputs transitioning close to the clock edge, the output
// is cleanly synchronized and timing-related hazards are prevented.

`timescale 1ns/1ps

module tb_metastability_safe;

    reg clk;
    reg async_in;
    wire sampled;

    // Instantiate Device Under Test (DUT)
    metastability_safe uut (
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
        $dumpfile("metastability_safe.vcd");
        $dumpvars(0, tb_metastability_safe);

        $display("----------------------------------------------------------------");
        $display("Starting simulation for Synchronized CDC (Safe)...");
        $display("----------------------------------------------------------------");

        // Case 1: Synchronous transition (Safe)
        #15 async_in = 1; 
        #10 async_in = 0; 

        // Case 2: Asynchronous transition violating setup/hold times
        // Clock rose edge is at 30ns.
        // Transition async_in at 29.9ns, only 0.1ns before the clock edge.
        #4.9 async_in = 1; 
        
        // Next clock edge is at 40ns.
        // Transition async_in at 39.9ns.
        #10 async_in = 0;

        // Case 3: Transition exactly on the clock edge at 50ns.
        #10.1 async_in = 1; 

        #30;
        $display("Simulation complete. VCD dumped to metastability_safe.vcd");
        $display("----------------------------------------------------------------");
        $finish;
    end

endmodule
