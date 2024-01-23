/*
  快速生成网站 md 格式链接
  使用方法: 在网站先复制 title, 再输入 aa 即可
*/
; :*:aa::
;   flag := true
;   Content := Clipboard
;   FileAppend, %ClipboardAll%, temp.clip
;   Loop {
;     FileReadLine, line, temp.clip, %A_Index%
;     if ErrorLevel
;       break
;     c := RegExMatch(line,"SourceURL:(.*)$", url)
;     if (c = 1)
;     {
;       flag := false
;       ; Send, 网址: %url1%`n主题: %Content% ;注意url后面的数字1
;       Send {!}[%Content%](%url1%)
;       break
;     }
;   }
;   FileDelete, temp.clip
;   if (flag)
;   {
;     Send aa
;   }
; return

; 短按 CapsLock 切换中英文，长按开启大写
; https://www.zhihu.com/question/54950297
CapsLock::
  KeyWait, CapsLock
  if (A_TimeSinceThisHotkey > 300)
  {
    state := GetKeyState("Capslock", "T")
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
    Send {ctrl down}{shift down}
    Send {shift up}{ctrl up}
  }
return

; CapsLock 切换桌面
; CapsLock & 1::Send ^#{left}
; CapsLock & 2::Send ^#{right}
; return

; CapsLock + [ 进入 normal 模式，并切换到英文输入法，系统配置的切换到英文快捷键是 ctrl + 0
; CapsLock & [::
;   Send {Esc}
;   Send ^0
; return

; 用 gVim 编辑任意窗口的文字[AHK]
; https://www.appinn.com/gvim-ahk-tip/
^i::
    tmpfile=%A_ScriptDir%\ahk_text_edit_in_vim.txt
    gvim=P:\Vim\vim72\gvim.exe
    WinGetTitle, active_title, A
    clipboard =
        ; 清空剪贴板
    send ^a
        ; 发送 Ctrl + A 选中全部文字
    send ^c
        ; 发送 Ctrl + C 复制
    clipwait
        ; 等待数据进入剪贴板
    FileDelete, %tmpfile%
    FileAppend, %clipboard%, %tmpfile%
    runwait, %gvim% "%tmpfile%" +
    fileread, text, %tmpfile%
    clipboard:=text
        ; 还原读取的数据到剪贴板
    winwait %active_title%
        ; 等待刚才获取文字的窗口激活
    send ^v
        ; 发送 Ctrl + V 粘贴
return

;=====================================================================o
; 激活窗口，切换最大/小化

!g::
;WinGet, OutputVar, ProcessName, A
WinGetTitle, OutputVar, A
clipboard := OutputVar
MsgBox, %OutputVar%
return

!h::
RX := "RX文件管理器"
SetTitleMatchMode 2
  if not WinExist(RX)
  {
    run "%A_Programs%\RX-Explorer"
  }
  else if WinActive(RX)
  {
    WinMinimize
  }
  else
  {
    WinActivate
  }
return

!j::
  if not WinExist("ahk_exe chrome.exe")
  {
    run "%A_ProgramsCommon%\Google Chrome"
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

!l::
  if not WinExist("ahk_exe WindowsTerminal.exe")
  {
    run "%A_Programs%\WindowsTerminal"
  }
  else if WinActive("ahk_exe WindowsTerminal.exe")
  {
    WinMinimize
  }
  else
  {
    WinActivate
  }
return

!;::
  if not WinExist("ahk_exe WXWork.exe")
  {
    run "%A_StartMenuCommon%\WXWork"
  }
  else if WinActive("ahk_exe WXWork.exe")
  {
    WinMinimize
    ; WinHide
  }
  else
  {
    WinActivate
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
