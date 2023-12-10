# ubuntu-gdm-set-background

Set Background for Ubuntu's (Gnome's GDM) lock/login screen!

Useful for privacy, where your personal desktop background isn't revealed to those around who don't have your password.

----

# Note:
## Before running this script, first please follow this link for setting login background via `gsettings`: https://bugs.launchpad.net/ubuntu/+source/gnome-shell/+bug/1929536. If you are not satisfied with the result then only go for the script.

> [Test Case]
>
> 1. Boot a desktop session
> 2. Verify that the greeter shows the default aubergine background.
> 3. Login as the administrator of the machine
> 4. Install systemd-container
> 5. Switch to the GDM user:
>    `$ sudo machinectl shell gdm@ /bin/bash`
> 6. Apply a different background with the command:
>    `$ gsettings set com.ubuntu.login-screen background-picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'`
> 7. Logout
> 8. Verify that the greeter now shows the image `warty-final-ubuntu.png`.

# UPDATES for Ubuntu 23.04+

## for Ubuntu 23.10/Gnome 45

This is highly recommonded way: https://github.com/PRATAP-KUMAR/gdm-extension - as it avoids having to recompile gresources.

## for Ubuntu 23.04+

1. `ubuntu-gdm-set-background` -> has four options just like the previous versions: Image, Color, Gradient Horizontal, Gradient Vertical.
2. `ubuntu-gdm-set-background-transparent` -> sets the login-background color transparent so that the background set via `gsettings set com.ubuntu.login-screen background-picture-uri` is visible. This is the **RECOMMENDED** way for 23.04+.

Please follow this link for setting login background via `gsettings`: https://bugs.launchpad.net/ubuntu/+source/gnome-shell/+bug/1929536

# `ubuntu-gdm-set-background` script (for changing Ubuntu 20.04, 21.04, 22.04, 22.10, 23.04, 23.10 GDM Background) HELP

Download the script with one of these commands:

```console
$ wget -q https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background && chmod +x ubuntu-gdm-set-background
$ curl -fL 'https://raw.githubusercontent.com/PRATAP-KUMAR/ubuntu-gdm-set-background/main/ubuntu-gdm-set-background' -o ubuntu-gdm-set-background && chmod +x ubuntu-gdm-set-background
```

There are four options

1. background with image
2. background with color
3. background with gradient horizontal ( requires two valid hex color inputs)
4. background with gradient vertical ( requires two valid hex color inputs)

Tip: be ready with valid hex color code in place of below example like `#aAbBcC` or `#dDeEfF`. Change them to your preferred hex color codes.
You may choose colors from [color-hex.com](https://www.color-hex.com/)

Example Commands:

1. `sudo bash ubuntu-gdm-set-background --image /home/user/backgrounds/image.jpg`
2. `sudo bash ubuntu-gdm-set-background --color \#aAbBcC`
3. `sudo bash ubuntu-gdm-set-background --gradient horizontal \#aAbBcC \#dDeEfF`
4. `sudo bash ubuntu-gdm-set-background --gradient vertical \#aAbBcC \#dDeEfF`
5. `sudo bash ubuntu-gdm-set-background --reset`
6. `bash ubuntu-gdm-set-background --help`

RESCUE_MODE, Example Commands:

1. `sudo bash ubuntu-gdm-set-background --image /home/user/backgrounds/image.jpg rescue`
2. `sudo bash ubuntu-gdm-set-background --color \#aAbBcC rescue`
3. `sudo bash ubuntu-gdm-set-background --gradient horizontal \#aAbBcC \#dDeEfF rescue`
4. `sudo bash ubuntu-gdm-set-background --gradient vertical \#aAbBcC \#dDeEfF rescue`

Why RESCUE_MODE?
When you try to change the background with some other scripts and then interact with this script,
there could be some conflicts. In case you ran other scripts to change the background and then tried this script,
and found conflicts, then add 'rescue' to the end of the command as mentioned above.

Please note that for `RESCUE_MODE` active internet connection is necessary

# Screenshots (some with their respective recipe command below each)

![1](https://user-images.githubusercontent.com/40719899/138041931-c61f5223-b446-47f4-bc30-4926b380db9f.png)

![2](https://user-images.githubusercontent.com/40719899/138041947-ca1d8f27-a294-45c4-9f0a-50e6c5de8004.png)

![3](https://user-images.githubusercontent.com/40719899/138041955-321aa1bb-1d1f-4b61-96ff-9accc129b846.png)

![4](https://user-images.githubusercontent.com/40719899/138041957-e8dcae5c-b52d-4c58-be04-d899b9e49ce8.png)

`sudo bash ubuntu-gdm-set-background --color \#456789`

![5](https://user-images.githubusercontent.com/40719899/138041959-32db8c1b-7679-4513-9c15-5071f231f796.png)

`sudo bash ubuntu-gdm-set-background --color \#ff00ff`

![6](https://user-images.githubusercontent.com/40719899/138041960-3978f9c0-8cee-4a68-82fb-5f77865c8c77.png)

`sudo bash ubuntu-gdm-set-background --color \#282828`

![7](https://user-images.githubusercontent.com/40719899/138041961-7c58337d-9cbb-42d4-974f-d260a024e5fd.png)

`sudo bash ubuntu-gdm-set-background --gradient vertical \#aAbBcC \#dDeEfF`

![8](https://user-images.githubusercontent.com/40719899/138041963-a4981163-1c1f-4886-9a67-cfc1827a5d80.png)

`sudo bash ubuntu-gdm-set-background --gradient horizontal \#aAbBcC \#dDeEfF`

![9](https://user-images.githubusercontent.com/40719899/138041965-19699e82-4d31-4539-80ac-3f3bc559504d.png)

![10](https://user-images.githubusercontent.com/40719899/138041973-bde88f7c-8fe5-4862-87bc-3affd4d44dbf.png)

`sudo bash ubuntu-gdm-set-background --color \#8a5f2f`

![11](https://user-images.githubusercontent.com/40719899/138041974-e229d7a4-9950-4eec-b837-716d7947b192.png)

`sudo bash ubuntu-gdm-set-background --gradient horizontal \#8ab333 \#2aad9e`

![12](https://user-images.githubusercontent.com/40719899/138041976-8c6f1f36-a32c-4ed3-993d-22fe66a9fc42.png)

`sudo bash ubuntu-gdm-set-background --gradient vertical \#3338ab \#00abcd rescue`

Has discovered the gradient of the backgrounds thanks to the awesome: https://cssgradient.io/
