#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2016.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 8637b5552da9405f9f7e0dc0d3f16323 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot AND_gate_tb_behav xil_defaultlib.AND_gate_tb -log elaborate.log
