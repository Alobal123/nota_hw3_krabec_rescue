--Simple move command which does not keep formation.

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
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
			{
				name = "danger",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			
		}
	}
end

running = 0

function Run(self, units, parameter)

	local rescueable = parameter.rescueable
	local safePlace = parameter.safePlace
	local danger = parameter.danger
	running = running + 1
	
	if (running <= #units) then 
		local i = running
		local path = Sensors.nota_hw3_krabec_rescue.FindSafePath(units,rescueable,danger,i,i)
		if path == nil then 
			path = Sensors.nota_hw3_krabec_rescue.FindSafePath(units,rescueable,danger,i,i+20)
		end
		if path ~= nil then
			transport = units[i]
			
			for j=1,#path do
				local x,z = (path[j])["x"],(path[j])["z"]
				Spring.GiveOrderToUnit(transport, CMD.MOVE, Vec3(x,0,z):AsSpringVector(), {"shift"})
			end
			
			Spring.GiveOrderToUnit(transport, CMD.LOAD_UNITS,{rescueable[i]},{"shift"})
			
			for j=#path,1,-1 do
				local x,z = (path[j])["x"]+15,(path[j])["z"]+15
				Spring.GiveOrderToUnit(transport, CMD.MOVE, Vec3(x,0,z):AsSpringVector(), {"shift"})
			end
			
			x,y,z = safePlace["x"],safePlace["y"],safePlace["y"]
			Spring.GiveOrderToUnit(transport, CMD.UNLOAD_UNITS,{x,y,z,250},{"shift"})
		end
	end
	
	return RUNNING

end

function Reset(self)
	running = 0
end
