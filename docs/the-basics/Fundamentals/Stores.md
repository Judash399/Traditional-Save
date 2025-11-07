# Stores

Store's are the object that every single other object derives from and is the only object that can be created directly from the module itself. Stores are crucial to usage of the module. Stores act esentially like wrapper around roblox DataStores and handle direct saving and loading to the DataStore.

Stores are created like this:
```lua
local store = TraditionalSave2.GetStore("StoreName")
```

The StoreName Property is used to determine what store your going to get. A different StoreName means different data.

## Multiple Stores
You aren't limited to creating just one store either! For example, If you want a grouping system, where only one group could be loaded at a time globably you could do:
```lua

--Create a store for players
local playerStore = TraditionalSave2.GetStore("PlayerData")

--Create a store for groups
local GroupStore = TraditionalSave2.GetStore("GroupData")
```

!!! info "Keep in mind"
    For each new store, your DataStore rates will increase. So only create multiple if you have too!

## Config

When defining a store, you can pass another optional property, Config! 
```lua
local store = TraditionalSave2.GetStore("StoreName", {
    --changes go here!
})
```
Config lets you modify how TraditionalSave2 manages your save data and objects.

For example you can change the `SeperateStudioData` property to merge live and studio data:

```lua
local store = TraditionalSave2.GetStore("StoreName", {
    SeperateStudioData = false
})
```

For a full list of Config options, see the [API Reference](../../../API-Reference/Types/StoreConfig).