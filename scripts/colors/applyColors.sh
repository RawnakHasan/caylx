#! /bin/env bash

SHELL_SCRIPTS="$HOME/.config/quickshell/caylx/scripts"
SHELL_COLOR_SCRIPTS="$SHELL_SCRIPTS/colors"

$SHELL_COLOR_SCRIPTS/generate-colors-material.sh
$SHELL_COLOR_SCRIPTS/apply-term.sh
$SHELL_COLOR_SCRIPTS/kde_material_you.sh
