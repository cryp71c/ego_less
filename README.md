# EGOLESS.SH

## What is EGOLESS
Egoless is a post exploitation tool kit that searches for multipule tools on a system. It can also do host discovery scans, if nmap exits it will tell you. 

### Tools that ego searches for

|  Tools       | Supported          |
| ------------ | ------------------ |
|  nmap        | ✅ |
|  Metasploit  | ✅ |
|  NetCat      | ✅ |

```diff
+ nmap if exists can run
+ NetCat if exists can run
! Metasploit will run but be careful if it exists it might have pre-existing configuration files

@@ Things to do that are in progress @@
- IP info
- MAC Lookup
- whois query
- 
-
```
# In Script Commands/Options
```bash
## Main Switch Case
function msc(){
	echo -e ${Red}'(1) Check for tools\t(2)Host Discovery\n(99) Exit'${WHITE}
	read -p "${BROWN}EGO>${WHITE}" CHOICE
	case $CHOICE in
		1)
			## Tool Search
			toolcheck
			;;
		2)
			## Host Scan
			srvyscan
			;;
		99)
			exit 1
			;;
		clear)
			## Clear Screen
			clear
			banner
			msc
			;;
		banner)
			## Print Banner
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
			## Metasploit
			msfconsole
			msc
			;;
		*)
			echo "No user input give or bad option"
			msc
			;;
		esac
}
```
