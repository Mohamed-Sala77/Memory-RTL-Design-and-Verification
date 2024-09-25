    class my_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(my_sequence_item)
    function new(string name ="my_sequence_item");
        super.new(name);
    endfunction

    rand bit [31:0] data;
    rand bit [3:0] address;
    rand bit enable;
    rand bit read_write;
    bit rst ;

    bit [31:0] data_out;
    bit valid_out;

    
    constraint enable_constraint {
        enable dist { 1 := 85, 0 := 15 };
    }



    virtual function string convert2string();
        return $sformatf("\nTransaction:\tdata = %0d   ,\taddress = %0d   ,\tenable = %0b   ,\tread_write = %0b   ,\trst = %0b   \ndata_out = %0d   ,\tvalid_out = %0b\n", 
            data, address, enable, read_write, rst, data_out, valid_out);
    endfunction

endclass
        