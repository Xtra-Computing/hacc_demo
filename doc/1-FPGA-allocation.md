## Demo 1:  FPGA Allocation


HACC@NUS cluster adopts [Slurm](https://slurm.schedmd.com/documentation.html) job scheduler to manage hardware resource. 
In order to run an __FPGA accelerated__ task, you must submit a slurm job request to the scheduler, by requesting how much time you want, what type of resources you require. We suggest the user to learn basic knowledge of Slurm, and [here](https://github.com/Xtra-Computing/hacc_demo/tree/main/doc/slurm.pdf) is a command cheat sheet for using Slurm.



This demo gives a brief introduction on different ways of allocating FPGA boards in HACC@NUS using Slurm. 



### Cluster Status

In ```hacchead```, you can run sinfo to see the node status, an example of output can be found here:

```
user@hacchead:~$ sinfo
PARTITION                              AVAIL  TIMELIMIT  NODES  STATE NODELIST
cpu_only*                                 up 7-00:00:00      1    mix hacc-node2
head                                      up 2-00:00:00      1   unk* hacchead
u50_standard_reservation_pool             up   12:00:00      1   idle hacc-u50-1
vck5000_compile                           up 7-00:00:00      1   idle hacc-node0
vck5000_qdma                              up      30:00      3   idle hacc-vck5000-[2-4]
u250_standard_reservation_pool            up   12:00:00      5   idle hacc-u250-[1-4],hacc-u250-frp
u280_standard_reservation_pool            up   12:00:00      2   idle hacc-u280-[1-2]
u250_long_reservation_pool                up 2-00:00:00      4   idle hacc-u250-[1-4]
u280_long_reservation_pool                up 2-00:00:00      2   idle hacc-u280-[1-2]
frp_test                                  up 20-00:00:0      1   idle hacc-u250-frp
p2p_test                                  up 20-00:00:0      1  alloc hacc-gpu2
mi210_u250_u55c                           up 7-00:00:00      1   idle hacc-gpu1
mi210_vck_u55c                            up 7-00:00:00      1    mix hacc-gpu3
mi210_vck_u55c                            up 7-00:00:00      1  alloc hacc-gpu2
mi100                                     up 7-00:00:00      2   idle hacc-gpu[4-5]
u250_1                                    up   12:00:00      1   idle hacc-u250-1
u250_2                                    up   12:00:00      1   idle hacc-u250-2
u250_3                                    up   12:00:00      1   idle hacc-u250-3
u250_4                                    up   12:00:00      1   idle hacc-u250-4
amd_gpu                                   up 7-00:00:00      1   idle hacc-gpu0
xilinx_u280_xdma_201920_3                 up    1:00:00      2   idle hacc-u280-[1-2]
xilinx_u50_gen3x16_xdma_201920_3          up    1:00:00      1   idle hacc-u50-1
xilinx_u250_gen3x16_xdma_3_1_202020_1     up    1:00:00      4   idle hacc-u250-[1-4]
xilinx_u250_gen3x16_xdma_4_1_202210_1     up    1:00:00      1   idle hacc-gpu1
xilinx_u55c_gen3x16_xdma_3_202210_1       up    1:00:00      1    mix hacc-gpu3
xilinx_u55c_gen3x16_xdma_3_202210_1       up    1:00:00      1  alloc hacc-gpu2
xilinx_u55c_gen3x16_xdma_3_202210_1       up    1:00:00      1   idle hacc-gpu1
xilinx_vck5000_gen4x8_qdma_2_202220_1     up    1:00:00      1    mix hacc-gpu3
xilinx_vck5000_gen4x8_qdma_2_202220_1     up    1:00:00      1  alloc hacc-gpu2
xilinx_vck5000_gen4x8_qdma_2_202220_1     up    1:00:00      4   idle hacc-node0,hacc-vck5000-[2-4]
xilinx_vck5000_gen3x16_xdma_1_202120_1    up    1:00:00      1   idle hacc-vck5000-1


``` 



- The __PARTITION__ column lists the hardware you can access.
- The __AVAIL__ column shows the availability of the corresponding partition.
- The __TIMELIMIT__ column shows the maximum time you can allocate.
- The __STATE__ column shows the current state of the partition.
    + If the state is _idle_, it is ready to use with full capacity.
    + If the state is _alloc_, the node of the partition is allocated and cannot be allocated now. Your request will be put into the waitlist.
    + If the state is _mix_, it means the hardware resources including CPU/GPU/FPGA are now used by others. Your allocation is under the risk of resource conflict.



You can monitor the resource queues by running ```squeue```


```
user@hacchead:~$ squeue 
             JOBID PARTITION       NAME     USER  ST       TIME  NODES NODELIST(REASON)
              2137  cpu_only       bash    user1   R      26:54      1 hacc-node2
              2138  frp_test  script.sh    user2   R       9:37      1 hacc-u250-frp
              2056 inner_tes   interact    user3   R 5-00:28:10      1 hacc-gpu3
              2129  p2p_test       bash    user1   R    4:50:19      1 hacc-gpu2

```


### Interactive Job
login in the FPGA node in the bash shell by running the following command:
```
srun -p u250_standard_reservation_pool  -n 1 --pty bash –i

```
or you can just use the provide script tool:

```
./env/hacclogin u250_standard_reservation_pool 
```


After that, you can see the FPGA board:
```
source /opt/xilinx/xrt/setup.sh
xbutil examine
```
and run a Vitis program:
```
cd fpga_example
./host.app fpga.xclbin
```

exit from node:
```
exit
```


### Batched Job

You can directly use srun in __hacchead__:

```
source /opt/xilinx/xrt/setup.sh
cd fpga_example
srun -p u250_standard_reservation_pool ./host.app  fpga.xclbin 

```

Or use sbatch to submit a job (bash script) in __hacchead__:
```
# first, copy the program to the shared path /data
mkdir -p /data/${USER}/
cp -r fpga_example /data/${USER}/

# then submit job using sbatch
sbatch -p u250_standard_reservation_pool example.sh 

# to see the status of our submitted job:
squeue

# the log will be stored in slurm-xxx.out
cat *.out

```

The details of [example.sh](example.sh) are shown as follows as a reference for you to write your own job script.


```shell
#!/bin/bash
#SBATCH --chdir /tmp/
#SBATCH --account=slurm

# 0. Keep the above two lines unchanged for slurm env setup


# Change the following username to yours
username=xtra_test

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

# To test u250 board, set path to test_u250.
path=test_u250
# The test_u250 path have the following host program and FPGA bitstream.
app=burst_rw
fpga=vadd.xclbin



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
    /opt/xilinx/xrt/bin/xbutil  examine  > ${log_path}/scan.log
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

# 3. Run your program on VMs.
./${app} ${fpga} >  ${log_path}/exec.log 2>&1


# 4. To hot reset the FPGA board, please call the following function.
function reset_fpga
{
    board_id=$(/opt/xilinx/xrt/bin/xbutil examine | grep "\[" | awk '{print$1}' | sed 's/\[//' | sed 's/\]//')
    /opt/xilinx/xrt/bin/xbutil reset -d ${board_id} --force
}
#reset_fpga >>  ${log_path}/exec.log 2>&1

```




### References

_[1] UIUC, XACC Cluster Job Submission and Scheduling (https://xilinx-center.csl.illinois.edu/xacc-cluster/xacc-user-guide/xacc-job-submission-and-scheduling/)_

_[2] Slurm, Slurm Tutorials (https://slurm.schedmd.com/tutorials.html)_


