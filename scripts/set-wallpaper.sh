#!/bin/bash

# pick a default/random wallpaper for a theme
# and set it

# theme names are uppercase
valid_themes=(
	"Camila"
	"Esmeralda"
	"Nami" 
	"Raven" 
	"Ryan"
	"Simon"
	"Xavier" 
	"Zenitsu"
)

print_usage() {
	echo "Usage: $0 theme-name [-r] [-h]"
}

print_help() {
	print_usage
	echo "Options:"
	echo "    -r        Enable random wallpapers"
	echo "    -h        Display this help message"
	echo "Themes:"
	for theme in "${valid_themes[@]}"; do
		echo "    $theme"
	done
}

# parse args
# (some jank based on option positioning)
script_args=()
set_random=false
while [ $OPTIND -le "$#" ]
do
    if getopts "hr" option
    then
        case $option
        in
            h) print_help; exit 0 ;;
            r) set_random=true ;;
			*) print_usage; exit 1;
        esac
    else
        script_args+=("${!OPTIND}")
        ((OPTIND++))
    fi
done

# validate theme
theme=$script_args
if [ ${#script_args[@]} -ne 1 ]; then
	print_usage
	exit 1
fi
if [[ ! " ${valid_themes[*]} " =~ [[:space:]]${theme}[[:space:]] ]]; then
	echo "Invalid theme-name '$theme'"
	print_help
	exit 1
fi

# update wallpaper
user=$(whoami)
wallpapers_dir="/home/${user}/.themes/${theme}/wallpapers"

# verify directory exists
if [ ! -d "$wallpapers_dir" ]; then
	echo "Wallpaper directory $wallpapers_dir does not exist!"
	exit 1
fi

# pick random/default wallpaper
wallpapers=($(find "$wallpapers_dir" -type f -name "*.png" -o -name "*.jpg" -o -name "*.jpeg"))
if [ "$set_random" = true ]; then
	wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"
else
	# TODO add an option to pick which a default wallpaper
	wallpaper="${wallpapers_dir}/wal-0.png"
fi

# SET WALLPAPER
feh --bg-scale "$wallpaper"
