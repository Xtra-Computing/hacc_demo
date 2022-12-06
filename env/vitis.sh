#!/bin/bash

if [ $# -lt 1 ];
then
    version=20.2
    echo "defalut: ${version}"
else
    version=$1
fi


export LIBRARY_PATH=$LIBRARY_PATH:/usr/lib/x86_64-linux-gnu
source /opt/xilinx/xrt/setup.sh


if [ -e  /xtra/tools/Vitis/20${version}/settings64.sh ]
then
    source  /xtra/tools/Vitis/20${version}/settings64.sh
fi

if [ -e   /opt/Xilinx/Vitis/20${version}/settings64.sh ]
then
    source   /opt/Xilinx/Vitis/20${version}/settings64.sh
fi

if [ -e   /tools/Vitis/20${version}/settings64.sh ]
then
    source   /tools/Vitis/20${version}/settings64.sh
fi

if [ -e   ~/tools/Vitis/20${version}/settings64.sh ]
then
    source   ~/tools/Vitis/20${version}/settings64.sh
fi

if [ -e   /tools/Xilinx/Vitis/20${version}/settings64.sh ]
then
    source  /tools/Xilinx/Vitis/20${version}/settings64.sh
fi

if [ -e   /data/Vitis/20${version}/settings64.sh ]
then
    source  /data/Vitis/20${version}/settings64.sh
fi

cat /opt/xilinx/xrt/version.json
which vitis

