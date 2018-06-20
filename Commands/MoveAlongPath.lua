function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
			{
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{
				name = "path",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},			
			{
				name = "reversed",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			
		}
	}
end

running = false

function Run(self, units, parameter)

	local unit = parameter.unit
	local path = parameter.path
	local reversed = parameter.reversed
		
	if (not running) then 
		running = true
		if path == nil then 
			return FAILURE
		end
		if reversed then
			for j=#path,1,-1 do
				local x,z = (path[j])["x"],(path[j])["z"]
				Spring.GiveOrderToUnit(unit, CMD.MOVE, Vec3(x,0,z):AsSpringVector(), {"shift"})
			end
		else
			for j=1,#path do
				local x,z = (path[j])["x"],(path[j])["z"]
				Spring.GiveOrderToUnit(unit, CMD.MOVE, Vec3(x,0,z):AsSpringVector(), {"shift"})
			end
		end
	end
	if (reversed and Vec3(Spring.GetUnitPosition(unit)):Distance(path[1]) < 250) then
		return SUCCESS
	elseif (not reversed and Vec3(Spring.GetUnitPosition(unit)):Distance(path[#path]) < 250) then
		return SUCCESS
	end
	
	return RUNNING

end

function Reset(self)
	running = false
end
