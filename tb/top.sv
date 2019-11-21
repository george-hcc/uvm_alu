module top;
   import uvm_pkg::*;
   import pkg::*;
   logic clk;
   logic rst_n;
   
   initial begin​
      clk = 1;​
      rst_n = 1;​
      #20 rst_n = 0;​ //verificar com a equipe se o reset vai ser esse mesmo
      #20 rst_n = 1;​
   end​
   
   always #10 clk = !clk;​ //verificar com a equipe se o clk vai ser esse
   
   //Instanciar a interface e conexões
   alu_if dut_alu_if ();   
   reg_if dut_reg_if ();

   //Instanciar o dut e suas conexões

   initial begin​
   `ifdef XCELIUM​
      $recordvars();​
   `endif​
   `ifdef VCS​
      $vcdpluson;​
   `endif​
   `ifdef QUESTA​
      $wlfdumpvars();​
      set_config_int("*", "recording_detail", 1);​
   `endif​
   end

   initial begin //Inserir as duas interfaces aqui (setar elas)
      uvm_config_db#(virtual alu_if)::set(uvm_root::get(), "*", "vif", dut_alu_if); //trocar vif pelo nome da interface virutal no driver
      uvm_config_db#(virtual reg_if)::set(uvm_root::get(), "*", "vif", dut_reg_if);
   end

   initial begin
      run_test("simple_test");​
   end

endmodule : top
