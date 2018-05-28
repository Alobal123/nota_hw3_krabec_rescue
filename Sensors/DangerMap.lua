local sensorInfo = {
	name = "DangerMap",
	desc = "Finds out the danger level across the map",
	author = "Krabec",
	date = "2018-05-25",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 10000

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end
function str(vector)
	return vector["x"]..","..vector["z"]
end

function euclideanDistance(v1,v2)
	return math.sqrt((v1["x"] - v2["x"])*(v1["x"] - v2["x"]) + (v1["z"] - v2["z"])*(v1["z"] - v2["z"]))
end


-- @description return list of all positions on a map evaluated by their danger
return function()
	local X,Z = Game.mapSizeX , Game.mapSizeZ
	local areaSize = 100
	X,Z = math.floor(X/areaSize), math.floor(Z/areaSize)
	local spots = {}
	
	for j=0, Z do
		for i=0, X do
			x = i*areaSize
			z = j*areaSize
			loc = Vec3(x,0,z)
			spots[str(loc)] = 1
		end
	end
	
	local enemies = Spring.GetTeamUnits(1)
	for key,value in pairs(enemies) do
		loc = Vec3(Spring.GetUnitPosition(value))
		x = math.floor(loc["x"]/areaSize)
		z = math.floor(loc["z"]/areaSize)
		for i=-8,8 do
			for j =-8,8 do
				spots[str(Vec3((x+i)*areaSize,0,(z+j)*areaSize))] = 0
			end
		end
	end
	
	for j=0, Z do
		for i=0, X do
			x = i*areaSize
			z = j*areaSize
			y = Spring.GetGroundHeight(x,z)
			loc = Vec3(x,0,z)
			if (y < 100) then
				spots[str(loc)] = 1
			end
		end
	end

	
	return spots
end