# Profile Methods
Profile Methods allow you to define functions attached to a profile which make code that interacts with save data look more simple and elegant.

You define methods by calling the `:SetMethods()` Function and passing a dictionary of methods which looks like this in practice:
```lua
profile:SetMethods({
    foo = function()

    end,

    bar = function()

    end,
})
```

Then, using these methods as simple as this:
```lua
profile.Methods.foo()

profile.Methods.bar()
```

## Giving it auto complete
You may notice that profiles don’t have autocomplete when writing code. This happens because there’s currently no way to dynamically infer types for methods, so you need to define them manually.

Adding autocomplete involves using **type annotations** and **generics**. If you’re not familiar with these concepts, it’s worth learning them first.

Here’s how you can define methods with types for a single profile:
```lua
--This is the list of methods you define
type profileMethods = {
    foo: () -> ()
}

local profile = Store:NewProfile("Test Profile"):: TraditionalSave2.Profile<profileMethods> 

profile:SetMethods({
    foo = function()

    end
})

```

And now you will notice you have auto complete whenever you try to call the methods!

## Giving PlayerProfiles autocomplete
You can also provide autocomplete for profiles created by a PlayerProfiles object. The process is similar:

```lua
--This is the list of methods you define
type profileMethods = {
    foo: () -> ()
}

local profiles = Store:ProfileFromPlayers(function(profile)

    profile:SetMethods({
    foo = function()

    end
    })
end):: TraditionalSave2.PlayerProfiles<profileMethods>
```
Now, all profiles created by PlayerProfiles will also have autocomplete for the methods you defined.