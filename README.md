# impish-gdm-set-background

This Script is only for Ubuntu 21.10 (Code Name: Impish) to change the gdm background to any color or with Image.

1. Download the script with the below command
````
wget -qO - https://github.com/PRATAP-KUMAR/impish-gdm-set-background/archive/main.tar.gz | tar zx --strip-components=1 impish-gdm-set-background-main/impish-gdm-set-background
````

2. run the below command to set the color  
````
sudo ./impish-gdm-set-background \#000000
````

you can set the background with Image by running below command  
````
sudo ./impish-gdm-set-background /absolute/path/to/the/image
````

-----------------------------------------------------------------------------------

to reset to Ubuntu default, run the below command  
````
sudo ./impish-gdm-set-background --reset
````
