# Profile

## Description
A Profile is an object that stores data and provides methods to interact with it. While this data is often associated with a player, it can be used independently of any player.

## <img src="/docsAssets/property.png" width="20"> Properties
### Error: boolean
Used to make checking if creation of a profile errored or not in strict mode easier. Doesn't serve any actual purpose aside from that.

### Methods: \{[***string***]: (***...any***) -> (***...any***)}
List of custom methods which is intended to be overwritten with `Profile:SetMethods(Methods)`. 
For more information check out [Defining Methods](../../the-basics/defining-methods).

## <img src="/docsAssets/function.png" width="20"> Methods

### CreateLoader
```lua
Profile:CreateLoader(ID, DefaultData, DefaultKey?, Locked?)
```
<h4>Description:</h4>
Creteas a new *[Loader](../Loader)* Object attached to the given *Profile*.

<h4>Parameters</h4>
* *Profile* - The Profile which the *[Loader](../Loader)* will be attached too.
* *ID* - The Identifier used to reference this *[Loader](../Loader)*.
* *DefaultData* - The data that new files will be, and the data which will fill into empty keys if the default is a table.
* *DefaultKey?* - An optional Parameter that lets you select what file the *[Loader](../Loader)* will be loaded into initially.
* *Locked?* - An optional Parameter that determines if the created *[Loader](../Loader)* is locked. For more information, check out [Locked Loaders](../../the-basics/locked-loaders).

<h4>Returns:</h4>
* *Loader* - The created *[Loader](../Loader)*.

<br>

### CreateUpdatingLoader
```lua
Profile:CreateUpdatingLoader(ID, DefaultData, UpdateInterval DefaultKey?, Locked?)
```
<h4>Description:</h4>
Creteas a new *[Loader](../Loader)* Object attached to the given *Profile* with extra logic to mark the data for saving every *UpdateInterval* by calling `Save()` on the *[Loader](../Loader)*.

<h4>Parameters:</h4>
* *Profile* - The Profile which the *[Loader](../Loader)* will be attached too.
* *ID* - The Identifier used to reference this *[Loader](../Loader)*.
* *DefaultData* - The data that new files will be, and the data which will fill into empty keys if the default is a table.
* *UpdateInterval* - How often it will call the `Save()` method on the loader.
* *DefaultKey?* - An optional Parameter that lets you select what file the *[Loader](../Loader)* will be loaded into initially.
* *Locked?* - An optional Parameter that determines if the created *[Loader](../Loader)* is locked. For more information, check out [Locked Loaders](../../the-basics/locked-loaders).

<h4>Returns:</h4>
* *Loader* - The created *[Loader](../Loader)*.

<br>

### Destroy
```lua
Proflie:Destroy()
```
<h4>Description:</h4>
Removes strong connections, and freezes the profile, allowing it to be garbage collected.

<h4>Parameters:</h4>
* *Profile* - The Profile you want to destroy.

<br>

### SetMethods
```lua
Profile:SetMethods(Methods)
```
<h4>Description:</h4>
Sets the `Profile.Methods` table to the given dictonary of methods.
For more information check out [Defining Methods](../../the-basics/defining-methods).

<h4>Parameters:</h4>
* *Profile* - The profile where you want to set the methods.
* *Methods* - The dictonary of methods you want to set the `Profile.Methods` table to.

<br>

### IsFileLoaded
```lua
Profile:IsFileLoaded(FileKey)
```
<h4>Description:</h4>
Returns a boolean determining if the passed file is currently loaded by a *[Loader](../Loader)* attached to this Profile.
<h4>Parameters:</h4>
* *Profile* - The profile you want to check.
* *FileKey* - The [FileKey](../../Types/FileKey) for the file you want to check is loaded.
<h4>Returns:</h4>
* *Loaded* - Is the file loaded or not.

<br>

### CopyFile
```lua
Profile:CopyFile(FromKey, ToKey)
```
<h4>Description:</h4>
Copies the data from the *FromKey* file into the *ToKey* file for this profile.

<h4>Parameters:</h4>
* *Profile* - The profile conatining the *from* and *to* files.
* *FromKey* - The [FileKey](../../Types/FileKey) of the source file.
* *ToKey* - The [FileKey](../../Types/FileKey) of the destination file.

<br>

### DeleteFile
```lua
Profile:DeleteFile(FileKey)
```
<h4>Description:</h4>
Deletes the data from the given *FileKey*.

<h4>Parameters:</h4>
* *Profile* - The profile contianing the file you want to delete.
* *FromKey* - The [FileKey](../../Types/FileKey) for the file you want to delete.

<br>

### ReadDataBulk
```lua
Profile:ReadDataBulk(FileKeys)
```
<h4>Description:</h4>
Returns a dictonary of the data for each given FileKey.

<h4>Parameters:</h4>
* *Profile* - The profile you want to read from.
* *FileKeys* - The [FileKeys](../../Types/FileKey) that you want to use.

<h4>Returns:</h4>
* *FileData* - The Dictonary of data where a key gives a files data. This data is a copy and modifying it will not modify the file.

## <img src="/docsAssets/event.png" width="20"> Signals

### OnDestroying

<h4> Fires: </h4>
Fires right before this profile is being destroyed.

### OnSave

<h4> Fires: </h4>
Fires right before the profile is marked to save.