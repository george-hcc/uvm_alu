import "DPI-C" context function int my_alu(int a, int b, int op);

`uvm_analysis_imp_decl(_alu)
`uvm_analysis_imp_decl(_reg)

class refmod extends uvm_component;
   `uvm_component_utils(refmod)

   alu_transaction alu_tr_in;
   reg_transaction reg_tr_in;
   ref_transaction ref_tr_out;

   uvm_analysis_imp #(alu_transaction, refmod) alu_pin;
   uvm_analysis_imp #(reg_transaction, refmod) reg_pin;
   uvm_analysis_port #(ref_transaction) ref_pout;

   event begin_refmodtask, begin_record, end_record;

   logic [15:0] ref_regs [4];

   function new(string name = "refmod", uvm_component parent);
      super.new(name, parent);
      alu_pin = new("alu_pin", this);
      reg_pin = new("reg_pin", this);
      ref_pout = new("ref_pout", this);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      ref_regs = {16'hC4F3, 16'hB45E, 16'hD1E5, 16'h1DE4};
   endfunction // build_phase

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      fork
	 refmod_task();
	 record_tr();
      join
   endtask // run_phase

   task refmod_task();
      forever begin
	 @begin_refmodtask;
	 ref_tr_out = ref_transaction::type_id::create("ref_tr_out", this);
	 -> begin_record;
	 ref_tr_out.data_out = my_alu(alu_tr_in.data_in, ref_regs[alu_tr_in.reg_sel], alu_tr_in.instr);
	 #10;
	 -> end_record;
	 ref_pout.write(ref_tr_out);
      end
   endtask // refmod_task

   virtual function write_alu (alu_transaction tr);
      alu_tr_in = alu_transaction#()::type_id::create("alu_tr_in", this);
      alu_tr_in.copy(tr);
      if(alu_tr_in.valid_in)
	-> begin_refmodtask;
   endfunction // write_alu

   virtual function write_reg (reg_transaction tr);
      reg_tr_in = reg_transaction#()::type_id::create("reg_tr_in", this);
      reg_tr_in.copy(tr);
      if(reg_tr_in.valid_reg)
	#1 ref_regs[reg_tr_in.addr] = reg_tr_in.data_in;
   endfunction // write_reg

   virtual task record_tr();
      forever begin
	 @begin_record;
	 begin_tr(ref_tr_out, "refmod");
	 @end_record;
	 end_tr(ref_tr_out);
      end
   endtask // record_tr	 

endclass // refmod

	 
   
   
