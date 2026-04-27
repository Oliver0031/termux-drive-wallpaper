# Termux Drive Wallpaper

Automatically rotate high-quality wallpapers on Android from a Google Drive folder using Termux. No PC required. Wallpapers change on a schedule, pull from the cloud one at a time, and never repeat until every image has been shown.

Built for Android-only users who want a cloud-based wallpaper rotation system without filling up local storage.

---

## What It Does

- Picks a random image from your Google Drive folder
- Downloads it temporarily, sets it as wallpaper, then deletes it
- No repeats until every image has been shown — then cycles again
- Skips automatically if no WiFi
- Runs on a schedule in the background — no manual effort after setup

---

## Requirements

- Android phone
- [Termux](https://f-droid.org/packages/com.termux/) (install from F-Droid)
- [Termux:API](https://f-droid.org/packages/com.termux.api/) (install from F-Droid)
- [Termux:Boot](https://f-droid.org/packages/com.termux.boot/) (install from F-Droid)
- Google Drive account with images already in a folder
- rclone configured with your Google Drive (see setup below)

---

## Setup

### 1. Install packages in Termux

```bash
pkg update -y && pkg upgrade -y && pkg install -y termux-api
pkg install -y curl && curl https://rclone.org/install.sh | bash
pkg install -y cronie
termux-setup-storage
