#!/bin/bash

# COLORS THE SCRIPT
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

# VARIABLES DATABASE
USERNAME=$(whoami)
THEMEDIR="/home/${USERNAME}/.themes"
POLYDIR="/home/${USERNAME}/.config/polybar/cuts"
CONDIR="/home/${USERNAME}"

# TRAPS CTRL-C
trap ctrl_c INT

# EXIT THE SCRIPT CTRL-C
ctrl_c () {
echo ""
echo ""
echo -e "${Blue} ${White}[${Cyan}i${White}] Exiting the theming script"
exit 0
}

# BANNER THE SCRIPT
banner () {
echo -e "${White} ╔────────────────────────────────────────────────────────────────────╗     		  		  "
echo -e "${White} |${Blue} ████████╗██╗  ██╗███████╗ █████╗ ███╗   ███╗██╗███╗   ██╗ ██████╗ ${White} |    		  "
echo -e "${White} |${Blue} ╚══██╔══╝██║  ██║██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔════╝ ${White} |     		  "
echo -e "${White} |${Blue}    ██║   ███████║█████╗  ███████║██╔████╔██║██║██╔██╗ ██║██║  ███╗${White} |    		  "
echo -e "${White} |${Blue}    ██║   ██╔══██║██╔══╝  ██╔══██║██║╚██╔╝██║██║██║╚██╗██║██║   ██║${White} |    	          "
echo -e "${White} |${Blue}    ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║╚██████╔╝${White} |    	          "
echo -e "${White} |${Blue}    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ${White} |    	          "
echo -e "${White} ┖────────────────────────────────────────────────────────────────────┙    		 	          "
echo -e "${Blue} ${White}[${Cyan}i${White}] Welcome ${Red}${USERNAME}${White} to theme launcher and mode! 		  "
echo -e "${Blue} ${White}[${Cyan}i${White}] If you want to exit the script use ${Red}[CTRL+C]                             "
echo -e "${Blue} ${White}[${Cyan}i${White}] What type of theme do you want to apply? 			  		  "
}

# added to make the code nicer
GetTheme() {
	echo ""
	echo -e "${Blue} ${White}[${Cyan}i${White}] Loading themes normal mode..."
	echo ""
	echo -e "${Blue} [${Cyan}1${Blue}] Zenitsu"
	echo -e "${Blue} [${Cyan}2${Blue}] Raven"
	echo -e "${Blue} [${Cyan}3${Blue}] Simon"
	echo -e "${Blue} [${Cyan}4${Blue}] Camila"
	echo -e "${Blue} [${Cyan}5${Blue}] Ryan"
	echo -e "${Blue} [${Cyan}6${Blue}] Esmeralda"
	echo -e "${Blue} [${Cyan}7${Blue}] Xavier"
	echo -e "${Blue} [${Cyan}8${Blue}] Nami"
	echo ""
	echo -ne "${Blue} ▶ ${Red}"

	read THEMENAME
	case $THEMENAME in
		1) THEMENAME="Zenitsu" ;;
		2) THEMENAME="Raven" ;;
		3) THEMENAME="Simon" ;;
		4) THEMENAME="Camila" ;;
		5) THEMENAME="Ryan" ;;
		6) THEMENAME="Esmeralda" ;;
		7) THEMENAME="Xavier" ;;
		8) THEMENAME="Nami" ;;
		*)
		echo ""
		echo -e "${Blue} ${White}[${Cyan}i${White}] Invalid option, use numbers"
		GetTheme
		;; 
	esac
}

PenetrationThemes () {
	# sets THEMENAME
	GetTheme

	echo ""
	echo -e " ${White}[${Cyan}i${White}] Loading theme penetration mode ${Red}[${THEMENAME}]${NC}"

	# terminal colors
	cd ${THEMEDIR}/${THEMENAME}/kitty
	cp color.ini ${CONDIR}/.config/kitty

	# bspwm
	# window highlight and wallpaper
	cd ${THEMEDIR}/${THEMENAME}
	cp bspwmrc ${CONDIR}/.config/bspwm

	# polybar and rofi colors
	cd ${THEMEDIR}/${THEMENAME}/polybar
	cp user_modules.ini colors.ini ${CONDIR}/.config/polybar/cuts
	cp colors.rasi ${CONDIR}/.config/polybar/cuts/scripts/rofi

	# TODO edit the config.ini structure for ALL themes
	cd ${THEMEDIR}/${THEMENAME}/bar_pentest
	cp config.ini ${CONDIR}/.config/polybar/cuts

	# polybar module scripts (custom colors)
	cd ${THEMEDIR}/${THEMENAME}/scripts
	cp ethernet_status.sh machine_target.sh vpn_status.sh ${CONDIR}/.config/polybar/cuts/scripts

	# prob a,, better lockscreen
	echo ""
	betterlockscreen -u ${THEMEDIR}/${THEMENAME}/wallpapers/wal-0.png
	echo ""

	# restart window manager
	bspc wm -r

	echo -e " ${White}[${Cyan}i${White}] ${Red}[${THEMENAME}]${White} theme applied correctly"
	exit 0
}

# run the script lol
reset
PenetrationThemes
