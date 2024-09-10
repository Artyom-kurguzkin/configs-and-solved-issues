# Probelm

Can't share my sccreen while in google meet web meeting.

<br>

# Solution

Install xdg packages - they are supposed to work as interfaces for GUI programs in Wayland.

```bash
$ sudo nala install pipewire xdg-desktop-portal xdg-desktop-portal-wlr
```

<br>

Add the following line to `~/.config/sway/config`:

```
set $XDG_CURRENT_DESKTOP sway
exec export XDG_CURRENT_DESKTOP=$XDG_CURRENT_DESKTOP
```

<br>

Add the following into `/etc/sway/config.d/50-systemd-user.conf`:

```
exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP

exec hash dbus-update-activation-environment 2>/dev/null && \
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
```

<br>

reboot.

Use this website to test screensharing: https://mozilla.github.io/webrtc-landing/gum_test.html 
