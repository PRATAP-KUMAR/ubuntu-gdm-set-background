For Ubuntu 22.04 and above, support migrated to https://github.com/PRATAP-KUMAR/gdm-extension for gnome-shell versions 42 and above using `gdm-extension` instead of extracting resource files, editing, saving and recompiling.

For Ubuntu 20.04 (gnome-shell version 3.36)
You can use `ubuntu-gdm-set-badckground.sh` script.

--source - you can use 'yaru'(ubuntu default) shell theme or 'vanilla'(that blue one) shell theme.

Example Commands:
1. sudo ./ubuntu-gdm-set-background.sh --source yaru --color \#aAbBcC
2. sudo ./ubuntu-gdm-set-background.sh --source vanilla --image /home/user/backgrounds/image.jpg
3. sudo ./ubuntu-gdm-set-background.sh --source yaru --gradient horizontal \#aAbBcC \#dDeEfF
4. sudo ./ubuntu-gdm-set-background.sh --source vanilla --gradient vertical \#aAbBcC \#dDeEfF

RESCUE_MODE, Example Commands:
1. sudo ./ubuntu-gdm-set-background.sh --source yaru --color \#aAbBcC rescue
2. sudo ./ubuntu-gdm-set-background.sh --source vanilla --image /home/user/backgrounds/image.jpg rescue
3. sudo ./ubuntu-gdm-set-background.sh --source yaru --gradient horizontal \#aAbBcC \#dDeEfF rescue
4. sudo ./ubuntu-gdm-set-background.sh --source vanilla --gradient vertical \#aAbBcC \#dDeEfF rescue

Why RESCUE_MODE?
It is when you try to change the background with some other scripts and then interacted with this script,
there will be some conflicts. In case you ran other scripts to change the background and then tried this script,
found conflicts? then add 'rescue' to the end of the command as mentiond above.

Please note that for 'RESCUE_MODE' active internet connection is necessary.

At anytime you want to reset to where you were before discovering this script
```
sudo ./ubuntu-gdm-set-background.sh --reset
```

If you found any issues please raise an issue with this github repository.