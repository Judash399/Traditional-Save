# Loader

## Description
A Loader is an object attached to a [Profile](../Profile) that provides access to a file. It allows you to read, modify, save, and unload the data, as well as bind objects to a file so they get destroyed when the file is unloaded.

## <img src="/docsAssets/property.png" width="20"> Properties

* *Data* - The data for the currently loaded file. Although this works, its recomended to use `Loader:GetData()` to make your intention more clear, and to help prevent bugs.

## <img src="/docsAssets/function.png" width="20"> Methods

### GetData
```lua
Loader:GetData()
```
<h4>Description:</h4>
Returns the data for the currently loaded file. Throws an error if there is no loaded file.

<h4>Parameters:</h4>
* *Loader* - The loader you want to get the data from.

<h4>Returns:</h4>
* *Data* - A reference to the data the in the loaded file.

<br>

## Save
```lua
Loader:Save(NewData?)
```
<h4>Description:</h4>
Marks the [Profile](../Profile) the given loader is attached too, to save the currently loaded file. Uses NewData as the files new data if its passed or just `Loader.Data`.

<h4>Parameters:</h4>
* *Loader* - The loader you want to save from.

<br>

## Unload
```lua
Loader:Unload()
```
<h4>Description:</h4>
Makes the given loader load out of the currently loaded file. Throws an error if already not loaded in a file or if the loader is locked.

<h4>Parameters:</h4>
* *Loader* - The loader you want to load out of.

<br>

## LoadInto
```lua
Loader:LoadInto(Key)
```
<h4>Description:</h4>
Makes the given loader load into a specified file. Throws an error if already loaded into a file or if the loader is locked.

<h4>Parameters:</h4>
* *Loader* - The loader you want to load into the given file.
* *Key* - The [FileKey](../../Types/FileKey) for the file which you want to load into.

<br>

### IsLoaded
```lua
Loader:IsLoaded()
```
<h4>Description:</h4>
Returns a boolean where its true if the given loader is currently loaded in a file, and false if not.
<h4>Parameters:</h4>
* *Loader* - The loader you want to check.
<h4>Returns:</h4>
* *Loaded* - A boolean which determine's if the loader is loaded in a file.

### BindTo
```lua
Loader:BindTo(Object, Cleanup?)
```
<h4>Description:</h4>
Binds an object to the currently loaded file. If the file is unloaded or the profile is deleted, this object will be destroyed. Check out [Binding to Loaders](../../../the-basics/binding-to-loaders) for more information.

<h4>Parameters:</h4>
* *Loader* - The loader to bind the object to.
* *Object* - The object to bind to the file.
* *Cleanup?* - The name of the cleanup method for the object, If your object isnt an table, you don't need to pass this parameter.

<h4>Returns:</h4>
* *Object* - The object you passed into the `Object` parameters.

<br>

## <img src="/docsAssets/event.png" width="20"> Signals

### OnLoaded

<h4> Fires: </h4>
Fires whenever the Loader loads into a file.

<h4> Arguments: </h4>
* *[FileKey](../../Types/FileKey)* - The key for the file that was loaded into.

<br>

### OnUnloaded

<h4> Fires: </h4>
Fires whenever the Loader loads out of a file.

<br>

### OnFileCreated
<h4> Fires: </h4>
Fires whenever the Loader loads into a file that hasnt been loaded into before, meaning that its a new file.

<h4> Arguments: </h4>
* *[FileKey](../../Types/FileKey)* - The key for the file that was loaded into.