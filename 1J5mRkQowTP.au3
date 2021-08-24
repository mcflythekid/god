#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#include '_Startup.au3'
#include <WinAPISys.au3>
#include <Misc.au3>

Const $SLEEP = 666
Const $KEY_VALUE = 'vSMv7x6i0Et23HL1YQmD'
Const $KEY_FILE = 'god.txt'
Const $PORN[] = [ "phim sex", "vlxx", "porn" ]

Opt("WinTitleMatchMode",2)
_Main()

Func _Main()
    _StartupRegistry_Install()
	_Singleton(@ScriptName)

	While True
		Local $isKeyNotFound = Not _CheckDrives()
		Local $isNotOnWorkingHour = Not _IsOnWorkingHour()

		If $isKeyNotFound Then
			If $isNotOnWorkingHour Then _Lock()
			_KillShit()
			_KillPorn()
		EndIf

		Sleep($SLEEP)
	WEnd
EndFunc   ;==>_Main

Func _KillShit()
	; Hosts
	WinKill("C:\Windows\system32\Drivers\etc\hosts")
	WinKill("C:\Windows\System32\drivers")
	; Tor
	ProcessClose("tor.exe")
	ProcessClose("firefox.exe")
	; Task manager
	ProcessClose("Taskmgr.exe")
	; LOL
	ProcessClose("leagueclient.exe")
	ProcessClose("leagueclientux.exe")
	ProcessClose("leagueclientuxrender.exe")
	ProcessClose("garena.exe")
	#cs
	ProcessClose("discord.exe")
	ProcessClose("zalo.exe")
	ProcessClose("zalocall.exe")
	ProcessClose("zalocap.exe")
	ProcessClose("zavimeet.exe")
	#ce
EndFunc

Func _KillPorn()
	For $i = 0 To UBound($PORN) - 1
		If WinExists($PORN[$i]) Then
			WinKill($PORN[$i])
		EndIf
	Next
EndFunc   ;==> _KillPorn

Func _Lock()
	_WinAPI_LockWorkStation()
	;Beep()
EndFunc   ;==>_Lock

Func _IsOnWorkingHour()
	Return @HOUR >= 6 and @hour <= 18
EndFunc   ;=>_IsOnWorkingHour

Func _CheckDrives()
	Local $drives = DriveGetDrive($DT_REMOVABLE)
	If @error Then Return False
	For $i = 1 To $drives[0]
		If _CheckDrive($drives[$i]) Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>_CheckDrives

Func _CheckDrive($drive)
	Local $path = $drive & '\' & $KEY_FILE
	If Not FileExists($path) Then Return False
	Local $content = FileRead($path)
	Return StringCompare($content, $KEY_VALUE, $STR_CASESENSE) == 0
EndFunc   ;==>_CheckDrive
