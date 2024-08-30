Issue: yazi CLI file manager has to be manually configured to exit back into shell at a previously bavigated folder. 
In their documentation page, they suggested to configure the following script:

```bash
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
```

yet, there are many ways to point bash to a script, like pointing an alias, using .profile, .bashrc, .bash_profile, etc

<br>

---

Solution: 

What eventually worked was adding this line to the end of the script:

```bash
export -f yy
```

, adding execute permssion to the file, and adding this to .bash_profile

```bash
for file in "$HOME/.functions/"*; do
    [ -r "$file" ] && source "$file"
done
```

