// rtl/metastability_safe.v
// This module demonstrates a safe Clock Domain Crossing (CDC) using a 
// standard 2-stage Flip-Flop (2FF) Synchronizer.

`timescale 1ns/1ps

module metastability_safe (
    input  wire clk,        // Destination clock domain (Clk_2)
    input  wire async_in,   // Asynchronous input signal from Clock Domain 1
    output wire sampled     // Synchronized, stable output
);

    reg sync_reg_1;
    reg sync_reg_2;

    always @(posedge clk) begin
        sync_reg_1 <= async_in;   // First stage: samples the async input (may go metastable)
        sync_reg_2 <= sync_reg_1; // Second stage: resolves potential metastability to a stable state
    end

    // The stable output is taken from the second stage
    assign sampled = sync_reg_2;

endmodule
