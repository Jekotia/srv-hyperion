#! /bin/bash
declare -A modules=(
	#['camptocamp-systemd']='' #'2.9.0'
	['geoffwilliams-chmod_r']='' #'1.0.0'
	['geoffwilliams-chown_r']='' #'1.1.0'
	['jethrocarr-hostname']='' #'1.0.3'
	# ['kakwa-samba']='' #'2.0.0'
	# ['pk-systemd']='' #--version 1.1.0
	# ['puppet-nginx']='' #'1.1.0'
	# ['puppet-openvpn']='' #'7.4.0'
	# ['puppet-python']='' #'2.2.2'
	['puppet-unattended_upgrades']='' #'3.2.1'
	['puppetlabs-apt']='' #'6.3.0'
	['puppetlabs-docker']='' #'3.9.1'
	['puppetlabs-stdlib']='' #'' #'4.25.1'
	# ['puppetlabs-vcsrepo']='' #'2.4.0'
	# ['rehan-samba']='' #'1.2.0'
	['saz-locales']='' #'2.5.1'
	['saz-ssh']='' #'4.0.0'
	['saz-sudo']='' #'5.0.0'
	['saz-timezone']='' #'5.0.2'
	# ['WhatsARanjit-plexmediaserver']='' #'2.2.0'
)
declare -A packages=(
	["software-properties-common"]=''
)

#-> KEY VARIABLES
#-> PATH TO SRV-COMMON REPO
cPATH="/srv/common"

#-> SOURCE FUNCTIONS
source ${cPATH}/init

#-> ENSURE SUPERUSER BEFORE GOING ANY FURTHER
isRoot "exit"

function printLine() {
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

printLine

#-> ENSURE GIT IS PRESENT
if ! git --version > /dev/null 2>&1 ; then
	apt install -y git
	printLine
fi

git clone --recurse-submodules https://github.com/Jekotia/srv-common.git ${cPATH}

printLine

#-> SETUP ENVIRONMENT VARIABLES
source ${cPATH}/bin/build-environment

printLine

#-# PUPPET
if lsb_release -i | grep -e ":\sUbuntu$" ; then
	if ! apt search puppet | grep "puppet6-release" ; then
		wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
		sudo dpkg -i puppet6-release-bionic.deb
	fi
	sudo apt-get install puppet-agent

	#-> PUPPET INSTALLS TO A NON-STANDARD LOCATION FOR BINARIES; LETS CREATE A SYMLINK TO /USR/BIN
	if [ ! -e /usr/bin/puppet ] && [ -e /opt/puppetlabs/bin/puppet ] ; then
		ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
	fi
else
	echo "Unsupported platform"
	exit 1
		#-> INSTALL THE CENTOS REPO RPM
		###package_InstallFromURL "https://yum.puppet.com/puppet6-release-el-7.noarch.rpm"
		#-> INSTALL THE AGENT FROM THE REPO ADDED ABOVE
		###package_install --unattended --verbose "puppet-agent"
fi

printLine

#-> PUPPET MODULES REQUIRED BY THE PUPPETFILES IN THIS REPO
for module in "${!modules[@]}" ; do
	version="${modules[$module]}"
	if [[ "$version" == '' ]] ; then
		puppet module install $module
	else
		puppet module install $module --version $version
	fi
done

printLine

#-> PUPPET PACKAGES REQUIRED BY THE PUPPETFILES IN THIS REPO
for package in "${!packages[@]}" ; do
	version="${packages[$package]}"
	if [[ "$version" == '' ]] ; then
		apt install -y $package
	else
		apt install -y ${package}=${version}
	fi
done

printLine
echo "Sourcing /etc/environment"
source /etc/environment

printLine

#-> APPLY THE PUPPET MANIFESTS FROM THIS REPO
puppet apply ${_PUPPET_ROOT}/manifests
