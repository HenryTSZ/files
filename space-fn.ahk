;=====================================================================o
; 开机启动 iNode

; Run C:\Program Files (x86)\iNode\iNode Client\iNode Client.exe

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
:*:stup::
Send %A_Startup%
return

:*:tlp::131****0472

:*:adeb::debug_http://10.1.73.71:8080/#/?full_screen=1

/*
	快速生成网站 md 格式链接
	使用方法: 在网站先复制 title, 再输入 aa 即可
*/
:*:aa::
  flag := true
  Content := Clipboard
  FileAppend, %ClipboardAll%, temp.clip
  Loop {
    FileReadLine, line, temp.clip, %A_Index%
    if ErrorLevel
      break
    c := RegExMatch(line,"SourceURL:(.*)$", url)
    if (c = 1)
    {
      flag := false
      ; Send, 网址: %url1%`n主题: %Content% ;注意url后面的数字1
      Send {!}[%Content%](%url1%)
      break
    }
  }
  FileDelete, temp.clip
  if (flag)
  {
    Send aa
  }
return

;=====================================================================o
; 按键修饰符

\::BS

BS::\

LAlt::LCtrl

LWin::LAlt

LCtrl::LWin

RAlt::RCtrl

;RCtrl::LWin

AppsKey::RAlt

CapsLock::
  KeyWait, CapsLock
  if (A_TimeSinceThisHotkey > 300)
  {
    state := GetKeyState("Capslock", "T") ; 当 CapsLock 打开时为真, 否则为假.
    if state
      SetCapsLockState, Off
    else
      SetCapsLockState, On
  }
  else
  {
    state := GetKeyState("Capslock", "T")
    if state
    {
      SetCapsLockState, Off
    }
    Send {Shift}
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

;  *** space + [] (windows virual desktop switcher)
space & [::Send ^#{left}
space & ]::Send ^#{right}

; *** space other
space & \:: Send {Del}
space & '::`
space & s:: Send {space}

;  *** space + X + Y
#if GetKeyState("space", "P")
  d & k:: Send +{up}
d & h:: Send +{left}
d & j:: Send +{down}
d & l:: Send +{right}
f & k:: Send ^{up}
f & h:: Send ^{left}
f & j:: Send ^{down}
f & l:: Send ^{right}
g & k:: Send ^+{up}
g & h:: Send ^+{left}
g & j:: Send ^+{down}
g & l:: Send ^+{right}
return
