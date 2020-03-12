#!/bin/bash

INVENTORY="inventory_zabbix.yml"

COMPONENTS="vmware servers webs proxies agents"
ACTION=""
GROUP=""
COMPONENT=""
STATE=""
FORCE=""

f_usage() {
  echo ""
  echo "Manage Zabbix infrastructure"
  echo "Usage : $(basename $0) [-h|--help] [-g <group>] -d|-u|-p -c <component>"
  echo "  -d : action deploy"
  echo "  -u : action undeploy"
  echo "  -p : action postinstall"
  echo "  -g : group from INVENTORY. Only for vmware component (ex: all, zabbixServers, VM-*)"
  echo "  -c : component (vmware, servers, webs, proxies, agents)"
  echo ""
  exit 1
}

f_get_params() {
  options=$(getopt -o hdupg:c: -l help -- "$@")
  [ $? -ne 0 ] && f_usage
  eval set -- $options
  while [ $# -gt 0 ] ; do
    case $1 in
      -h|--help) f_usage ;;
      -d) ACTION="deploy" ;;
      -u) ACTION="undeploy" && STATE="absent" && FORCE="True" ;;
      -p) ACTION="postinstall" ;;
      -g) shift ; GROUP=$1 ;;
      -c) shift ; COMPONENT=$1 ; echo $COMPONENTS|grep -wq $COMPONENT
                                 if [ $? -ne 0 ] ; then
                                   echo Error unknown component $COMPONENT 
                                   f_usage
                                 fi ;;
      --) shift ; [ -n "$1" ] && echo "invalid option : $1" && f_usage ;;
    esac
    shift
  done
  [ -z "$ACTION" ] && echo "action is required (-d|-u|-p)" && f_usage
  [ -z "$COMPONENT" ] && echo "component is required (-c)" && f_usage
}
  
# MAIN
f_get_params $*
[ $# -eq 0 ] && echo "Missing options" && f_usage

if [ "$COMPONENT" == "vmware" ] ; then
  [ -z "$GROUP" ] && echo "group is required (-g)" && f_usage
  if [ -z "$VMWARE_USERNAME" ] ; then
    echo -e "Enter VMWARE login (like : sbouchex@axelit.fr) : \c"
    read VMWARE_USERNAME
    VMWARE_USER=$VMWARE_USERNAME
    export VMWARE_USERNAME VMWARE_USER
  fi
  if [ -z "$VMWARE_PASSWORD" ] ; then
    echo -e "Enter VMWARE password : \c"
    read -s VMWARE_PASSWORD
    export VMWARE_PASSWORD
  fi
  if [ "$ACTION" == "undeploy" ] ; then
    ansible-playbook -i $INVENTORY $COMPONENT.yml -e "my_group=$GROUP state=$STATE force=$FORCE" -t $ACTION
  else
    ansible-playbook -i $INVENTORY $COMPONENT.yml -e "my_group=$GROUP" -t $ACTION
  fi
else
  ansible-playbook -i $INVENTORY $COMPONENT.yml 
fi




