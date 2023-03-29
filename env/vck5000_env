#/usr/bin/env bash

_hacclogin_completions()
{
  list=$(sinfo  | grep -v PARTITION   | grep -v \* | awk '{print $1 }')
  COMPREPLY=($(compgen -W "${list}" "${COMP_WORDS[1]}"))
}

complete -F _hacclogin_completions hacclogin


if [ $# -lt 1 ];
then
    version=22.2
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

