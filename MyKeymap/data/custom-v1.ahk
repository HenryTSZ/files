; Gui 展示输入法状态
CustomColor := "0352ff" ; 可以为任意 RGB 颜色
MyInput := 0 ; 定义显隐变量
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow ; +ToolWindow 避免显示任务栏按钮和 alt-tab 菜单项.
Gui, Color, %CustomColor%
Gui, Show, x0 y400 w3 h500 NoActivate ; NoActivate 让当前活动窗口继续保持活动状态.

;=====================================================================o
; 5 分钟内无鼠标键盘活动, 触发一次鼠标移动事件, 防止屏幕锁定

/*
Loop{
  If A_TimeIdle > 295000
  {
    Random, x, -15, 15
    Random, y, -15, 15
    MouseMove, %x%, %y%, 0, r
  }
}
return
*/

;=====================================================================o
; 热字符串

; 启动目录
:*:stu::
  Send %A_Startup%
return

:*:tlp::13161080472

:*:dbg::debug_http://10.2.174.93:8080/?full_screen=1

;=====================================================================o
; 按键修饰符

; CapsLock 短按切换输入法，先按其他功能键再按 CapsLock 为切换大小写；CapsLock 与其他某个键同按时，CapsLock 映射为 ctrl，如 CapsLock + w => ctrl + w
; https://zhuanlan.zhihu.com/p/389784449

UpdateOSD(arg) {
  Gui +LastFound
  if (arg) {
    Gui, Hide
  } else {
    Gui, Show, NoActivate
  }
}

#InstallKeybdHook
; 禁用大写功能，防止误触
SetCapsLockState, alwaysoff
*Capslock::
  Send {LControl Down}
  KeyWait, CapsLock
  Send {LControl Up}
  if ( A_PriorKey = "CapsLock" )
  {
    Send {alt down}{shift down}
    Send {alt up}{shift up}
    MyInput := !MyInput
    UpdateOSD(MyInput)
  }
  ; CapsLock + [ 进入 normal 模式，并切换到英文输入法，系统配置的切换到英文快捷键是 ctrl + 0
  if ( A_PriorKey = "[")
  {
    ; Send {Esc}
    Send ^9
    MyInput := 1
    UpdateOSD(MyInput)
    return
  }
return

;=====================================================================o

/*
; MsgBox, 0, 自动复制 chrome / edge 页签 title, 使用方法 `n 使用 chrome / edge 打开需要复制的页签 `n 使用快捷键 Ctrl + q 复制(可以在任何地方) `n 复制以后会在鼠标附近展示复制的内容，时长 1s `n 在需要粘贴的地方使用 Ctrl + v 粘贴 `n`n 退出软件 `n 在任务栏下方找到绿色背景大 H 的图标，右键选择 Exit
^q::
  GroupAdd, Browser, ahk_exe chrome.exe
  GroupAdd, Browser, ahk_exe msedge.exe
  WinGetTitle, Title, ahk_group Browser
  Title := RegExReplace(Title, " - 产研管理JIRA.*")
  Title := RegExReplace(Title, " - 个人.*")
  Title := RegExReplace(Title, " - Google Chrome")
  ToolTip, %Title%
  clipboard := Title
  Sleep, 1000
  ToolTip
return
*/
