/*
Prompt

Divide an input number by a power of two and round the result to the nearest integer. The power of two is calculated using 2DIV_LOG2 where DIV_LOG2 is a module parameter. Remainders of 0.5 or greater should be rounded up to the nearest integer. If the output were to overflow, then the result should be saturated instead.
Input and Output Signals

    din - Input number
    dout - Rounded result

Example 1 (Click to Expand)

If din = 0xb and DIV_LOG2 = 2, we can calculate dout like this:

dout = din⁄2DIV_LOG2
= 0xb⁄22
= 11⁄4
= 2.75
= 3 (rounded)


Example 2 (Click to Expand)

Assume OUT_WIDTH = 2 in this example.

If din = 0xf and DIV_LOG2 = 2, we can calculate dout like this:

dout = din⁄2DIV_LOG2
= 0xf⁄22
= 15⁄4
= 3.75
= 3 (rounded with saturation)

Note that the purely mathematical approach would have rounded 3.75 up to 4, but since the output is only two bits wide in our example, the output result is saturated to 3 (b11) instead.
*/


module model #(parameter
  DIV_LOG2=3,
  OUT_WIDTH=32,
  IN_WIDTH=OUT_WIDTH+DIV_LOG2
) (
  input [IN_WIDTH-1:0] din,
  output logic [OUT_WIDTH-1:0] dout
);

always_comb begin
  dout = din[IN_WIDTH-1:DIV_LOG2];
  if(din[DIV_LOG2-1])
    if (dout != '1)
      dout = dout + 1'b1;
  else
    dout = dout;
end

/* Their Solution
logic [OUT_WIDTH:0] temp;

    assign temp = din[IN_WIDTH-1:DIV_LOG2] + din[DIV_LOG2-1];
    assign dout = (temp[OUT_WIDTH] == 1 ? din[IN_WIDTH-1:DIV_LOG2] : temp[OUT_WIDTH-1:0]);

*/
endmodule