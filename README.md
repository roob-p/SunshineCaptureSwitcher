# 🔄 Sunshine Capture Switcher 
✨ This utility automatically switches between the WGC and DDX capture methods in Sunshine.
When using WGC, it's not possible to stream while on the lock screen, so this program will switch to DDX when the computer is locked, and switch back to WGC when the computer is unlocked.
**Works with both Sunshine and Apollo. Now includes an automatic UAC-handling system when in WGC mode.**

## 🚀 How it works:
- Two tasks are created in the Windows Task Scheduler:
  - Sunshine WGC, triggered when the computer is unlocked.
  - Sunshine DDX, triggered when the computer is locked (as well as during sleep, hibernation, etc.).

- Starting from version 1.0.3, support for Apollo and a UAC-handling system have been added. The launch scripts can now stay active, and a system tray icon is shown to indicate which capture method is running.
- From version 1.0.2 onwards, Sunshine Capture Switcher no longer modifies the Sunshine.conf file to set the capture method, but directly launches Sunshine with the `capture=wgc` flag when WGC is to be used.
- If you don't want the tasks to automatically run on locking and unlocking the computer and prefer to launch Sunshine manually, run `Deactivate Tasks Trigger` (also available as `Activate Tasks Trigger` to restore the original functionality). You can also launch Sunshine using the Sunshine DDX and Sunshine WGC shortcuts from the Start menu and desktop.
- When switching capture methods, you’ll need to reconnect from the client.
- You can edit the Sunshine and Apollo installation paths in `config.ini.`  

## ⚙️ UAC Handling system (WGC-specific):
- When using WGC, UAC prompts are not visible in the stream. To work around this limitation, the script can automatically switch to DDX when a UAC prompt appears and return to WGC once the UAC window is closed (however, reconnecting from the client is required).
- In `config.ini`, `Reswitch` defines how the script behaves when UAC prompts:
   - `0`: Do nothing. Sunshine remains in WGC mode, and the WGC icon stays visible in the system tray.
   - `1`: Switch to DDX and remain there *(you’ll need to reconnect after switching).*
   - `2`: Temporarily switch to DDX, and return to WGC once the UAC window is closed *(requires reconnecting twice from the client).* ‎‎‎‎After returning to WGC, the script remains active in the system tray and continues to monitor for future UAC prompts. 
   - `-1`: Launch Sunshine in WGC mode and then close the WGC script. *(no WGC icon in the system tray).*

## 🛰️ Support for Apollo:
- Just set `ProgToUse = Apollo` in `config.ini` and the program is ready to use!

  
## ⚠️ Notes:
- If Sunshine is set to WGC, it cannot be launched via service (this causes errors on the localhost homepage). It must be launched directly as an .exe (which the program handles automatically).
- In WGC mode, UAC prompts won't show up, so the program now includes the workaround described above.
- You can tell if WGC mode is active by checking the tray icon or by pressing Win + G to open the Windows Game Bar: it will only show on the client side when the stream is using WGC.
- If you don't want the DDX tray icon (and its script) to stay active after launching Sunshine in DDX mode, set `DdxPersistentIcon(andScript)` to 0 in `config.ini`.
- You can specify the tray icons to use under the `[Icons]` section in `config.ini`.  
  If the icon files are located in the installation folder, **do not** use a relative path like `.\wgc.ico`, just write `wgc.ico`.  
  *Two different icon types (for WGC and DDX) are already included in the installation folder.*
<br>

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/E1E214R1KB)
