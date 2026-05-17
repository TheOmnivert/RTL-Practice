/*
Prompt

Given a value, output its index in the standard Gray code sequence. This is 
known as converting a Gray code value to binary.

Each input value's binary representation is an element in the Gray code sequence, 
and your circuit should output the index of the Gray code sequence the input 
value corresponds to.

In the standard encoding the least significant bit follows a repetitive pattern 
of 2 on, 2 off ( ... 11001100 ... ); the next digit a pattern of 4 on, 4 off 
( ... 1111000011110000 ... ); the nth least significant bit a 
pattern of 2n on 2n off.

Input and Output Signals

    gray - Input signal, interpreted as an element of the Gray code sequence
    bin - Index of the Gray code sequence the input corresponds to

Example (Click to Expand)

Set the input signal gray to the binary representation and the output signal 
bin to decimal representation to better understand this example.

If we assume DATA_WIDTH = 4 for this example, then the Gray code sequence and 
its indices are:

b0000 (index 0)
b0001 (index 1)
b0011 (index 2)
b0010 (index 3)
b0110 (index 4)
b0111 (index 5)
b0101 (index 6)
b0100 (index 7)
b1100 (index 8)
b1101 (index 9)
b1111 (index 10)
b1110 (index 11)
b1010 (index 12)
b1011 (index 13)
b1001 (index 14)
b1000 (index 15)

The input b0110 results in an ouput of 4 because b0110 corresponds to the 4th 
index of the Gray code sequence. Similarly, the input b1110 results in an output 
of 11 because b1110 corresponds to the 11th index of the Gray code sequence.

*/
module model #(parameter
  DATA_WIDTH = 16
) (
  input [DATA_WIDTH-1:0] gray,
  output logic [DATA_WIDTH-1:0] bin
);

always_comb begin
  bin[DATA_WIDTH-1] = gray[DATA_WIDTH-1];
  for(int i=DATA_WIDTH-1; i>0; i--) begin
    bin[i-1] = gray[i-1] ^ bin[i];
  end
end


/*
 int i;
    logic [DATA_WIDTH-1:0] temp;

    always @(*) begin
        for(i=0; i<DATA_WIDTH; i++) begin
            temp[i] = ^(gray >> i);
        end
    end

    assign bin = temp;
*/


/*
uint GrayToBinary(uint num)
{
    uint mask = num;
    while (mask) {   
    // Each Gray code bit is exclusive-ored with all more significant bits.
        mask >>= 1;
        num   ^= mask;
    }
    return num;
}
*/

endmodule