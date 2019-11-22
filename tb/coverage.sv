class coverage extends uvm_component;​
  `uvm_component_utils(coverage)​
 
  alu_transaction alu_tr;​
  uvm_analysis_imp#(alu_transaction, coverage) alu_port;​
  int min_tr;​
  int n_tr = 0;​
  event end_of_simulation;​

  function new(string name = "coverage", uvm_component parent= null);​
    super.new(name, parent);​
    alu_port = new("alu_port", this);​
    alu_tr=new;​
    min_tr = 100;​
  endfunction​

  function void build_phase(uvm_phase phase);​
    super.build_phase (phase);​
  endfunction​

  task run_phase(uvm_phase phase);​
    phase.raise_objection(this);​
    @(end_of_simulation);​
    phase.drop_objection(this);​
  endtask: run_phase​

  function void write(alu_transaction t);​
    n_tr = n_tr + 1;​
    if(n_tr >= min_tr)begin​
      ->end_of_simulation;​
    end​
  endfunction: write​

  

covergroup tx_word_format_cg
  with function sample(bit[5:0] lcr);

  option.name = "tx_word_format";
  option.per_instance = 1;

  WORD_LENGTH: coverpoint lcr[1:0] {
    bins bits_5 = {0};
    bins bits_6 = {1};
    bins bits_7 = {2};
    bins bits_8 = {3};
  }

  STOP_BITS: coverpoint lcr[2] {
    bins stop_1 = {0};
    bins stop_2 = {1};
  }

  PARITY: coverpoint lcr[5:3] {
    bins no_parity = {3'b000, 3'b010, 3'b100, 3'b110};
    bins even_parity = {3'b011};
    bins odd_parity = {3'b001};
    bins stick1_parity = {3'b101};
    bins stick0_parity = {3'b111};
  }

  WORD_FORMAT: cross WORD_LENGTH, STOP_BITS, PARITY;

endgroup: tx_word_format_cg













endclass : coverage​