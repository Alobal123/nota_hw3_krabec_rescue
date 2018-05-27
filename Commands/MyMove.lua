--Simple move command which does not keep formation.

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
			{ 
				name = "path",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
		}
	}
end

function euclideanDistance(v1,v2)
	return math.sqrt((v1["x"] - v2["x"])*(v1["x"] - v2["x"]) + (v1["z"] - v2["z"])*(v1["z"] - v2["z"]))
end

running = false

-- speed-ups
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitPosition = Spring.GetUnitPosition

function Run(self, units, parameter)
	local path = parameter.path
	-- pick the spring command implementing the move
	if (not running) then 
		local cmdID = CMD.MOVE
		running = true
		for i=1, #units do
			for j= 1,#path do
				local x,z = (path[j])["x"],(path[j])["z"]
				local thisUnitWantedPosition = Vec3(x,Spring.GetGroundHeight(x,z),z)
				SpringGiveOrderToUnit(units[i], cmdID, thisUnitWantedPosition:AsSpringVector(), {"shift"})
			end
		end
	end
	position = path[#path]
	-- We return success once each unit is close enough to the target location
	for i=1,#units do
		local x,y,z = SpringGetUnitPosition(units[i])
		if (euclideanDistance(Vec3(x,y,z),position) > 100) then
			return RUNNING
		end
	end
	return SUCCESS
end


function Reset(self)
	running = false
end
