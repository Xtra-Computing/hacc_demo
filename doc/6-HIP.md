# Demo 6: Programming AMD GPUs with HIP

In this example, we show how to use HIP and ROCm to program AMD GPUs inside HACC@NUS cluster.

First, allocate one GPU node. Here we use the MI100 GPUs, the candidate gpu partitions are ```mi100```,```mi25```,```mi210_u250_u55c``` and ```mi210_vck_u55c```.
```bash  
srun -p mi100 --cpus-per-task=8 --pty  bash -i
```
or 
```bash  
haccalloc  mi100           # you need source /home/hacc_env to use this command  
```


Second, clone the HIP example code, and go to the Hello World example.

```bash  
git clone https://github.com/ROCm-Developer-Tools/HIP-Examples.git
cd HIP-Examples/HIP-Examples-Applications/HelloWorld/
```


Next, run make

```bash
make
```


The output should look like:
```bash
/opt/rocm/hip/bin/hipcc -g   -c -o HelloWorld.o HelloWorld.cpp
/opt/rocm/hip/bin/hipcc HelloWorld.o -o HelloWorld
./HelloWorld
 System minor 0
 System major 9
 agent prop name AMD Instinct MI100
input string:
GdkknVnqkc

output string:
HelloWorld
Passed!

```

