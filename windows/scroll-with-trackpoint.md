# Description

I have a trackpoint on my keyboard (a red knob you see on thinkpads). I want to be able to scroll verticaly and horizontally using it.

---

<br>

# Solution

See my previous note on using autoHotkey for [binding a keyboard shortcut to mouse click](https://github.com/Artyom-kurguzkin/configs-and-solved-issues/blob/main/windows/map-keyboardKey-to-mouse-left-click.md). 
I append the following to the same script:

```
scrollThreshold := 5      ; Minimum pixels to move before sending a scroll
scrollFactor := 0.1       ; Adjust this value to control scroll sensitivity
lastX := 0
lastY := 0
scrolling := false

SetTimer(WatchMouse, 20)  ; Check mouse position every 20 milliseconds

WatchMouse() {
    global lastX, lastY, scrolling, scrollThreshold, scrollFactor

    if GetKeyState("LShift", "P") {
        MouseGetPos(&x, &y)

        if !scrolling {
            lastX := x
            lastY := y
            scrolling := true
            return
        }

        dx := x - lastX
        dy := y - lastY

        ; Calculate the number of scroll steps based on movement
        stepsX := Floor(Abs(dx) * scrollFactor)
        stepsY := Floor(Abs(dy) * scrollFactor)

        ; Determine scroll direction and send events
        if stepsY >= 1 {
            directionY := dy < 0 ? "Up" : "Down"
            Loop stepsY {
                Send("{Wheel" directionY "}")
                Sleep(10)  ; Small delay between scroll steps
            }
            lastY := y
        }

        if stepsX >= 1 {
            directionX := dx < 0 ? "Left" : "Right"
            Loop stepsX {
                Send("{Wheel" directionX "}")
                Sleep(10)  ; Small delay between scroll steps
            }
            lastX := x
        }
    } else {
        scrolling := false
    }
}
```
