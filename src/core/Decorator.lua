require 'b3'
require 'core.BaseNode'

local decorator = b3.Class(b3.BaseNode)
b3.Decorator = decorator

function decorator:ctor(params)

	if not params then
		params = {}
	end
	print("decorator:ctor")
	print(params.child)
	self.child = params.child or nil
end

function decorator:initialize(params)

end
