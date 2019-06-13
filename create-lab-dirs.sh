# This little scripts bings all the ips in the lab env from xx.xx.xx.1 - xx.xx.xx.254.
# If a host responds, it automatically creates a directory with the specific name in 
# the path the script is running.
# Usage Example: ./create-lab-dirs.sh '10.11.1'"

#!/bin/bash

echo "This script was written by 1N53C (invasive-security.de) for automating"
echo "the process of making directories for each and every machine in the OSCP-Labs"

if [ $# -eq 0 ]
	then
		echo "[-] No arguments supplied"
		echo "[!] Usage Example: ./create-lab-dirs.sh '10.11.1'"
		exit
fi

echo "Creating directory for each IP that is responding to PING..."

for ip in $(seq 1 254); do
	if [ `ping -c 1 $1.$ip | grep "bytes from" | cut -d" " -f4 | cut -d":" -f1` ]
		then
			mkdir $1.$ip
			echo "Directory $1.$ip has been created"
			echo $1.$ip >> hostfile.txt
	fi 
done

echo "[+] Directories have been created. A list of all pingable hosts is stored in 'hostfile.txt'"
echo "[!] If a host was not pingable during the process for whatever reason, no folder has been created"
echo "[!] Please double-check that with an additional nmap-scan e.g. 'nmap -sP xx.xx.xx.0/24"
