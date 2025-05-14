#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <DateTimeConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Global $FormMain = GUICreate("Auto shutdown", 481, 392, -1, -1)
GUISetFont(12, 400, 0, "Segoe UI")
Global $labelSelect = GUICtrlCreateLabel("Select action", 24, 24, 91, 25)
Global $cbxOption = GUICtrlCreateCombo("", 24, 56, 201, 29, BitOR($GUI_SS_DEFAULT_COMBO,$CBS_SIMPLE))
GUICtrlSetData(-1, "Shutdown|Restart", "Shutdown")
Global $chkForce = GUICtrlCreateCheckbox("Force running applications to close", 24, 88, 289, 25)
Global $chkSetTime = GUICtrlCreateCheckbox("Set the timeout period before shutdown", 24, 112, 313, 33)
GUICtrlSetState(-1, $GUI_CHECKED)
Global $labelTime = GUICtrlCreateLabel("Timeout", 24, 152, 61, 25)
Global $txtTime = GUICtrlCreateInput("30", 88, 152, 105, 29, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
Global $labelSeconds = GUICtrlCreateLabel("Seconds", 200, 152, 62, 25)
Global $timePicker = GUICtrlCreateDate("", 280, 152, 186, 29, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))
Global $labelCmt = GUICtrlCreateLabel("Comment", 24, 192, 73, 25)
Global $txtCmt = GUICtrlCreateEdit("", 24, 224, 441, 89)
GUICtrlSetData(-1, "")
Global $btnStart = GUICtrlCreateButton("Start", 24, 336, 179, 33)
GUICtrlSetBkColor(-1, 0xC8C8C8)
Global $btnCancel = GUICtrlCreateButton("Cancel", 288, 336, 179, 33)
GUICtrlSetBkColor(-1, 0xC8C8C8)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $chkSetTime
			; chỉ khi được tick thì mới cho phép nhập time
			If GUICtrlRead($chkSetTime) == $GUI_CHECKED Then
				ConsoleWrite("check")
				toggleTime(True)
			Else
				ConsoleWrite("check2" & GUICtrlRead($chkSetTime))
				toggleTime(False)
			EndIf
		Case $timePicker
			Local $time = GUICtrlRead($timePicker)
			ConsoleWrite($time & @SEC & @CRLF)
			If StringRegExp($time, "(\d{1,2}):(\d{2}):(\d{2})\s?(AM|PM)", 0) Then
			$d = StringRegExp($time, "(\d{1,2}):(\d{2}):(\d{2})\s?(AM|PM)", 1)
			$h = ($d[3] = "PM" And $d[0] < 12) ? $d[0]+12 : ($d[3] = "AM" And $d[0]=12) ? 0 : $d[0]
			$inputSec = $h * 3600 + $d[1] * 60 + $d[2]

			$nowSec = @HOUR * 3600 + @MIN * 60 + @SEC
			Local $timeout = $inputSec - $nowSec
			GUICtrlSetData($txtTime, $timeout)

;~         ConsoleWrite("Chênh lệch (giây): " & ($inputSec - $nowSec) & @CRLF)
		EndIf
		Case $btnStart
			Run(generateCommand(), '', @SW_HIDE)
;~ 			MsgBox(64 + 262144, 'Thông báo', generateCommand())
		Case $btnCancel
			Run('shutdown -a','', @SW_HIDE)
			MsgBox(64 + 262144, 'Thông báo', 'Đã hủy')
	EndSwitch
WEnd

Func generateCommand()
	Local $cmd = 'shutdown '
	Local $action = GUICtrlRead($cbxOption)
	$cmd &= ($action == 'Shutdown' ? '-s' : '-r')

	; có đóng toàn bộ windown ko
	Local $checkForce = GUICtrlRead($chkForce)
	If $checkForce == $GUI_CHECKED Then
		$cmd &= ' -f'
	EndIf

	; có set time hay ko
	Local $checkSetTime = GUICtrlRead($chkSetTime)
	If $checkSetTime == $GUI_CHECKED Then
		Local $timeout = GUICtrlRead($txtTime)

		If Not $timeout Then
			$timeout = 30
			GUICtrlSetData($txtTime, 30)
		ElseIf $timeout < 0 Then
			$timeout = 30
			GUICtrlSetData($txtTime, 30)
		EndIf
		$cmd &= ' -t ' & $timeout
	EndIf

	; có nhập cmt hay ko
	Local $cmt = GUICtrlRead($txtCmt)
	If $cmt Then
		$cmd &= ' -c "' & $cmt & '"'
	Else
		Local $txtAction = $action == 'Shutdown' ? 'tắt máy' : 'khởi động lại'
		$cmd &= ' -c "Máy tính sẽ ' & $txtAction &' sau ' & convertTime(GUICtrlRead($txtTime)) & ' nữa !"'
	EndIf

	return $cmd
EndFunc

Func toggleTime($enabled)
	Local $value = $enabled ? $GUI_ENABLE : $GUI_DISABLE
	GUICtrlSetState($labelTime, $value)
	GUICtrlSetState($txtTime, $value)
	GUICtrlSetState($labelSeconds, $value)
	GUICtrlSetState($timePicker, $value)

	If $value Then
		GUICtrlSetState($txtTime, $GUI_FOCUS)
	EndIf

EndFunc

Func convertTime($time)
	Local $h = Int($time / 3600)
	Local $m = Int(Mod($time, 3600) / 60)
	Local $s = Mod($time, 60)

	; Định dạng chuỗi giờ:phút:giây với 2 chữ số
	Local $timeFormatted = StringFormat("%02d:%02d:%02d", $h, $m, $s)
	Return $timeFormatted
EndFunc
