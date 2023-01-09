## HACC Demo

This repo provides some useful scripts and examples to set up environment variables and utlize resources in HACC@NUS cluster.
 

HACC@NUS cluster adopts [Slurm](https://slurm.schedmd.com/documentation.html) job scheduler to manage hardware resource. 
In order to run an __FPGA accelerated__ task, you must submit a slurm job request to the scheduler, by requesting how much time you want, what type of resources you require. The details of how to write a slurm job are shown in the following part.  [Here](doc/slurm.pdf) is a command cheat sheet for using Slurm [[1]](https://xilinx-center.csl.illinois.edu/xacc-cluster/xacc-user-guide/xacc-job-submission-and-scheduling/)


To see the available FPGA resources, you can run ```sinfo``` after logining our cluster.

```
~$ sinfo
PARTITION                      AVAIL  TIMELIMIT  NODES  STATE NODELIST
cpu_only*                         up      30:00      6   idle hacc-u250-[1-4],hacc-u280-[1-2]
frp_test                          up 2-00:00:00      1   idle hacc-u250-frp
u250_1                            up   12:00:00      1   idle hacc-u250-1
u250_2                            up   12:00:00      1   idle hacc-u250-2
u250_3                            up   12:00:00      1   idle hacc-u250-3
u250_4                            up   12:00:00      1   idle hacc-u250-4
u250_rtl_1                        up   12:00:00      1   unk* hacc-u250-rtl-1
u280_1                            up   12:00:00      1   idle hacc-u280-1
u280_2                            up   12:00:00      1   idle hacc-u280-2
amd_gpu                           up 2-00:00:00      1   idle hacc-gpu0
u250_short_reservation_pool       up      30:00      4   idle hacc-u250-[1-4]
u280_short_reservation_pool       up      30:00      2   idle hacc-u280-[1-2]
u250_standard_reservation_pool    up   12:00:00      4   idle hacc-u250-[1-4]
u280_standard_reservation_pool    up   12:00:00      2   idle hacc-u280-[1-2]
u250_long_reservation_pool        up 2-00:00:00      4   idle hacc-u250-[1-4]
u280_long_reservation_pool        up 2-00:00:00      2   idle hacc-u280-[1-2]
```

There are several simple demo of how to use resouces provided HACC@NUS: 

- [Demo 0: Login HACC@NUS](doc/0-login.md)
- [Demo 1: FPGA allocation](doc/1-FPGA-allocation.md)
- [Demo 2: Use VNC for waveform-based simulation](doc/2-waveform-based-simulation.md)
- [Demo 3: 100G networking](doc/3-100G-network-interaction.md)
