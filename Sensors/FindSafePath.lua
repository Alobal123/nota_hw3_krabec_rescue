List = {}
function List.new ()
  return {first = 0, last = -1}
end

function List.pushright (list, value)
  local last = list.last + 1
  list.last = last
  list[last] = value
end

function List.popleft (list)
  local first = list.first
  if first > list.last then error("list is empty") end
  local value = list[first]
  list[first] = nil        -- to allow garbage collection
  list.first = first + 1
  return value
end

function List.isEmpty(list)
	return not (list.first > list.last)
end

function reverse(tbl)
  for i=1, math.floor(#tbl / 2) do
    tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]
  end
end

local sensorInfo = {
	name = "FindSafePath",
	desc = "Finds safe path given danger map",
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

areaSize = 100
X,Z = Game.mapSizeX , Game.mapSizeZ
function isOnMap(loc)
	return loc['x'] >= 0 and loc['x']<= X and loc['z'] >= 0 and loc['z']<= Z
end


function getNeighbours(loc)
	local neighs = {}
	for dx=-1,1 do
		vector = Vec3(loc["x"] + dx*areaSize,0,loc["z"])
		if dx~=0 and isOnMap(vector)then
			neighs[Vec3(dx,0,dz)] = vector
		end
	end
	for dz = -1,1 do 
		vector = Vec3(loc["x"],0,loc["z"] + dz*areaSize)
		if dz ~= 0 and isOnMap(vector)then
			neighs[Vec3(dx,0,dz)] = vector
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

function dfs(from, to, dangerMap)
	local searching = true
	local q = List.new()
	local visited = {}
	local start = gridize(from)
	local goal = gridize(to)
	List.pushright(q,start)
	visited[str(start)] = 0
	
	while searching and List.isEmpty(q) do
		opened = List.popleft(q)
		neighs = getNeighbours(opened)
		for _,value in pairs(neighs) do
			if visited[str(value)] == nil and dangerMap[str(value)] == 1 then
				List.pushright(q,value)
				visited[str(value)] = opened
				if value == goal then
					searching = false
				end
			end
		end
	end
	
	
	
	index = 1
	if not searching then
		local path = {}
		path[index] = to
		local succ = goal
		while true do
			index = index+1
			path[index] = succ
			succ = visited[str(succ)]
			if succ == start then
				break
			end
		end
		index = index+1
		path[index] = start
		reverse(path)
		return path
	end
	return nil
end

-- @description return list of all positions on a map evaluated by their danger
return function(transports,rescuable,dangerMap, i, j)

	if #rescuable<i or #transports<j then return nil end
	
	local path = dfs(Vec3(Spring.GetUnitPosition(transports[i])),Vec3(Spring.GetUnitPosition(rescuable[j])),dangerMap)
	
	return path
end