#!/bin/bash

# get_files_by_extension.sh
# Advanced file finder with multiple options

DIRECTORY=""
EXTENSIONS=()
RECURSIVE=true
COUNT_ONLY=false
VERBOSE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--directory)
      DIRECTORY="$2"
      shift 2
    ;;
    -e|--extension)
      EXTENSIONS+=("$2")
      shift 2
    ;;
    -n|--no-recursive)
      RECURSIVE=false
      shift
    ;;
    -c|--count)
      COUNT_ONLY=true
      shift
    ;;
    -v|--verbose)
      VERBOSE=true
      shift
    ;;
    -h|--help)
      echo "Usage: $0 -d <directory> -e <ext1> [-e <ext2>] [options]"
      echo ""
      echo "Options:"
      echo "  -d, --directory <path>    Directory to search"
      echo "  -e, --extension <ext>     File extension (can be used multiple times)"
      echo "  -n, --no-recursive        Don't search subdirectories"
      echo "  -c, --count               Only show count of files"
      echo "  -v, --verbose             Show detailed output"
      echo "  -h, --help                Show this help message"
      echo ""
      echo "Examples:"
      echo "  $0 -d /usr/share/applications -e .desktop"
      echo "  $0 -d ~/Music -e .mp3 -e .flac -e .wav -c"
      echo "  $0 -d ~/Documents -e .pdf -n -v"
      exit 0
    ;;
    *)
      echo "Unknown option: $1"
      echo "Use -h or --help for usage information"
      exit 1
    ;;
  esac
done

# Validate inputs
if [ -z "$DIRECTORY" ]; then
  echo "Error: Directory is required. Use -d <directory>"
  exit 1
fi

if [ ${#EXTENSIONS[@]} -eq 0 ]; then
  echo "Error: At least one extension is required. Use -e <extension>"
  exit 1
fi

if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Directory '$DIRECTORY' does not exist"
  exit 1
fi

# Build find command
FIND_CMD="find \"$DIRECTORY\""

if [ "$RECURSIVE" = false ]; then
  FIND_CMD="$FIND_CMD -maxdepth 1"
fi

FIND_CMD="$FIND_CMD -type f \\("

# Add extensions
FIRST=true
for ext in "${EXTENSIONS[@]}"; do
  # Add dot if not present
  if [[ ! "$ext" =~ ^\. ]]; then
    ext=".$ext"
  fi
  
  if [ "$FIRST" = false ]; then
    FIND_CMD="$FIND_CMD -o"
  fi
  FIRST=false
  
  FIND_CMD="$FIND_CMD -name \"*$ext\""
done

FIND_CMD="$FIND_CMD \\) 2>/dev/null"

if [ "$VERBOSE" = true ]; then
  echo "Searching in: $DIRECTORY"
  echo "Extensions: ${EXTENSIONS[*]}"
  echo "Recursive: $RECURSIVE"
  echo ""
fi

# Execute find command
FILES=$(eval $FIND_CMD)

if [ "$COUNT_ONLY" = true ]; then
  COUNT=$(echo "$FILES" | grep -c .)
  echo "$COUNT files found"
else
  echo "$FILES"
  
  if [ "$VERBOSE" = true ]; then
    COUNT=$(echo "$FILES" | grep -c .)
    echo ""
    echo "Total: $COUNT files"
  fi
fi