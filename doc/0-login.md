
### Accessing HACC@NUS

In terms of using the hardware/software provided by HACC@NUS, we consider that you have already read and agreed to the [HACC@NUS Terms of Use](doc/terms_of_use.md). 



### Login HACC@NUS

To login to HACC@NUS, please set up 2FA by following the instructions in the registration email. After that, you can use SSH with the given username and 2FA key to login to the node ```hacchead```.


```
ssh username@xacchead.d2.comp.nus.edu.sg
```


Once you are logged in to ```hacchead```, please clone this repository to use the script tools and demos provided by us.



```
git clone https://github.com/XACCNUS/hacc_demo.git
```

### Software Environment

The hardware compilation environment and hardware shell version for different hardware are shown in the table below. 


|Cluster|  Hardware | Shell/Arch Version | XRT Version | Toolchain Version|
|-------------------|----------------|--------------------|-------------|-------------------|
| Heterogeneous Cluster |VCK5000 | xilinx_vck5000_gen4x8_qdma_2_202220_1 | 2.14.384  | Vitis 2022.2 |
|                  | U55C   | xilinx_u55c_gen3x16_xdma_3_202210_1 | 2.14.384   | Vitis 2022.2 |
|                  | U250 | xilinx_u250_gen3x16_xdma_4_1_202210_1 | 2.14.384   | Vitis 2022.2 |
|                  |MI210 | gfx90a  | -   | ROCm-5.4.2 |
| GPU Cluster | MI25    | gfx906  | -  | ROCm-5.4.2 |
|  | MI100    | gfx908  | -  | ROCm-5.4.2 |
| U250 Cluster  |  U250     | xilinx_u250_gen3x16_xdma_3_1_202020_1  | 2.14.354   | Vitis 2021.2 |
| U280 Cluster |  U280    | xilinx_u280_xdma_201920_3  | 2.14.354    | Vitis 2021.2 |
| VCK5000 Cluster  | VCK5000     | xilinx_vck5000_gen4x8_qdma_2_202220_1     |2.14.384   | Vitis 2022.2 |
| U50 Single Node |  U50   | xilinx_u50_gen3x16_xdma_201920_3  | 2.14.354    | Vitis 2021.2 |


We provide a unified environment setup script located in ```/home/hacc_env```. You can use it by simply running the script or add it to your ```bashrc```. 



The path of deployed toolchains are list as follows.

|Toolchain | Installation Location |
|-------------------|----------------|
| XRT |```/opt/xilinx/xrt/```|
| Vitis/Vivado |```/tools/xilinx/```|
| ROCm |```/opt/rocm/```|
