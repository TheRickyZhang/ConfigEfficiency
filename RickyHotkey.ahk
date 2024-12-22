#Requires AutoHotkey v2.0

^!n:: {
    SetWorkingDir("C:\Users\ricky")  ;
    Run("C:\Program Files\Neovim\bin\nvim.exe")  ;
}

^!v:: {
    Run('"C:\Users\ricky\AppData\Local\Programs\Microsoft VS Code\Code.exe" "C:\Users\ricky\ConfigEfficiency\RickyHotkey.ahk"')
}
^!a:: {
    Run "C:\Users\ricky\ConfigEfficiency\RickyHotkey.ahk"
}
^!q:: {
    Suspend(-1) ;
    ToolTip("Hotkeys suspended!")
    Sleep(500) ;
    ToolTip("") ;
}

!;:: {
    Send("{{}")
    Sleep(10)   
    Send("{Enter}")
}

CapsLock::Alt
!e::Send("{Enter}")
!p::Send("{Backspace}") 

!a::Send("=")
!q::Send("{+}")
!w::Send("-")

!Space::Send("{Down}") 
#Space::Send("{Up}") 

!u::Send("[")
!o::Send("]")
!l::Send("]")
!7::Send("{(}")
!8::Send("{)}")
!0::Send("0")

!.::Send("{End}")
!,::Send("{Home}")

!s::Send("^{Left}")
!d::Send("^{Right}")
+!s::Send("^+{Left}") 
+!d::Send("^+{Right}")

!i::Send("i")
!j::Send("j")
!x::Send("x")
!y::Send("y")

!1::Send("1")
!2::Send("2")
!3::Send("3")
!4::Send("4")

global isVimMode := false

!k:: {
    global isVimMode
    isVimMode := !isVimMode
    Tooltip(isVimMode ? "Vim Mode: ON" : "Vim Mode: OFF", , , 1)
    SetTimer(() => Tooltip("", , , 1), 100) ;
}

#HotIf isVimMode

h::Send("{Left}")
j::Send("{Down}")
k::Send("{Up}")
l::Send("{Right}")

s::Send("^{Left}")
d::Send("^{Right}")
w::Send("^+{Left}") 
e::Send("^+{Right}")
p::Send("{Backspace}") 
x::Send("{Delete}")
+j::Send("{PgDn}")
+k::Send("{PgUp}")

#HotIf