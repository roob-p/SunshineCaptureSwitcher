# setup-task.ps1
#param (
#  [string]$TaskName = "Sunshine DDX",
#	[string]$TaskName2 = "Sunshine WGC",
#	[string]$TaskName3 = ""
#   [string]$TemplatePath = ".\Sunshine DDX.xml",
#	[string]$TemplatePath2 = ".\Sunshine WGC.xml"
#	[string]$TemplatePath3 = ".\Sunshine WGC Boot (Autologon and no-pw).xml"
#)


$TaskName = "Sunshine DDX"
$TaskName2 = "Sunshine WGC"
$TaskName3 = "Sunshine WGC Boot (Autologon and no-pw)"
$TemplatePath = ".\Sunshine DDX.xml"
$TemplatePath2 = ".\Sunshine WGC.xml"
$TemplatePath3 = ".\Sunshine WGC Boot (Autologon and no-pw).xml"



if (-not $PSScriptRoot) {
    #$PSScriptRoot = "C:\SunshineCaptureSwitcher\" 
$PSScriptRoot= [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
$PSScriptRoot= [System.IO.Path]::GetDirectoryName($PSScriptRoot)
}



#$currentUser = $env:USERNAME
$currentUser = "$env:USERDOMAIN\$env:USERNAME"
$sid = (New-Object System.Security.Principal.NTAccount($currentUser)).Translate([System.Security.Principal.SecurityIdentifier]).Value


$exePath = Join-Path $PSScriptRoot "Sunshine DDX.exe"
$exePath2 = Join-Path $PSScriptRoot "Sunshine WGC.exe"
$exePath3 = Join-Path $PSScriptRoot "Wait for Desktop (autologon and no-pw).exe"

# Read and replace placeholders
$template = Get-Content $TemplatePath -Raw
$template = $template -replace "{{USERNAME}}", $currentUser
$template = $template -replace "{{USERID}}", $sid
$template = $template -replace "{{EXEPATH}}", $exePath.Replace("\", "\\")




$modifiedXmlPath = "$env:TEMP\sunshine_task.xml"
$template | Set-Content -Path $modifiedXmlPath -Encoding Unicode


schtasks /Create /TN "$TaskName" /XML "$modifiedXmlPath" /F


#2
$template2 = Get-Content $TemplatePath2 -Raw
$template2 = $template2 -replace "{{USERNAME}}", $currentUser
$template2 = $template2 -replace "{{USERID}}", $sid
$template2 = $template2 -replace "{{EXEPATH}}", $exePath2.Replace("\", "\\")


$modifiedXmlPath2 = "$env:TEMP\sunshine_task2.xml"
$template2 | Set-Content -Path $modifiedXmlPath2 -Encoding Unicode

schtasks /Create /TN "$TaskName2" /XML "$modifiedXmlPath2" /F




#3
$template3 = Get-Content $TemplatePath3 -Raw
$template3 = $template3 -replace "{{USERNAME}}", $currentUser
$template3 = $template3 -replace "{{USERID}}", $sid
$template3 = $template3 -replace "{{EXEPATH}}", $exePath3.Replace("\", "\\")




$modifiedXmlPath3 = "$env:TEMP\sunshine_task3.xml"
$template3 | Set-Content -Path $modifiedXmlPath3 -Encoding Unicode

schtasks /Create /TN "$TaskName3" /XML "$modifiedXmlPath3" /F



sleep -s 2
exit
