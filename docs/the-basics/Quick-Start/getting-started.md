# Getting Started
Once you have the module downloaded, require the module in a new module script. and write this

``` lua
--!strict --You don't need this, but TraditionalSave2 works with strict mode!

local TraditionalSave2 = --Reference to the module

local store = TraditionalSave2.GetStore("PlayerData", {})

-- Creates a PlayerProfiles object which manages profiles for players.
local profiles = store:ProfileFromPlayers(function(profile)
    local MainLoader = profile:CreateLoader("SaveSlots", {})

    --Define custom methods.
    profile:SetMethods({
        foo = function()

        end
    })
end)

return profiles
```

Then, other scripts can require this module and do what they want with the profiles.

``` lua
local profiles = --Refrence to module


local profile = profiles.Profiles[player]

--Run a custom method
profile.Methods.foo()
```

This is the recomended setup for *TraditonalSave2* that is both scalable, and easily maintainable. 

!!! warning "Important!"
    For this method to work, you need to have at least 1 script that requires the `profiles` module at runtime! Or else bugs may occur!