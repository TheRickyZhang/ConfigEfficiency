#Requires AutoHotkey v2.0
#SingleInstance Force


;CapsLock::Ctrl
LAlt::Backspace

SetCapsLockState "AlwaysOff"
*CapsLock::{
    s := GetKeyState("Shift","P")   ; SHIFT state at press
    Send "{Ctrl down}"
    KeyWait "CapsLock"
    Send "{Ctrl up}"
    if (A_PriorKey = "CapsLock" || A_PriorKey = "LShift" || A_PriorKey = "RShift") {
        if s
            Send "{Shift down}{vkBB}{Shift up}"
        else
            Send "{vkBB}"                        ; '='
    }
}
`::{
    Send "{Alt down}{Tab}"
    KeyWait "Tab"                 ; wait until j is released
    Send "{Alt up}"
}


LAlt::Return
; Mimic symbol layer with key b
#HotIf GetKeyState("LAlt", "P")
y::SendText "^"
u::SendText "{"
i::SendText "}"
o::SendText "$"
h::SendText "#"
j::SendText "("
k::SendText ")"
l::SendText "*"
`;::SendText "\"
m::SendText "_"
,::SendText "<"
.::SendText ">"
/::SendText "|"
w::SendText "~"
s::SendText "!"
d::SendText "@"
Tab::{
    Send "{Alt down}{Tab}"
    KeyWait "Tab"
    Send "{Alt up}"
}
Space::Tab
#HotIf

; Colemak DH remapping
e::f
r::p
t::b
y::j
u::l
i::u
o::y
p::;

; Home row
s::r
d::s
f::t
h::m
j::n
k::e
l::i
`;::o

z::x
x::c
c::d
$SC030::Esc
n::k
m::h

Space & SC030::Send "{Esc}"     ; SC030 = physical B
Space::Send " "                 ; keep Space working when pressed alone
Esc::z

; Reverse quotes
$SC028::SendText('"')
$+SC028::SendText("'")
