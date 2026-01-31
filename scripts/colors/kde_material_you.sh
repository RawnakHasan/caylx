#!/usr/bin/env bash

XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
SHELL_DIR="$HOME/.config/quickshell/caylx"
CONFIG_FILE="$HOME/.config/caylx/config.json"
SCHEME=$(jq -r '."color-scheme"' "$CONFIG_FILE")
COLOR=$(tr -d '\n' < "$XDG_STATE_HOME/caylx/color.txt")

current_mode=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")
if [[ "$current_mode" == "prefer-dark" ]]; then
    mode_flag="-d"
else
    mode_flag="-l"
fi

case "$SCHEME" in
    scheme-content) sv_num=0 ;;
    scheme-expressive) sv_num=1 ;;
    scheme-fidelity) sv_num=2 ;;
    scheme-monochrome) sv_num=3 ;;
    scheme-neutral) sv_num=4 ;;
    scheme-tonal-spot) sv_num=5 ;;
    scheme-vibrant) sv_num=6 ;;
    scheme-rainbow) sv_num=7 ;;
    scheme-fruit-salad) sv_num=8 ;;
    "") sv_num=5 ;;
    *)
        echo "Unknown scheme variant: $SCHEME" >&2
        exit 1
        ;;
esac

source "${SHELL_DIR}/.venv/bin/activate"
kde-material-you-colors "$mode_flag" --color "$COLOR" -sv "$sv_num" --iconsdark "Papirus" --iconslight "Papirus"
deactivate
