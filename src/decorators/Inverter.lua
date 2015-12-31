require 'b3'
require 'core.Decorator'

local inverter = b3.Class(b3.Decorator)
b3.Inverter = inverter

function inverter:ctor()
	self.name = "Inverter"
end

function inverter:tick(tick)
	if not self.child then
		return b3.ERROR
	end

	local status = self.child:_execute(tick)

	if status == b3.SUCCESS then
		status = b3.FAILURE
	elseif status == b3.FAILURE then
		status = b3.SUCCESS
	end

	return status
end
