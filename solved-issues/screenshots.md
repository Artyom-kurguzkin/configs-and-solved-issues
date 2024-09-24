# Issue

There is no straightforward way to make and edit screenshots on Wayland. 
I want something similar to snipping tool on Windows binded to my `Fn + Ptrscr` key

<br>


# Solution


```bash
$ sudo nala install grim slurp
$ grim -g "$(slurp)" - | (sleep 0.1 && swappy -f -)
```

- note, swappy was not available from any of the default apt repositories, so I found a deb package here: https://software.opensuse.org/download/package?package=swappy&project=home%3ASunderland93%3Atileos-dev 

<br>

Figure out the key code for the key binding

```
$ sudo nala install wev
```

run wev and figure out the key code.

in my case, combination of `Fn + PrtSc` resolves to `Print` or `107` code. Note, Fn may be implemented through keyboard hardware, in which case it wan't be easily discernible.  

<br>

bind the command to the key

```
$ cd ~/.config/sway
$ code config &
```

add this line

```
# Screenshots
bindsym Print exec grim -g "$(slurp)" - | (sleep 0.1 && swappy -f -)
```

* note, sway has some sort of aliasing already implemented for Print = 107, so the line here worked straight away for me. 

* I had to add delay for swappy, otherwise temp file for the pipe wasn't created in time

<br>

reload sway

```
$ swaymsg reload
```
