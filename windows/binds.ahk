#Requires AutoHotkey v2.0



; emulate mouse actions
!z::
{
    Send("{AppsKey}")
}

!c::Click()


; escape
<!x:: {
    SendLevel 1
    SendEvent("{Esc}")
}



; Line navigation
!]::Send("{End}")        ; Alt+]        -> jump to end of line
![::Send("{Home}")       ; Alt+[        -> jump to start of line
+!]::Send("+{End}")      ; Shift+Alt+]  -> select to end of line
+![::Send("+{Home}")     ; Shift+Alt+[  -> select to start of line

; Alt+O: go to end of line, open a new line below, cursor at its start.
; Uses Shift+Enter instead of Enter so chat/textarea apps insert a newline
; instead of submitting the message.
InsertLineBelow() {
    Send("{End}{Shift down}{Enter}{Shift up}")
}
!o::InsertLineBelow()    ; Alt+O
+!o::InsertLineBelow()   ; Shift+Alt+O (same behavior)


; Remap PgUp / PgDn to Win + Ctrl + Right / Left
PgUp::Send "^#{Left}"
PgDn::Send "^#{Right}"


; Scroll 
scrollSteps := 3     ; Number of scroll steps per key press
scrollDelay := 10    ; Delay between scroll steps (in milliseconds)

; Vertical scrolling
!j::Scroll("Down")   ; Alt + j scrolls down
!k::Scroll("Up")     ; Alt + k scrolls up

; Horizontal scrolling
!h::Scroll("Left")   ; Alt + h scrolls left
!l::Scroll("Right")  ; Alt + l scrolls right

Scroll(direction) {
    global scrollSteps, scrollDelay
    Loop scrollSteps {
        Send("{Wheel" direction "}")
        Sleep(scrollDelay)
    }
}



; jump mouse to active CenterMouseOnActiveWindow

#SingleInstance Force


; Configuration
hoverInterval  := 700              ; Interval (ms) between hover checks
prevUnderMouse := ""              
prevActive     := WinExist("A")    ; Track the window active before Alt+Tab

; Alt-Up hotkeys—center only on Alt+Tab release
~LAlt Up::AltReleased()
~RAlt Up::AltReleased()

AltReleased() {
    global prevActive
    Sleep 50                       ; Allow Windows to settle focus
    hwndNew := WinExist("A")
    if (hwndNew && hwndNew != prevActive
        && !MouseInsideWindow(hwndNew)
    ) {
        CenterMouseOnWindow(hwndNew)
    }
    prevActive := hwndNew
}

; Hover-to-focus (no centering)
SetTimer(HoverFocus, hoverInterval)
HoverFocus() {
    global prevUnderMouse
    if GetKeyState("Alt","P")       ; Suspend hover during Alt sequences
        return

    MouseGetPos(, , &hwnd)
    if (hwnd 
        && hwnd != prevUnderMouse 
        && IsRealWindow(hwnd)
    ) {
        prevUnderMouse := hwnd
        WinActivate("ahk_id " hwnd)
    }
}

; Helpers

IsRealWindow(hwnd) {
    style := WinGetStyle("ahk_id " hwnd)

    WS_VISIBLE          := 0x10000000
    WS_OVERLAPPEDWINDOW := 0x00CF0000
    WS_CHILD            := 0x40000000
    WS_POPUP            := 0x80000000

    return (style & WS_VISIBLE)
        && (style & WS_OVERLAPPEDWINDOW)
        && !(style & WS_CHILD)
        && !(style & WS_POPUP)
}

MouseInsideWindow(hwnd) {
    WinGetPos(&x,&y,&w,&h, "ahk_id " hwnd)
    MouseGetPos(&mx,&my)
    return (mx >= x && mx <= x + w && my >= y && my <= y + h)
}

CenterMouseOnWindow(hwnd) {
    WinGetPos(&x,&y,&w,&h, "ahk_id " hwnd)
    if (w > 0 && h > 0) {
        cx := x + (w // 2)
        cy := y + (h // 2)
        DllCall("SetCursorPos", "Int", cx, "Int", cy)
    }
}
