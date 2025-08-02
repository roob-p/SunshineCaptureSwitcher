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

function Disable-Trigger-In-XmlString {
    param (
        [string]$XmlString,
        [string]$TriggerToDisable  # es. "SessionLock" o "SessionUnlock"
    )

    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true  
    $xml.LoadXml($XmlString)

    $triggers = $xml.Task.Triggers.LogonTrigger

    foreach ($trigger in $triggers) {
            $trigger.Enabled = "false"
    }

    return $xml
}


$TaskName = "Sunshine WGC Boot (Autologon and no-pw)"
$TemplatePath = ".\Sunshine WGC Boot (Autologon and no-pw).xml"
$ExePath = Join-Path $PSScriptRoot "Wait for Desktop (autologon and no-pw).exe"


$templateBoot = Replace-Placeholders -TemplatePath $TemplatePath -ExePath $ExePath
$xmlBoot = Disable-Trigger-In-XmlString -XmlString $templateBoot -TriggerToDisable "Logon"
$modifiedXmlPathBoot = "$env:TEMP\sunshine_task_boot.xml"
$xmlBoot.Save($modifiedXmlPathBoot)  
schtasks /Create /TN "$TaskName" /XML "$modifiedXmlPathBoot" /F


Write-Host "Task trigger deactivated!"

start-sleep -s 2
exit
