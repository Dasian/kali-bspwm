#!/usr/bin/bash

# Simple CLI for shell-color-scripts

USERNAME=$(whoami)
DIR_COLORSCRIPTS="/home/${USERNAME}/.themes/rice-scripts/colorscripts"
fmt_help="  %-20s\t%-54s\n"
list_colorscripts="$(/usr/bin/ls "${DIR_COLORSCRIPTS}" | cut -d ' ' -f 1 | nl)"
length_colorscripts="$(/usr/bin/ls "${DIR_COLORSCRIPTS}" | wc -l)"
function _help() {
    echo "Description: A collection of terminal color scripts."
    echo ""
    echo "Usage: colorscript [OPTION] [SCRIPT NAME/INDEX]"
    printf "${fmt_help}" \
        "-h, --help, help" "Print this help." \
        "-l, --list, list" "List all installed color scripts." \
        "-r, --random, random" "Run a random color script." \
        "-e, --exec, exec" "Run a specified color script by SCRIPT NAME or INDEX."
}

function _list() {
    echo "There are "$(/usr/bin/ls "${DIR_COLORSCRIPTS}" | wc -l)" installed color scripts:"
    echo "${list_colorscripts}"
}

function _random() {
    declare -i random_index=$RANDOM%$length_colorscripts
    [[ $random_index -eq 0 ]] && random_index=1

    random_colorscript="$(echo  "${list_colorscripts}" | sed -n ${random_index}p \
        | tr -d ' ' | tr '\t' ' ' | cut -d ' ' -f 2)"
    echo "${random_colorscript}"
    exec "${DIR_COLORSCRIPTS}/${random_colorscript}"
}

function ifhascolorscipt() {
    [[ -e "${DIR_COLORSCRIPTS}/$1" ]] && echo "Has this color script."
}

function _run_by_name() {
    if [[ "$1" == "random" ]]; then
        _random
    elif [[ -n "$(ifhascolorscipt "$1")" ]]; then
        exec "${DIR_COLORSCRIPTS}/$1"
    else
        echo "Input error, Don't have color script named $1."
        exit 1
    fi
}

function _run_by_index() {
    if [[ "$1" -gt 0 && "$1" -lt "${length_colorscripts}" ]]; then

        colorscript="$(echo  "${list_colorscripts}" | sed -n ${1}p \
            | tr -d ' ' | tr '\t' ' ' | cut -d ' ' -f 2)"
        exec "${DIR_COLORSCRIPTS}/${colorscript}"
    else
        echo "Input error, Don't have color script indexed $1."
        exit 1
    fi
}

function _run_colorscript() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        _run_by_index "$1"
    else
        _run_by_name "$1"
    fi
}

case "$#" in
    0)
        _help
        ;;
    1)
        case "$1" in
            -h | --help | help)
                _help
                ;;
            -l | --list | list)
                _list
                ;;
            -r | --random | random)
                _random
                ;;
            *)
                echo "Input error."
                exit 1
                ;;
        esac
        ;;
    2)
        if [[ "$1" == "-e" || "$1" == "--exec" || "$1" == "exec" ]]; then
            _run_colorscript "$2"
        else
            echo "Input error."
            exit 1
        fi
        ;;
    *)
        echo "Input error, too many arguments."
        exit 1
        ;;
esac
