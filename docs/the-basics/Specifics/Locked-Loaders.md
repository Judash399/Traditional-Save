# Locked Loaders
Sometimes, you will have a certain loader which should stay on the same file and not swap. For this situation TraditionalSave has a certain optional parameter which lets you prevent the loader from being changed:
```lua
local Loader = Profile:CreateLoader("ID", {}, Locked?)
```
When you set locked to true, you can no longer load into or out of a file, but theres an issue that comes with that. 
> If you can't load into any files, how does it even be in a file?

So thats why Loaders also come with 1 more aditional property which lets you determine what file it starts in:
```lua
local Loader = Profile:CreateLoader("ID", {}, true, "Locked_Data")
```

So, if you want settings data, you can make a loader which holds it:
```lua
local SettingsLoader = Profile:CreateLoader("Settings", {}, true, "Settings")
```