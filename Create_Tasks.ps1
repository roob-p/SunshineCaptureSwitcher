# setup-task.ps1
#param (
 #   [string]$TaskName = "Sunshine DDX",
#	[string]$TaskName2 = "Sunshine WGC",
#    [string]$TemplatePath = ".\Sunshine DDX.xml",
#	[string]$TemplatePath2 = ".\Sunshine WGC.xml"
#)


$TaskName = "Sunshine DDX"
$TaskName2 = "Sunshine WGC"
$TemplatePath = ".\Sunshine DDX.xml"
$TemplatePath2 = ".\Sunshine WGC.xml"


if (-not $PSScriptRoot) {
    #$PSScriptRoot = "C:\SunshineCaptureSwitcher\" 
$PSScriptRoot= [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
$PSScriptRoot= [System.IO.Path]::GetDirectoryName($PSScriptRoot)
}



#$currentUser = $env:USERNAME
$currentUser = "$env:USERDOMAIN\$env:USERNAME"
$sid = (New-Object System.Security.Principal.NTAccount($currentUser)).Translate([System.Security.Principal.SecurityIdentifier]).Value


$exePath = Join-Path $PSScriptRoot "Sunshine Switch ddx.exe"
$exePath2 = Join-Path $PSScriptRoot "Sunshine Switch wgc.exe"

# Read and replace placeholders
$template = Get-Content $TemplatePath -Raw
$template = $template -replace "{{USERNAME}}", $currentUser
$template = $template -replace "{{USERID}}", $sid
$template = $template -replace "{{EXEPATH}}", $exePath.Replace("\", "\\")




$modifiedXmlPath = "$env:TEMP\sunshine_task.xml"
$template | Set-Content -Path $modifiedXmlPath -Encoding Unicode

# Register the task
schtasks /Create /TN "$TaskName" /XML "$modifiedXmlPath" /F



$template2 = Get-Content $TemplatePath2 -Raw
$template2 = $template2 -replace "{{USERNAME}}", $currentUser
$template2 = $template2 -replace "{{USERID}}", $sid
$template2 = $template2 -replace "{{EXEPATH}}", $exePath2.Replace("\", "\\")


$modifiedXmlPath2 = "$env:TEMP\sunshine_task2.xml"
$template2 | Set-Content -Path $modifiedXmlPath2 -Encoding Unicode

# Register the task
schtasks /Create /TN "$TaskName2" /XML "$modifiedXmlPath2" /F

sleep -s 2
exit
