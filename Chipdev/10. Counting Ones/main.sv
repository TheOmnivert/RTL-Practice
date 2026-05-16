/*
Prompt

Given an input binary value, output the number of bits that are equal to 1.
Input and Output Signals

    din - Input value
    dout - Number of 1's in the input value

Example (Click to Expand)

b1011 has three 1's and b0000 has zero 1s. This will be more clear 
if you change the waveform to display values in binary format.
*/
module model #(parameter
  DATA_WIDTH = 16
) (
  input [DATA_WIDTH-1:0] din,
  output logic [$clog2(DATA_WIDTH):0] dout
);


always_comb begin
  dout = 0;
  for(int i=0; i < DATA_WIDTH; i++) begin
      dout = dout + din[i];  
  end
end
endmodule