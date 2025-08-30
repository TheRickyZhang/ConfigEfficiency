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

; Backtick -> Alt-Tab (wait on backtick itself)
`::{
    Send "{Alt down}{Tab}"
    KeyWait "Tab"
    Send "{Alt up}"
}


; ---- LAlt = momentary symbol layer (no tap action) ----
altHeld := false
*LAlt:: altHeld := true
*LAlt up:: altHeld := false

#HotIf altHeld

Space::Send "{Tab}"
#HotIf

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
$SC027::o        ; ';' -> o

$z::x
$x::c
$c::d
$n::k
$m::h
$b::Esc

Esc::z

; Reverse quotes on apostrophe (SC028)
$SC028::SendText '"'
$+SC028::SendText "'"
