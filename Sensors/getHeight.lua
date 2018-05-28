local sensorInfo = {
	name = "getHeight",
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

return function(position)

	x = position['x']
	z = position['z']

			

	
	return Spring.GetGroundHeight(x,z)
end