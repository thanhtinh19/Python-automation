Func test($value, $index = Default)
	If $value > 0 Then
	ConsoleWrite('value dương' & @CRLF)
	ElseIf $value < 0 Then
		If StringIsInt($value) Then
			ConsoleWrite('value là số nguyên'& @CRLF)
		Else
			ConsoleWrite('value là số thực'& @CRLF)
		EndIf
		Else
		ConsoleWrite('value là số 0' & @CRLF)
	EndIf
	Local $a = 0, $test = 'Test'
	Select
		Case $a = 1
			ConsoleWrite('a là số 1')
		Case $test = 'Test'
			ConsoleWrite('test check done ' & @CRLF)
		Case Else
			ConsoleWrite('điều kiện khác')
	EndSelect

	Local $msg = ''
	Switch @HOUR
		Case 6 To 11
			$msg="Chào buổi sáng"
		Case 12 To 17
			$msg="Chào buổi chiều "
		Case 18 To 21
			$msg="Chào buổi tối"
		Case Else
			$msg="Chào buổi khuya"
	EndSwitch
	ConsoleWrite($msg  & @CRLF)
EndFunc

test(15)
