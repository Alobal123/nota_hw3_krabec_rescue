--Simple move command which does not keep formation.

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
			{
				name = "paths",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{
				name = "rescueable",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{
				name = "safePlace",
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
firsttarget = false

function Run(self, units, parameter)
	local paths = parameter.paths
	local transports = units
	local rescueable = parameter.rescueable
	local safePlace = parameter.safePlace
	
	if paths == nill then return FAILURE end
	if (not running) then 
		running = true
		for i=1,20 do --#transports do
			local path = paths[i]
			if path~= nil then
				local transport = transports[i]
				local cmdID = CMD.MOVE
				for j= 1, #path do
					local x,z = (path[j])["x"],(path[j])["z"]
					Spring.GiveOrderToUnit(transport, cmdID, Vec3(x,0,z):AsSpringVector(), {"shift"})
				end
				Spring.GiveOrderToUnit(transport, CMD.LOAD_UNITS,{rescueable[i]},{"shift"})
				for j= #path,1,-1 do
					local x,z = (path[j])["x"]+15,(path[j])["z"]+15
					Spring.GiveOrderToUnit(transport, cmdID, Vec3(x,0,z):AsSpringVector(), {"shift"})
				end
				x,y,z = safePlace["x"],safePlace["y"],safePlace["y"]
				Spring.GiveOrderToUnit(transport, CMD.UNLOAD_UNITS,{x,y,z,250},{"shift"})
			end
		end
	end

	--local path = paths[1]
	--local unit = transports[1]
	--local position = path[#path]
	-- We return success once each unit is close enough to the target location

	--if (euclideanDistance(Vec3(SpringGetUnitPosition(unit)),position) < 100) then
		--firsttarget = true
	--end
	--position = path[1]
	--if (firsttarget and euclideanDistance(Vec3(SpringGetUnitPosition(unit)),position) < 100) then
	--	return SUCCESS
	--end
	return RUNNING

end

function Reset(self)
	running = false
end
