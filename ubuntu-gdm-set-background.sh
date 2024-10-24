#!/bin/bash
set -e

# Colors
Red='\e[0;31m'
BRed='\e[1;31m'
BIRed='\e[1;91m'
Gre='\e[0;32m'
BGre='\e[1;32m'
BBlu='\e[1;34m'
BWhi='\e[1;37m'
RCol='\e[0m'

codename="$(grep UBUNTU_CODENAME /etc/os-release | cut -d = -f 2)"
osname="$(grep -E '="?Ubuntu"?$' /etc/os-release | cut -d = -f 2)"

if [ "$codename" == "focal" ] && [[ "$osname" =~ \"?Ubuntu\"? ]]; then
  GDM_RESOURCE_CONFIG_NAME="gdm3"
else
  echo -e "${Red}
------------------------------------------------------------------
Sorry, Script is only for Ubuntu ${BWhi}20.04${Red}
Exiting...
------------------------------------------------------------------
${RCol}"
  exit 1
fi

if ! dpkg -l | grep -q libglib2.0-dev-bin; then
  echo -e "${Red}
-----------------------------------------------------------------------------------------------------
Installing dependency ${BGre}'libglib2.0-dev-bin'${Red}...
-----------------------------------------------------------------------------------------------------${RCol}"
  #exit 1
  sudo apt-get install libglib2.0-dev-bin
fi

dest="/usr/local/share/gnome-shell/custom-gdm"
color='#456789'
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

###################################################
HELP() {

  echo -e "
${BGre}ubuntu-gdm-set-background${BGre} script (for changing Ubuntu 20.04 GDM Background) -- HELP ${RCol}

there are four options
1. background with color
2. background with image
3. background with gradient horizontal (requires two valid hex color inputs)
4. background with gradient vertical (requires two valid hex color inputs)

${BGre}Tip: be ready with valid hex color code in place of below example like #aAbBcC or #dDeEfF.
Change them to your preffered hex color codes.
you may choose colors from ${BBlu}https://www.color-hex.com/${RCol}

General Commands:
${BBlu}
1. ./ubuntu-gdm-set-background.sh --help
2. sudo ./ubuntu-gdm-set-background.sh --reset${RCol}

Example Commands:
${BGre}
1. sudo ./ubuntu-gdm-set-background.sh --source yaru --color \#aAbBcC
2. sudo ./ubuntu-gdm-set-background.sh --source vanilla --image /home/user/backgrounds/image.jpg
3. sudo ./ubuntu-gdm-set-background.sh --source yaru --gradient horizontal \#aAbBcC \#dDeEfF
4. sudo ./ubuntu-gdm-set-background.sh --source vanilla --gradient vertical \#aAbBcC \#dDeEfF${RCol}

RESCUE_MODE, Example Commands:
${BBlu}
1. sudo ./ubuntu-gdm-set-background.sh --source yaru --color \#aAbBcC rescue
2. sudo ./ubuntu-gdm-set-background.sh --source vanilla --image /home/user/backgrounds/image.jpg rescue
3. sudo ./ubuntu-gdm-set-background.sh --source yaru --gradient horizontal \#aAbBcC \#dDeEfF rescue
4. sudo ./ubuntu-gdm-set-background.sh --source vanilla --gradient vertical \#aAbBcC \#dDeEfF rescue${RCol}

${BWhi}Why RESCUE_MODE?${RCol}
It is when you try to change the background with some other scripts and then interacted with this script,
there will be some conflicts. In case you ran other scripts to change the background and then tried this script,
found conflicts? then add 'rescue' to the end of the command as mentiond above.

${BRed}Please note that for 'RESCUE_MODE' active internet connection is necessary ${RCol}
"

}
###################################################

###################################################
ROUTINE_CHECK() {
  if [ "$UID" != "0" ]; then
    echo -e "${BRed}This script must be run with sudo${RCol}"
    exit 1
  fi

  if ! [ -d "$dest" ]; then
    install -d "$dest"
  fi

}
###################################################

###################################################
RESCUE_MODE() {
  echo -e "
>>>>> Trying to ${BWhi}reinstall${RCol} the package yaru-theme-gnome-shell,
if the reinstallation of the package is succesful, background change will be done
otherwise No changes will be made <<<<<<<<<
"

  if ! apt install --reinstall yaru-theme-gnome-shell; then
    echo -e "${BIRed}
SCRIPT COULD NOT FINISH THE JOB, FAILURE, NO CHANGES WERE DONE.${RCol}"
    exit 1
  fi
}
###################################################

###################################################
EXTRACT() {
  for r in $(gresource list $source); do
    t="${r/#\/org\/gnome\/shell\//}"
    mkdir -p -- "$(dirname -- "$tmp_dir/$t")"
    # *should* only be $tmp_dir/theme, but should make a tempdir for this
    gresource extract "$source" "$r" >"$tmp_dir/$t"
  done
}
###################################################

###################################################
CREATE_XML() {
  extractedFiles="$(find "$tmp_dir/theme" -type f -printf "    <file>%P</file>\n")"
  cat <<EOF >"$tmp_dir/theme/custom-gdm-background.gresource.xml"
<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">
$extractedFiles
  </gresource>
</gresources>
EOF
}
###################################################

###################################################
SET_GRESOURCE() {
  update-alternatives --quiet --install "/usr/share/gnome-shell/$GDM_RESOURCE_CONFIG_NAME-theme.gresource" "$GDM_RESOURCE_CONFIG_NAME-theme.gresource" "$dest/custom-gdm-background.gresource" 0
  update-alternatives --quiet --set "$GDM_RESOURCE_CONFIG_NAME-theme.gresource" "$dest/custom-gdm-background.gresource"

  if update-alternatives --query "$GDM_RESOURCE_CONFIG_NAME-theme.gresource" | grep -q "Value: $dest/custom-gdm-background.gresource"; then
    echo -e "
\xf0\x9f\x98\x80\x00 ${BGre}Seems 'background change is successful'${RCol}
Changes will be effective after a Reboot (${BWhi}CTRL+ALT+F1${RCol} may show the changes immediately)
If something went wrong, log on to tty and run the below command
${BWhi}$ sudo update-alternatives --quiet --set $GDM_RESOURCE_CONFIG_NAME-theme.gresource $source${RCol}
"
  else
    echo Failure
    exit 1
  fi
}
###################################################

############################################################################################
case "$1" in
--help)
  HELP
  exit 0
  ;;
--reset)
  ROUTINE_CHECK
  if ! [ -f "$dest/custom-gdm-background.gresource" ]; then
    echo -e "
-----------------------------------------------------------------------------
No need, Already Reset. ${Red}(or unlikely background is not set using this Script.)${RCol}
-----------------------------------------------------------------------------"
    exit 0
  else
    if [ -z $(gresource list "$dest/custom-gdm-background.gresource" | grep "yaru.css") ];then
      css_source="/usr/share/gnome-shell/gnome-shell-theme.gresource"
    else
      css_source="/usr/share/gnome-shell/theme/Yaru/gnome-shell-theme.gresource"
    fi
    rm "$dest/custom-gdm-background.gresource"
    update-alternatives --quiet --set "$GDM_RESOURCE_CONFIG_NAME-theme.gresource" $css_source
    #! Run in subshell so outside pwd not changed
    (cd /usr/local/share/ && rmdir --ignore-fail-on-non-empty -p gnome-shell/custom-gdm)
    echo -e "${Gre}
      				---------------
		  		|Reset Success|
		  		---------------
		  		Changes will be effective after a Reboot ${RCol}"
    exit 0
  fi
  ;;
--source)
  if [ "$2" == "yaru" ]; then
    source="/usr/share/gnome-shell/theme/Yaru/gnome-shell-theme.gresource"
    source_css="yaru"
  elif [ "$2" == "vanilla" ]; then
    source="/usr/share/gnome-shell/gnome-shell-theme.gresource"
    source_css="vanilla"
  else
    echo "Please specify source 'yaru' or 'vanilla' for the --source option"
    exit 1
  fi
  if [ -z "$3" ];then
    echo -e "Please specify option --color | --image | --gradient\n or run './ubuntu-gdm-set-background --help' for help"
    exit 1
  fi
  ;;
*)
  echo -e "\nYou have not followed the example commands.\nPlease go through the exmaple commands below"
  HELP
esac
############################################################################################

############################################################################################
case "$3" in
--image)
  if [ -z "$4" ]; then
    echo -e "${BRed}Image path is not provided${RCol}"
    exit 1
  fi

  if
    image_path="$(realpath -- "$4")" && file "$image_path" | grep -qE 'image|bitmap'
  then
    ROUTINE_CHECK
    if [ "$5" == "rescue" ]; then
      RESCUE_MODE
    fi
    EXTRACT

    cp "$image_path" "$tmp_dir/theme/gdm-background"
    mv "$tmp_dir/theme/$GDM_RESOURCE_CONFIG_NAME.css" "$tmp_dir/theme/$source_css.css"
    echo '@import url("resource:///org/gnome/shell/theme/'$source_css'.css");
#lockDialogGroup {
background: '"$color"' url("resource:///org/gnome/shell/theme/gdm-background");
background-repeat: no-repeat;
background-size: cover;
background-position: center; }' > "$tmp_dir/theme/$GDM_RESOURCE_CONFIG_NAME.css"
    CREATE_XML
    glib-compile-resources --sourcedir "$tmp_dir/theme" "$tmp_dir/theme/custom-gdm-background.gresource.xml"
    mv "$tmp_dir/theme/custom-gdm-background.gresource" "$dest"

    SET_GRESOURCE

    exit 0

  else
    echo -e "${BRed}
Absolute path to image is neither provided nor is it valid.
see help with below command${BWhi}
$ ./ubuntu-gdm-set-background.sh --help${RCol}"
    exit 1
  fi
  ;;
--color)
  if [ -z "$4" ]; then
    echo -e "${Red}Color is not provided.
      Use ${BWhi}sudo ./ubuntu-gdm-set-background.sh --color \\#aee02a${BBlu} to set #aee02a as the background color.${RCol}"
    exit 1
  fi
  if ! [[ "$4" =~ ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$ ]]; then
    echo -e "${BRed}Provided color is not a valid 'HEX Color Code'${RCol}
See help with below command
${BWhi}./ubuntu-gdm-set-background.sh --help${RCol}"
    exit 1
  fi

  ROUTINE_CHECK
  if [ "$5" == 'rescue' ]; then
    RESCUE_MODE
  fi

  EXTRACT

  mv "$tmp_dir/theme/$GDM_RESOURCE_CONFIG_NAME.css" "$tmp_dir/theme/$source_css.css"
  echo '@import url("resource:///org/gnome/shell/theme/'$source_css'.css");
#lockDialogGroup {
background-color: '"$4"'; }' > "$tmp_dir/theme/$GDM_RESOURCE_CONFIG_NAME.css"
  CREATE_XML

  glib-compile-resources --sourcedir "$tmp_dir/theme" "$tmp_dir/theme/custom-gdm-background.gresource.xml"
  mv "$tmp_dir/theme/custom-gdm-background.gresource" "$dest"

  SET_GRESOURCE

  exit 0
  ;;
--gradient)
  if [ "$4" == "horizontal" ] || [ "$4" == "vertical" ]; then
    direction="$4"
  else
    echo -e "${BRed}Gradient direction is not provided.${RCol}
    Use ${BWhi}sudo ./ubuntu-gdm-set-background.sh --gradient horizontal \#aa03af \#afa0ee${RCol} OR
    ${BWhi}sudo ./ubuntu-gdm-set-background.sh --gradient vertical \#aa03af \#afa0ee${RCol} to set a vertical gradient.
    See ${BWhi}./ubuntu-gdm-set-background.sh --help for more info${RCol}"
    exit 1
  fi
  if [[ -z "$5" || -z "$6" ]]; then
    echo -e "${BRed}color/colors is/are not provided${RCol}"
    exit 1
  fi

  if ! [[ "$5" =~ ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$ ]] || ! [[ "$6" =~ ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$ ]]; then
    echo -e "${BRed}Provided color/colors is/are not a valid 'HEX Color Code'${RCol}.
See help with below command
${BWhi}$ ./ubuntu-gdm-set-background --help${RCol}"
    exit 1
  fi

  ROUTINE_CHECK

  if [ "$7" == "rescue" ]; then
    RESCUE_MODE
  fi

  EXTRACT
  mv "$tmp_dir/theme/$GDM_RESOURCE_CONFIG_NAME.css" "$tmp_dir/theme/$source_css.css"
  echo '@import url("resource:///org/gnome/shell/theme/'$source_css'.css");
#lockDialogGroup {
background-gradient-direction: '"$direction"';
background-gradient-start: '"$5"';
background-gradient-end: '"$6"'; }' > "$tmp_dir/theme/$GDM_RESOURCE_CONFIG_NAME.css"
  CREATE_XML
  glib-compile-resources --sourcedir "$tmp_dir/theme" "$tmp_dir/theme/custom-gdm-background.gresource.xml"
  mv "$tmp_dir/theme/custom-gdm-background.gresource" "$dest"

  SET_GRESOURCE

  exit 0
  ;;
esac
############################################################################################
