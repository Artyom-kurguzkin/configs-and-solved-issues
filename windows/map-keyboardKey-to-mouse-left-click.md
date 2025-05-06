# Description

While typing, some autocomplete and syntax checkers only trigger if right-clicked on. 
It is way too time-consumming to reach out for a mouse each time. The most convinient way is to map mouse right click to a keyboard shortcut.

I have successfully managed to do it using Power Toys keyboard manager before, but it seems to have isssues with laptops (apparently somehting to do with touchpad drivers).

Instead this solution uses autoHotKey: https://www.autohotkey.com

---

<br>

# Solution

Once installed, a menu should appear. One of the options is to create new blank script in `User/Documents/autohotkey/`. Put the following in the script:

```
#Requires AutoHotkey v2.0
<!z::Click("Right")
```

Execute the script to check if it is working.

Next, create a shortcut for the script. press Winkey and type `Run`. 

In runner, type `shell:startup`. 

A new file explorer window opens. Put the shortcut there, so the script runs on your computer's startup. 
