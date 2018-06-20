-- This command loads all units in area nearby position, in radius 
local testBuildOrder = Spring.TestBuildOrder
local giveOrderToUnit = Spring.GiveOrderToUnit

function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
					{ 
				name = "transport",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",

			},
			{ 
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "100",
			}
		
		}

	}
end
running = false
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

function Run(self, units, parameter)

	local transport = parameter.transport
	local unit = parameter.unit
	if not running then
		running = true
		local cmdID = CMD.LOAD_UNITS
		SpringGiveOrderToUnit(transport, cmdID,{unit},{})
	end
	if Spring.GetUnitIsTransporting(transport)[1] ~= nil then
		return SUCCESS
	end
	return RUNNING
end

function Reset(self)
	running = false
end
