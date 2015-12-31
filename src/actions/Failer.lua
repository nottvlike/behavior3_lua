require 'b3'
require 'core.Action'

local failer = b3.Class(b3.Action)
b3.Failer = failer

function failer:ctor()
	self.name = "Failer"
end

function failer:tick()
	return b3.SUCCESS
end
