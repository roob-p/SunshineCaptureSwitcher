<!--[🔙 Back](https://roob-p.github.io)-->
<!--[![🔙 Back](https://img.shields.io/badge/🔙-Back-blue)](https://roob-p.github.io)-->
[![🔙 Back](https://img.shields.io/badge/🔙-Back-white?style=flat-square&logoColor=blue&color=blue)](https://roob-p.github.io)
# 🔄 SunshineCaptureSwitcher
✨ This utility automatically switches between the WGC and DDX capture methods in Sunshine.
When using WGC, it's not possible to stream while on the lock screen, so this program will therefore switch to DDX when the computer is locked, and switch back to WGC when the computer is unlocked.

## ⚙️ How it works:
- Two tasks are created in the Windows Task Scheduler:
  - Sunshine WGC, triggered when the computer is unlocked
  - Sunshine DDX, triggered when the computer is locked (as well as during sleep, hibernation, etc.)

- Starting from version 1.0.2, Sunshine Capture Switcher will no longer modify the Sunshine.conf file to set the capture method, but will directly launch Sunshine with the capture=wgc flag when WGC is to be used.
- If you don't want the tasks to automatically run upon locking and unlocking the computer and prefer to launch Sunshine manually, run `Deactivate Tasks Trigger` (also available as `Activate Tasks Trigger` to restore the original functionality). You can also launch Sunshine using the Sunshine DDX and Sunshine WGC shortcuts from the Start menu and desktop.
- When switching capture methods, you’ll need to reconnect from the client.
- You can edit the Sunshine installation path in config.ini.

## ⚠️ Notes:
- If Sunshine is set to WGC, it cannot be launched via service (this causes errors on the localhost homepage). It must be launched directly as an .exe (which the program handles automatically).
- In WGC mode, UAC prompts will not appear.
- To verify that WGC mode is active, press Win + G to open the Windows Game Bar: it will only appear on the client side if the stream is using WGC.

<br>

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/E1E214R1KB)


- Github: [roop-p/SunshineCaptureSwitcher](https://github.com/roob-p/SunshineCaptureSwitcher/)
- Download last version:
  [v1.0.2](https://github.com/roob-p/SunshineCaptureSwitcher/releases/download/v1.0.2/SunshineCaptureSwicher_INSTALLER.exe)
  <br>
