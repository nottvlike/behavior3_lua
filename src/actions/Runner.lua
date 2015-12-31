require 'b3'
require 'core.Action'

local runner = b3.Class(b3.Action)
b3.Runner = runner

function runner:ctor()
	self.name = "Runner"
end

function runner:tick(tick)
	return b3.RUNNING
end