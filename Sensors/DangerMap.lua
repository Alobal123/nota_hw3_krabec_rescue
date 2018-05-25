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


function euclideanDistance(v1,v2)
	return math.sqrt((v1["x"] - v2["x"])*(v1["x"] - v2["x"]) + (v1["z"] - v2["z"])*(v1["z"] - v2["z"]))

end


-- @description return list of all positions on a map evaluated by their danger
return function()
	local X,Z = Game.mapSizeX , Game.mapSizeZ
	local areaSize = 500
	X,Z = math.floor(X/areaSize), math.floor(Z/areaSize)
	local spots = {}
	
	for j=0, Z do
		for i=0, X do
			x = i*areaSize
			z = j*areaSize
			y = Spring.GetGroundHeight(x,z)
			if (y < 200) then
				spots[Vec3(x,0,z)] = 1
			end
			else 
				spots[Vec3(x,0,z)] = 0
			end
		end
	end
	return spots
	
end