    class my_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(my_scoreboard)
    
        // Declare variables to store the sequence item and counts
        my_sequence_item sequence_item;
        my_sequence_item expected_item;
        int correct_count;
        int error_count;
        event   run ;

         bit [31:0] mem [16];


        uvm_analysis_imp#(my_sequence_item, my_scoreboard) m_put_imp;
    
        // Constructor
        function new(string name, uvm_component parent);
            super.new(name, parent);
            correct_count = 0;
            error_count = 0;
        endfunction


    //  UVM Build Phases
        function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequence_item =my_sequence_item::type_id::create("sequence_item", this);
        expected_item =my_sequence_item::type_id::create("expected_item", this);


        m_put_imp = new("m_put_imp",this);
    endfunction

    
        /*---  UVM Run Phases ---*/
        /*----------------------------------------------------------------------------*/
        task run_phase(uvm_phase phase);
        
            super.run_phase(phase);
            
    
            forever begin

                @(run);

                ref_model(sequence_item, expected_item);
                compare(sequence_item, expected_item);
    

            end
        endtask // run_phase
    
        function void write(my_sequence_item t);
        sequence_item = t;
            ->run;
        endfunction // write


        // reprort phase will executed after all run_phase is completed
    
        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase", $sformatf("Total successful transactions: %0d", correct_count), UVM_MEDIUM);
            `uvm_info("report_phase", $sformatf("Total failed transactions: %0d", error_count), UVM_MEDIUM);
        endfunction // report_phase



    
        ////____________________________Reference model

        task ref_model(input my_sequence_item t, ref my_sequence_item expected_item);
        

             
             $display("---------------------------------------------------------------");
             $display(" TRANSACTION RECEIVED IN scoreboard IS %p", sequence_item.convert2string());
             $display("---------------------------------------------------------------");


           
            if (!t.rst) begin
                // Reset behavior: all memory locations are set to zero
                for (int i = 0; i < 16; i++) begin
                    mem[i] = 32'b0;
                end
                expected_item.data_out = 32'b0;
                expected_item.valid_out = 1'b0;
            end else if (t.enable) begin
                if (t.read_write) begin
                    // Write operation
                    mem[t.address] = t.data;
                    expected_item.valid_out = 1'b0;
                end else begin
                    // Read operation
                    expected_item.data_out = mem[t.address];
                    expected_item.valid_out = 1'b1;
                end
            end
            else begin
                // No operation
                expected_item.data_out = 32'b0;
                expected_item.valid_out = 1'b0;
            end
        endtask // ref_model

        task  compare(input my_sequence_item sequence_item, input my_sequence_item expected_item);
                            // Compare actual and expected results
        if (sequence_item.data_out == expected_item.data_out && 
        sequence_item.valid_out == expected_item.valid_out) begin
        correct_count++;
    end else begin
        error_count++;
        `uvm_error("COMPARE", $sformatf("Mismatch: Actual data_out=%0d, expected data_out=%0d, Actual valid_out=%0b, expected valid_out=%0b",
                                        sequence_item.data_out, expected_item.data_out,
                                        sequence_item.valid_out, expected_item.valid_out))
    end
        endtask 
    endclass