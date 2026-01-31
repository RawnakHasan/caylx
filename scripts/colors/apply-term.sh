#!/usr/bin/env bash

# Configuration
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
STATE_DIR="$XDG_STATE_HOME/caylx"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
term_alpha=100 # Set to < 100 for transparency

# Check if sequences template exists
if [ ! -f "$SCRIPT_DIR/terminal/sequences.txt" ]; then
  echo "Template file not found: $SCRIPT_DIR/terminal/sequences.txt"
  exit 1
fi

# Read generated colors
if [ ! -f "$STATE_DIR/material_colors.scss" ]; then
  echo "Generated colors not found: $STATE_DIR/material_colors.scss"
  exit 1
fi

# Parse color names and values
colornames=$(cat "$STATE_DIR/material_colors.scss" | cut -d: -f1)
colorstrings=$(cat "$STATE_DIR/material_colors.scss" | cut -d: -f2 | cut -d ' ' -f2 | cut -d ";" -f1)

IFS=$'\n'
colorlist=($colornames)
colorvalues=($colorstrings)

# Prepare output directory
mkdir -p "$STATE_DIR/terminal"
cp "$SCRIPT_DIR/terminal/sequences.txt" "$STATE_DIR/terminal/sequences.txt"

# Apply color substitutions
for i in "${!colorlist[@]}"; do
  sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$STATE_DIR/terminal/sequences.txt"
done

# Apply alpha transparency
sed -i "s/\$alpha/$term_alpha/g" "$STATE_DIR/terminal/sequences.txt"

# Apply to all active terminals
for file in /dev/pts/*; do
  if [[ $file =~ ^/dev/pts/[0-9]+$ ]]; then
    cat "$STATE_DIR/terminal/sequences.txt" > "$file" 2>/dev/null &
  fi
done

echo "Terminal colors applied successfully"
