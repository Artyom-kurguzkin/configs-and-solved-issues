# Description

This script does 2 things

1. When useing `atl+tab` to change focused window with multi-monitor setup, you have to drag your mouse to the aother monitor, which can be quite tedious depending on mouse and monitor settings. 
This script automatically moves your mouse to recently focused window. 

2. When moving mouse to another window, you need to click on it to 'activate it'. This script automatically focuses the window that you hover onto. Note. This can cause unexpected behaviour for popups and such. I tried to add some handling for this, but this is not a robust solution.

```
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
```
