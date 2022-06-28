;=====================================================================o
; 5 分钟内无鼠标键盘活动, 触发一次鼠标移动事件, 防止屏幕锁定

Loop{
  If A_TimeIdle > 295000
  {
    Random, x, -15, 15
    Random, y, -15, 15
    MouseMove, %x%, %y%, 0, r
  }
}
return

;=====================================================================o
; 热字符串

; 启动目录
:*:stu::
  Send %A_Startup%
return

;=====================================================================o
; 按键修饰符

\::BS
BS::\
return

LWin::LCtrl
LCtrl::LWin
RWin::RCtrl
return

; CapsLock 短按切换输入法，先按其他功能键再按 CapsLock 为切换大小写；CapsLock 与其他某个键同按时，CapsLock 映射为 ctrl，如 CapsLock + w => ctrl + w
; https://zhuanlan.zhihu.com/p/389784449
#InstallKeybdHook
; 禁用大写功能，防止误触
SetCapsLockState, alwaysoff
Capslock::
  Send {LControl Down}
  KeyWait, CapsLock
  Send {LControl Up}
  if ( A_PriorKey = "CapsLock" )
  {
    Send {ctrl down}{shift down}
    Send {shift up}{ctrl up}
  }
  ; CapsLock + [ 进入 normal 模式，并切换到英文输入法，系统配置的切换到英文快捷键是 ctrl + 0
  if ( A_PriorKey = "[")
  {
    ; Send {Esc}
    Send ^0
    return
  }
  ; if ( A_PriorKey = "1")
  ; {
  ;   Send ^#{left}
  ;   return
  ; }
  ; if ( A_PriorKey = "2")
  ; {
  ;   Send ^#{right}
  ;   return
  ; }
return

;=====================================================================o
/*
  自动复制 chrome 页签 title

  使用方法:
  1. 使用 chrome 打开需要复制的页签
  2. 使用快捷键 Ctrl + q 复制(可以在任何地方)
  3. Ctrl + v 粘贴
*/
^q::
  WinGetTitle, Title, ahk_exe chrome.exe
  Title := StrReplace(Title, " - Google Chrome")
  Title := StrReplace(Title, " - Glodon New JIRA")
  Title := StrReplace(Title, " - 产研管理JIRA库")
  ToolTip, %Title%
  clipboard := Title
  Sleep, 1000
  ToolTip
return

;=====================================================================o
; 激活窗口，切换最大/小化

!j::
  if not WinExist("ahk_exe chrome.exe")
  {
    run "%A_Programs%\Google Chrome"
    WinWait, ahk_exe chrome.exe
    WinMaximize
  }
  else if WinActive("ahk_exe chrome.exe")
  {
    WinMinimize
  }
  else
  {
    WinActivate
    WinGet, OutputVar, MinMax
    if OutputVar != 1
      WinMaximize
  }
return

!k::
  if not WinExist("ahk_exe Code.exe")
  {
    run "%A_Programs%\Visual Studio Code\Visual Studio Code"
  }
  else if WinActive("ahk_exe Code.exe")
  {
    WinMinimize
  }
  else
  {
    WinActivate
    WinGet, OutputVar, MinMax
    if OutputVar != 1
      WinMaximize
  }
return

;=====================================================================o
; space-fn

space::Send {space}

^space::Send ^{space}
#space::Send #{space}
^#space::Send ^#{space}
!space::Send !{space}
^!space::Send ^!{space}

;  *** space + Num to Function
space & 1::Send {F1}
space & 2::Send {F2}
space & 3::Send {F3}
space & 4::Send {F4}
space & 5::Send {F5}
space & 6::Send {F6}
space & 7::Send {F7}
space & 8::Send {F8}
space & 9::Send {F9}
space & 0::Send {F10}
space & -::Send {F11}
space & =::Send {F12}

; *** space + hjkl uiop to move cursor
space & k:: Send {up}
space & h:: Send {left}
space & j:: Send {down}
space & l:: Send {right}
space & i:: Send {home}
space & o:: Send {end}
space & u:: Send {Pgup}
space & p:: Send {Pgdn}

; *** space + acxvz to copy/cut/paste...
space & a:: Send ^a
space & c:: Send ^c
space & x:: Send ^x
space & v:: Send ^v
space & z:: Send ^z

; *** space other
space & \:: Send {Del}
space & '::`
space & q:: Send #^{left}
space & w:: Send #^{right}
; space & s:: Send {space}

;  *** space + X + Y
#if GetKeyState("space", "P")
  LAlt & k:: Send !{up}
LAlt & h:: Send !{left}
LAlt & j:: Send !{down}
LAlt & l:: Send !{right}
LShift & k:: Send +{up}
LShift & h:: Send +{left}
LShift & j:: Send +{down}
LShift & l:: Send +{right}
f & k:: Send ^{up}
f & h:: Send ^{left}
f & j:: Send ^{down}
f & l:: Send ^{right}
g & k:: Send ^+{up}
g & h:: Send ^+{left}
g & j:: Send ^+{down}
g & l:: Send ^+{right}
return
