#!/bin/bash

# ==============================
# SETTINGS — edit these if needed
# ==============================
REMOTE="gdrive:Wallpapers/instagram/_artsopolis"
TEMP_DIR=~/temp_wp
SEEN_FILE=~/wallpaper_seen.txt

# ==============================
# WIFI CHECK
# ==============================
if ! ping -c 1 -W 3 8.8.8.8 > /dev/null 2>&1; then
  echo "No internet. Skipping."
  exit 0
fi

# ==============================
# GET FILE LIST
# ==============================
ALL_FILES=$(rclone ls "$REMOTE" | awk '{print $2}' | grep -iE '\.(jpg|jpeg|png|webp)$')

if [ -z "$ALL_FILES" ]; then
  echo "No images found."
  exit 1
fi

# ==============================
# SHUFFLE — no repeats until all seen
# ==============================
touch "$SEEN_FILE"
UNSEEN=$(comm -23 <(echo "$ALL_FILES" | sort) <(sort "$SEEN_FILE"))

if [ -z "$UNSEEN" ]; then
  echo "All images shown. Resetting cycle."
  > "$SEEN_FILE"
  UNSEEN="$ALL_FILES"
fi

# ==============================
# PICK RANDOM IMAGE
# ==============================
RANDOM_FILE=$(echo "$UNSEEN" | shuf -n 1)
echo "Selected: $RANDOM_FILE"

# ==============================
# DOWNLOAD AND SET WALLPAPER
# ==============================
mkdir -p "$TEMP_DIR"
rclone copy "$REMOTE/$RANDOM_FILE" "$TEMP_DIR/"
termux-wallpaper -f "$TEMP_DIR/$RANDOM_FILE"

# ==============================
# MARK SEEN AND CLEANUP
# ==============================
echo "$RANDOM_FILE" >> "$SEEN_FILE"
rm -rf "$TEMP_DIR"
echo "Done: $RANDOM_FILE"
