require 'b3'
require 'core.BaseNode'

local action = b3.Class(b3.BaseNode)
b3.Action = action

function action:ctor()
	self.category = b3.ACTION
end

function action:initialize(params)

end
