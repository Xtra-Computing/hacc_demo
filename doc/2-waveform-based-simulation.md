## Demo 2:  Use VNC for Waveform-Based Simulation

This demo shows how to use VNC to connect HACC@NUS and conduct waveform-based simulation.

```
# start vncserver 
vncserver 

# change the port number and username accordingly.
ssh -L 59xx:localhost:59xx username@xacchead.d2.comp.nus.edu.sg 

```


### VNC Setup

Follow the instructions [here](https://xaccnus.github.io/Job-Scheduler/vnc_setup) to setup your VNC password.

```
```

### Waveform-based Simulation on HACC@NUS

```
# 1. clone the Vitis example
git clone https://github.com/Xilinx/Vitis_Accel_Examples.git
cd Vitis_Accel_Examples
git checkout  -b 2020.2 origin/2020.2 

# 2. use one simple example  
cd cpp_kernels/burst_rw/


# 3. make 
source /opt/xilinx/xrt/setup.sh
source /opt/Xilinx/Vitis/2020.2/settings64.sh
make TARGET=hw_emu DEVICE=xilinx_u250_gen3x16_xdma_3_1_202020_1 all -j 

# 4. setup emu env, you can directly use the provided xrt.ini in env
cp ../../../env/xrt.ini .

# 5. run emulation
source /opt/xilinx/xrt/setup.sh
source /opt/Xilinx/Vitis/2020.2/settings64.sh
XCL_EMULATION_MODE=hw_emu ./burst_rw build_dir.hw_emu.xilinx_u250_gen3x16_xdma_3_1_202020_1/vadd.xclbin

```
