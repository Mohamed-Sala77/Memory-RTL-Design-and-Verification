    class my_env  extends uvm_env ;
    `uvm_component_utils(my_env )

my_agent agent;
my_scoreboard scoreboard;
my_subscriber subscriber;
virtual intf1 intf ;

    
function new(string name ="my_env " , uvm_component parent=null);
        super.new(name , parent);
    endfunction



 function void build_phase(uvm_phase phase);
   
 super.build_phase(phase);
    agent          = my_agent::type_id::create("agent", this);
    scoreboard = my_scoreboard::type_id::create("scoreboard", this);
    subscriber  = my_subscriber::type_id::create("subscriber", this);

//configuration of resources
if (!uvm_config_db#(virtual intf1)::get(this,"","my_inf",intf))
`uvm_fatal(get_full_name(), "Error in getting interface")

uvm_config_db#(virtual intf1)::set(this,"agent","my_inf",intf);
        
endfunction //build_phase

 function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.m_put_port.connect(subscriber.analysis_export);
    agent.monitor.m_put_port.connect(scoreboard.m_put_imp);

    //``` agent.m_put_port.connect(subscriber.analysis_export);
    //``` agent.m_put_port.connect(scoreboard.m_put_imp);

endfunction //connect_phase


/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

 task run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask //run_phase
endclass
