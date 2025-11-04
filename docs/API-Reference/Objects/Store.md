# Store

## Description
The Store is the core object that connects Roblox DataStores with TraditionalSave, serving as the foundation that all other TraditionalSave classes attach to. Stores manage core features such as the save interval, and [Profile](../Profile.md) creation.

## <img src="/docsAssets/property.png" width="20"> Properties

### StoreName: string
The name of the datastore that the Store will use. This is not recomended to be changed after creation because the DataStore being used will **not** update.

### Config: [StoreConfig](../Types/StoreConfig)
The configuration table that is used for everything that uses this store. This can be modified after creation but it is likely that certain properties and methods will not update.

## <img src="/docsAssets/function.png" width="20"> Methods

### ProfileFromPlayers
``` lua
Store:ProfileFromPlayers(function(Profile)

end)
```
<h4> Description:</h4>
Returns a [PlayerProfiles](../PlayerProfiles) object for the given `Store`, calling the provided `Callback` for each created [Profile](../Profile.md).

<h4>Parameters:</h4>
* *Store* - The Store in which the [PlayerProfiles](../PlayerProfiles) will be attached.
* *Callback* - The function called for each created [Profile](../Profile.md). Recives the [Profile](../Profile.md) as its argument.

<h4>Returns:</h4>
* *PlayerProfiles* - The created [PlayerProfiles](../PlayerProfiles) object.

<br>

### NewProfile
``` lua
Store:NewProfile(Key)
```
<h4> Description:</h4>
Returns either a [Profile](../Profile.md) thats attached to the given [Key](../../Types/Key), or an [Error](../Error) object.

<h4>Parameters:</h4>
* *Store* - The Store in which the [Profile](../Profile.md) will be attached.
* *Key* - the [Key](../../Types/Key) attached to the profile.

<h4>Returns:</h4>
* *Profile* - The created [Profile](../Profile.md), or an [Error](../Error) object.

<br>

### NewPlayerProfile
```lua
Store:NewPlayerProfile(Player)
```
<h4> Description: </h4>
Creates a new [Profile](../Profile.md) attached to a player using the players userID as a key.

<h4>Parameters:</h4>
* *Store* - The Store in which the [Profile](../Profile.md) will be attached.
* *Player* - The player to attach to the [Profile](../Profile.md).

<h4>Returns:</h4>
* *Profile* - The created [Profile](../Profile.md), or an [Error](../Error) object.

## <img src="/docsAssets/event.png" width="20"> Signals

### OnProfileAdded

<h4> Fires: </h4>
Fires whenever a profile is added to the store.

<h4> Arguments: </h4>
* *[Profile](../Profile.md)* - The profile that was added.

### OnProfileRemoving
<h4> Fires: </h4>
Fires right before a profile is removed from the store.

<h4> Arguments: </h4>
* *[Profile](../Profile.md)* - The profile thats being removed.

### OnProfileCreated
<h4> Fires: </h4>
Fires whenever a profile is added that has no data attached to it, and was created for the first time.

<h4> Arguments: </h4>
* *[Profile](../Profile.md)* - The profile that was created.