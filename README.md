
# impish-gdm-set-background script (for changing Ubuntu 21.10 GDM Background) HELP

This Script is only for Ubuntu 21.10 (Code Name: Impish) to change the gdm background to any color or with Image.

Download the script with the below command
````
wget -qO - https://github.com/PRATAP-KUMAR/impish-gdm-set-background/archive/main.tar.gz | tar zx --strip-components=1 impish-gdm-set-background-main/impish-gdm-set-background
````

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

![1](https://user-images.githubusercontent.com/40719899/137702434-2bb8b220-1d12-4365-b225-a2e34cfc1c33.png)

![2](https://user-images.githubusercontent.com/40719899/137702706-35a2dbc5-1f65-4ae0-89c7-dc6ff47c3e9f.png)

![3](https://user-images.githubusercontent.com/40719899/137702727-38daa6a6-dd11-4180-85eb-7c065d7251aa.png)

![4](https://user-images.githubusercontent.com/40719899/137702731-5d2d68c9-6ef4-4360-bf11-66ee1b9596ab.png)

![5](https://user-images.githubusercontent.com/40719899/137702734-7f78ddbf-eb94-45ac-992f-526434d0dbae.png)

![6](https://user-images.githubusercontent.com/40719899/137792906-c52b950c-9a60-4767-b609-45bf298116dd.png)

![7](https://user-images.githubusercontent.com/40719899/137792910-f41be737-d35d-45fb-ab6a-2ebfc9dc796f.png)

![8](https://user-images.githubusercontent.com/40719899/137792913-f9e78e69-97db-4621-944d-cf843309ba19.png)

![9](https://user-images.githubusercontent.com/40719899/137794268-a80aaa40-0f1c-4c8b-b1cc-87b6e1ce9662.png)
