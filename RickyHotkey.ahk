#Requires AutoHotkey v2
#SingleInstance Force
#UseHook
#InputLevel 1
SendMode "Input"
SendLevel 0
SetKeyDelay -1

; --- CapsLock hold=Ctrl, tap="=" (Shift+=") ---
SetCapsLockState "AlwaysOff"
*CapsLock::{
    s := GetKeyState("Shift","P")
    Send "{Ctrl down}"
    KeyWait "CapsLock"
    Send "{Ctrl up}"
    if (A_PriorKey="CapsLock" || A_PriorKey="LShift" || A_PriorKey="RShift")
        Send (s? "{Text}+" : "{Text}=")
}

; --- Alt-Tab on ` (SC029) ---
SC029::( Send "{Alt down}{Tab}", KeyWait "SC029", Send "{Alt up}" )

; --- LAlt mod-tap: tap=Backspace, hold=Symbol layer ---
tap := 160
altHeld := false, altUsed := false
*LAlt::{
    altHeld := true, altUsed := false
    SetTimer(() => (!GetKeyState("LAlt","P") && !altUsed ? (Send "{BS}") : 0), -tap)
}
*LAlt up:: altHeld := false

#HotIf altHeld
y::SendText "^"
u::SendText "{"
i::SendText "}"
o::SendText "$"
h::SendText "#"
j::SendText "("
k::SendText ")"
l::SendText "*"
`;::SendText "\"        ; semicolon key
m::SendText "_"
,::SendText "<"
.::SendText ">"
/::SendText "|"
w::SendText "~"
s::SendText "!"
d::SendText "@"
Space::(altUsed := true, Send "{Tab}")
#HotIf

; --- Colemak DH (emit text to avoid chains) ---
e::SendText "f"
r::SendText "p"
t::SendText "b"
y::SendText "j"
u::SendText "l"
i::SendText "u"
o::SendText "y"
p::SendText ";"

s::SendText "r"
d::SendText "s"
f::SendText "t"
h::SendText "m"
j::SendText "n"
k::SendText "e"
l::SendText "i"
`;::SendText "o"       ; semicolon key

z::SendText "x"
x::SendText "c"
c::SendText "d"
n::SendText "k"
m::SendText "h"

; --- Reverse quotes on ' key (SC028) ---
$SC028::SendText '"'
$+SC028::SendText "'"
