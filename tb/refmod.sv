class refmod extends uvm_component;
   `uvm_component_utils(refmod)

   alu_transaction alu_tr_in;
   reg_transaction reg_tr_in;
   alu_transaction ref_tr_out;

   uvm_analysis_imp #(alu_transaction, refmod) alu_in;
   uvm_analysis_imp #(reg_transaction, refmod) reg_in;
   uvm_analysis_port #(alu_transaction) out;

   event begin_reftask, begin_record, end_record;

   function new(string name = "refmod", uvm_component parent);
      super.new(name, parent);
      alu_in = new("alu_in", this);
      reg_in = new("reg_in", this);
      out = new("out", this);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction // build_phase

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      fork
	 refmod_task();
      join
   endtask // run_phase

endclass // refmod

	 
   
   
