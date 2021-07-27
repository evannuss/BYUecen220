add_force clk {0 0} {1 5} -repeat_every 10
add_force -radix hex sw 333
run 163830 ns

add_force -radix hex sw fff
run 163830 ns

add_force -radix hex sw 999
run 163830 ns
