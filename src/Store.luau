--!strict

--Services
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--Modules
local Types = require(script.Parent.Types)
local ConfigDefaults = require(script.ConfigDefaults)
local Profile = require(script.Parent.Profile)
local Signal = require(script.Parent.Packages.Signal)
local PlayerProfiles = require(script.Parent.PlayerProfiles)

local module = {}

function module.New(storeName: string, config: Types.StoreConfig?): Types.Store
	local config = config or {}:: Types.StoreConfig
	for key: any, value: any in ConfigDefaults do
		if config[key] == nil then
			config[key] = value
		end
	end
	
	local self = {}:: Types.HiddenStore
	
	self.Config = config
	self.StoreName = storeName
	self._Profiles = {}
	self._DataStore = DataStoreService:GetDataStore(storeName, if not config.SeperateStudioData then nil elseif RunService:IsStudio() then "Studio" else "Live")
	
	
	self.OnProfileAdded = Signal.new()
	self.OnProfileRemoving = Signal.new()
	self.OnProfileCreated = Signal.new()
	
	local function Save(Key: string, NewData: any): boolean
		local attemptCount = 0
		repeat
			local success, data = pcall(function()
				return self._DataStore:SetAsync(Key, NewData)
			end)
			
			if success then
				return true
			end
			
			attemptCount += 1
		until attemptCount > self.Config.SaveGetAttemptCount:: number
		
		return false
	end
	
	local function Get(Key: string): (boolean, any?)
		local attemptCount = 0
		repeat
			local success, data = pcall(function()
				return self._DataStore:GetAsync(Key)
			end)

			if success then
				return true, data
			end

			attemptCount += 1
		until attemptCount > self.Config.SaveGetAttemptCount:: number

		return false, nil
	end
	
	--Update datastore loop
	task.spawn(function()
		while true do
			task.wait(config.UpdateInterval)
			
			for _, profile in self._Profiles do
				if profile._ReadyToSave == true or os.difftime(profile._LastSaveTime, os.time()) >= self.Config.TimestampUpdateInterval:: number then
					Save(tostring(profile._Key), profile._DataToSave)
					profile._ReadyToSave = false
				end
			end
		end
	end)
	
	
	function self.ProfileFromPlayers(self, callback)
		local self = self:: Types.HiddenStore
		
		return PlayerProfiles.New(self, callback):: Types.PlayerProfiles<any>
	end
	
	function self:NewPlayerProfile(player: Player)
		return self:NewProfile(player.UserId)
	end
	
	function self:NewProfile(key: Types.Key)
		local self = self:: Types.HiddenStore
		
		local profile, isNew = Profile.New(self, key)
		
		if not profile.Error then
			local profile = profile:: Types.HiddenProfile
			
			table.insert(self._Profiles, profile)
			
			if isNew then
				self.OnProfileCreated:Fire(profile)
			end

			self.OnProfileAdded:Fire(profile)
			
			profile.OnDestroying:Once(function()
				self.OnProfileRemoving:Fire(profile)
			end)
		end
		
		return profile
	end
	
	function self:_GetDataStoreData(StoreKey)
		local self = self:: Types.HiddenStore
		
		local success, data = Get(tostring(StoreKey))
		
		if success == false then
			return success, {
				Error = true,
				Reason = "Failed to get DataStore key. DataStores may be down!"
			}
		else
			return success, data
		end
	end
	
	function self:_SaveImmediate(Profile: Types.HiddenProfile)
		return Save(tostring(Profile._Key), Profile._DataToSave)
	end
	
	return self
end

return module