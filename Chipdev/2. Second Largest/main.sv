/*
Prompt

Given a clocked sequence of unsigned values, output the second-largest value 
seen so far in the sequence. If only one value is seen, then the output (dout) 
should equal 0. Note that repeated values are treated as separate candidates for 
being the second largest value.

When the reset-low signal (resetn) goes low, all previous values seen in the 
input sequence should no longer be considered for the calculation of the second 
largest value, and the output dout should restart from 0 on the next cycle.

Input and Output Signals

    clk - Clock signal
    resetn - Synchronous reset-low signal
    din - Input data sequence
    dout - Second-largest value seen so far

Output signals during reset

    dout - 0 when resetn is active

Example 1 (Click to Expand)

This example calculates the second largest value from the x2, x6, x0, xe, xc 
sequence of values. Note that in the beginning, x0 is output first when there 
are fewer than two values in the sequence.

Once reset goes low again, all previous values in the sequence are discarded and 
we begin calculating the second largest value of the sequence x0, x1, x2.

Example 2 (Click to Expand)

This example calculates the second largest value from the x1, x2, x3, x3, x3 
sequence of values. Even though x3 shows up multiple times, each occurence is 
treated as an individual candidate for the second largest value, meaning that the 
last two cycles have x3 as the second largest value instead of x2.
*/

module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);
/*
I think we have to create a shift register for this
the first register will store the greatest one and 
the second will store the second_largest one.
output will be always the second largest one
*/

logic [DATA_WIDTH-1:0] largest, second_largest;

always_ff @(posedge clk) begin
  if (!resetn) begin
    largest <= '0;
    second_largest <= '0;
  end
  else if (din > largest && din > second_largest) begin
    largest <= din;
    second_largest <= largest;
  end
  else if (din > second_largest) begin
    largest <= largest;
    second_largest <= din;
  end
  else begin
    largest <= largest;
    second_largest <= second_largest;
  end
end

//output is driven by second_largest
assign dout = second_largest;

endmodule
