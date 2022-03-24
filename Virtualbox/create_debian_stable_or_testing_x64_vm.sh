#######################
### BEGIN VARIABLES ###
#######################
# ARGUMENT VARIABLES
name=$1
domain=$3
hostname="$2"."$domain"
medium=$4

# OS, CPU, disk and RAM vars
ostype=debian_64
vdisize=60000
base=$(pwd)
vdifile="$base"/"$name"/"$name".vdi
memory=2048
cpus=2
vram=16

# CREDENTIALS
user=vbox
user_groups="sudo,vboxsf"
password=changeme

# REGIONAL
country=NL

#######################
### BEGIN ARGUMENTS ###
#######################
# Check args
if (( "$#" <= "2" )); then
	echo "[*] Usage: "${0}" <vmname> <hostname> <domainname> {optional_iso_image}"
	exit 0
fi

# Using entered image as argument or download image
if [ $# -eq 3 ]; then
	read -p "[*] Use (S)table or (T)esting image? " st
	case $st in
		[Ss]* ) 
			medium=deb_amd64_stable_netinst.iso
			if [ -e "$medium" ]; then
				echo "[*] File already exists, reusing existing file..."
			else
				echo "[*] Downloading stable ISO image..."
				curl -Lo "$medium" "http://debian-cd.debian.net/debian-cd/10.8.0/amd64/iso-cd/debian-10.8.0-amd64-netinst.iso"
			fi;;
		[Tt]* ) 
			medium=deb_amd64_testing_netinst.iso
			if [ -e "$medium" ]; then
				echo "[*] File already exists, reusing existing file..."
			else
				echo "[*] Downloading testing ISO image..."
				curl -Lo "$medium" "https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/debian-testing-amd64-netinst.iso"
			fi;;
		* ) echo "Please answer S or T."; exit 0;
	esac
fi

#####################
### END ARGUMENTS ###
#####################

###################################
### START POST INSTALL COMMANDS ###
###################################

# Install some prerequisites for installing/getting packages
apt_pre_pkg="apt-get -y install software-properties-common wget; "

######################
### BEGIN GUI PKGS ###
######################
# Start GUI packages; modify/delete if desired
apt_gui_pkgs="xfce4-* \
		firefox-esr \
		bleachbit \
		gparted \
		"
for pkg in ${apt_gui_pkgs}; do
	apt_gui_cmd+="apt-get -y install ${pkg}; ";
done
####################
### END GUI PKGS ###
####################

# Apt update
apt_update_cmd="apt-get update"

#######################
### BEGIN DEB REPO ####
#######################
# Begin regular Apt repo; add non-free, contrib to apt sources
apt_deb_sources_cmd="apt-add-repository non-free; apt-add-repository contrib"
# Begin install apt packages
apt_deb_pkgs="virtualbox-guest-additions-iso \
	acpid \
	build-essential \
	module-assistant \
	sudo \
	vim \
	net-tools \
	dnsutils \
	sudo \
	htop \
	curl 
	wget \
	openssl \
	nmap \
	lsof \
	netcat \
	ncat \
	aptitude \
	ack-grep \
	ripgrep \
	p7zip-full \
	"

# Concatenate Apt commands
apt_deb_cmd+="${apt_deb_sources_cmd}; "
apt_deb_cmd+="${apt_update_cmd}; "
for pkg in ${apt_deb_pkgs}; do
	apt_deb_cmd+="apt-get -y install ${pkg}; ";
done
####################
### END DEB REPO ###
####################

# Set Grub timeout to 0
grub_timeout_cmd="sed -i 's/^GRUB_TIMEOUT=.$/GRUB_TIMEOUT=0/' /etc/default/grub && update-grub;"
# Install virtualbox guest additions manually due to errors using --install-additions, after having installed ISO and 7zip via apt
vbox_guest_additions="m-a prepare; \
		mkdir /tmp/vboxiso; \
		/usr/bin/7z x /usr/share/virtualbox/VBoxGuestAdditions.iso -o/tmp/vboxiso; \
		sh /tmp/vboxiso/VBoxLinuxAdditions.run; \
		rm -rf /tmp/vboxiso/;"
# Add user to groups
usermod_cmd="usermod -aG ${user_groups} ${user};"

# Interpolate run commands
run_cmds+="${apt_pre_pkg} "
run_cmds+="${apt_deb_cmd} "
run_cmds+="${apt_gui_cmd} "
run_cmds+="${vbox_guest_additions} "
run_cmds+="${usermod_cmd} "
run_cmds+="${grub_timeout_cmd} "

# Add the commands to postinstall_cmd
prefix_cmd="chroot /target sh -c "
postinstall_cmd="${prefix_cmd} \""
for cmd in ${run_cmds}; do
	postinstall_cmd+=" ${cmd} ";
done
postinstall_cmd+="\""
#################################
### END POST INSTALL COMMANDS ###
#################################

# ISOLINUX AND LOG LOCATION
aux_base_path="$base"/"$name"/
isolinux="$aux_base_path"isolinux-isolinux.cfg
logfile="$aux_base_path"logfile.txt
#####################
### END VARIABLES ###
#####################

#####################
### BEGIN STORAGE ###
#####################
# Create VM config
vboxmanage createvm --name "$name" --ostype "$ostype" --basefolder "$base" --register
# Create disk
vboxmanage createmedium --filename "$vdifile" --size "$vdisize"
# Attach disk
vboxmanage storagectl "$name" --name SATA --add SATA --controller IntelAhci
vboxmanage storageattach "$name" --storagectl SATA --port 0 --device 0 --type hdd --medium "$vdifile"
# Attach CD/DVD for install
vboxmanage storagectl "$name" --name IDE --add ide
vboxmanage storageattach "$name" --storagectl IDE --port 0 --device 0 --type dvddrive --medium "$medium"
###################
### END STORAGE ###
###################

##################################
### BEGIN VM SPECIFIC SETTINGS ###
##################################
# CPU's
vboxmanage modifyvm "$name" --cpus "$cpus"
# Memory and videoram
vboxmanage modifyvm "$name" --memory "$memory" --vram "$vram"
# IO APIC
vboxmanage modifyvm "$name" --ioapic on
# Video SVGA
vboxmanage modifyvm "$name" --graphicscontroller vmsvga
# PAE
vboxmanage modifyvm "$name" --pae on
# Drag and drop
vboxmanage modifyvm "$name" --draganddrop bidirectional
# Clipboard mode
vboxmanage modifyvm "$name" --clipboard-mode bidirectional
# Bootorder
vboxmanage modifyvm "$name" --boot1 dvd --boot2 disk --boot3 none --boot4 none
# Disable audio
vboxmanage modifyvm "$name" --audio none
# Disable USB
vboxmanage modifyvm "$name" --usb off
vboxmanage modifyvm "$name" --usbehci off
vboxmanage modifyvm "$name" --usbxhci off
# Set NAT network
vboxmanage modifyvm "$name" --nic1 nat
################################
### END VM SPECIFIC SETTINGS ###
################################

##########################
### BEGIN INSTALL ARGS ###
##########################
vboxmanage unattended install "$name" \
	--auxiliary-base-path "$aux_base_path" \
	--user="$user" \
	--password="$password" \
	--country="$country" \
	--hostname="$hostname" \
	--iso="$medium" \
	--package-selection-adjustment=minimal \
	--post-install-command="$postinstall_cmd" \
########################
### END INSTALL ARGS ###
########################

# Change ISOLINUX for text install
sed -i 's/^default vesa.*/default install/' "$isolinux"

# Actually start the VM
vboxmanage startvm "$name"

