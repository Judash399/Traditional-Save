--!nocheck

--Services
local Players = game:GetService("Players")

--Modules
local Types = require(script.Parent.Types)
local Error = require(script.Parent.Utils.Error)
local Signal = require(script.Parent.Packages.Signal)

local PlayerProfiles = {}

function PlayerProfiles.New(Store, callback)
	local callback = callback
	
	local self = setmetatable({})
	
	self.Profiles = {}
	
	self.OnPlayerAdded = Signal.new()
	self.OnPlayerRemoving = Signal.new()
	
	Players.PlayerAdded:Connect(function(player)
		local profile = Store:NewPlayerProfile(player)

		if profile.Error == true then
			local profile = profile:: Types.Error

			player:Kick(profile.Reason)
			return
		end

		callback(profile, player)

		self.Profiles[player] = profile
		
		self.OnPlayerAdded:Fire(profile, player)

		local connection: RBXScriptConnection
		connection = Players.PlayerRemoving:Connect(function(other)
			if other == player then
				self.OnPlayerRemoving:Fire(profile, player)
				
				connection:Disconnect()
				profile:Destroy()
				self.Profiles[player] = nil
			end
		end)
	end)
	
	return self
end

return PlayerProfiles