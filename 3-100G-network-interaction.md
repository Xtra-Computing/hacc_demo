# Demo 3: 100G Network


This demo shows the ability of using CPU's 100G network card to communicate with FPGAs on HACC@NUS


In __hacchead__, the subnet 192.168.0.xxx is the 100G network, the CPU node ip is 192.168.0.2

```
# first, setup xrt environment
source /opt/xilinx/xrt/setup.sh
# then, program one FPGA node with prebuilt app to configure the FPGA network stack:
srun -p u250_2  fpga_network/fpga_network_config  fpga_network/vnx_basic_if1.xclbin
```

After the configuration, we can ping the FPGA node:
```
ping -c 5 192.168.0.201 
```


You can further write your own network services to debug FPGA network applications in HACC@NUS.
