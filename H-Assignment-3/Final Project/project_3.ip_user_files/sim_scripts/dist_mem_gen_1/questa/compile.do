vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../../project_3.gen/sources_1/ip/dist_mem_gen_1/dist_mem_gen_1_sim_netlist.vhdl" \


