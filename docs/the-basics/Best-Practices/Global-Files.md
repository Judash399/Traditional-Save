# Global Files
Global Files are essentially files accessable by all scripts and cannot be loaded in or out of, and don't need to be manually saved to update.

That sounds offly like a auto updating locked loader. And thats because it is!

For example, something that would be considered a global file would be some settings:
```lua
local SettingsLoader = Profile:CreateUpdatingLoader("Settings", {}, "Settings", true)
```

So all you need too do to create a global file is make an ***updating locked loader***.