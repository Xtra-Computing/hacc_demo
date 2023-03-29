## HACC Demo

This repo provides some useful tool scripts and examples to demonstrate how to use the available FPGA resources in HACC@NUS cluster.


HACC@NUS cluster adopts [Slurm](https://slurm.schedmd.com/documentation.html) job scheduler to manage hardware resource. 
In order to run an __FPGA accelerated__ task, you must submit a slurm job request to the scheduler, by requesting how much time you want, what type of resources you require. [Here](doc/slurm.pdf) is a command cheat sheet for using Slurm [[1]](https://xilinx-center.csl.illinois.edu/xacc-cluster/xacc-user-guide/xacc-job-submission-and-scheduling/). 


The following part gives a quick hand-on of using Slurm to access HACC@NUS's hardware resources.


To see the available FPGA resources, you can run ```sinfo``` after logining our cluster.

```
~$ sinfo
PARTITION                         AVAIL  TIMELIMIT  NODES  STATE NODELIST
cpu_only*                            up 7-00:00:00      1   idle hacc-node2
u50_standard_reservation_pool        up   12:00:00      1   idle hacc-u50-1
vck5000_standard_reservation_pool    up      20:00      4   idle hacc-vck5000-[1-4]
vck5000_compile                      up 7-00:00:00      1   idle hacc-node0
u250_standard_reservation_pool       up   12:00:00      4   idle hacc-u250-[1-4]
u280_standard_reservation_pool       up   12:00:00      2   idle hacc-u280-[1-2]
u250_short_reservation_pool          up      30:00      4   idle hacc-u250-[1-4]
u280_short_reservation_pool          up      30:00      2   idle hacc-u280-[1-2]
u250_long_reservation_pool           up 2-00:00:00      4   idle hacc-u250-[1-4]
u280_long_reservation_pool           up 2-00:00:00      2   idle hacc-u280-[1-2]
amd_gpu                              up 2-00:00:00      1   idle hacc-gpu0

```

There are several simple demo of how to use resouces provided HACC@NUS: 

- [Demo 0: Login HACC@NUS](doc/0-login.md)
- [Demo 1: FPGA allocation](doc/1-FPGA-allocation.md)
- [Demo 2: Use VNC for waveform-based simulation](doc/2-waveform-based-simulation.md)
- [Demo 3: 100G networking](doc/3-100G-network-interaction.md)
- [Demo 4: VCK5000 exploration](doc/4-VCK5000.md)
- [Demo 5: U250 DFX-2RP](doc/5-U250_DFX.md)