# Downloading Instagram Images to Google Drive (Android Only)

This guide downloads images from a public Instagram page directly into Google Drive using Google Colab — no PC needed, runs entirely in your phone browser.

---

## What You Need

- A Google account
- Firefox for Android (Chrome won't work for this)
- A secondary/spare Instagram account (not your main one)

---

## Step 1 — Open Google Colab

Go to **colab.research.google.com** in your browser. Sign in. Tap **New Notebook**.

---

## Step 2 — Mount Google Drive

Create a cell, paste this, tap Run:

```python
from google.colab import drive
drive.mount('/content/drive')
```

Approve the Google authorization popup.

---

## Step 3 — Install gallery-dl

New cell, paste, run:

```python
!pip install gallery-dl
```

---

## Step 4 — Get Instagram Cookies

Instagram requires you to be logged in. You need to extract your browser session cookies.

1. Install **Firefox for Android**
2. In Firefox, open Add-ons and install **Cookie Quick Manager**
3. Log into Instagram in Firefox using a secondary account
4. Open Cookie Quick Manager, search `instagram.com`
5. Find and note the values for: `csrftoken`, `datr`, `ig_did`, `mid`, `ds_user_id`, `sessionid`

---

## Step 5 — Save Cookies in Colab

New cell. Replace each value with your actual cookie values:

```python
lines = [
    "# Netscape HTTP Cookie File",
    "\t".join([".instagram.com", "TRUE", "/", "TRUE", "1811861089", "csrftoken", "YOUR_CSRFTOKEN"]),
    "\t".join([".instagram.com", "TRUE", "/", "TRUE", "1811858948", "datr", "YOUR_DATR"]),
    "\t".join([".instagram.com", "TRUE", "/", "TRUE", "1808834948", "ig_did", "YOUR_IG_DID"]),
    "\t".join([".instagram.com", "TRUE", "/", "TRUE", "1811858957", "mid", "YOUR_MID"]),
    "\t".join([".instagram.com", "TRUE", "/", "TRUE", "1785077089", "ds_user_id", "YOUR_DS_USER_ID"]),
    "\t".join([".instagram.com", "TRUE", "/", "TRUE", "1808834980", "sessionid", "YOUR_SESSIONID"]),
]

with open("/content/instagram_cookies.txt", "w") as f:
    f.write("\n".join(lines))

print("Cookie file saved!")
```

---

## Step 6 — Download Images

New cell. Replace `USERNAME` with the Instagram handle you want to download from:

```python
!gallery-dl \
  --cookies "/content/instagram_cookies.txt" \
  --sleep 3 --sleep-request 1 \
  --filter "extension in ('jpg', 'jpeg', 'png', 'webp')" \
  --download-archive "/content/drive/MyDrive/Wallpapers/archive.txt" \
  -d "/content/drive/MyDrive/Wallpapers/" \
  https://www.instagram.com/USERNAME/
```

Images download directly into a `Wallpapers` folder in your Google Drive. Videos and reels are automatically skipped.

---

## Important Notes

- Keep the Colab tab open while downloading — it stops if the tab closes
- If it disconnects mid-download, just re-run the same command — it resumes automatically thanks to `--download-archive`
- `429 Too Many Requests` errors are normal — gallery-dl waits and retries automatically
- gallery-dl creates subfolders: your images will be at `Wallpapers/instagram/USERNAME/`
- Use a secondary Instagram account — bulk downloading can flag accounts

---

## After Downloading

Once images are in Google Drive, follow the main [README](README.md) to set up automatic wallpaper rotation on your phone using Termux.
