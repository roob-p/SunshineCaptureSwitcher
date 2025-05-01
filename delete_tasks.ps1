Unregister-ScheduledTask -TaskName "Sunshine DDX" -Confirm:$false
Unregister-ScheduledTask -TaskName "Sunshine WGC" -Confirm:$false

write "Tasks deleted"

start-sleep -s 2
exit