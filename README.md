# ----WARNING----
- ONLY WORKS ON OLDER VM VERSIONS (tested on v3.0.1.8)
    download v3.0.1.8 (origin: webarchive.org): https://www.mediafire.com/file/sswni1zifdfgquo/Voicemeeter8Setup.exe/file

(Read Issues)

# Voicemeeter-Potato-Activator (Kinda)
Resets the cooldown timer in the registry every time you try to open Voicemeeter

- To use: Download .bat or .py file from repo and run as admin

That's it!
Re-run if the timer returns (maybe after an update) and report on GitHub

# What the script does: 
Every 32 days, the registry key value in the path "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" will increment by 32.

# How to calibrate and install

- Go To Regedit
- Go to Path "Computer\HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" in regedit
- Right-click on "Code" on the right side and select "Modify"
- Increment the HEX or Decimal Values (by one at a time) until you get the smallest value that doesn't show the popup on Voicemeeter launch (it is recommended to use Task Manager to force close Voicemeeter while the popup shows in your testing)
- Once the pop-up is no longer showing, run the script once, and then every time it shows in the future, making sure it is extracted and a "data.txt" file is in the same directory as the script
- DONE
---
- If the pop-up shows still, please create an issue in GitHub

# Credit: 

Download Voicemeeter: https://voicemeeter.com/

Legitimate activation:

USD - https://shop.vb-audio.com/en/win-apps/21-voicemeeter8.html?SubmitCurrency=1&id_currency=2

EUR - https://shop.vb-audio.com/en/win-apps/21-voicemeeter8.html?SubmitCurrency=1&id_currency=1
