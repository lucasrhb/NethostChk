#!/bin/bash
# Check new hosts in a network
# Author: Lucas Ludziejewski
#######################################################

# Temporary folder
temp="/tmp"

#######################################################
# There is no need to change anything below


arpbefore=`uuidgen`
arpafter=`uuidgen`
compared=`uuidgen`


echo -e "\nNethostChk v0.1"
echo "Yet Another Simple Nmap Based Script to Check New Hosts in Network"
echo "####################################################################"
echo


if [ $# -eq 0 ]
	then
	echo -e "\nERROR: No arguments supplied\n"
	echo "Run scripts with argument (network ip/class)"
	echo -e "For example: $0 192.168.1.0/24\n\n"
	
	exit 0;
fi




echo "Generating current network hosts log:"
	nmap -sP "$1" > $temp/$arpbefore
	x=`cat $temp/$arpbefore | grep "Nmap done:" | gawk -F"(" '{print $2}' | gawk -F")" '{print $1}'`
echo "$x, now go and connect another host to the same lan"

	read -p "Wait 10 seconds and press any key" -n1 -s
	echo -e "\n\n"
	nmap -sP "$1" > $temp/$arpafter
	y=`cat $temp/$arpafter | grep "Nmap done:" | gawk -F"(" '{print $2}' | gawk -F")" '{print $1}'`

echo "$y now connected"


if [ "$x" = "$y" ]
then

	echo "No new hosts detected"
	exit 0;

else

echo "Lets compare results in $temp/$arpbefore and $temp/$arpafter"
echo 
echo "List of new hosts: "

sdiff $temp/$arpbefore $temp/$arpafter > $temp/$compared
	echo

	cat $temp/$compared
	#grep " >" $temp/$compared | tr -d '	' | sed 's/^ *//'
fi


	rm "$temp/$arpbefore"
	rm "$temp/$arpafter"
	rm "$temp/$compared"
echo
	
exit 0;


