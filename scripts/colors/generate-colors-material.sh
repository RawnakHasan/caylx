#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$HOME/.config/caylx/config.json"
WALLPAPER=$(cat ~/.local/state/caylx/wallpaper.txt)
SCHEMA_BASE_JSON="$SCRIPT_DIR/terminal/schema-base.json"
MODE=$(jq -r '.mode' "$CONFIG_FILE")
SCHEME=$(jq -r '."color-scheme"' "$CONFIG_FILE")
HARMONY=$(jq -r '.harmony' "$CONFIG_FILE")
OUTPUT_FILE="$HOME/.local/state/caylx/material_colors.scss"

# Change to the script directory before running Python
cd "$SCRIPT_DIR"

python convert_colors_material.py \
  --path "$WALLPAPER" \
  --mode "$MODE" \
  --scheme "$SCHEME" \
  --termscheme $SCHEMA_BASE_JSON \
  --harmony "$HARMONY" \
  --blend_bg_fg > $OUTPUT_FILE
