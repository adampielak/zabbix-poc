#!/bin/bash

echo -e "Enter VMWARE login : \c"
read VMWARE_USERNAME
echo -e "Enter VMWARE password : \c"
read -s VMWARE_PASSWORD
VMWARE_USER=$VMWARE_USERNAME
export VMWARE_USERNAME VMWARE_USER VMWARE_PASSWORD

