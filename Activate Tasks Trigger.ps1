
if (-not $PSScriptRoot) {
    #$PSScriptRoot = "C:\SunshineCaptureSwitcher\" 
$PSScriptRoot= [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
$PSScriptRoot= [System.IO.Path]::GetDirectoryName($PSScriptRoot)
}

function Replace-Placeholders {
    param (
        [string]$TemplatePath,
        [string]$ExePath
    )

    $currentUser = "$env:USERDOMAIN\$env:USERNAME"
    $sid = (New-Object System.Security.Principal.NTAccount($currentUser)).Translate([System.Security.Principal.SecurityIdentifier]).Value

    $template = Get-Content $TemplatePath -Raw
    $template = $template -replace "{{USERNAME}}", $currentUser
    $template = $template -replace "{{USERID}}", $sid
    $template = $template -replace "{{EXEPATH}}", $ExePath.Replace("\", "\\")

    return $template
}

function Enable-Trigger-In-XmlString {
    param (
        [string]$XmlString,
        [string]$TriggerToEnable 
    )

    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true 
    $xml.LoadXml($XmlString)

    if ($TriggerToEnable -eq "Logon") {
        $logonTriggers = $xml.Task.Triggers.LogonTrigger
        foreach ($trigger in $logonTriggers) {
            $trigger.Enabled = "true"
        }
    }
    else {

    $triggers = $xml.Task.Triggers.SessionStateChangeTrigger

    foreach ($trigger in $triggers) {
        if ($trigger.StateChange -eq $TriggerToEnable) {
            $trigger.Enabled = "true"
          
        }
    }
}
    return $xml
}


$TaskName = "Sunshine DDX"
$TaskName2 = "Sunshine WGC"
$TaskName3 = "Sunshine WGC Boot (Autologon and no-pw)"
$TemplatePath = ".\Sunshine DDX.xml"
$TemplatePath2 = ".\Sunshine WGC.xml"
$TemplatePath3 = ".\Sunshine WGC Boot (Autologon and no-pw).xml"
$ExePath = Join-Path $PSScriptRoot "Sunshine DDX.exe"
$ExePath2 = Join-Path $PSScriptRoot "Sunshine WGC.exe"
$ExePath3 = Join-Path $PSScriptRoot "Wait for Desktop (autologon and no-pw).exe"


$templateDDX = Replace-Placeholders -TemplatePath $TemplatePath -ExePath $ExePath
$xmlDDX = Enable-Trigger-In-XmlString -XmlString $templateDDX -TriggerToEnable "SessionLock"
$modifiedXmlPathDDX = "$env:TEMP\sunshine_task_ddx.xml"
$xmlDDX.Save($modifiedXmlPathDDX) 
schtasks /Create /TN "$TaskName" /XML "$modifiedXmlPathDDX" /F


$templateWGC = Replace-Placeholders -TemplatePath $TemplatePath2 -ExePath $ExePath2
$xmlWGC = Enable-Trigger-In-XmlString -XmlString $templateWGC -TriggerToEnable "SessionUnlock"
$modifiedXmlPathWGC = "$env:TEMP\sunshine_task_wgc.xml"
$xmlWGC.Save($modifiedXmlPathWGC)  
schtasks /Create /TN "$TaskName2" /XML "$modifiedXmlPathWGC" /F


$templateBoot = Replace-Placeholders -TemplatePath $TemplatePath3 -ExePath $ExePath3
$xmlBoot = Enable-Trigger-In-XmlString -XmlString $templateBoot -TriggerToEnable "Logon"
$modifiedXmlPathBoot = "$env:TEMP\sunshine_task_boot.xml"
$xmlBoot.Save($modifiedXmlPathBoot)  
schtasks /Create /TN "$TaskName3" /XML "$modifiedXmlPathBoot" /F

Write-Host "Tasks trigger successfully restored!"
start-sleep -s 2
exit

