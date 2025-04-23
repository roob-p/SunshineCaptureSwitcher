#RequireAdmin
#include <MsgBoxConstants.au3>
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=sunshine.ico
#AutoIt3Wrapper_Res_Fileversion=1.0.1
#AutoIt3Wrapper_Res_ProductName=Sunshine Capture Switcher
#AutoIt3Wrapper_Res_ProductVersion=1.0.1
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

$iniFile = @ScriptDir & "\config.ini"
$path = IniRead($iniFile, "Path", "SunshinePath", "")
$filepath = IniRead($iniFile, "Path", "SunshineFileConfig", "")



If $filepath = "" Then
    MsgBox("","","Error, Sunshine.conf not found!")
    Exit
EndIf


;$file = FileOpen("C:\Program Files\Sunshine\config\Sunshine.conf", 0)
$file = FileOpen($filepath,0)

$content = FileRead($file)
FileClose($file)

;$mod = StringReplace($content, "ddx", "wgc")
$mod = StringReplace($content, "capture = ddx", "capture = wgc")
If Not StringInStr($content, "ddx") And Not StringInStr($content, "wgc") Then

	$mod &= "capture = wgc"
EndIf


;$file = FileOpen("C:\Program Files\Sunshine\config\Sunshine.conf", 2)
$file = FileOpen($filepath,2)
FileWrite($file, $mod)
FileClose($file)


Run(@ComSpec & ' /c net stop "' & "Sunshine Service" & '"', "", @SW_HIDE)
ProcessClose("sunshine.exe")

;ShellExecute("C:\Program Files\Sunshine\Sunshine.exe")
;ShellExecute("C:\Program Files\Sunshine\Sunshine.exe","","C:\Program Files\Sunshine\","",@SW_HIDE)
ShellExecute($path &"\Sunshine.exe","",$path,"",@SW_HIDE)
