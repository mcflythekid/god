#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;#NoTrayIcon
#include '_Startup.au3'
#include <WinAPISys.au3>
#include <Misc.au3>

Const $SLEEP = 444
Const $KEY_VALUE = 'vSMv7x6i0Et23HL1YQmD'
Const $KEY_FILE = 'god.txt'

Const $PORN[] = [ _
"phim sex", "phimsex", _
"vlxx", "porn", _
"clip sex", "clipsex", _
"sex trung quoc", _
"hình sex", "hinh sex", "hinhsex", _
"truyện sex", "truyen sex", "truyensex", _
"truyện dâm", "truyen dam", "truyendam", _
"phim heo", "phimheo", _
"phim con heo", "phimconheo", _
"18+", "wapbold", _
"kích dục", "kich duc", "kichduc", _
"truyen nguoi lon", "truyện người lớn", _
"tình dục", "tinh duc", "tinh duc", _
"bú cu", "bu cu", "bucu", _
"phim heo", "phim con heo", "phimheo", "phimconheo", _
"cõi thiên thai", "coi thien thai", "coithienthai", _
" sex ", _
"thiendia" ]

Const $DISTRACTION[] = [ _
"facebook", "youtube", _
"facebook" ]

Opt("WinTitleMatchMode", -2)
_Main()

Func _Main()
    _StartupRegistry_Install()
	_Singleton(@ScriptName)

	While True
		Local $isKeyNotFound = Not _CheckDrives()
		Local $isNotOnWorkingHour = Not _IsOnWorkingHour()

		If $isNotOnWorkingHour Then _SelfProtect()

		If $isKeyNotFound And $isNotOnWorkingHour Then _Lock()
		If $isKeyNotFound Then _KillDistraction()

		_KillPorn() ; Always kill porn

		Sleep($SLEEP)
	WEnd
EndFunc   ;==>_Main

Func _SelfProtect()
	ProcessClose("Taskmgr.exe")
	WinKill("git\god")
EndFunc

Func _KillDistraction()
	; Hosts
	WinKill("C:\Windows\system32\Drivers\etc\hosts")
	WinKill("C:\Windows\System32\drivers")
	; LOL
	ProcessClose("leagueclient.exe")
	ProcessClose("leagueclientux.exe")
	ProcessClose("leagueclientuxrender.exe")
	ProcessClose("garena.exe")
	; Distraction
	ProcessClose("discord.exe")
	ProcessClose("zalo.exe")
	ProcessClose("zalocall.exe")
	ProcessClose("zalocap.exe")
	ProcessClose("zavimeet.exe")
	; Distraction template
	For $i = 0 To UBound($DISTRACTION) - 1
		If WinExists($DISTRACTION[$i]) Then
			WinKill($DISTRACTION[$i])
		EndIf
	Next
EndFunc   ;==> _KillDistraction

Func _KillPorn()
	; Tor (Porn)
	ProcessClose("firefox.exe")

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
