## Demo 1:  FPGA Allocation

This demo gives a brief introduction on different ways of allocating FPGA boards in HACC@NUS.



HACC@NUS provide three reservation pool with different reservation time.

- Short reservation pool  (30 minutes)
- Standard reservation pool (12 hours)
- Long reservation pool (2 days)



### Interactive Job
login in the FPGA node in the bash shell by running the following command:
```
srun -p u250_standard_reservation_pool  -n 1 --pty bash –i

```
or you can just use the provide script tool:

```
./env/login u250_standard_reservation_pool 
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


