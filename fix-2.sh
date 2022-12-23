#!/bin/bash

# Colors
Red='\e[0;31m';     
BRed='\e[1;31m'; 
BIRed='\e[1;91m';
Gre='\e[0;32m';     
BGre='\e[1;32m';
BBlu='\e[1;34m';
BWhi='\e[1;37m';
RCol='\e[0m';

codename=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d = -f 2)
osname=$(cat /etc/os-release | grep '="Ubuntu"' | cut -d = -f 2)

if [ "$codename" == "focal" ]  || [ "$codename" == "hirsute" ] && [ "$osname" == '"Ubuntu"' ]; then
  GDM_RESOURCE_CONFIG_NAME="gdm3"

elif [ "$codename" == "impish" ] || [ "$codename" == "jammy" ] || [ "$codename" == "kinetic" ] && [ "$osname" == '"Ubuntu"' ]; then
  GDM_RESOURCE_CONFIG_NAME="gdm"

else
  echo -e "${Red}
------------------------------------------------------------------
Sorry, Script is only for Ubuntu ${BWhi}20.04, 21.04, 21.10, 22.04 & 22.10${Red} Only
Exiting...
------------------------------------------------------------------
${RCol}"
  exit 1
fi
