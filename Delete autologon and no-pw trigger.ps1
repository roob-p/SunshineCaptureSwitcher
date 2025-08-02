Unregister-ScheduledTask -TaskName "Sunshine WGC Boot (Autologon and no-pw)" -Confirm:$false

write "Task deleted"

start-sleep -s 2
exit