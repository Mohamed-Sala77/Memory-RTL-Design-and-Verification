##**** before you run the do file change the diroctory from file->change diroctory to the recent file 


## for quit the last simulation
quit -sim

## for compile the files "we here compile with f files for more general case "
vlog -coveropt 3 +cover +acc -sv my_top.sv -v mem_dut.v

## for run the simulation
vsim -coverage -novopt -suppress 12110 work.my_top -c -do "coverage save -onexit -directive -codeAll cover_repo.ucdb"
add wave -position insertpoint sim:/my_top/dut1/clk
add wave -position insertpoint sim:/my_top/dut1/rst
add wave -position insertpoint sim:/my_top/dut1/enable
add wave -position insertpoint sim:/my_top/dut1/read_write
add wave -noupdate -height 60 -divider "divider"
add wave -position insertpoint sim:/my_top/dut1/address
add wave -position insertpoint sim:/my_top/dut1/data_in
add wave -position insertpoint sim:/my_top/dut1/data_out
add wave -position insertpoint sim:/my_top/dut1/valid_out
add wave -position insertpoint sim:/my_top/dut1/mem
 
 run -all

radix -binary -showbase
radix signal sim:/my_top/dut1/data_in unsigned -showbase
radix signal sim:/my_top/dut1/address unsigned -showbase
radix signal sim:/my_top/dut1/data_out unsigned -showbase
radix signal sim:/my_top/dut1/mem[0] unsigned -showbase
radix signal sim:/my_top/dut1/mem[1] unsigned -showbase
radix signal sim:/my_top/dut1/mem[2] unsigned -showbase
radix signal sim:/my_top/dut1/mem[3] unsigned -showbase
radix signal sim:/my_top/dut1/mem[4] unsigned -showbase
radix signal sim:/my_top/dut1/mem[5] unsigned -showbase
radix signal sim:/my_top/dut1/mem[6] unsigned -showbase
radix signal sim:/my_top/dut1/mem[7] unsigned -showbase
radix signal sim:/my_top/dut1/mem[8] unsigned -showbase
radix signal sim:/my_top/dut1/mem[9] unsigned -showbase
radix signal sim:/my_top/dut1/mem[10] unsigned -showbase
radix signal sim:/my_top/dut1/mem[11] unsigned -showbase
radix signal sim:/my_top/dut1/mem[12] unsigned -showbase
radix signal sim:/my_top/dut1/mem[13] unsigned -showbase
radix signal sim:/my_top/dut1/mem[14] unsigned -showbase
radix signal sim:/my_top/dut1/mem[15] unsigned -showbase
 
 #for generate the report
coverage report -details -output coverage_report.txt
vcover report -html cover_repo.ucdb

##vcover merge -o combined_coverage.ucdb Adds.ucdb early.ucdb Lt_fall_gen2s.ucdb Lt_fall_gen3s.ucdb Lt_fall_gen4s.ucdb Normal_gen2_1s.ucdb normal_gen3_1s.ucdb normal_gen3_2s.ucdb normal_gen4s.ucdb sbrx_gen4s.ucdb sbrx_gen2s.ucdb sbrx_gen3s.ucdb