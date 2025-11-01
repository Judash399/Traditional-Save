# Inital Setup
Once you have the model downloaded, require the module in a new server script. and write this code:

``` lua
local TraditionalSave2 = --Refrence to the module

local store = TraditionalSave2.GetStore("PlayerData", {})

store:ProfileFromPlayers(function(profile: TraditionalSave2.Profile)
	local MainLoader = profile:CreateLoader("SaveSlots", {})
end)
```

This is all you need to have a very basic setup of `TraditionalSave` working. You may not understand what all of this means, but by the end of this cattegory you should understand exactly what this is saying. This setup does work for small games, but it is very likely that you will need to refrence profiles from multiple scripts. So here is a more advanced setup which is more scalable.

=== "Main.lua"

    ``` lua
    local TraditionalSave2 = --Refrence to the module

    local store = TraditionalSave2.GetStore("PlayerData", {})

    store:ProfileFromPlayers(function(profile: TraditionalSave2.Profile)
        local MainLoader = profile:CreateLoader("SaveSlots", {})
    end)
    ```

=== "Profiles.lua"

    ```lua
   local profiles = {}

   return profiles
    ```
