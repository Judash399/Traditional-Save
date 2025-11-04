# Updating Loaders
Sometimes you have files that you want to have constantly updating, like a settings menu! TraditionalSave2 actually has a built in method for this:
```lua
Profile:CreateUpdatingLoader(ID, DefaultData, UpdateInterval)
```

This has the exact same values as a normal loader, but with 1 more required value, after you define the default data, you need to define how often it will mark this file to save.

So A interval of 60 will save every minute, while 30 every 30 seconds.