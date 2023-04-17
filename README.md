# ----WARNING----
- DONT USE BAT FILE
(Read Issues)

# Voicemeeter-Potato-Activator (Kinda)
Resets the cooldown timer in the registry every time you try to open voicemeeter

- To use: Download .bat file from repo and run as admin

Thats it!
Re-run if the timer returns (maybe after an update) and report on github

# What the script does: 

Every 32 days the regkey value in path "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" will increment by 32 so this script will do that

# How to calibrate and install

- Go To Regedit
- Go to Path "Computer\HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" in regedit
- Right Click On "Code" on the right side and select "Modify"
- Increment the HEX or Decimal Values until you get the smallest value that doesnt show the popup on voicemeeter launch (it is recommended to use task manager to force close voicemeeter while the popup shows in your testing)
- Once the popup is no longer showing, place the "Script V2.py" file of the repo in the "C:\Users\[YourUser]\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" and make sure python is installed (all modules used are pre installed with a standard python install)
- make a file called "data.txt" in the same directory
- Run the py file
- DONE
---
- If popup shows still please create an issue in github

# Credit: 

Download Voicemeeter: https://voicemeeter.com/

Legitimate activation:

USD - https://shop.vb-audio.com/en/win-apps/21-voicemeeter8.html?SubmitCurrency=1&id_currency=2

EU - https://shop.vb-audio.com/en/win-apps/21-voicemeeter8.html?SubmitCurrency=1&id_currency=1
