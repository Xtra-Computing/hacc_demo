# Coyote Quick-Start on HACC@NUS

## 1. Inspect The hardware with `hdev`

Run:
```bash
hdev examine
```

You’ll see output like:
```
Ubuntu 20.04.6 LTS (Focal Fossa)
Description : 20.04.6 LTS
Codename    : focal
Linux kernel: 6.8.12-custom
Uptime      : up 1 day, 8 hours, 27 minutes

AMD EPYC 7V13 64-Core Processor
CPU(s): 256
On-line CPU(s) list: 0-254
Thread(s) per core: 1
Core(s) per socket: 64

NUMA node 0 CPU(s): 0-63,128-191
    CPU MHz: 1500.000
    CPU max MHz: 3718.0659
    CPU min MHz: 1500.0000
    Frequency boost: enabled
    Memory: 252GB

    GPUs
    1: 03:00.0
    2: 24:00.0
    3: 43:00.0
    4: 63:00.0

NUMA node 1 CPU(s): 64-127,192-254
    CPU MHz: 1500.000
    CPU max MHz: 3718.0659
    CPU min MHz: 1500.0000
    Frequency boost: enabled
    Memory: 252GB

    NICs
    1: c2:00.0 (MT28908)

    Adaptive devices
    2: 81:00.0 (xcu280_u55c_0)

Device Index : BDF     : Device Type (Name)   : Networking                        : Device (type)
------------------------------------------------------------------------------------------------------------
1            : c2:00.0 : nic (MT28908)        : 192.168.0.112 (08:C0:EB:F5:81:C6) : ens8f0np0 (ethernet)
                                                192.168.100.112 (08:C0:EB:F5:81:C7)

Device Index : BDF     : Device Type (Name)   : Serial Number : Networking                        : Workflow
------------------------------------------------------------------------------------------------------------
1            : c1:00.0 : fpga (xcu280_u55c_0) : XFL1CF1Q1MBZA : 192.168.0.152 (00:0A:35:0F:58:00) : vivado
                                                                192.168.0.172 (00:0A:35:0F:58:01)
2            : 81:00.0 : fpga (xcu280_u55c_0) : XFL11ALY1TNKA : 192.168.0.153 (00:0A:35:0F:59:98) : vitis
                                                                192.168.0.173 (00:0A:35:0F:59:99)

Device Index : PCI BUS : Device Type (GPU ID) : Serial Number : Unique ID
------------------------------------------------------------------------------------------------------------
1            : 03:00.0 : gpu (0x740f)         : 692221002189  : 0x86e2ac051869a69d
2            : 24:00.0 : gpu (0x740f)         : 692222002154  : 0x4c36a7d41fe5f548
3            : 43:00.0 : gpu (0x740f)         : 692221002256  : 0x8361d9eceaae1709
4            : 63:00.0 : gpu (0x740f)         : 692224000183  : 0xc48bc7d4ed71a9a0

NICs Adaptive Devices GPUs
```

Choose your target (e.g. device index, 1).

⸻

2. Build the “Hello World” Bitstream

See Building the hardware for full details:
https://fpgasystems.github.io/Coyote/intro/quick-start.html#building-the-hardware

```bash
cd Coyote/examples/01_hello_world/hw
mkdir build_hw && cd build_hw
cmake ../ -DFDEV_NAME=<your_device_name>    # e.g. -DFDEV_NAME=u55c
make project bitgen                         # synthesize & generate `.bit`
```

⸻

3. Compile the Kernel Driver
```bash
cd Coyote/driver
make    # produces coyote_driver.ko

```
⸻

4. Program FPGA + Insert Driver via hdev
```bash
hdev program \
  --target 1 \
  --bitstream path/to/bitstreams/cyt_top.bit \
  --driver   path/to/coyote_driver.ko
```
Verify with:
```bash
hdev examine
# or
dmesg | tail

Look for “probe returning 0”.
```
⸻

5. Build & Run the Example Software
```bash
cd Coyote/examples/01_hello_world/sw
mkdir build_sw && cd build_sw
cmake ../
make
./bin/test
```
You should see your “Hello, Coyote!” message.

⸻


For the full deep-dive (all examples, CMake flags, simulation, advanced deployment, GPU P2P, multi-tenant shells, etc.), check the complete Quick-Start guide:
https://github.com/fpgasystems/Coyote/tree/master/examples

The GPU P2P and ROCm example is coming soon. 