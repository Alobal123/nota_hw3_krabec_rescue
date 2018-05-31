local sensorInfo = {
	name = "getUnitPosition",
	desc = "gets the position of given unit",
	author = "Krabec",
	date = "2018-05-25",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1
function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(unitId)
	return Vec3(Spring.GetUnitPosition(unitId))
end