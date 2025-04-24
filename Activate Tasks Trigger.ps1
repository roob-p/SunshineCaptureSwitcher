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

function Enable-Trigger-In-XmlString {
    param (
        [string]$XmlString,
        [string]$TriggerToEnable 
    )

    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true 
    $xml.LoadXml($XmlString)

    $triggers = $xml.Task.Triggers.SessionStateChangeTrigger

    foreach ($trigger in $triggers) {
        if ($trigger.StateChange -eq $TriggerToEnable) {
            $trigger.Enabled = "true"
          
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
$xmlDDX = Enable-Trigger-In-XmlString -XmlString $templateDDX -TriggerToEnable "SessionLock"
$modifiedXmlPathDDX = "$env:TEMP\sunshine_task_ddx.xml"
$xmlDDX.Save($modifiedXmlPathDDX) 
schtasks /Create /TN "$TaskName" /XML "$modifiedXmlPathDDX" /F


$templateWGC = Replace-Placeholders -TemplatePath $TemplatePath2 -ExePath $ExePath2
$xmlWGC = Enable-Trigger-In-XmlString -XmlString $templateWGC -TriggerToEnable "SessionUnlock"
$modifiedXmlPathWGC = "$env:TEMP\sunshine_task_wgc.xml"
$xmlWGC.Save($modifiedXmlPathWGC)  
schtasks /Create /TN "$TaskName2" /XML "$modifiedXmlPathWGC" /F

Write-Host "Tasks trigger successfully restored!"
start-sleep -s 2
exit

