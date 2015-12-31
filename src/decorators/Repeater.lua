require "b3"
require "core.Decorator"

local repeater = b3.Class(b3.Decorator)
b3.Repeater = repeater

function repeater:ctor(params)
	if not params then
		params = {}
	end

	print("================================================")
	print(params)
	for i,v in pairs(params) do
		print(i,v)
	end
	print("================================================")

	self.name = "Repeater"
	self.title = "Repeater <maxLoop>x"
	self.parameters = {maxLoop = -1}

	self.maxLoop = params.maxLoop or -1
end

function repeater:initialize(params)

end

function repeater:open(tick)
	print("================================================")
	print("open")
	print("================================================")

	tick.blackboard:set("i", 0, tick.tree.id, self.id)
end

function repeater:tick(tick)
	if not self.child then
		return b3.ERROR
	end

	local i = tick.blackboard:get("i", tick.tree.id , self.id)
	local status = b3.SUCCESS

	while(self.maxLoop < 0 or i < self.maxLoop)
	do
		local status = self.child:_execute(tick)
		if status == b3.SUCCESS or status == b3.FAILURE then
			i = i + 1
		else
			break
		end
	end

	i = tick.blackboard:set("i", i, tick.tree.id, self.id)
	return status
end
