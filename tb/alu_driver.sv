typedef virtual alu_if alu_vif;

class alu_driver extends uvm_driver #(alu_transaction);
   `uvm_object_utils(alu_driver)
   alu_vif vif;
   event begin_record, end_record;
   
   function new(string name = "alu_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      assert(uvm_config_db#(alu_vif)::get(this, "", "vif", vif));
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      fork
	 reset_signals();
	 get_and_drive(phase);
      join
   endtask // run_phase

   virtual task reset_signals();

   endtask // reset_signals

   virtual task get_and_drive();

   endtask // get_and_drive

   virtual task driver_transfer();

   endtask // driver_transfer

endclass // alu_driver
