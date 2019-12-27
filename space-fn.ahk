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
; 按键修饰符

\::BS

BS::\

LAlt::LCtrl

LWin::LAlt

LCtrl::LWin

RAlt::RCtrl

AppsKey::RAlt

CapsLock::
	KeyWait, CapsLock
	if (A_TimeSinceThisHotkey > 300)
	{
		state := GetKeyState("Capslock", "T")  ; 当 CapsLock 打开时为真, 否则为假.
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

;#if GetKeyState("LCtrl", "P")
;Tab:: Send !{Tab}
;return

;=====================================================================o
; space-fn

space::Send {space}

^space::Send ^{space}
#space::Send #{space}
^#space::Send ^#{space}
!space::Send !{space}
^!space::Send ^!{space}

;  *** space + Num
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


;  *** space + [] (windows virual desktop switcher)
space & [::Send ^#{left}
space & ]::Send ^#{right}

;  *** space + XX
#if GetKeyState("space", "P")
f & k:: Send +{up}
f & h:: Send +{left}
f & j:: Send +{down}
f & l:: Send +{right}
d & k:: Send ^{up}
d & h:: Send ^{left}
d & j:: Send ^{down}
d & l:: Send ^{right}
g & k:: Send ^+{up} 
g & h:: Send ^+{left}
g & j:: Send ^+{down}
g & l:: Send ^+{right}

k:: Send {up}
h:: Send {left}
j:: Send {down}
l:: Send {right}
i:: Send {home}
o:: Send {end}
u:: Send {Pgup}
p:: Send {Pgdn}

a:: Send ^a
c:: Send ^c
x:: Send ^x
v:: Send ^v
z:: Send ^z

\:: Send {Del}

'::`

s:: Send {space}

return
