IFS = ../tb/alu_if.sv

PKGS = ./tb/pgk.sv

RTL = ../src/datapath.sv \
../src/mux.sv \
../src/rb.sv \
../src/ula.sv

RUN_ARGS_COMMON = -access +r -input ./shm.tcl \
+uvm_Set_config_int=*, recording_detail,1 -coverage all -covoverwrite

sim:
	xrun -64bit -uvm $(PKGS) $(IFS) $(RTL) ../tb/top.sv -sv_lib test.so \
+UVM_TESTNAME=simple_test -covtest simple_test $(RUN_ARGS_COMMON)
