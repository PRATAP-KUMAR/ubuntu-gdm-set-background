# impish-gdm-set-background script (for changing Ubuntu 21.10 GDM Background) HELP

there are four options
1. background with image
2. background with color
3. background with gradient horizontal ( requires two valid hex color inputs)
4. background with gradient vertical ( requires two valid hex color inputs)

tip: be ready with valid hex color code in place of below example like #aAbBcC or #dDeEfF. Change them to your preffered hex color codes.
you may choose colors from https://www.color-hex.com/

Example Commands:

1. `sudo ./impish-gdm-set-background --image /home/user/backgrounds/image.jpg`
2. `sudo ./impish-gdm-set-background --color \#aAbBcC`
3. `sudo ./impish-gdm-set-background --gradient horizontal \#aAbBcC \#dDeEfF`
4. `sudo ./impish-gdm-set-background --gradient vertical \#aAbBcC \#dDeEfF`
5. `sudo ./impish-gdm-set-background --reset`
6. `./impish-gdm-set-background --help`

RESCUE_MODE, Example Commands:

1. `sudo ./impish-gdm-set-background --image /home/user/backgrounds/image.jpg rescue`
2. `sudo ./impish-gdm-set-background --color \#aAbBcC rescue`
3. `sudo ./impish-gdm-set-background --gradient horizontal \#aAbBcC \#dDeEfF rescue`
4. `sudo ./impish-gdm-set-background --gradient vertical \#aAbBcC \#dDeEfF rescue`

Why RESCUE_MODE?
It is when you try to change the background with some other scripts and then interacted with this script,
there will be some conflicts. In case you ran other scripts to change the background and then tried this script,
found conflicts? then add 'rescue' to the end of the command as mentiond above.

Please note that for 'RESCUE_MODE' active internet connection is necessary
