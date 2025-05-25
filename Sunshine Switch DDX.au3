#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=sunshine.ico
#AutoIt3Wrapper_Res_Fileversion=1.0.3.0
#AutoIt3Wrapper_Res_ProductName=Sunshine Capture Switcher
#AutoIt3Wrapper_Res_ProductVersion=1.0.3
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <TrayConstants.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>


AutoItSetOption("TrayIconDebug", 1) ; Mostra la variabile @error nel tooltip dell’icona nella tray



if ProcessExists("Sunshine Switch WGC.exe") Then
	processclose("Sunshine Switch WGC.exe")
	endif


$iniFile = @ScriptDir & "\config.ini"
$progtouse = IniRead($iniFile, "Global", "ProgToUse", "")
$ddxpersistenticon = IniRead($iniFile, "Global", "DdxPersistentIcon(andScript)", "")

if $progtouse = "Sunshine" then
$path = IniRead($iniFile, "Path", "SunshinePath", "")
$service = IniRead($iniFile, "Service", "SunshineService", "")

Elseif $progtouse = "Apollo" Then
$path = IniRead($iniFile, "Path", "ApolloPath", "")
$service = IniRead($iniFile, "Service", "ApolloService", "")
endif








Run(@ComSpec & ' /c net stop "' & $service & '"', "", @SW_HIDE)
ProcessClose("sunshine.exe")
sleep(500)
;Run(@ComSpec & ' /c net start "' & "Sunshine Service" & '"', "", @SW_HIDE)
Run(@ComSpec & ' /c net start "' & $service & '"', "", @SW_HIDE)

TraySetIcon(@ScriptDir & "\ddx.ico")


if $DdxPersistentIcon=1 Then


while 1
sleep(2000)
	wend
endif