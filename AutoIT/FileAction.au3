

; Script Start - Add your code below here
;thao tác với file
#cs
FileOpen()
FileRead()
FileWrite()
FileClose()
#ce


;Ghi dữ liệu ra file: mở file-> ghi dữ liệu -> đóng file

;~ Global $filePath = FileSaveDialog('Save', @ScriptDir, "All (*.*)|Text files (*.txt)|AutoIt (*.au3)",16,'macro.txt', form)
;~ ;option 2: file phải tồn tại  16: ghi đè  form: cửa sổ cha
;~ Global $data = 'Xin chào' & @CRLF & 'Hello'
;~ Local $fileHandle = FileOpen('abc\testfile.txt', 2 + 8) ;1: thêm vào cuối 2:ghi đè  8:tạo thư mục nếu nó ko tồn tại  128: ghi dữ liệu có dấu (utf-8)
;~ FileWrite($fileHandle, $data)
;~ ;FileWriteLine($fileHandle, 'Hello')
;~ FileClose($fileHandle)


;Đọc dữ liệu
;FileRead(file, count) count: số ký tự được đọc ( ko bắt buộc)
;Global $filePath = FileOpenDialog('Open', @ScriptDir, "All (*.*)|Text files (*.txt)|AutoIt (*.au3)",1 + 2 + 8,'macro.txt', form)
;1: file phải tồn tại  2: Đường dẫn file phải tồn tại 4: multiselect file 8: tạo file mới khi chưa tồn tại,     macro.txt:tên mặc định

;~ Local $fileHandle = FileOpen('abc\testfile.txt', 128)
;~ Local $data = FileRead($fileHandle)
;~ FileClose($fileHandle)

;~ ConsoleWrite($data & @CRLF)

;~ Đọc ghi file .ini
;~ IniRead()
;~ IniWrite()
;~ IniGet()
;~ IniDelete()


#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#Region ### START Koda GUI section ### Form=
Global $FormMain = GUICreate("Untitled - Notepad", 598, 420, -1, -1, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP))
Global $File = GUICtrlCreateMenu("&File")
Global $New = GUICtrlCreateMenuItem("&New", $File)
Global $Open = GUICtrlCreateMenuItem("&Open", $File)
Global $Save = GUICtrlCreateMenuItem("&Save", $File)
Global $MenuItem1 = GUICtrlCreateMenuItem("", $File)
Global $Exit = GUICtrlCreateMenuItem("E&xit", $File)
Global $Help = GUICtrlCreateMenu("&Help")
Global $About = GUICtrlCreateMenuItem("&About", $Help)
GUISetFont(14, 400, 0, "Segoe UI")
Global $Edit = GUICtrlCreateEdit("", 0, 0, 614, 416)
GUICtrlSetData(-1, "")
GUICtrlSetResizing(-1, $GUI_DOCKAUTO)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $New
			; Nếu không có dữ liệu: thì không làm gì
			; Nếu có dữ liệu: hỏi người dùng có muốn lưu lại không
			; - Nếu không lưu: xóa dữ liệu trong Edit
			; - Nếu có lưu: lưu lại và xóa dữ liệu trong Edit
			Local $content = GUICtrlRead($Edit)

			If $content Then
				Local $action = MsgBox(3 + 262144, 'Notepad', 'Do you want to save changes to Untitled?', 0, $FormMain)

				If $action == 6 Or $action == 7 Then
					; Lưu file
					If $action == 6 Then
						saveFile($content)
					EndIf

					; xóa dữ liệu
					GUICtrlSetData($Edit, '')
					WinSetTitle($FormMain, '', 'Untitled - Notepad')
				EndIf
			EndIf
		Case $Open
			; Nếu không có dữ liệu: thì hiển thị hộp thoại mở file
			; Nếu có dữ liệu: hỏi người dùng có muốn lưu lại không
			; - Nếu không lưu: hiển thị hộp thoại mở file
			; - Nếu có lưu: lưu lại và hiển thị hộp thoại mở file
			Local $content = GUICtrlRead($Edit)

			If $content Then
				; có dữ liệu
				saveFile($content)
			EndIf

			Local $filePath = openFile()

			updateTitle($filePath)
		Case $Save
			; Hỏi người dùng có muốn lưu file không
			Local $content = GUICtrlRead($Edit)

			If $content Then
				Local $filePath = saveFile($content)
				updateTitle($filePath)
			EndIf

		Case $Exit
			Exit
		Case $About
			MsgBox(64 + 262144, 'About', 'Developed by JUNO_OKYO', 0, $FormMain)
	EndSwitch
WEnd

Func saveFile($content)
	Local $fileHandle = FileSaveDialog('Save', @ScriptDir, 'Text files (*.txt)|All files (*.*)', 16, '', $FormMain)

	If $fileHandle Then
		Local $filePath = FileOpen($fileHandle, 2)
		FileWrite($filePath, $content)
		FileClose($filePath)

		Return $fileHandle
	EndIf
EndFunc

Func openFile()
	Local $fileHandle = FileOpenDialog('Open', @ScriptDir, 'Text files (*.txt)|All files (*.*)', 1 + 2 + 8, '', $FormMain)

	If $fileHandle Then
		Local $filePath = FileOpen($fileHandle, 128)
		Local $data = FileRead($filePath)
		FileClose($filePath)

		GUICtrlSetData($Edit, $data)

		Return $fileHandle
	EndIf
EndFunc

Func updateTitle($filePath)
	Local $drive, $dir, $fileName, $fileExt
	_PathSplit($filePath, $drive, $dir, $fileName, $fileExt)

	WinSetTitle($FormMain, '', $fileName & $fileExt & ' - Notepad')
EndFunc









