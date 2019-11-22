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

endclass : coverage​