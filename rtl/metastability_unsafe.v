// rtl/metastability_unsafe.v
// This module demonstrates an unsynchronized Clock Domain Crossing (CDC).
// Sampling an asynchronous input directly leads to metastability issues.

`timescale 1ns/1ps

module metastability_unsafe (
    input  wire clk,        // Destination clock domain (Clk_2)
    input  wire async_in,   // Asynchronous input signal from Clock Domain 1
    output reg  sampled     // Sampled output (prone to metastability and glitches)
);

    always @(posedge clk) begin
        sampled <= async_in;
    end

endmodule
