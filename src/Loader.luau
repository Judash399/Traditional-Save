--!nocheck

local Loader = {}

local Methods = {}
Methods.__index = Methods

--Modules
local Types = require(script.Parent.Types)
local Error = require(script.Parent.Utils.Error)
local Signal = require(script.Parent.Packages.Signal)

function Loader.New<T>(Profile, Id: string, DefaultData: T, DefaultKey: Types.FileKey?, Locked: boolean?)
	local self = setmetatable({}, Methods)
	
	self.Data = nil --We aren't loading into a file yet.
	
	self._ID = Id
	self._Locked = Locked or false
	self._LoadedIntoFile = false
	self._DefaultData = DefaultData
	
	self._BindedObjects = {}
	
	self._Profile = Profile
	
	self.OnLoaded = Signal.new()
	self.OnUnloaded = Signal.new()
	self.OnFileCreated = Signal.new()
	self.OnUnloading = Signal.new()
	self.OnSaving = Signal.new()
	
	if DefaultKey then
		self:LoadInto(DefaultKey)
	end
	
	return self
end

function Methods:GetData()
	if not self._LoadedIntoFile then
		Error("Attempt to read file data from an unloaded loader with ID '" .. self._ID .. "' in the profile with the key '" .. self._Profile._Key .. "'!")
		return
	end
	
	return self.Data
end

	
function Methods:Save(NewData)
	if not self._LoadedIntoFile then
		Error("Attempt to save in an unloaded loader with ID '" .. self._ID .. "' in the profile with the key '" .. self._Profile._Key .. "'!")
		return
	end
	
	if NewData ~= nil then
		self.Data = NewData
	end
	
	self.OnSaving:Fire(self._Key:: Types.FileKey)
	
	self._Profile:_Save()
	return
end
	
function Methods:Unload()
	if self._Locked and self.Data then
		Error(`Attempt to unload when nothing is loaded for Loader '{self._ID}' in profile '{self._Profile._Key}'!`)
	end
	
	self.OnUnloading:Fire(self._Key:: Types.FileKey)
	
	self._LoadedIntoFile = false
	self.Data = nil
	self._Key = nil
	
	--Cleanup all binded objects.
	for i, data in self._BindedObjects do
		if typeof(data.object) == "Instance" then
			data.object:Destroy()
		elseif typeof(data.object) == "RBXScriptConnection" then
			data.object:Disconnect()
		elseif typeof(data.object) == "table" then
			local methodsToAttempt = {
				data.cleanup,
				"Disconnect",
				"Cleanup",
				"Destroy"
			}
			
			for _, methodName in methodsToAttempt do
				local method = data.object[methodName]
				
				if type(method) == "function" then
					pcall(method, data.object)
					break
				end
			end
		elseif typeof(data.object) == "thread" then
			task.cancel(data.object)
		end
	end
	
	table.clear(self._BindedObjects)
	
	self.OnUnloaded:Fire()
end
	
function Methods:IsLoaded()
	return self._LoadedIntoFile
end
	
function Methods:BindTo<O>(object: O, method): O
	local data = {
		object = object,
		cleanup = method
	}
	
	table.insert(self._BindedObjects, data)
	
	return object
end
	
function Methods:LoadInto(Key)
	if self.Data ~= nil then
		Error(`Loader '{self._ID}' in profile '{self._Profile._Key}' is already loaded! Unload it before loading another file.`)
	end
	if self._Locked and self.Data then
		Error(`Cannot load new file! loader '{self._ID}' in profile '{self._Profile._Key}' is locked.`)
	end
	
	--Loading logic would go here.
	
	local data, Isnew = self._Profile:_GetFileData(Key, self._DefaultData)
	
	self._LoadedIntoFile = true
	
	self._Key = Key
	
	self.Data = data
	
	if Isnew then
		self.OnFileCreated:Fire(Key)
	end
	
	self.OnLoaded:Fire(Key)
end
	
function Methods:_Destroy()
	--This complains because the type is not defined with a DisconnectAll() method, likely to hide it from outside scripts. But it does exist, its just hidden.
	self.OnUnloaded:DisconnectAll()
	self.OnLoaded:DisconnectAll()
	self.OnSaving:DisconnectAll()
	self.OnFileCreated:DisconnectAll()
	self.OnUnloading:DisconnectAll()
	
	for index, value in self do
		self[index] = nil
	end
	
	table.freeze(self)
end

return Loader