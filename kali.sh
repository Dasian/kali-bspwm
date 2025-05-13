#!/bin/bash

# COLOR USE THE SCRIPT
Black='\033[1;30m'
Red='\033[1;31m'
Green='\033[1;32m'
Yellow='\033[1;33m'
Blue='\033[1;34m'
Purple='\033[1;35m'
Cyan='\033[1;36m'
White='\033[1;37m'
NC='\033[0m'
blue='\033[0;34m'
white='\033[0;37m'
lred='\033[0;31m'
IWhite="\[\033[0;97m\]"

# VARIABLE DATABASE AND OTHER THINGS
USERNAME=$(whoami)
HOME="/home/${USERNAME}"
KERNEL=$(uname -r)
DISTRIBUTION=$(uname -o)
HOST=$(uname -n)
BIT=$(uname -m)
CWD=$(pwd)
rice_scripts="${HOME}/.themes/rice-scripts"

# SCRIPT PRESENTATION
banner () {
	echo -e "${White} ╔───────────────────────────────────────────────╗                 	"
	echo -e "${White} |${Cyan} ██████╗ ███████╗██████╗ ██╗    ██╗███╗   ███╗${White} |      "
	echo -e "${White} |${Cyan} ██╔══██╗██╔════╝██╔══██╗██║    ██║████╗ ████║${White} |      "
	echo -e "${White} |${Cyan} ██████╔╝███████╗██████╔╝██║ █╗ ██║██╔████╔██║${White} |      "
	echo -e "${White} |${Cyan} ██╔══██╗╚════██║██╔═══╝ ██║███╗██║██║╚██╔╝██║${White} |	"
	echo -e "${White} |${Cyan} ██████╔╝███████║██║     ╚███╔███╔╝██║ ╚═╝ ██║${White} |	"
	echo -e "${White} |${Cyan} ╚═════╝ ╚══════╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝${White} |	"
	echo -e "${White} ┖───────────────────────────────────────────────┙			"
	echo ""
	echo -e "${White} [${Blue}i${White}] BSPWM | Hacker environment automation script."
	echo ""
	echo -e "${White} [${Blue}i${White}] Installation will begin soon."
	echo ""
	echo -e "${White} [${Blue}i${White}] Hello ${Red}${USERNAME}${White}, This is the bspwm installation script for kali linux"
}

# INSTALL BSPWM KALI LINUX SETUP
setup () {
	clear
	banner
	echo -ne "${White} [${Blue}!${White}] Do you want to continue with the installation? Y|N ▶ ${Red}"
	# TODO make this if statement better
	read quest
if [ $quest = Y ]; then

	echo "Updating system..."
	sudo apt update -y

	# installing core packages for the theme
	declare -a themepackages=(
		"bspwm" 
		"sxhkd" 
		"kitty" 
		"picom" 
		"neofetch" 
		"ranger" 
		"cava" 
		"polybar"
	)
	for themepkg in "${themepackages[@]}";
	do
		echo -e "${White} [${Blue}i${White}] checking if ${themepkg} is installed"
		if ! dpkg -s ${themepkg} &>/dev/null ; then
			echo -e "${White} [${Red}-${White}] ${themepkg} is not installed, installing bspwm"
			sudo apt install ${themepkg} -y
		fi

		# installing config files (some files still need to be +x)
		# TODO ask to change config
		echo -e "${White} [${Blue}+${White}] ${themepkg} is installed, installing configuration"
		cd ${CWD}/config
		sudo rm -rf ${HOME}/.config/${themepkg}
		cp -r ${themepkg} ${HOME}/.config/${themepkg}
	done

	# set configs as executable
	echo -e "${White} [${Blue}+${White}] Making config files executable..."
	chmod +x ${HOME}/.config/bspwm/bspwmrc
	chmod +x ${HOME}/.config/sxhkd/sxhkdrc
	chmod +x ${HOME}/.config/polybar/launch.sh
	chmod +x ${HOME}/.config/polybar/cuts/scripts/checkupdates
	chmod +x ${HOME}/.config/polybar/cuts/scripts/*.sh

	# other packages
	echo -e "${White} [${Blue}i${White}] Installing missing dependencies"
	sudo apt install rofi fonts-firacode fonts-cantarell lxappearance nitrogen lsd betterlockscreen flameshot git net-tools xclip xdotool -y
	sudo apt install scrub bat tty-clock openvpn feh pulseaudio-utils git lolcat -y

	# installing fonts
	echo -e "${White} [${Blue}i${White}] Installing fonts"
	cd ${CWD}
	sudo rm -rf ${HOME}/.fonts
	cp -r .fonts ${HOME}
	sudo cp -r .fonts /usr/share/fonts

	# installing themes
	echo -e "${White} [${Blue}i${White}] Installing bspwm themes"
	cd ${CWD}
	cp -r themes ${HOME}/.themes
	chmod +x ${rice_scripts}/*.sh
	echo ""
	for THEMENAME in "Camila" \
		"Esmeralda" \
		"Nami" \
		"Raven" \
		"Ryan" \
		"Simon" \
		"Xavier" \
		"Zenitsu"
		do 
			echo -e "${White} [${Blue}+${White}] Installing theme ${Red}${THEMENAME}"
			# polybar pentest modules
			chmod +x ${HOME}/.themes/${THEMENAME}/scripts/*.sh

			# create a copy of master bspwmrc (.config/bspwm/bspwmrc)
			# add themed wallpaper
			themed_bspwmrc_dir="${HOME}/.themes/${THEMENAME}/bspwmrc"
			cp ${CWD}/config/bspwm/bspwmrc $themed_bspwmrc_dir
			chmod +x $themed_bspwmrc_dir
			echo "\${HOME}/.themes/rice-scripts/set-wallpaper.sh ${THEMENAME} -r &" >> "${themed_bspwmrc_dir}"

		done

	# TODO add your preferred packages!
	echo -e "${White} [${Blue}i${White}] Step 12 Installing preferred packages"
	cd ${CWD}
	cp zshrc ${HOME}/.zshrc
	cp vimrc ${HOME}/.vimrc
	# cd ; git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

	# colorscript
	# it's the terminal prompt stuff which is cute

	# oh my zsh install
	# https://github.com/ohmyzsh/ohmyzsh
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# zsh vi mode 
	git clone https://github.com/jeffreytse/zsh-vi-mode ${HOME}/.zsh-vi-mode

fi
}

# CALLS THE SCRIPT
reset
setup

