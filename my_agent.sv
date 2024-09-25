    class  my_agent  extends uvm_agent ;
    `uvm_component_utils( my_agent )

my_driver driver;
my_monitor monitor;
my_sequencer sequencer;
virtual intf1 intf ;

//*****///**** the lines in yellow in agent and the env this if you want not to distroy the abstraction of the uvm "but u can ignor that and use the normal way"
//```  uvm_analysis_port#(my_sequence_item) m_put_port;

    
function new(string name =" my_agent " , uvm_component parent=null);
        super.new(name , parent);
    endfunction


/*  UVM Build Phases                                                          */

/*----------------------------------------------------------------------------*/

 function void  build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver       = my_driver::type_id::create("driver", this);
    monitor    = my_monitor::type_id::create("monitor", this);
    sequencer = my_sequencer::type_id::create("sequencer", this);

if (!uvm_config_db#(virtual intf1)::get(this,"", "my_inf", intf))
`uvm_fatal(get_full_name(), "Error in getting interface")

uvm_config_db#(virtual intf1)::set(this,"driver", "my_inf", intf);
uvm_config_db#(virtual intf1)::set(this,"monitor", "my_inf", intf);

//```  m_put_port= new("m_put_port", this);
        
endfunction //build_phase

 function void  connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);

    //`` monitor.m_put_port.connect(m_put_port);    
endfunction //connect_phase

/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task  run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask //run_phase
endclass