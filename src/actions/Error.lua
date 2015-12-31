require 'b3'
require 'core.Action'

local error = b3.Class(b3.Action)
b3.Error = error

function error:ctor()
	self.name = "Error"
end

function error:tick()
	return b3.ERROR
end
