require 'b3'
require 'core.Action'

local wait = b3.Class(b3.Action)
b3.Wait = wait

function wait:ctor(settings)
	self.name = "Wait"
	self.title = "Wait <milliseconds>ms"
	self.parameters = {milliseconds = 0,}

	settings = settings or {}
end

function wait:initialize()

end

function wait:open(tick)
	local startTime = os.time()
	tick.blackboard.set("startTime", startTime, tick.tree.id, self.id)
end

function wait:tick(tick)
	local currTime = os.time()
	local startTime = tick.blackboard.get("startTime", tick.tree.id, self.id)

	if currTime - startTime > self.endTime then
		return b3.SUCCESS
	end

	return b3.RUNNING
end
