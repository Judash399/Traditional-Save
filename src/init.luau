--!nocheck

--[[
Copyright 2025, Judash399
TraditionalSave: Version 2.2.0

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”),
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local TraditionalSave2 = {}

--Services
local RunService = game:GetService("RunService")

--Modules
local Store = require(script.Store)
local Types = require(script.Types)
local Error = require(script.Modules.Utils.Error)
local Signal = require(script.Modules.Packages.Signal)

if RunService:IsClient() then
	Error("TraditionalSave2 is server only! don't require it on the client!")
end

--Type Definitions
export type MethodList = Types.MethodList
export type StoreConfig = Types.StoreConfig
export type Error = Types.Error
export type FileKey = Types.FileKey

export type Store = {
	Config: StoreConfig,
	StoreName: string,
	
	---------Methods---------
	ProfileFromPlayers: typeof(
		--Returns a <em>PlayerProfiles</em> object for the given Store, calling the provided <code>Callback</code> for each created <em>Profile</em>.
		function<Methods>(self: Store, callback: (Profile<MethodList>, Player) -> ()): PlayerProfiles<Methods> end
	),
	NewProfile: typeof(
		--Creates a new profile object using the given key.
		function(self: Store, Key: Types.Key): (Profile<{}> | Error) end
	),
	NewPlayerProfile: typeof(
		--Creates a new <em>Profile<em> attached to a player using the players userID as a key.
		function(self: Store, Player: Player): Profile<{}> | Error end
	),
	
	---------Signals---------

	--Fires whenever a <em>Profile</em> is added to the store.
	OnProfileAdded: Signal.Signal<Profile<{}>>,

	--Fires right before a <em>Profile</em> is removed from the store.
	OnProfileRemoving: Signal.Signal<Profile<{}>>,

	--Fires whenever a <em>Profile</em> is added that has no data attached to it, and was created for the first time.
	OnProfileCreated: Signal.Signal<Profile<{}>>,
}

export type Loader<T> = {
	Data: T,
	
	---------Methods---------
	GetData: typeof(
		--Returns the data for the currently loaded file. Throws an error if there is no loaded file.
		function(self: Loader<T>): T end
	),
	Save: typeof(
		--Marks the <em>Profile</em> the given <em>Loader</em> is attached too, to save the currently loaded file. Uses NewData as the files new data if its passed or just <code>Loader.Data</code>.
		function(self: Loader<T>, NewData: T | any?): () end
	),
	Unload: typeof(
		--Makes the given <em>Loader</em> load out of the currently loaded file. Throws an error if already not loaded in a file or if the loader is locked.
		function(self: Loader<T>): () end 
	),
	LoadInto: typeof(
		--Makes the given <em>Loader</em> load into a specified file. Throws an error if already loaded into a file or if the <em>Loader</em> is locked.
		function(self: Loader<T>, Key: FileKey): () end 
	),
	IsLoaded: typeof(
		--Returns a boolean where its true if the given <em>Loader</em> is currently loaded in a file, and false if not.
		function(self: Loader<T>): boolean end
	),
	BindTo: typeof(
		--Binds an object to the currently loaded file. If the file is unloaded or the profile is deleted, this object will be destroyed.
		function<O>(self: Loader<T>, Object: O, Cleanup: string?): O end 
	),
	
	---------Signals---------

	--Fires whenever the Loader loads into a file.
	OnLoaded: Signal.Signal<FileKey>,

	--Fires whenever the Loader loads into a file.
	OnUnloaded: Signal.Signal<>,

	--Fires before the <em>Loader</em> loads out of a file.
	OnUnloading: Signal.Signal<FileKey>,

	--Fires whenever the Loader loads into a file that hasnt been loaded into before, meaning that its a new file.
	OnFileCreated: Signal.Signal<FileKey>,

	--Fires before the <em>Loader</em> marks the attached <em>Profile</em> for saving.
	OnSaving: Signal.Signal<FileKey>,
}

export type Profile<Methods = {}> = {
	Error: boolean,
	Methods: Methods,
	
	---------Methods---------

	CreateLoader: typeof(
		--Creteas a new <em>Loader</em> Object attached to the given <em>Profile</em>.
		function<T>(self: Profile<Methods>, Id: string, DefaultData: T, DefaultKey: FileKey?, Locked: boolean?): (Loader<T>) end
	),
	CreateUpdatingLoader: typeof(
		--Creteas a new <em>Loader</em> Object attached to the given Profile with extra logic to mark the data for saving every UpdateInterval by calling <code>Save()</code> on the <em>Loader</em>.
		function<T>(self: Profile<Methods>, Id: string, DefaultData: T, UpdateInterval: number, DefaultKey: FileKey?, Locked: boolean?): Loader<T> end
	),
	Destroy: typeof(
		--Removes strong connections, and freezes the profile, allowing it to be garbage collected.
		function(self: Profile<Methods>): () end
	),
	SetMethods: typeof(
		--Sets the <code>Profile.Methods</code> table to the given dictonary of methods.
		function(self: Profile<Methods>, methods: MethodList): () end
	),
	ReadDataBulk: typeof(
		--Returns a dictonary of the data for each given FileKey.
		function(self: Profile<Methods>, Keys: {FileKey}): ({[FileKey]: any}) end
	),
	IsFileLoaded: typeof(
		--Returns a boolean determining if the passed file is currently loaded by a <em>Loader</em> attached to this Profile.
		function(self: Profile<Methods>, FileKey: FileKey): boolean end
	),
	CopyFile: typeof(
		--Copies the data from the FromKey file into the ToKey file for this profile.
		function(self: Profile<Methods>, FromKey: FileKey, ToKey: FileKey): () end
	),
	DeleteFile: typeof(
		--Deletes the data from the given FileKey.
		function(self: Profile<Methods>, FileKey: FileKey): () end
	),
	
	---------Signals---------

	--Fires right before this profile is being destroyed.
	OnDestroying: Signal.Signal<>,

	--Fires right before the profile is marked to save.
	OnSave: Signal.Signal<>,
}

export type PlayerProfiles<Methods> = {
	Profiles: { [Player]: Profile<Methods> },

	OnPlayerAdded: Signal.Signal<(Profile<Methods>, Player)>,
	OnPlayerRemoving: Signal.Signal<(Profile<Methods>, Player)>,
}

--Returns a Store Object using the given StoreName.
function TraditionalSave2.GetStore(StoreName: string, Config: Types.StoreConfig?): Store
	return Store.New(StoreName, Config)
end

return TraditionalSave2