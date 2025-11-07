# PlayerProfiles

## Description
PlayerProfiles is a object attached to a [Store](../Store) that automaticly creates a [Profile](../Profile) for each player that is in the place. and fires the given callback with the Profile as a argument. 

## <img src="/docsAssets/property.png" width="20"> Properties
* *Profiles* - A dictonary of all the [Profiles](../Profile), where the player instance is the key.

## <img src="/docsAssets/event.png" width="20"> Signals

### OnPlayerAdded

<h4> Fires: </h4>
Fires whenever a player joins and a profile is attached to that player.

<h4> Arguments: </h4>
* *[Profile](../Profile)* - The profile that is attached to the player.

### OnPlayerRemoving
<h4> Fires: </h4>
Fires right before a player leaves and the profile is removed from the *Profiles* dictionary. 

<h4> Arguments: </h4>
* *[Profile](../Profile)* - The profile that is attached to the player.