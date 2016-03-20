#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

passwd -d centos
passwd -d root


if [[ -f /etc/yum.repos.d/CentOS-Base.repo.saved ]]; then
  mv /etc/yum.repos.d/CentOS-Base.repo.saved /etc/yum.repos.d/CentOS-Base.repo
fi

rm -f /etc/ssh/ssh_host_*
[[ -d /home/centos/.ssh ]] && rm -Rf /home/centos/.ssh
[[ -d /root/.ssh ]] && rm -Rf /root/.ssh

while read varlog; do
  cp /dev/null ${varlog}
done < <(find /var/log/ -type f)

history -c 
