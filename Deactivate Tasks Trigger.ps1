if (-not $PSScriptRoot) {
    $PSScriptRoot = "C:\SunshineCatpureSwitcher\" 
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

function Disable-Trigger-In-XmlString {
    param (
        [string]$XmlString,
        [string]$TriggerToDisable  # es. "SessionLock" o "SessionUnlock"
    )

    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true  
    $xml.LoadXml($XmlString)

    $triggers = $xml.Task.Triggers.SessionStateChangeTrigger

    foreach ($trigger in $triggers) {
        if ($trigger.StateChange -eq $TriggerToDisable) {
            $trigger.Enabled = "false"
        }
    }

    return $xml
}


$TaskName = "Sunshine DDX"
$TaskName2 = "Sunshine WGC"
$TemplatePath = ".\Sunshine DDX.xml"
$TemplatePath2 = ".\Sunshine WGC.xml"
$ExePath = Join-Path $PSScriptRoot "Sunshine Switch ddx.exe"
$ExePath2 = Join-Path $PSScriptRoot "Sunshine Switch wgc.exe"


$templateDDX = Replace-Placeholders -TemplatePath $TemplatePath -ExePath $ExePath
$xmlDDX = Disable-Trigger-In-XmlString -XmlString $templateDDX -TriggerToDisable "SessionLock"
$modifiedXmlPathDDX = "$env:TEMP\sunshine_task_ddx.xml"
$xmlDDX.Save($modifiedXmlPathDDX)  
schtasks /Create /TN "$TaskName" /XML "$modifiedXmlPathDDX" /F


$templateWGC = Replace-Placeholders -TemplatePath $TemplatePath2 -ExePath $ExePath2
$xmlWGC = Disable-Trigger-In-XmlString -XmlString $templateWGC -TriggerToDisable "SessionUnlock"
$modifiedXmlPathWGC = "$env:TEMP\sunshine_task_wgc.xml"
$xmlWGC.Save($modifiedXmlPathWGC)  
schtasks /Create /TN "$TaskName2" /XML "$modifiedXmlPathWGC" /F

Write-Host "Tasks trigger deactivated!"

start-sleep -s 2
exit
