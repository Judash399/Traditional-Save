--!nocheck

local Profile = {}

local Methods = {}
Methods.__index = Methods

--Modules
local Types = require(script.Parent.Types)
local Loader = require(script.Parent.Loader)
local Signal = require(script.Parent.Modules.Packages.Signal)
local DeepCopy = require(script.Parent.Modules.Packages.DeepCopy)
local Error = require(script.Parent.Modules.Utils.Error)

function Profile.New(Store, Key: Types.Key): (Types.Profile<{}> | Types.Error, boolean?)
	local self = setmetatable({}, Methods)
	
	self.Methods = {}
	
	self._Loaders = {}

	self._Store = Store
	self._Key = Key
	
	self.Error = false --This is to make strict mode testing for errors simplier.
	self._ReadyToSave = false
	self._LastSaveTime = os.time()
	
	self.OnDestroying = Signal.new()
	self.OnSave = Signal.new()
	
	--Read the data from the key.
	local success: boolean
	success, self._DataStoreData = self._Store:_GetDataStoreData(Key)

	if not success then
		return self._DataStoreData
	end

	local newProfile = false
	if not self._DataStoreData then
		self._DataStoreData = {
			Meta = {
				ActiveSession = false,
				LastTimeSave = os.time(),
				Version = require(script.Parent.Modules.Utils.Version)
			},
			Files = {}
		}
		newProfile = true
	end

	local meta = self._DataStoreData.Meta:: Types.StoreMeta
	
	if meta.ActiveSession == true and os.difftime(meta.LastTimeSave, os.time()) < self._Store.Config.IgnoreLockTime:: number then
		return {
			Error = true,
			Reason = "An Active session already exists for this key!"
		}
	end

	if not self._Store.Config.LockingInStudio then
		meta.ActiveSession = true
	end

	self._DataToSave = self._DataStoreData
	
	local success = self._Store:_SaveImmediate(self)

	if not success then
		return {
			Error = true,
			Reason = "Failed to lock profile's key on the DataStore! DataStore service may be down!"
		}
	end
	
	return self, newProfile
end

function Methods:CreateLoader<T>(Id: string, defaultData: T, defaultKey: Types.FileKey?, locked: boolean?)
	local loader = Loader.New(self, Id, defaultData, defaultKey, locked)
	
	table.insert(self._Loaders, loader)
	
	return loader
end

function Methods:CreateUpdatingLoader<T>(Id: string, defaultData: T, updateInterval: number, defaultKey: Types.FileKey?, locked: boolean?)
	local loader = Loader.New(self, Id, defaultData, defaultKey, locked)
	
	table.insert(self._Loaders, loader)
	
	task.defer(function()
		while loader do
			if loader:IsLoaded() then
				loader:Save(loader.Data)
			end
			task.wait(updateInterval)
		end
	end)

	return loader
end

function Methods:Destroy()
	self.OnDestroying:Fire()
	
	self._DataStoreData.Meta.ActiveSession = false
	
	self._Store:_SaveImmediate(self)
	
	--This complains because the type is not defined with a DisconnectAll() method, likely to hide it from outside scripts. But it does exist, its just hidden.
	self.OnSave:DisconnectAll()
	self.OnDestroying:DisconnectAll()

	--Cleanup the loaders
	for _, loader in pairs(self._Loaders) do
		local loader = loader
		
		loader:_Destroy()
	end

	local profiles = self._Store._Profiles
	
	local key = table.find(profiles, self)
	
	if key then
		self._Store._Profiles[key] = nil
	end
	
	for index, value in pairs(self) do
		self[index] = nil
	end
	
	table.freeze(self)
end

function Methods:IsFileLoaded(FileKey: Types.FileKey)
	for _, loader in self._Loaders do
		local loader = loader
		
		if loader._Key == FileKey then
			return true
		end
	end
	
	return false
end
	
function Methods:CopyFile(FromKey: Types.FileKey, ToKey: Types.FileKey)
	if self:IsFileLoaded(FromKey) then
		Error("Cannot copy from file with key: '" .. tostring(FromKey) .. "' because it is currently loaded! Ensure both the source and destination files are not loaded before copying.")
	end
	
	if self._DataStoreData.Files[FromKey] == nil then
		Error("Cannot copy from file with key: '" .. tostring(FromKey) .. "' because it is an empty file!")
	end
	
	if self:IsFileLoaded(ToKey) then
		Error("Cannot copy to file with key: '" .. tostring(ToKey) .. "' because it is currently loaded! Ensure both the source and destination files are not loaded before copying.")
	end
	
	self._DataStoreData.Files[ToKey] = DeepCopy(self._DataStoreData.Files[FromKey])
end
	
function Methods:DeleteFile(FileKey: Types.FileKey)
	if self:IsFileLoaded(FileKey) then
		Error("Cannot delete file with key: '" .. tostring(FileKey) .. "' because it is currently loaded! Ensure the target file isnt loaded when deleting.")
	end
	
	self._DataStoreData.Files[FileKey] = nil
end
	
function Methods:SetMethods(methods)
	self.Methods = methods
end

function Methods:_GetFileData(fileKey: Types.FileKey, defaultData: any)
	local data = self._DataStoreData.Files[fileKey]
	
	local new = false
	
	if not data then
		if type(defaultData) == "table" then
			data = table.clone(defaultData)
		else
			data = defaultData
		end
		
		self._DataStoreData.Files[fileKey] = data
		
		new = true
	end
	
	if type(data) == "table" then
		--Defaults logic if this is a table.
		for i, value in defaultData do
			if not data[i] then
				data[i] = value
			end
		end
	end
	
	return data, new
end
	
function Methods:_Save()
	self.OnSave:Fire()
	
	self._DataToSave = self._DataStoreData
	self._LastSaveTime = os.time()
	self._ReadyToSave = true
end
	
function Methods:ReadDataBulk(Keys)
	local FinalData = {}
	
	for _, key in ipairs(Keys) do
		local data = self._DataStoreData.Files[key]
		
		if data then
			FinalData[key] = DeepCopy(self._DataStoreData.Files[key]) --You may think to use :GetFileData(), but that creates new files if they already exist. All this needs to do is return the data for all the given files.
		end
	end
	
	return FinalData
end

return Profile