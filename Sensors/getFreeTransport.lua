local sensorInfo = {
	name = "getFreeTransport",
	desc = "Returns a transport unit which is not busy",
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
return function(safePlace, units)
	
	for i=1,#units do
		value = units[i]
		if Vec3(Spring.GetUnitPosition(value)):Distance(safePlace) < 5000 then -- and Spring.GetUnitVelocity(value) == nil) then
			_,_,_, velocity = Spring.GetUnitVelocity(value)
			--velocity = 0
			if velocity == 0 then
				return value
			end
		end
	end

	return nil
end