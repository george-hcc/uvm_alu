typedef virtual alu_if alu_vif;

class alu_driver extends uvm_driver #(alu_transaction);
   `uvm_object_utils(alu_driver)
   alu_vif vif;
   alu_transaction tr;
   
   function new(string name = "alu_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(alu_vif)::get(this, "", "vif", vif))
	`uvm_fatal("NOVIF", "failed to get virtual interface")
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      get_and_drive(phase);
   endtask // run_phase

   virtual task get_and_drive(uvm_phase phase);
      wait (alu_vif.rst_n === 0);
      @(posedge alu_vif.rst_n);
      forever begin
	 seq_item_port.get_next_item(tr);
	 driver_transfer(tr);
	 seq_item_port.item_done();
      end
   endtask // get_and_drive

   virtual task driver_transfer(alu_transaction tr);
      @(posedge alu_vif.clk);
      alu_vif.data_A   <= tr.data_in;
      alu_vif.reg_sel  <= tr.reg_sel;
      alu_vif.instr    <= tr.instr;
      alu_vif.valid_in <= tr.valid_in;
      @(posedge alu_vif.valid_out);
   endtask // driver_transfer
   
endclass // alu_driver
