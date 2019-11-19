class reg_sequencer extends uvm_sequencer;
   `uvm_object_utils(reg_sequencer);

   function new(string name = "reg_sequencer", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

endclass: reg_sequencer
