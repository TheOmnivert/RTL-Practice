/*
Prompt

Build a circuit that pulses dout one cycle after the rising edge of din. A pulse 
is defined as writing a single-cycle 1 as shown in the examples below. When resetn 
is asserted, the value of din should be treated as 0.

Bonus - can you enhance your design to pulse dout on the same cycle as the rising 
edge? Note that this enhancement will not pass our test suite, but is still a 
useful exercise.

Input and Output Signals

    clk - Clock signal
    resetn - Synchronous reset-low signal
    din - Input signal
    dout - Output signal

Output signals during reset

    dout - 0 when resetn is active

Example 1 (Click to Expand)

Even if din maintains a value of 1 for mulitple cycles after its rising edge, 
dout's pulse should only last for exactly one cycle.

Example 2 (Click to Expand)

If din has multiple rising edges, dout will have multiple pulses.

Example 3 (Click to Expand)

If resetn goes low in the same cycle as the input's rising edge, the resetn 
specification takes priority. This means the output is 0, instead of a pulse.
*/
module model (
  input clk,
  input resetn,
  input din,
  output dout
);
logic din_prev, dout_reg;

always @(posedge clk) begin
  if(~resetn)
    din_prev <= 0;
  else
    din_prev <= din;
end

always @(posedge clk) begin
  if (!resetn)
    dout_reg <= 0;
  else begin
    if(din & ~din_prev)
      dout_reg <= 1;
    else 
      dout_reg <= 0;
  end
end
assign dout = dout_reg;

//My same cycle edge detection solution
// assign dout = (din & ~din_prev) ? 1 : 0;

//Their solution using FSM
/*
    parameter S00=0, S01=1, S10=2, S11=3;
    logic [1:0] state;

    always @(posedge clk) begin
        if (!resetn) begin
            state <= S00;
        end else begin
            case (state)
                S00 : state <= (din ? S01 : S00);
                S01 : state <= (din ? S11 : S10);
                S10 : state <= (din ? S01 : S00);
                S11 : state <= (din ? S11 : S10);
            endcase
        end
    end

    assign dout = (state == S01);
*/
endmodule