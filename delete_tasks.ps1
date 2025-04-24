Unregister-ScheduledTask -TaskName "Sunshine ddx" -Confirm:$false
Unregister-ScheduledTask -TaskName "Sunshine wgc" -Confirm:$false

write "Tasks deleted"

start-sleep -s 2
exit