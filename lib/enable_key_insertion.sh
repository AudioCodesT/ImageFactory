#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x
# enable_key_insertions.sh -> see http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html#public-amis-install-credentials

distro_user='centos'
home_dir="/home/$distro_user"
ssh_dir="$home_dir/.ssh"

cat <<-SSKI > /etc/rc.local

if [ ! -d ${ssh_dir} ] ; then
        mkdir -p ${ssh_dir}
        chmod 700 ${ssh_dir}
fi

# Fetch public key using HTTP
curl http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key > /tmp/my-key
if [ $? -eq 0 ] ; then
        cat /tmp/my-key >> ${ssh_dir}/authorized_keys
        chmod 700 ${ssh_dir}/authorized_keys
        rm /tmp/my-key
fi
SSKI