# Store

## Methods

### ProfileFromPlayers
``` lua
Store:ProfileFromPlayers(function(Profile)

end)
```
<h4> Description:</h4>
Returns a [PlayerProfiles](../PlayerProfiles) object for the given `Store`, calling the provided `Callback` for each created [Profile](../Profile).

<h4>Parameters:</h4>
* *Store* - The Store in which the [PlayerProfiles](../PlayerProfiles) will be attached.
* *Callback* - The function called for each created [Profile](../Profile). Recives the [Profile](../Profile) as its argument.

<h4>Returns:</h4>
* *PlayerProfiles* - The created [PlayerProfiles](../PlayerProfiles) object.

<br>

### NewProfile
``` lua
Store:NewProfile(Key)
```
<h4> Description:</h4>
Returns either a [Profile](../Profile) thats attached to the given [Key](../Types/Key), or an [Error](../Error) object.

<h4>Parameters:</h4>
* *Store* - The Store in which the [Profile](../Profile) will be attached.
* *Key* - the [Key](../Types/Key) attached to the profile.

<h4>Returns:</h4>
* *Profile* - The created [Profile](../Profile), or an [Error](../Error) object.

<br>

### NewPlayerProfile
```lua
Store:NewPlayerProfile(Player)
```
<h4> Description: </h4>
Creates a new [Profile](../Profile) attached to a player using the players userID as a key.

<h4>Parameters:</h4>
* *Store* - The Store in which the [Profile](../Profile) will be attached.
* *Player* - The player to attach to the [Profile](../Profile).

<h4>Returns:</h4>
* *Profile* - The created [Profile](../Profile), or an [Error](../Error) object.
