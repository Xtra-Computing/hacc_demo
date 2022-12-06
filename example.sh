#!/bin/bash

# 0. Keep the above two lines unchanged for slurm env setup




# 1. modify the following file/path name to yours.
# your program must be exsit in "/${data}/${username}/${path}/"
# "/data" is a shared directory with the host and VMs, you can use it to transfer data/programs.
# In this example, we have the following file structure:
# /data
#   ├── ...
#   └── xtra_test
#       ├── test_u250
#       │   ├── burst_rw
#       │   └── vadd.xclbin
#       └── test_u280
#           ├── burst_rw
#           └── vadd.xclbin

username=${USER}
path=fpga_example
app=host.app
fpga=fpga.xclbin



# 2. Setup a temp workspace in the VM. We provide the following shell function that can be directly used.
function init_env
{
    # 2.1 Relocate working dir on vm.
    workdir=/tmp/${username}
    rm -rf ${workdir}
    mkdir -p ${workdir}
    cd ${workdir}

    # 2.2 Make a new direction in /data/${username}/log/ to save the log and results.
    time_string=`date +%Y_%m_%d_%H_%M_%S`
    log_path=/data/${username}/log/${app}_test_log_${time_string}
    mkdir -p ${log_path}

    # 2.3 Setup XRT environment.
    source /opt/xilinx/xrt/setup.sh

    # 2.4 Scan cards (you can get the card id from scan.log).
    /opt/xilinx/xrt/bin/xbutil  examine  | tee ${log_path}/scan.log
}

function prepare_on_vm
{
    init_env
    # 2.5 copy your applicaitons to vm
    # NOTE:
    #      your application files should be already in "/${data}/${username}/${path}/" path
    #      In this example, in the host side, we manually copy the host program "burst_rw" and fpga bitstream "vadd.xclbin" to "/data/xtra_test/test_u250/".
    #            Then, in the vm side, the following script command copy them from /data to its working direction.

    cp /data/${username}/${path}/${app}  ${workdir} >  ${log_path}/copy.log 2>&1
    cp /data/${username}/${path}/${fpga} ${workdir} >> ${log_path}/copy.log 2>&1
    chmod +x ./${app}
}



# Call the function
prepare_on_vm

# Only for demo
sleep 10

# 3. Run your program on VMs.
./${app} ${fpga} | tee  ${log_path}/exec.log


# 4. To hot reset the FPGA board, please call the following function.
function reset_fpga
{
    board_id=$(/opt/xilinx/xrt/bin/xbutil examine | grep "\[" | awk '{print$1}' | sed 's/\[//' | sed 's/\]//')
    /opt/xilinx/xrt/bin/xbutil reset -d ${board_id} --force
}
#reset_fpga >>  ${log_path}/exec.log 2>&1