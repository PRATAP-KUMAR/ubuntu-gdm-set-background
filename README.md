For Ubuntu 22.04 and above, support migrated to [gdm-extension](https://github.com/PRATAP-KUMAR/gdm-extension).

For Ubuntu 20.04, you can use this `ubuntu-gdm-set-badckground.sh` script.

What is `--source` option in below commands?  
It will use either `yaru` or `vanilla` theme and then customize the background of GDM Login screen.  
You must specify which one to use `yaru || vanilla`

### Installation
```
git clone https://github.com/PRATAP-KUMAR/ubuntu-gdm-set-background
cd ubuntu-gdm-set-background
./ubuntu-gdm-set-background.sh --help
```

### Example Commands:
```
sudo ./ubuntu-gdm-set-background.sh --source yaru --color \#aAbBcC
sudo ./ubuntu-gdm-set-background.sh --source vanilla --image /home/user/backgrounds/image.jpg
sudo ./ubuntu-gdm-set-background.sh --source yaru --gradient horizontal \#aAbBcC \#dDeEfF
sudo ./ubuntu-gdm-set-background.sh --source vanilla --gradient vertical \#aAbBcC \#dDeEfF
```

### Rescue mode, Example Commands:
```
sudo ./ubuntu-gdm-set-background.sh --source yaru --color \#aAbBcC rescue
sudo ./ubuntu-gdm-set-background.sh --source vanilla --image /home/user/backgrounds/image.jpg rescue
sudo ./ubuntu-gdm-set-background.sh --source yaru --gradient horizontal \#aAbBcC \#dDeEfF rescue
sudo ./ubuntu-gdm-set-background.sh --source vanilla --gradient vertical \#aAbBcC \#dDeEfF rescue
```

### Why Rescue mode?
It is when you try to change the background with some other scripts and then interacted with this script,
there will be some conflicts. In case you ran other scripts to change the background and then tried this script,
found conflicts? then add 'rescue' to the end of the command as mentiond above.

Please note that for 'Rescue mode' active internet connection is necessary.

### Reset
At anytime you want to reset to where you were before discovering this script
```
sudo ./ubuntu-gdm-set-background.sh --reset
```

### Issues
If you find any issues please raise an issue with this github repository.
