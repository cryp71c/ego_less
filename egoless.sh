#!/bin/bash
####### Variables
OS=$(hostnamectl | grep "Operating System:")
OS=$(echo $OS | sed 's/^[ \t]*//')
## String Variables
Y="Y"
YES="YES"
## Color Variables
Red=$'\e[1;31m'
Green=$'\e[1;32m'
Blue=$'\e[1;34m'
PURPLE=$'\e[1;35m'
WHITE=$'\e[0;97m'
CYAN=$'\e[0;36m'
BROWN=$'\e[0;33m'
## File Variables
PY2="$(which python2)"
PY3="$(which python3)"
SFS="$(find /home/$(whoami) -name egoless.sh)"
NMP="$(which nmap)"
## Find username Variable
USR=$(whoami)
## Find Groups Variable
GRPS=$(groups)
## Clear choice variables
CHOICE=""
## Run Clear
clear
## Valid Network Host Scan
function srvyscan(){
	echo "${Red}WARNING::Chosing the custom scan will take longer::WARNING${WHITE}"
	if [[ -f $NMP ]]
	then
		echo -e "WELCOME TO HOST DISCOVERY$Blue(type nmap or custom for scan)$WHITE$Green[default:No Scan]$WHITE"
		read -p "${BROWN}HostDiscovery>$WHITE " RNMP
		
	else
		read -e "WELCOME TO HOST DISCOVERY$Blue(type custom for scan)$WHITE$Green[default:No Scan]$WHITE"
		read -p "${BROWN}HostDiscovery>$WHITE " RNMP
	fi

	if [[ -z "$RNMP" ]]
	then
		RNMP="No"
	fi
	
	if [ $RNMP == "nmap" ]
	then
		echo "Running nmap...."
		read -p "Enter network and cidr(192.168.0.0/24): " NWORK
		$NMP -sP -T5 $NWORK
	elif [ $RNMP == "custom" ]; then
		echo "This will only scan /24 and smaller networks"
		read -p "Please enter the first 3 octets$Red(fmt 192.168.1)$Green[default:192.168.1]$WHITE: " OCT
		if [[ -z "$OCT" ]]
		then	
			OCT="192.168.1"
			echo "Scanning $OCT"
			for i in {1..254};do ping -c 1 $OCT.$i | grep 'from'; done
		else
			for i in {1..254};do ping -c 1 $OCT.$i | grep 'from'; done
		fi
	else
		echo "No go on the host scan.. got it"
	fi

	msc
}

## Welcome Banner
function banner(){
	echo -e $Red'\t _____ ____  ___  _     _____ ____ ____   ____  _   _'
	echo -e $Green'\t| ____/ ___|/ _ \| |   | ____/ ___/ ___| / ___|| | | |'
	echo -e $CYAN'\t|  _|| |  _| | | | |   |  _| \___ \___ \ \___ \| |_| |'
	echo -e $Blue'\t| |__| |_| | |_| | |___| |___ ___) |__) | ___) |  _  |'
	echo -e $PURPLE'\t|_____\____|\___/|_____|_____|____/____(_)____/|_| |_|'$WHITE
	echo "--------------------------------------------------------------------------"	
	echo -e $BROWN'      0100000101001101010000100011000100110011010011100011011100110111'
	echo "0x450x470x4f0x4c0x450x530x53::${Green}Author--AMB13N77${BROWN}::0x450x470x4f0x4c0x450x530x53"
	echo -e '      0100000101001101010000100011000100110011010011100011011100110111'$WHITE
	echo "--------------------------------------------------------------------------"
	echo "$OS"
	echo "GPERMS: $GRPS"
	echo "--------------------------------------------------------------------------"
	return
}

## Tool Check
function toolcheck(){
	echo -e "Checking for tools..\n${Green}EXISTS ${Red}NOT FOUND${WHITE}:\n(1) $(if test -f "$(which msfconsole)"; then echo "$Green"; else echo "$Red"; fi)Metasploit$WHITE\t(2) $(if test -f "$(which nmap)"; then echo "$Green"; else echo "$Red"; fi)nmap$WHITE\n(3) $(if test -f "$(which nc)"; then echo "$Green"; else echo "$Red";fi)NetCat$WHTIE\t"
	msc
}

## IP Check
function ip_check(){
	echo -e "${Red}(1) Get your public ip\t(2) $(if test -f "$(which whois)"; then echo $Green; else echo "$BROWN"; fi)Whois$Red\n(3) Trace Route\t\t(4) $(if test -f "$(which ping)"; then echo $Green; else echo "$BROWN";fi)Ping\n$Green--------'r' to return--------$WHITE"
	read -p "${BROWN}IP>" OPTION
	case $OPTION in
		1)
			curl ifconfig.me/all
			echo ""
			ip_check
			;;
		2)
			if [[ -f "$(which whois)" ]]
			then
				read -p "Enter an ip ${Green}[192.168.1.1]${BROWN}IP>${WHITE}" ip
				whois $ip
			else
				echo "Whois doesn't exist on this system"
			fi
			ip_check
			;;			
		3)
			read -p "Enter an ip ${Green}[192.168.0.1]${BROWN}IP${WHITE}>" ip
			if [[ -f "$(which traceroute)" ]]
			then
				$(which traceroute) $ip
			elif [[ -f "$(which tracepath)" ]]; then
				$(which tracepath) $ip
			else
				echo "Trace Route and Trace Path do not exist on this system."
			fi	
			ip_check
			;;
		
		4)
			read -p "Enter an ip and count ${Green}[192.168.0.1]${BROWN}IP>${WHITE}" ip
			ping -c 3 $ip
			ip_check
			;;
		r)
			clear
			main
			;;

		*)
			echo "No/invalid option, try agin"
			ip_check
			;;
	esac

}



## Main Switch Case
function msc(){
	echo -e ${Red}'(1) Check for tools\t(2) Host Discovery\n(3) Ip Tools\t\t(99) Exit'${WHITE}
	read -p "${BROWN}EGO>${WHITE}" CHOICE
	case $CHOICE in
		1)
			toolcheck
			;;
		2)
			srvyscan
			;;
		3)
			ip_check
			;;
		99)
			exit 1
			;;
		clear)
			clear
			banner
			msc
			;;
		banner) 
			clear
			banner
			msc
			;;
		ifconfig)
			ifconfig
			msc
			;;
		exit)
			exit 1
			;;
		msfconsole)
			msfconsole
			main
			;;
		*)
			echo "No user input give or bad option"
			msc
			;;
		esac
}



## Main Program
function main(){
        banner
	msc
}

main
## Blow Away Self
