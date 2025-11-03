# Getting Started
Once you have the model downloaded, require the module in a new server script and module script. and write this
=== "Main.lua"

    ``` lua
    local TraditionalSave2 = --Reference to the module

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
This is the recomended setup for 'TraditonalSave' that is both scalable and recomended
