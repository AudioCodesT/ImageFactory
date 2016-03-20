#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -x

#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.saved

releasever='5.7'
majorver='5'
baseurl=http://vault.centos.org

cat <<-REPO > /tmp/CentOS-Base.repo
	[base]
	name=CentOS-${releasever} - Base
	baseurl=${baseurl}/${releasever}/os/\$basearch/
	gpgcheck=1
	gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${majorver}

	[updates]
	name=CentOS-${releasever} - Updates
	baseurl=${baseurl}/${releasever}/updates/\$basearch/
	gpgcheck=1
	gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${majorver}
	REPO
