#Requires AutoHotkey v2.0
#SingleInstance Force

; CLion, Visual Studio, VSCode my beloved
^!8:: {
    SetWorkingDir("C:\Users\ricky")
    Run("C:\Program Files\JetBrains\CLion 2024.3\bin\clion64.exe")
}
^!9:: {
    SetWorkingDir("C:\Users\ricky")
    Run('"C:\Users\ricky\AppData\Local\Programs\Microsoft VS Code\Code.exe"')
}
^!0:: {
    SetWorkingDir("C:\Users\ricky")
    Run("C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe")
}

; Opening, running, quiting RickyHotkey
^!o:: {
    Run('"C:\Users\ricky\AppData\Local\Programs\Microsoft VS Code\Code.exe" "C:\Users\ricky\ConfigEfficiency\RickyHotkey.ahk"')
}
^!r:: {
    Run "C:\Users\ricky\ConfigEfficiency\RickyHotkey.ahk"
}
^!q:: {
    Suspend(-1)
    ToolTip("Hotkeys suspended!")
    Sleep(500)
    ToolTip("")
}


; Alt > Capslock
CapsLock::Alt

; This should be a default for all curly bracket languages
!;:: {
    Send("{{}")
    Sleep(10)   
    Send("{Enter}")
}

; Move around
!.::Send("{End}")
!,::Send("{Home}")
!s::Send("^{Left}")
!d::Send("^{Right}")
!w::Send("{Left}")
!r::Send("{Right}")
!Space::Send("{Down}")
#Space::Send("{Up}")
!n:: {
    Loop 10 {
        Send("{Down}")
    }
}
!m:: {
    Loop 10 {
        Send("{Up}")
    }
}

; Delete words/lines
!+u::Send("^+{Left}{Del}")
!+i::Send("^+{Right}{Del}")
!+j::Send("+{Home}{Del}")
!+k::Send("+{End}{Del}")
!+l::Send("{Home}+{End}{Del}") ; To work in clion map extend to line end -> shift+end
!+m::Send("{Up}{Home}+{End}{Del}")
!+n::Send("{Down}{Home}+{End}{Del}")

; Select Words/lines
; ^u::Send("^+{Left}^c")
^i::Send("^+{Right}^c")
^l::Send("{Home}+{End}^c")
^!n::Send("+{Down}^c")
^!m::Send("+{Up}^c")

; Move lines
^+!n::Send("!{Down}")
^+!m::Send("!{Up}")

; Grr you're just too far...
!e::Send("{Enter}")
!p::Send("{Backspace}") 

!a::Send("=")
!q::Send("{+}")

!u::Send("[")
!o::Send("]")
!l::Send("]")

; Identity mappings for convenience holding down keys
!i::Send("i")
!j::Send("j")
!k::Send("k")
!x::Send("x")
!y::Send("y")
!0::Send("0")
!1::Send("1")
!2::Send("2")
!3::Send("3")
!4::Send("4")

#HotIf

