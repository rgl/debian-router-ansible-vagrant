#!/bin/bash
set -euox pipefail

vm_name=$1; shift || true
interface_name=${1:-any}; shift || true

mkdir -p tmp
vagrant ssh-config $vm_name >tmp/$vm_name-ssh-config.conf
wireshark -o "gui.window_title:$vm_name $interface_name" -k -i <(ssh -F tmp/$vm_name-ssh-config.conf $vm_name "sudo tcpdump -s 0 -U -n -i $interface_name -w - not port 22")
