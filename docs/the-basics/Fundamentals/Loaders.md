# Loaders

Loaders are the containers which store information about a file. They are attached to a profile by calling:
```lua
local loader = Profile:CreateLoader(ID, DefaultData)
```

The `ID` is whats used for and internal and extrnal refrence of that loader and has to be unique to that loader (at least in that Profile)

`DefaultData` is what new files loaded are set too or is how existing files (if its a table) get new keys added. DefaultData is recomended to be a table, but it works as other types aswell.

## Files
Before you can store data in a loader, you need it to have it loaded into a file or else it will throw an error.

You can load into a file by doing:
```lua
loader:LoadInto(FileKey)
```
!!! note
    Unlike `ProfileKeys`, `FileKeys` can be '2' or 2 and it will not refrence the same file.

Then, once your done with the file, you can load out of a file by doing:
```lua
loader:Unload()
```
!!! warning
    If you load out of a file with unsaved modified data, It will be pernamently gone!

## Managing Data
You can get the data from a loader by calling:
```lua
local data = loader:GetData()
```
This is a **Strong Reference**, meaning that modifying this variable will modify loaders internal data.


You can save a loaders file data by calling:
```lua
loader:Save()
```
!!! note
    the `Save()` method takes an optional perameter which lets you pass new data:
    ```lua
    loader:Save(NewData)
    ```

Putting all of this together, if you want have a counter that increases every time you load into a file you can do:
```lua
local loader = Profile:CreateLoader("LoadCounter", 0)
loader:LoadInto(1)

local data = loader:GetData()

data += 1

loader:Save()
```

---

For more advanced loader usage check out:

* [Binding to loaders](../../Specifics/Binding-To-Loaders)
* [Locked Loaders](../../Specifics/Locked-Loaders)
* [Updating Loaders](../../Specifics/Updating-Loaders)