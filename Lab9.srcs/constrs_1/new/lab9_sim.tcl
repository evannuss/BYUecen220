add_force clk {0 0} {1 5} -repeat_every 10
add_force -radix hex width 0000
run 163830 ns

add_force -radix hex width 3333
run 163830 ns