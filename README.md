# Long running "fio" test on Ubuntu 18.04 Azure VM
Simple Azure ARM template to deploy a VM with multiple data disks and execute an embedded script to install and run a long fio test on multiple data disks

NOTE: init.sh script is base64 encoded and embedded within the ARM template custom script extension

Create resource group
```
az group create -n avfio1 -l eastus2
```

Create VMs and run the test
```
az group deployment create -g avfio1 --template-file long-fio-test.json --parameters vmSize=Standard_E64s_v3 dataDiskSize=1023 dataDiskCount=24
```

After VM finishes deploying, SSH into the VM and run dstat to see dsk/total read utilization
```
dstat -tam
```