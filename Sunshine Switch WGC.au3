#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=sunshine.ico
#AutoIt3Wrapper_Res_Fileversion=1.0.4.0
#AutoIt3Wrapper_Res_ProductName=Sunshine Capture Switcher
#AutoIt3Wrapper_Res_ProductVersion=1.0.4
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <TrayConstants.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>

if _Singleton("Sunshine Switch WGC")= 0 Then
	exit
	endif

AutoItSetOption("TrayIconDebug", 1)


if ProcessExists("Sunshine Switch DDX.exe") Then
	processclose("Sunshine Switch DDX.exe")
endif

if ProcessExists("ddx-reswitch1-icon.exe") Then
	processclose("ddx-reswitch1-icon.exe")
endif

$iniFile = @ScriptDir & "\config.ini"
$progtouse = IniRead($iniFile, "Global", "ProgToUse", "")
$ddxicon = IniRead($iniFile, "Icons", "DdxIcon", "")
$wgcicon = IniRead($iniFile, "Icons", "WgcIcon", "")
;$ddxpersistenticon = IniRead($iniFile, "Global", "DdxPersistentIcon(andScript)", "")

if $progtouse = "Sunshine" then
$path = IniRead($iniFile, "Path", "SunshinePath", "")
$service = IniRead($iniFile, "Service", "SunshineService", "")

Elseif $progtouse = "Apollo" Then
$path = IniRead($iniFile, "Path", "ApolloPath", "")
$service = IniRead($iniFile, "Service", "ApolloService", "")
endif

$reswitch = IniRead($iniFile, "Global", "Reswitch", "")




;TraySetIcon(@ScriptDir & "\wgc.ico")
TraySetIcon($wgcicon)


;Run(@ComSpec & ' /c net stop "' & "Sunshine Service" & '"', "", @SW_HIDE)
Run(@ComSpec & ' /c net stop "' & $service & '"', "", @SW_HIDE)
sleep(500)
ProcessClose("sunshine.exe")

;ShellExecute("C:\Program Files\Sunshine\Sunshine.exe")
;ShellExecute("C:\Program Files\Sunshine\Sunshine.exe","","C:\Program Files\Sunshine\","",@SW_HIDE)
ShellExecute($path &"\Sunshine.exe","capture=wgc",$path,"",@SW_HIDE)



if $reswitch>0 then

while 1

If ProcessExists("consent.exe") Then
	;SplashImageOn("switch","C:\SkipUacTaskCreator\graphics\OK.bmp",150,100,-1,-1)
	ConsoleWrite("UAC Detected – Switching to DDX" & @CRLF)


		Run(@ComSpec & ' /c net stop "' & $service & '"', "", @SW_HIDE)
		ProcessClose("sunshine.exe")
		sleep(500)
		Run(@ComSpec & ' /c net start "' & $service & '"', "", @SW_HIDE)
		;TraySetIcon(@ScriptDir & "\ddx.ico")
		TraySetIcon($ddxicon)

		While ProcessExists("consent.exe")
		Sleep(1000)
		WEnd
		;TraySetIcon(@ScriptDir & "\ddx.ico")
        ConsoleWrite("UAC Closed" & @CRLF)

		if $reswitch==2 then
		Run(@ComSpec & ' /c net stop "' & $service & '"', "", @SW_HIDE)
		sleep(500)
		ProcessClose("sunshine.exe")

		ShellExecute($path &"\Sunshine.exe","capture=wgc",$path,"",@SW_HIDE)
		;TraySetIcon(@ScriptDir & "\wgc.ico")
		TraySetIcon($wgcicon)

		else
		ShellExecute(@ScriptDir & "\ddx-reswitch1-icon.exe")
		exit
		endif




    EndIf
    Sleep(1000)
	;SplashOff()



wend

elseif $reswitch=0 Then
	;TraySetIcon(@ScriptDir & "\wgc.ico")
while 1
	sleep(2000)
	WEnd
;elseif $reswitch=-1 Then
;exit
	endif






