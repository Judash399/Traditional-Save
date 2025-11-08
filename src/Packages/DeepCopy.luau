--!nocheck

--A deep clone function taken from the roblox documentation.
function deepClone(original)
	local clone = table.clone(original) 

	for key, value in original do
		if type(value) == "table" then
			clone[key] = deepClone(value)
		end
	end

	return clone
end

return deepClone