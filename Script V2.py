import datetime
import os
import winreg
t = datetime.datetime.now().date()
def regkey_value(path, name="", start_key=None):
   if isinstance(path, str):
      path = path.split("\\")
   if start_key is None:
      start_key = getattr(winreg, path[0])
      return regkey_value(path[1:], name, start_key)
   else:
      subkey = path.pop(0)
   with winreg.OpenKey(start_key, subkey) as handle:
      assert handle
      if path:
         return regkey_value(path, name, handle)
      else:
         desc, i = None, 0
         while not desc or desc[0] != name:
            desc = winreg.EnumValue(handle, i)
            i += 1
         return desc[1]
with open('data.txt', 'r') as f:
   try:
      f=f.read()
   except:
      pass
   if f == "":
      with open("data.txt", 'w', encoding='utf-8') as o:
         o.write(str(t))
   else:
      diff = (t-datetime.datetime.strptime(f, str("%Y-%m-%d")).date()).days
      key = regkey_value(r"HKEY_CURRENT_USER\VB-Audio\VoiceMeeter", "code") + diff
      os.system(f'reg add "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" /v code /t REG_DWORD /d {key} /f')
      with open("data.txt", 'w', encoding='utf-8') as o:
         o.write(str(t))
os.system (r'start "" "C:\Program Files (x86)\VB\Voicemeeter\voicemeeter8x64.exe"')