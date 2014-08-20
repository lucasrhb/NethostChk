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
echo "Yet Another Simple Arp Based Script to Check New Hosts in Network"
echo "####################################################################"
echo
echo "Generating current network hosts log:"
	arp -a > $temp/$arpbefore
	x=`wc -l $temp/$arpbefore | gawk -F"$temp" '{print $1}'`
echo "$x hosts found, now go and connect another host to the same lan"

	read -p "Wait 10 seconds and press any key" -n1 -s
	echo -e "\n\n"
	arp -a > $temp/$arpafter
	y=`wc -l $temp/$arpafter | gawk -F"$temp" '{print $1}'`


echo "$y hosts now connected"


if [ $x = $y ]
then

	echo "No new hosts detected"
	exit 0;

else

echo "Lets compare results in $temp/$arpbefore and $temp/$arpafter"
echo 
echo "List of new hosts: "

sdiff $temp/$arpbefore $temp/$arpafter > $temp/$compared
	echo

	grep " >" $temp/$compared | tr -d '	' | sed 's/^ *//'
fi


	rm "$temp/$arpbefore"
	rm "$temp/$arpafter"
	rm "$temp/$compared"
echo
	
exit 0;


