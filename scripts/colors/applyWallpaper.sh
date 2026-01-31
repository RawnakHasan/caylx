#!/usr/bin/env bash

# Check if wallpaper argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <wallpaper_path>"
    echo "Example: $0 /path/to/wallpaper.png"
    exit 1
fi

WALLPAPER="$1"
CONFIG_FILE="$HOME/.config/caylx/config.json"
SCRIPT_DIR="$HOME/.config/quickshell/caylx/scripts"

# Check if wallpaper file exists
if [ ! -f "$WALLPAPER" ]; then
    echo "Error: Wallpaper file '$WALLPAPER' not found"
    exit 1
fi

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file '$CONFIG_FILE' not found"
    exit 1
fi

# Read scheme from config
SCHEME=$(jq -r '."color-scheme"' "$CONFIG_FILE")

# Check if jq succeeded
if [ -z "$SCHEME" ] || [ "$SCHEME" = "null" ]; then
    echo "Error: Could not read color-scheme from config"
    exit 1
fi

# Run matugen
echo "Applying wallpaper: $WALLPAPER"
echo "Using scheme: $SCHEME"
matugen -t "$SCHEME" image "$WALLPAPER"

echo "Creating Terminal Colors"
$SCRIPT_DIR/colors/applyColors.sh
