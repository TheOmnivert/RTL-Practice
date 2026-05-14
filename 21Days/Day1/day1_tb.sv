// A simple TB for mux

module day1_tb ();

  // Write your Testbench here...
  reg [7:0] a_i, b_i;
  reg sel_i;
  wire [7:0] y_o;
  
  day1 dut (
    .a_i(a_i), 
    .b_i(b_i), 
    .sel_i(sel_i), 
    .y_o(y_o)
  );
  
  initial begin
  	a_i = 0; b_i = 0; sel_i = 0;
  	#10 a_i = 1; b_i = 8; sel_i = 0;
  	#10 a_i = 2; b_i = 9; sel_i = 0;
  	#10 a_i = 3; b_i = 10; sel_i = 0;
  	#10 a_i = 4; b_i = 11; sel_i = 0;
  	#10 a_i = 5; b_i = 12; sel_i = 1;
  	#10 a_i = 6; b_i = 13; sel_i = 1;
  	#10 a_i = 7; b_i = 14; sel_i = 1;
    
  end
  always @(*) begin
    if(sel_i && y_o == b_i)
      $display("B is selected");
    else if (!sel_i && y_o == a_i)
      $display("A is selected");
    else
      $error("error");
  end
endmodule
