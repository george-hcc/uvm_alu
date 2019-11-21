class alu_agent extends uvm_agent;
   `uvm_component_utils(alu_agent)

   typedef uvm_sequencer#(alu_transaction) alu_sequencer;
   alu_sequencer alu_sqr;
   alu_driver alu_drv;
   alu_monitor alu_mon;

   uvm_analysis_port #(alu_transaction) alu_agt_port;
   uvm_analysis_port #(ref_transaction) ref_agt_port;
   
   function new(string name = "alu_agent", uvm_component parent = null);
      super.new(name, parent);
      alu_agt_port = new("alu_agt_port", this);
      ref_agt_port = new("ref_agt_port", this);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sqr = alu_sequencer::type_id::create("alu_sqr", this);
      drv = alu_driver::type_id::create("alu_drv", this);
      mon = alu_monitor::type_id::create("alu_mon", this);
   endfunction // build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      alu_mon.alu_mon_port.connect(alu_agt_port); // mon -> refmod/coverage
      ref_mon.alu_ref_port.connect(ref_agt_port); // mon -> comparator
      alu_drv.seq_item_port.connect(sqr.seq_item_export); // sqr -> drv
   endfunction // connect_phase

endclass // alu_agent
