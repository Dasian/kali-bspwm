#!/bin/bash

# DATABASE VARIABLES
USERNAME=$(whoami)
USERDIR="/home/${USERNAME}"

# WALLPAPERS CAMILA

wallpapers_dir="/home/${USERNAME}/.themes/Camila/wallpapers"
wallpapers=($(find "$wallpapers_dir" -type f -name "*.png" -o -name "*.jpg" -o -name "*.jpeg"))

# RANDOM WALLPAPER
random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

# gonna just keep this one
fixed_wallpaper="${wallpapers_dir}/wal-0.png"

# SET WALLPAPER
# feh --bg-scale "$random_wallpaper"
feh --bg-scale "$fixed_wallpaper"
