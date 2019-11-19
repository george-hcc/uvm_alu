class reg_agent extends uvm_agent;
   `uvm_component_utils(reg_agent)

   uvm_analysis_port #(reg_transaction) reg_agt_port;
   reg_sequencer reg_sqr;
   reg_driver reg_drv;
   reg_monitor reg_mon;

   function new(string name = "reg_agent", uvm_component parent = null);
      super.new(name, parent);
      agt_port = new("reg_agt_port", this);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sqr = reg_sequencer::type_id::create("reg_sqr", this);
      drv = reg_driver::type_id::create("reg_drv", this);
      mon = reg_monitor::type_id::create("reg_mon", this);
   endfunction // build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      reg_mon.reg_port.connect(reg_agt_port);
      reg_drv.seq_item_port.connect(sqr.seq_item_export);
   endfunction // connect_phase

endclass // reg_agent

      
      
