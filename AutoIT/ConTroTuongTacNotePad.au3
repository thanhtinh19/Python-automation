;Global $handle = WinGetHandle('Untitled - Notepad')
;$handle = WinGetHandle("[CLASS:Notepad]")
;ConsoleWrite($handle & @CRLF)
;WinSetTitle($handle, '', 'Test')

Func main()
	Run('notepad')
	Sleep(2000)
	Send('Hello world')
EndFunc

;main()
#include <Array.au3>
#include <libarycustom.au3> ;cung thu muc
;khác thu muc phai su dung duong dan tuyet doi "D:\Tinh\Python-automation\AutoIT\libarycustom.au3"
Local $arr = ['a','b','c']
;_ArrayDisplay($arr)
_ArrayShow($arr)