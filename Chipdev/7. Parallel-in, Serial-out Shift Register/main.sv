/*
7. Parallel-in, Serial-out Shift Register
Easy
Prompt

Build a circuit that takes the multi-bit input (din) and shifts the input 
value’s least significant bit (rightmost bit) to the single-bit output (dout) 
one bit at a time.

The circuit should begin shifting the input’s least significant bit when the 
the input enable signal (din_en) goes high. In other words, the input enable 
signal going high indicates that this circuit should start shifting the current 
input signal from it’s least significant bit, regardless of which bits the 
circuit has already shifted.

If all the input’s bits have been shifted to the output so that there are no 
more bits to shift, the output must output 0.

When reset (resetn) is active, the input value that is being shifted is treated 
as 0. Even when reset goes back to being inactive, the input value will still be 
treated as 0, unless the input enable signal makes the circuit begin shifting 
from the input again.
Input and Output Signals

    clk - Clock signal
    resetn - Synchronous reset-low signal
    din - Input signal
    din_en - Enable signal for input data
    dout - Output signal

Output signals during reset

    dout - 0 when resetn is active

Example 1
Assume DATA_WIDTH = 8 in this example.

We only begin shifting values when din_en goes high. Even when the input value 
changes to 0, the output will continue shifting the 11111011 value loaded in 
when din_en went high.

Once resetn goes active, the input value that is being shifted is treated as 
0 instead of the remaining 1111 bits. Even after resetn goes back to being 
inactive, the input is still treated as 0, until din_en allows us to begin 
shifting a new value.

Example 2
Assume DATAWIDTH = 8 in this example.

In this example we hold din_en high for three cycles, which results in the 
output always restarting its shifting of input from it's rightmost 1 bit. 
Only when din_en goes inactive does the shifting of input proceed normally 
without being restarted.

Example 3 (Click to Expand)

See how resetn takes priority over din_en, such that the output is always 0 
despite din_en being active and having a value ready to shift from input.\

Example 4 (Click to Expand)

Assume DATAWIDTH = 8 in this example.

In this example we pad the output with 0 after we have finished shifing all 
eight bits of din.
*/


module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  input din_en,
  output logic dout
);

logic [DATA_WIDTH-1:0] din_reg;
logic [$clog2(DATA_WIDTH) - 1: 0] count;


always @(posedge clk) begin
  if(!resetn) begin
    din_reg <= '0;
    count <= 0;
  end
  else begin
    if(din_en) begin
      count <= 0;
      din_reg <= din;
    end
    else begin
      din_reg <= din_reg;
      if(count < DATA_WIDTH)
        count <= count + 1;
      else begin
        count <= DATA_WIDTH;
        din_reg <= 0;
      end
    end
  end
end
/*
Their Solution
    logic [DATA_WIDTH-1:0] temp;

    always @(posedge clk) begin
        if (!resetn) begin
            temp <= 0;
        end else if (din_en) begin
            temp <= din;
        end else begin
            temp <= temp >> 1;
        end
     end

    assign dout = temp[0];

*/
assign dout = din_reg[count];
endmodule