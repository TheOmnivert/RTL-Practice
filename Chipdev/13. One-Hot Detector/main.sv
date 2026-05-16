/*
Prompt

One-hot values have a single bit that is a 1 with all other bits being 0. Output a 1 if the input (din) is a one-hot value, and output a 0 otherwise.
Input and Output Signals

    din - Input value
    onehot - 1 if the input is a one-hot value and 0 otherwise

Example (Click to Expand)

x40 = b1000000 is one-hot because it has a single 1 bit.
x41 = b1000001 is not one-hot because it has multiple 1 bits.
*/

module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic onehot
);

always_comb begin
  onehot = 1'b0;
  if(((din) & (din-1)) == '0 && din != 0)
    onehot = 1'b1;

end
/*their solution
    int i;
    logic [DATA_WIDTH-1:0] num_ones;

    always @(*) begin
        num_ones = 0;
        for (i=0; i < DATA_WIDTH; i++) begin
            num_ones += din[i];
        end
    end

    assign onehot = (num_ones == 1);
*/
endmodule