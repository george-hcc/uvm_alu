class alu_sequencer extends uvm_sequencer;
   `uvm_object_utils(alu_sequencer);

   function new(string name = "alu_sequencer", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

endclass: alu_sequencer
