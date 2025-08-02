#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Description=Wait for Desktop (Autologon and no-pw)
#AutoIt3Wrapper_Res_Fileversion=1.0.5.0
#AutoIt3Wrapper_Res_ProductName=Sunshine Capture Switcher
#AutoIt3Wrapper_Res_ProductVersion=1.0.5
#AutoIt3Wrapper_Res_CompanyName=roob-p (author)
#AutoIt3Wrapper_Res_LegalCopyright=roob-p (author)
#AutoIt3Wrapper_Res_LegalTradeMarks=roob-p (author)
#AutoIt3Wrapper_Res_Language=1040
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>



While Not WinActive("[CLASS:Progman]")
Sleep(1000)
if ProcessExists("Sunshine WGC.exe") Then
	exit
endif
wend

If not ProcessExists("Sunshine WGC.exe") Then
	ShellExecute(@ScriptDir & "\Sunshine WGC.exe")
endif







