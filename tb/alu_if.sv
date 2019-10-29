interface alu_if
  (
   input logic clk,
   input logic rst_n
  );

   logic 	clk;
   logic 	rst_n;
   logic [31:0] data_A;
   logic [1:0] 	reg_sel;
   logic [1:0] 	instr;
   logic 	valid_in;
   logic 	data_out;
   logic 	valid_out;  

endinterface
