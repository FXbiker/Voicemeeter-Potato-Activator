import datetime
import os
import winreg

t = datetime.date.today()
INTERVAL = 32

def regkey_value(path, name, start_key=None):
    if isinstance(path, str):
        path = path.split("\\")
    if start_key is None:
        start_key = getattr(winreg, path[0])
        return regkey_value(path[1:], name, start_key)

    subkey = path[0]
    remaining = path[1:]

    with winreg.OpenKey(start_key, subkey) as handle:
        if remaining:
            return regkey_value(remaining, name, handle)

        # We are now at the final key — enumerate values
        i = 0
        while True:
            try:
                value_name, value_data, value_type = winreg.EnumValue(handle, i)
                if value_name == name:
                    return value_data
                i += 1
            except OSError:
                break

    raise KeyError(f"Registry value '{name}' not found in {path[0]}")

def set_reg_value(path, name, value):
    hive, *sub = path.split("\\")
    hive = getattr(winreg, hive)
    subkey = "\\".join(sub)

    with winreg.OpenKey(hive, subkey, 0, winreg.KEY_SET_VALUE) as handle:
        winreg.SetValueEx(handle, name, 0, winreg.REG_DWORD, value)

# Read last run date
try:
    with open("data.txt", "r", encoding="utf-8") as f:
        last = f.read().strip()
except FileNotFoundError:
    last = ""

if not last:
    with open("data.txt", "w", encoding="utf-8") as f:
        f.write(str(t))
else:
    last_date = datetime.datetime.strptime(last, "%Y-%m-%d").date()
    days_passed = (t - last_date).days
    intervals = days_passed // INTERVAL

    print("Last date:", last_date)
    print("Days passed:", days_passed)
    print("Intervals:", intervals)

    if intervals >= 1:
        current = regkey_value(r"HKEY_CURRENT_USER\VB-Audio\VoiceMeeter", "code")
        increment = INTERVAL * intervals
        new_value = current + increment

        print("Updating registry by:", increment)
        print("New registry value:", new_value)

        set_reg_value(r"HKEY_CURRENT_USER\VB-Audio\VoiceMeeter", "code", new_value)

        new_last_date = last_date + datetime.timedelta(days=INTERVAL * intervals)

        print("New stored date:", new_last_date)

        with open("data.txt", "w", encoding="utf-8") as f:
            f.write(str(new_last_date))
