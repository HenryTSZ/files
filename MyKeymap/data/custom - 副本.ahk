;=====================================================================o
; 按键修饰符
CustomColor := "0352ff" ; 可以为任意 RGB 颜色
MyInput := 0 ; 定义显隐变量

MyGui := Gui()
MyGui.Opt("+LastFound +AlwaysOnTop -Caption +ToolWindow") ; +ToolWindow 避免显示任务栏按钮和 alt-tab 菜单项
MyGui.BackColor := CustomColor
MyGui.Show("x0 y400 w3 h500 NoActivate") ; NoActivate 让当前活动窗口继续保持活动状态.
MyGui.Hide()

; CapsLock 短按切换输入法，先按其他功能键再按 CapsLock 为切换大小写；CapsLock 与其他某个键同按时，CapsLock 映射为 ctrl，如 CapsLock + w => ctrl + w
; https://zhuanlan.zhihu.com/p/389784449

UpdateOSD(arg := MyInput) {
  global MyInput
  MyInput := !arg
  MyGui.Opt("+LastFound")
  if (MyInput) {
    MyGui.Hide()
  } else {
    MyGui.Show("NoActivate")
  }
}

; #InstallKeybdHook
; 禁用大写功能，防止误触
SetCapsLockState "AlwaysOff"
*Capslock::
{
  Send "{LControl Down}"
  KeyWait "CapsLock"
  Send "{LControl Up}"
  if ( A_PriorKey = "CapsLock" )
  {
    Send "{alt down}{shift down}"
    Send "{alt up}{shift up}"
    UpdateOSD()
  }
  ; CapsLock + [ 进入 normal 模式，并切换到英文输入法，系统配置的切换到英文快捷键是 ctrl + 8
  if ( A_PriorKey = "[")
  {
    ; Send {Esc}
    Send "^8"
    UpdateOSD(0)
    return
  }
}

;=====================================================================o
; 热字符串

; 启动目录
:*:stu::
{
  Send %A_Startup%
}

:*:tlp::13161080472

:*:dbg::debug_http://10.2.174.93:8080/?full_screen=1
