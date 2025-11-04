# PlayerProfiles
PlayerProfiles is a higher level compared to all other objects in TraditionalSave2. Its purpose is to make creation of profiles for all the players in a place easier.

You create one by calling:
```lua
store:ProfileFromPlayers(callback)
```

The *PlayerProfiles* object will then create a new Profile for each new (any existing) player that joins, and automatically remove the profiles when the players leave. 

After creating a profile, it will run the callback you passed while passing the profile it made. This callback is intended for you to setup the profile by doing things like creating loaders, and adding methods:

```lua
local Profiles = store:ProfileFromPlayers(function(profile)
    local MainLoader = profile:CreateLoader("Main", {})

    profile:SetMethods({
        foo = function()

        end,
        bar = function()

        end
    })
end)
```

## Refrencing Profiles later
When you want to reference a profile later, you can use the `Profiles` key, and then index the player from that other table which looks like this in practice:
```lua
local playerProfile = Profiles.Profiles[player]
```