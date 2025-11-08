--!strict

--Services
local ServerScriptService = game:GetService("ServerScriptService")

--Modules
local TraditionalSave2 = require(ServerScriptService.Packages.TraditionalSave2)

local store = TraditionalSave2.GetStore("PlayerData", {})

local Profiles = store:ProfileFromPlayers(function(profile, player)
	local loader = profile:CreateLoader("MainLoader", {
		
	})
	
	profile:SetMethods({
		
	})
end)

return Profiles