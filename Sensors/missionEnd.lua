-- copied from trello
local sensorInfo = {
	name = "EndMission",
	desc = "ends the mission",
	author = "PepeAmpere",
	date = "2018-05-11",
	license = "notAlicense",
}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

function getInfo()
    return {
        period = 0 -- no caching
    }
end

-- @description ends the mission
return function()
    message.SendRules({
        subject = "CTP_playerTriggeredGameEnd",
        data = {},
    })
end