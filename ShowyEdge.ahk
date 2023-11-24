CustomColor := "0352ff" ; 可以为任意 RGB 颜色
MyInput := 1 ; 定义显隐变量. 1: 英文，隐藏，2: 中文，显示

MyGui := Gui()
MyGui.Opt("+LastFound +AlwaysOnTop -Caption +ToolWindow") ; +ToolWindow 避免显示任务栏按钮和 alt-tab 菜单项
MyGui.BackColor := CustomColor
MyGui.Show("x0 y400 w3 h500 NoActivate") ; NoActivate 让当前活动窗口继续保持活动状态.
MyGui.Hide()

updateInput(arg := MyInput) {
  global MyInput
  MyInput := !arg
  MyGui.Opt("+LastFound")
  if (MyInput) {
    MyGui.Hide()
  } else {
    MyGui.Show("NoActivate")
  }
}

getIMEKBL(win_id := "") { ; 获取激活窗口键盘布局
	if (win_id = "")
		win_id := WinExist("A") ; 获取当前活动窗口ID
	thread_id := DllCall("GetWindowThreadProcessId", "UInt", win_id, "UInt", 0)
	IME_State := DllCall("GetKeyboardLayout", "UInt", thread_id)
	switch IME_State
	{
		case 134481924:
			return 0
		case 67699721:
			return 1
		default:
			return 1
	}
}

checkInput() {
	LastKBLCode := getIMEKBL()
	If (LastKBLCode != MyInput)
		updateInput()
}

checkInput()
SetTimer checkInput, 100
