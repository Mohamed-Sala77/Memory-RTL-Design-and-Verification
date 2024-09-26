class  my_subscriber extends uvm_subscriber #(my_sequence_item);
`uvm_component_utils( my_subscriber  )

my_sequence_item sequence_item;


covergroup group_1;
Input_Data: coverpoint sequence_item.data {
    bins Input_Data[3] = {0 , 32'hFFFF_FFFF,[1:32'hFFFF_FFFE]};
    }

Address: coverpoint sequence_item.address {
    bins Address[] = {[0:15]};
}

Write_Read: coverpoint sequence_item.read_write{
    bins Write[] = {0,1};
}

Enable : coverpoint sequence_item.enable{
    bins Enable[] = {0,1};
}


Address_Write: cross Address, Write_Read , Enable;
endgroup

function new(string name =" my_subscriber  " , uvm_component parent=null);
    super.new(name , parent);
    group_1=new();
endfunction









/*----------------------------------------------------------------------------*/


/*  UVM Build Phases                                                          */

/*----------------------------------------------------------------------------*/

function void  build_phase(uvm_phase phase);
super.build_phase(phase);
sequence_item   = my_sequence_item::type_id::create("sequence_item,this");
    
endfunction //build_phase



function void  connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction //connect_phase


/*----------------------------------------------------------------------------*/
/*  UVM Run Phases                                                            */
/*----------------------------------------------------------------------------*/

task  run_phase(uvm_phase phase);
super.run_phase(phase);
endtask //run_phase


function void write(my_sequence_item t) ;
sequence_item = t ;

$display("---------------------------------------------------------------");
$display(" TRANSACTION RECEIVED IN Subscriber IS %p",sequence_item.convert2string());
$display("---------------------------------------------------------------");

group_1.sample();

endfunction //write

endclass
