--!strict

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
local Error = require(script.Utils.Error)
local Signal = require(script.Packages.Signal)

if RunService:IsClient() then
	Error("TraditionalSave2 is server only! don't require it on the client!")
end

--Type Definitions
export type StoreConfig = Types.StoreConfig

export type Store = {
	Config: StoreConfig,
	StoreName: string,
	
	--Methods
	ProfileFromPlayers: <Methods>(self: Store, callback: (Profile<MethodMap>, Player) -> ()) -> PlayerProfiles<Methods>,

	NewProfile: typeof(
		--Creates a new profile object using the given key.
		function(self: Store, Key: Types.Key): (Profile<{}> | Error) end
	),
	NewPlayerProfile: (self: Store, Player: Player) -> Profile<{}> | Error,
	
	--Signals
	OnProfileAdded: Signal.Signal<Profile<{}>>,
	OnProfileRemoving: Signal.Signal<Profile<{}>>,
	OnProfileCreated: Signal.Signal<Profile<{}>>,
}

export type Loader<T> = Types.Loader<T>

export type Profile<Methods = {}> = {
	Error: boolean,
	
	Methods: Methods,
	
	--Methods
	CreateLoader: typeof(
		function<T>(self: Profile<Methods>, Id: string, DefaultData: T, DefaultKey: FileKey?, Locked: boolean?): Loader<T> end
	),
	CreateUpdatingLoader: typeof(
		function<T>(self: Profile<Methods>, Id: string, DefaultData: T, UpdateInterval: number, DefaultKey: FileKey?, Locked: boolean?): Loader<T> end
	),
	Destroy: (self: Profile<Methods>) -> (),
	SetMethods: (self: Profile<Methods>, methods: MethodList) -> (),
	ReadDataBulk: (self: Profile<Methods>, Keys: {FileKey}) -> ({[FileKey]: any}),
	IsFileLoaded: (self: Profile<Methods>, FileKey: FileKey) -> boolean,
	CopyFile: (self: Profile<Methods>, FromKey: FileKey, ToKey: FileKey) -> (),
	DeleteFile: (self: Profile<Methods>, FileKey: FileKey) -> (),
	
	--Signals
	OnDestroying: Signal.Signal<>,
	OnSave: Signal.Signal<>,
}

export type Error = Types.Error
export type PlayerProfiles<Methods> = Types.PlayerProfiles<Methods>
export type MethodMap = Types.MethodMap
export type FileKey = Types.FileKey

--Returns a Store Object using the given StoreName.
function TraditionalSave2.GetStore(StoreName: string, Config: Types.StoreConfig?): Store
	return Store.New(StoreName, Config)
end

return TraditionalSave2