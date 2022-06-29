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


