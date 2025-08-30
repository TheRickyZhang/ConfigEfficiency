#Requires AutoHotkey v2
#SingleInstance Force
#UseHook
#InputLevel 1
SendMode "Input"
SendLevel 0
SetKeyDelay -1

; CapsLock: hold=Ctrl, tap "=" (Shift+=")
SetCapsLockState "AlwaysOff"
*CapsLock::{
    s := GetKeyState("Shift","P")
    Send "{Ctrl down}"
    KeyWait "CapsLock"
    Send "{Ctrl up}"
    if (A_PriorKey="CapsLock" || A_PriorKey="LShift" || A_PriorKey="RShift")
        Send (s? "{Text}+" : "{Text}=")
}

; Use / as RShift
*/::{
    s := GetKeyState("LShift","P")
    Send "{RShift down}"
    KeyWait "/"
    Send "{RShift up}"
    if (A_PriorKey="/" || A_PriorKey="LShift")
        Send (s? "{Text}?" : "{Text}/")
}

; Add z to LShift
*LShift::{
    s := GetKeyState("RShift","P")
    Send "{LShift down}"
    KeyWait "LShift"
    Send "{LShift up}"
    if (A_PriorKey="LShift" || A_PriorKey="RShift")
        Send (s? "{Text}Z" : "{Text}z")
}

; Backtick -> Alt-Tab (wait on backtick itself)
`::{
    Send "{Alt down}{Tab}"
    KeyWait "Tab"
    Send "{Alt up}"
}



#HotIf GetKeyState("LAlt","P")
*y::SendText "^"
*u::SendText "{"
*i::SendText "}"
*o::SendText "$"
*p::SendText "%"
*h::SendText "#"
*j::SendText "("
*k::SendText ")"
*l::SendText "*"
*`;::SendText "\"
*m::SendText "_"
*,::SendText "<"
*.::SendText ">"
*/::SendText "|"
*w::SendText "~"
*s::SendText "!"
*d::SendText "@"
Space::Send "{Tab}"
#HotIf

; Take advantage of opposite-shift conventions for extra layer
#HotIf GetKeyState("LShift", "P")
*z::Send Left
*x::Send Right
#HotIf

#HotIf GetKeyState("RShift", "P") 
*,::Send "Down"
*.::Send "Up"
#HotIf

$Esc::z
SC030::Send "{Esc}"

; ---- Colemak-DH — native, modifier-aware, no recursion ----
$e::f
$r::p
$t::b
$y::j
$u::l
$i::u
$o::y
$p::SC027        ; ';'

$s::r
$d::s
$f::t
$h::m
$j::n
$k::e
$l::i
$`;::o        ; ';' -> o

$z::x
$x::c
$c::d
$n::k
$m::h

$[::Backspace
$=::[
$F1::`

; Reverse quotes on apostrophe (SC028)
$SC028::SendText '"'
$+SC028::SendText "'"

