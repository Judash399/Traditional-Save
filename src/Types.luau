--!nocheck
--A collection of types used by the private API.

--Modules
local Signal = require(script.Parent.Modules.Packages.Signal)

export type StoreConfig = {
	SeperateStudioData: boolean?,
	UpdateInterval: number?,
	SaveGetAttemptCount: number?,
	IgnoreLockTime: number?,
	TimestampUpdateInterval: number?,
	LockingInStudio: boolean?
}

--A key used by the DataStore.
export type Key = string | number

--Just a key, but its for file index's, not DataStore keys. 
export type FileKey = string | number

export type StoreData = {
	Meta: StoreMeta,
	Files: {[FileKey]: any},
}

export type Error = {
	Error: true,
	Reason: string,
}

export type StoreMeta = {
	ActiveSession: boolean,
	LastTimeSave: number,
	Version: string,
}

export type ProfileMethod = (... any) -> (... any) 

export type MethodList = {[string]: ProfileMethod | MethodList}

export type Store = {
	--------PUBLIC API--------
	Config: StoreConfig,
	StoreName: string,
	
	--Methods
	ProfileFromPlayers: <Methods>(self: Store, callback: (Profile<MethodList>, Player) -> ()) -> PlayerProfiles<Methods>,

	NewProfile: typeof(
		--Creates a new profile object using the given key.
		function(self: Store, Key: Key): (Profile<{}> | Error) end
	),
	NewPlayerProfile: (self: Store, Player: Player) -> Profile<{}> | Error,
	
	--Signals
	OnProfileAdded: Signal.Signal<Profile<{}>>,
	OnProfileRemoving: Signal.Signal<Profile<{}>>,
	OnProfileCreated: Signal.Signal<Profile<{}>>,
	
	--------PRIVATE API--------
	_DataStore: DataStore,
	
	_Profiles: {Profile<{}>},
	
	_GetDataStoreData: (self: Store, StoreKey: Key) -> (boolean, any | Error),
	
	_SaveImmediate: (self: Store, Profile: Profile<{}>) -> boolean,
}

export type Profile<Methods = {}> = {
	--------PUBLIC API--------
	Error: boolean,
	Methods: Methods,
	
	--Methods
	CreateLoader: <T>(self: Profile<Methods>, Id: string, DefaultData: T, DefaultKey: FileKey?, Locked: boolean?) -> Loader<T>,
	CreateUpdatingLoader: <T>(self: Profile<Methods>, Id: string, DefaultData: T, UpdateInterval: number, DefaultKey: FileKey?, Locked: boolean?) -> Loader<T>,
	Destroy: (self: Profile<Methods>) -> (),
	SetMethods: (self: Profile<Methods>, methods: MethodList) -> (),
	ReadDataBulk: (self: Profile<Methods>, Keys: {FileKey}) -> ({[FileKey]: any}),
	IsFileLoaded: (self: Profile<Methods>, FileKey: FileKey) -> boolean,
	CopyFile: (self: Profile<Methods>, FromKey: FileKey, ToKey: FileKey) -> (),
	DeleteFile: (self: Profile<Methods>, FileKey: FileKey) -> (),
	
	--Signals
	OnDestroying: Signal.Signal<>,
	OnSave: Signal.Signal<>,

	--------PRIVATE API--------
	_Store: Store,
	_Key: Key,
	_DataStoreData: StoreData,
	_DataToSave: StoreData,
	_ReadyToSave: boolean,
	_LastSaveTime: number,
	_Loaders: {Loader<any>},
	
	_GetFileData: (self: Profile<Methods>, fileKey: FileKey, defaultData: any) -> (any, boolean),
	_Save: (self: Profile<Methods>) -> (),
}

export type Loader<T> = {
	--------PUBLIC API--------
	Data: T,
	
	--Methods
	GetData: (self: Loader<T>) -> T,
	Save: (self: Loader<T>, NewData: T | any?) -> (),
	Unload: (self: Loader<T>) -> (),
	LoadInto: (self: Loader<T>, Key: FileKey) -> (),
	IsLoaded: (self: Loader<T>) -> boolean,
	
	BindTo: <O>(self: Loader<T>, Object: O, Cleanup: string?) -> O,
	
	--Signals
	OnLoaded: Signal.Signal<FileKey>,
	OnUnloaded: Signal.Signal<>,
	OnUnloading: Signal.Signal<FileKey>,
	OnFileCreated: Signal.Signal<FileKey>,
	OnSaving: Signal.Signal<FileKey>,

	--------PRIVATE API--------
	_LoadedIntoFile: boolean,
	_Profile: Profile<{}>,
	_ID: string,
	_Locked: boolean,
	_DefaultData: T,
	_Key: FileKey?,
	
	_BindedObjects: {{object: any, cleanup: string?}},
	_Destroy: (self: Loader<T>) -> (),
}

export type PlayerProfiles<Methods = MethodList> = {
	Profiles: { [Player]: Profile<Methods> },

	OnPlayerAdded: Signal.Signal<(Profile<Methods>, Player)>,
	OnPlayerRemoving: Signal.Signal<(Profile<Methods>, Player)>,
}

return {}