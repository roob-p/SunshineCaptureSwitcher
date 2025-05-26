#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Fileversion=1.0.4.0
#AutoIt3Wrapper_Res_ProductName=Sunshine Capture Switcher
#AutoIt3Wrapper_Res_ProductVersion=1.0.4
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;TraySetIcon(@ScriptDir & "\ddx.ico")

$iniFile = @ScriptDir & "\config.ini"
$ddxicon = IniRead($iniFile, "Icons", "DdxIcon", "")
$ddxpersistenticon = IniRead($iniFile, "Global", "DdxPersistentIcon(andScript)", "")

TraySetIcon($ddxicon)


if $ddxpersistentIcon = 1 Then


while 1

	wend
endif