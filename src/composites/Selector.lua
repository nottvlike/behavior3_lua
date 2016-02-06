require 'Script.Behavior.core.Composite'

local selector = b3.Class("Selector", b3.Composite)
b3.Selector = selector

function selector:ctor()
	b3.Composite.ctor(self)
	
	self.name = "Selector"
end

function selector:tick(tick)
	for i = 1,table.getn(self.children) do
		local v = self.children[i]
		local status = v:_execute(tick)
	end
end
