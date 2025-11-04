# Binding To Loaders

Sometimes, you will have an objects that are specific to a certain file. For example you might have a building system where you can load into certain buildings:
```lua
local BuildingLoader = Profile:CreateLoader("Building", {

})
BuildingLoader:LoadInto("House")

---Create house floor
local HouseFloor = Instance.New("Part", workspace)
```

Then, Lets say you will eventually load into a new building:

```lua
--Somewhere later in our script...
BuildingLoader:Unload()
BuildingLoader:LoadInto("School")
```

All good right?

No! We forgot to clean up the houses floor, So we just created a memory leak!

TraditionalSave2 provides a way to fix this: you can **bind objects to a loader**. Objects bound to a loader will automatically be cleaned up when you unload or switch files. Here’s how you can adjust the code:
```lua
BuildingLoader:LoadInto("House")

---Create house floor
local HouseFloor = BuildingLoader:BindTo(Instance.New("Part", workspace))
```
Now, when `BuildingLoader:Unload()` is called, the house floor is automatically removed, preventing memory leaks.

## Binding Other Things
You don't have to just bind Instances though! You can bind many things including your own objects or objects defined in other modules! Binding is essentially a built-in, version of a *Janitor* or *Maid* system.

Here are some things you can bind:
```lua
--Instances (As already shown)
local part = Loader:BindTo(Instance.New("Part"))

--RBXScriptConnections
local connection = Loader:BindTo(part.Touched:Connect(function()
    print("Part Touched!")
end))

--OOP Objects
local object = Loader:BindTo(RandomModule.new(), "Destroy")
```

## OOP Improved
TraditionalSave automaticly checks most cleanup functions to see if they exist, Currently it checks for:

* `Destroy()`
* `Disconnect()`
* `Cleanup()`

Because of this, most flavors of OOP are supported. So, most of the time, Binding can be done as:
```lua
local object = Loader:BindTo(RandomModule.new())
```

If you wish for it to not check for these cleanup functions, set the correct cleanup function.