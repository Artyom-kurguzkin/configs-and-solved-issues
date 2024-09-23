# Issue

Have to copy-paste security token every time i try to push changes to github

<br>

# Solution

Create security token with appropriate scope

```bash
$ git config --global credential.helper store
$ git push origin
<- credentials
```

- now credentials are stored as plain text in git configs and will be substituted every time it is needed.
- note, more secure solution would be `credential.helper cache`.
