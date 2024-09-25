    class  my_sequencer  extends uvm_sequencer  #(my_sequence_item);
    `uvm_component_utils( my_sequencer )

my_sequence_item sequence_item;
    
function new(string name =" my_sequencer " , uvm_component parent=null);
        super.new(name , parent);
    endfunction


 




/*----------------------------------------------------------------------------*/


/*  UVM Build Phases                                                          */

/*----------------------------------------------------------------------------*/

 function void  :build_phase(uvm_phase phase);
    super.build_phase(phase);
sequence_item   = my_sequence_item::type_id::create("sequence_item");
        
endfunction //build_phase

 function void  :connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction //connect_phase


/*----------------------------------------------------------------------------*/
/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task  :run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask //run_phase

endclass

