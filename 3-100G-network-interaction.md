# Demo 3


This demo shows the ability of using CPU's 100G network card to communicate with FPGAs on HACC@NUS


In __hacchead__, the subnet 192.168.0.xxx is the 100G network, the CPU node ip is 192.168.0.2

```
# first program one FPGA node with a network stack:
source /opt/xilinx/xrt/setup.sh
srun -p u250_2  network_debug/fpga_network_config  network_debug/vnx_basic_if1.xclbin
```

After the configuration, we can ping the FPGA node:
```
ping -c 5 192.168.0.201 
```


You can further write your own network services to debug FPGA network applications using our HACC@NUS cluster.
