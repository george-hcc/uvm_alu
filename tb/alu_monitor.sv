class alu_monitor extends uvm_monitor;
   `uvm_component_utils(monitor)

   alu_vif vif;
   event begin_record, end_record;
   alu_transaction tr;
   uvm_analysis_port #(alu_transaction) alu_port;

   function new(string name = "alu_monitor", uvm_component parent = null);
      super.new(name, parent);
      alu_port = new("alu_port", this);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(alu_vif)::get(this, "", "vif", vif))
	 `uvm_fatal("NOVIF", "failed to get virtual interface")
      tr = alu_transaction::type_id::create("alu_tr", this);

   endfunction // build_phase

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      fork
	 collect_transaction(phase);
      join
   endtask // run_phase

   virtual task collect_transaction(uvm_phase phase);
      forever begin
	 @(posedge vif.clk);
	 if(vif.rst_n) begin
	    begin_tr(tr, "alu_tr");
	    tr.data_in   = vif.data_A;
	    tr.reg_sel   = vif.reg_sel;
	    tr.intr      = vif.intr;
	    tr.valid_in  = vif.valid_in;
	    tr.data_out  = vif.data_out;
	    tr.valid_out = vif.valid_out;
	    alu_port.write(tr);
	    @(negedge vif.clk);
	    end_tr(tr);
	 end // if (vif.rst_n)
      end // forever begin
   endtask // collect_transaction

endclass // alu_monitor
