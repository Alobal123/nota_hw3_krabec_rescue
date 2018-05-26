
local sensorInfo = {
	name = "FindSafePath",
	desc = "Finds safe path given danger map",
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

areaSize = 50
X,Z = Game.mapSizeX , Game.mapSizeZ
function isOnMap(loc)
	return loc['x'] > 0 and loc['x']<= X and loc['z'] > 0 and loc['z']<= Z
end

function getNeighbours(loc)
	local neighs = {}
	for dx=-1,1 do
		for dz = -1,1 do
			vector = Vec3(loc["x"] + dx*areaSize,0,loc["z"] + dz*areaSize)
			if not (dx==0 and dz == 0) and isOnMap(vector)then
				neighs[Vec3(dx,0,dz)] = vector
			end
		end
	end
	return neighs
end

function str(vector)
	return vector["x"]..","..vector["z"]
end

function gridize(vector)
	return Vec3(math.floor(vector["x"]/areaSize)*areaSize, 0, math.floor(vector["z"]/areaSize)*areaSize)
end


-- @description return list of all positions on a map evaluated by their danger
return function(from, to, dangerMap)
	searching = true
	q = {}
	visited = {}
	i = 0
	start = gridize(from)
	goal = gridize(to)
	q[#q+1] = start
	visited[start] = 0

	
	while searching and #q > 0  do
		opened = table.remove(q, 1)
		neighs = getNeighbours(opened)
		
		for _,value in pairs(neighs) do
			if visited[str(value)] == nil then--and dangerMap[value] == 1 then
				q[#q+1] = value
				visited[str(value)] = opened
				if value == goal then
					searching = false
				end
			end
		end
	end
	
	if not searching then
		path = {}
		table.insert(path,1,to)
		local succ = goal
		while true and i < 500 do
			table.insert(path,1,succ)
			succ = visited[str(succ)]
			if succ == start then
				break
			end
		end
		table.insert(path,1,start)
		return path
	end
	return nil

	
end