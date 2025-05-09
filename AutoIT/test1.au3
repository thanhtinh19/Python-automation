#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Global $FormLogin = GUICreate("FormLogin", 443, 178, -1, -1)
GUISetFont(10, 400, 0, "MS Sans Serif")
Global $labelUsername = GUICtrlCreateLabel("Username", 72, 32, 67, 20)
Global $labelPassword = GUICtrlCreateLabel("Password", 72, 80, 64, 20)
Global $txtUsername = GUICtrlCreateInput("", 152, 24, 201, 24)
Global $txtPassword = GUICtrlCreateInput("", 152, 72, 201, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
Global $btnReset = GUICtrlCreateButton("Reset", 72, 120, 123, 25)
GUICtrlSetCursor (-1, 0)
Global $btnLogin = GUICtrlCreateButton("Login", 224, 120, 123, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetCursor (-1, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;HotKeySet('{ENTER}', 'Login') sang màn hình khác thì ấn enter vẫn sẽ ăn hotkeyset
;khuyến khích dùng $BS_DEFPUSHBUTTON

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $labelUsername
		Case $labelPassword
		Case $txtUsername
		Case $txtPassword
		Case $btnReset
			GUICtrlSetData($txtUsername, '')
			GUICtrlSetData($txtPassword, '')
		Case $btnLogin
			Login()


	EndSwitch
WEnd

Func Login()
	Local $userName = GUICtrlRead($txtUsername)
	Local $passWord = GUICtrlRead($txtPassword)
	If($userName = '' Or $passWord = '') Then
		MsgBox(16 + 262144, 'Thông báo', 'Username hoặc password không được để trống!')
	Else
		;MsgBox(64 + 262144, 'Thông báo', 'Đăng nhập thành công!')
		;Run('notepad')
		ShellExecute('notepad')
		;Sleep(1000)
		;Send('Hello' & @CRLF)
	EndIf
EndFunc

