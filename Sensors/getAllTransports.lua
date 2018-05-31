local sensorInfo = {
	name = "getAllTransports",
	desc = "Returns table of all allied flying transports",
	author = "Krabec",
	date = "2018-05-27",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description Returns table of all allied flying transports
return function()

	local allies = Spring.GetTeamUnits(0)
	local rescuable = {}
	local index = 1
	for _,value in pairs(allies) do
		defID = Spring.GetUnitDefID(value)
		if (UnitDefs[defID].transportCapacity > 0 and UnitDefs[defID].canFly) then
			rescuable[index] = value	
			index = index + 1
		end
	end

	return rescuable
end