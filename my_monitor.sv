    class  my_monitor  extends uvm_monitor ;
    `uvm_component_utils( my_monitor )
    uvm_analysis_port#(my_sequence_item) m_put_port;


 my_sequence_item  sequence_item;
virtual intf1 intf ;
    
function new(string name =" my_monitor " , uvm_component parent=null);
        super.new(name , parent);
    endfunction





/*----------------------------------------------------------------------------*/


/*  UVM Build Phases                                                          */

/*----------------------------------------------------------------------------*/

 function void  build_phase(uvm_phase phase);
    super.build_phase(phase);
 sequence_item =my_sequence_item::type_id::create("sequence_item", this);
 m_put_port= new("m_put_port", this);

 if (!uvm_config_db#(virtual interface intf1)::get( this,"", "my_inf", intf)) 
`uvm_fatal(get_full_name(), "Error in getting interface")
        
endfunction //build_phase

 function void  connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction //connect_phase

/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task  run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin

        // Gettin the input at negedge of the clk 
        @(negedge intf.clk);
        sequence_item.data <= intf.data_in;
        sequence_item.enable <= intf.enable;
        sequence_item.read_write <= intf.read_write;
        sequence_item.address <= intf.address;
        sequence_item.rst <= intf.rst;
        
        // Gettin the output at negedge of the clk 
        sequence_item.data_out <= intf.data_out;
        sequence_item.valid_out <= intf.valid_out;
        
        $display("---------------------------------------------------------------");
        $display(" TRANSACTION RECEIVED IN Monitor IS %p" ,$time, sequence_item.convert2string());
        $display("---------------------------------------------------------------");

        m_put_port.write(sequence_item);
    end

endtask //run_phase

endclass
