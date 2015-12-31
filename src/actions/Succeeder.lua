require 'b3'
require 'core.Action'

local succeeder = b3.Class(b3.Action)
b3.Succeeder = succeeder

function succeeder:ctor()
	self.name = "Succeeder"
end

function succeeder:tick(tick)
	return b3.SUCCESS
end