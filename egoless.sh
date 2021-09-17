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
SFS="$(find /home/$(whomi) -name virus.sh)"
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
		read -p "${Green}nmap${WHITE} exists $NMP would you like to do host discovery$Blue(type nmap or custom for scan)$WHITE$Green[default:No Scan]$WHITE: " RNMP
	else
		read -p "${Red}nmap${WHITE} doesn't exist, would you like to try host discovery$Blue(type custom for scan)$WHITE$Green[default:No Scan]$WHITE: " RNMP
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
		read -p "Please enter the first 3 octets$Red(fmt 192.168.1)$WHITE[default:192.168.1]: " OCT
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
	echo -e "Checking for tools..\n${Green}EXISTS ${Red}NOT FOUND${WHITE}:\n(1) $(if test -f "$(which msfconsole)"; then echo "$Green"; else echo "$Red"; fi)Metasploit$WHITE\t(2) $(if test -f "$(which nmap)"; then echo "$Green"; else echo "$Red"; fi)nmap$WHITE\n"		
	 msc
}


## Main Switch Case
function msc(){
	echo -e ${Red}'(1) Check for tools\t(2)Host Discovery\n(99) Exit'${WHITE}
	read -p "${BROWN}EGO>${WHITE}" CHOICE
	case $CHOICE in
		1)
			toolcheck
			;;
		2)
			srvyscan
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
	*)
	echo "No user input give or bad option"
	esac
}



## Main Program
function main(){
        banner
	msc
}

main
## Blow Away Self
