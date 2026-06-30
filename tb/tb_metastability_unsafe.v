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

        // Match stimulus exactly with GVIM screenshot:
        #12 async_in = 1; // Change async_in near clock edge (Safe)
        #7 async_in = 0;  // Transitions at 19ps
        #6 async_in = 1;  // Transitions at 25ps (exactly on the rising clock edge!)
        #9 async_in = 0;  // Transitions at 34ps (1ps before the clock edge at 35ps!)
        #50;
        $display("Simulation complete. VCD dumped to metastability_unsafe.vcd");
        $display("----------------------------------------------------------------");
        $finish;
    end


endmodule
