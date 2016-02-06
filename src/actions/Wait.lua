require 'core.Action'

local wait = b3.Class("Wait", b3.Action)
b3.Wait = wait

function wait:ctor(settings)
	b3.Action.ctor(self, settings)

	self.name = "Wait"
	self.title = "Wait <milliseconds>ms"
	self.parameters = {milliseconds = 0,}

	settings = settings or {}
end

function wait:tick(tick)
	local currTime = os.time()
	local startTime = tick.blackboard:get("startTime", tick.tree.id, self.id)

	if not startTime or startTime == 0 then
		startTime = currTime
		tick.blackboard:set("startTime", currTime, tick.tree.id, self.id)
	end

	if currTime - startTime > self.endTime then
		return b3.SUCCESS
	end

	return b3.RUNNING
end
