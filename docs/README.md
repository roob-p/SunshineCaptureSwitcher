# 🚀 SunshineCaptureSwitcher
✨ This utility automatically switches between the WGC and DDX capture methods in Sunshine.
When using WGC, it's not possible to stream while on the lock screen, so this program will therefore switch to DDX when the computer is locked, and switch back to WGC when the computer is unlocked.

## ⚙️ How it works:
- Two tasks are created in the Windows Task Scheduler:
  - Sunshine WGC, triggered when the computer is unlocked
  - Sunshine DDX, triggered when the computer is locked (as well as during sleep, hibernation, etc.)

- The values in `sunshine.conf` will be modified or created automatically each time.
- When switching capture methods, you’ll need to reconnect from the client.
- The paths to sunshine.conf and the Sunshine executable are customizable via config.ini.

## ⚠️ Notes:
- If Sunshine is set to WGC, it cannot be launched via service (this causes errors on the localhost homepage).
It must be launched directly as an .exe (which the program handles automatically). This is something to keep in mind if you plan to manually kill the .exe or relaunch Sunshine.
- In WGC mode, UAC prompts will not appear.
- To remove the scheduled tasks, simply uninstall the program or run `delete_tasks.exe`.
- To verify that WGC mode is active, press Win + G to open the Windows Game Bar: it will only appear on the client side if the stream is using WGC.
