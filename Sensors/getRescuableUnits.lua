local sensorInfo = {
	name = "getRescuableUnits",
	desc = "Returns table of all rescuable units on the map",
	author = "Krabec",
	date = "2018-05-27",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 10000

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


function euclideanDistance(v1,v2)
	return math.sqrt((v1["x"] - v2["x"])*(v1["x"] - v2["x"]) + (v1["z"] - v2["z"])*(v1["z"] - v2["z"]))
end


-- @description return list of all positions on a map evaluated by their danger
return function()

	local allies = Spring.GetTeamUnits(0)
	local rescuable = {}
	for key,value in pairs(allies) do

	end

	return spots
end