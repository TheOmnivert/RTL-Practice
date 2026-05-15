/*
Prompt

Build a circuit that generates a Gray code sequence starting from 0 on the 
output (dout).

Gray code is an ordering of binary numbers such that two successive values only 
have one bit difference between them. For example, a Gray code sequence for a 
two bit value could be:

b00
b01
b11
b10

The Gray code sequence should use the standard encoding. In the standard 
encoding the least significant bit follows a repetitive pattern of 2 on, 2 off 
( ... 11001100 ... ); the next digit a pattern of 4 on, 4 off 
( ... 1111000011110000 ... ); the nth least significant bit a 
pattern of 2n on 2n off.

When the reset-low signal (resetn) goes to 0, the Gray code sequence should 
restart from 0.
Input and Output Signals

    clk - Clock signal
    resetn - Synchronous reset-low signal
    out - Gray code counter value

Output signals during reset

    out - 0 when resetn is active

Example (Click to Expand)

The first four expected outputs starting from and 0 are b0000, b0001, b0011, 
b0010, and b0110. Even though b0000, b0010, b0110, b0100, and b0101 is also a 
sequence that only changes a single bit each time, it is not the sequence that 
follows the standard encoding in the problem statement.

When resetn goes active again, the Gray code restarts from 0. Note that when 
out is x it means out can be any value and will not be checked by the code judge. 
You should not explicitly drive out to x.

The Gray code transition will be more clear if you change the waveform to 
display values in binary format.
*/

module model #(parameter
  DATA_WIDTH = 4
) (
  input clk,
  input resetn,
  output logic [DATA_WIDTH-1:0] out
);
logic [DATA_WIDTH-1:0] binary, gray;

always @(posedge clk) begin
  if(!resetn) begin
    binary <= 1'b1;
    gray <= '0;
  end
  else begin
    binary <= binary + 1'b1;
    gray <= binary ^ (binary >> 1);
  end
end
assign out = gray;


/*Their SOlution:
    logic [DATA_WIDTH-1:0] q, temp;

    always @ (posedge clk) begin
        if (!resetn) begin
            temp <= 0;
            q <= 1;
        end else begin
            q <= q + 1;

            for (int i = 0; i < DATA_WIDTH-1; i=i+1) begin
                temp[i] <= q[i+1] ^ q[i];
            end

            temp[DATA_WIDTH-1] <= q[DATA_WIDTH-1];
        end
    end

    assign out = temp;
*/
endmodule