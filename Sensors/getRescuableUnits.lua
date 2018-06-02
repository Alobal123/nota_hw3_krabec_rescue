local sensorInfo = {
	name = "getRescuableUnits",
	desc = "Returns table of all rescuable units on the map",
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

-- @description return table of all transportable allied units
return function(safePlace)
	
	local allies = Spring.GetTeamUnits(0)
	local rescuable = {}
	local index = 1
	for _,value in pairs(allies) do
		defID = Spring.GetUnitDefID(value)
		if not UnitDefs[defID].cantBeTransported  then
			if Vec3(Spring.GetUnitPosition(value)):Distance(safePlace) > 500 then
				rescuable[index] = value
				index = index + 1
			end
		end
	end

	return rescuable
end