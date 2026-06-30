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

        // Match stimulus exactly with GVIM screenshot:
        #12 async_in = 1; // Change async_in near clock edge (Safe)
        #7 async_in = 0;  // Transitions at 19ps
        #6 async_in = 1;  // Transitions at 25ps (exactly on the rising clock edge!)
        #9 async_in = 0;  // Transitions at 34ps (1ps before the clock edge at 35ps!)
        #50;
        $display("Simulation complete. VCD dumped to metastability_safe.vcd");
        $display("----------------------------------------------------------------");
        $finish;
    end


endmodule
