# Profiles
Profiles are the containers which hold your save data. These are usually attached to a player, but don't have to be!

You can create a profile like this:
```lua
local profile = store:NewProfile(Key)
```

## What is a Key?
The `Key` is a unique identifier for that profile’s save data which can be a string or number.
It’s how Roblox’s DataStore knows which data belongs to what.

!!! warning
    A key of '2' and 2 would refrence the same profile because its converted into a string when interacting with the DataStore.

For save data you’d usually want to use the player’s **UserId**:
```lua
local profile = store:NewProfile(player.UserId)
```
But, theres actually a built in function for creating a profile using a players UserID!
```lua
local profile = store:NewPlayerProfile(player)
```

!!! tip
    Setting a profile's key to a player's userID is refered to as attaching the player to the profile.

## Profile Methods
You can also set methods for your profiles to make interacting with them easier!
```lua

--Set the methods with :SetMethods()
profile:SetMethods({
    foo = function()

    end
})

--Call the method later!
profile.Methods.foo()
```

Learn more about this in [Profile Methods](../../Specifics/Profile-Methods).