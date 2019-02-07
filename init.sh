#!/bin/sh

apt-get update

apt-get install -y fio dstat

# Get all data disks via symlinks created by Azure udev rules
DATA_DISKS=$(ls -d /dev/disk/azure/scsi1/* | tr '\n' ':')

cat > /tmp/job1.fio << EOL
[global]
bs=256k
iodepth=80
direct=1
ioengine=libaio
group_reporting
time_based
runtime=2592000
filesize=10G
rw=read

[job1]
filename=${DATA_DISKS}
EOL

cat /tmp/job1.fio

nohup bash -c "(fio /tmp/job1.fio)" &> /tmp/fio.out &




