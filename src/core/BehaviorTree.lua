require 'b3'
require 'core.Tick'

local behaviorTree = b3.Class()
b3.BehaviorTree = behaviorTree

function behaviorTree:ctor()
	self.id 			= b3.createUUID()
	self.title 			= "The behavior tree"
	self.description 	= "Default description"
	self.properties 	= {}
	self.root			= nil
	self.debug			= nil
end

function behaviorTree:initialize()

end

function behaviorTree:load(data, names)
	names = names or {}

	self.title 			= data.title or self.title
	self.description 	= data.description or self.description
	self.properties 	= data.properties or self.properties

	local nodes = {}
	local id, spec, node

	for i,v in pairs(data.nodes) do
		id = i
		spec = v
		local Cls

		if names[spec.name] then
			Cls = names[spec.name]
		elseif b3[spec.name] then
			Cls = b3[spec.name]
		else
			print("Error : BehaviorTree.load : Invalid node name + " .. spec.name .. ".")
		end
		node = Cls.new(spec.properties)
		node.id = spec.id or node.id
		node.title = spec.title or node.title
		node.description = spec.description or node.description
		node.properties = spec.properties or node.proerties

		nodes[id] = node
	end

	for i,v in pairs(data.nodes) do
		id = i
		spec = v
		node = nodes[id]
		print(i,v)
		if v.child then
			node.child = nodes[v.child]
		end

		if v.children then
			for i = 1,table.getn(v.children) do
				local cid = spec.children[i]
				print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{")
				print(spec.children[i],nodes[cid])
				table.insert(node.children, nodes[cid])
			end
		end
	end

	self.root = nodes[data.root]
	print(self.root.name)
end

function behaviorTree:dump()
	local data = {}
	local customNames = {}

	data.title 			= self.title
	data.description 	= self.description
	if self.root then
		data.root		= self.root.id
	else
		data.root		= nil
	end
	data.properties		= self.properties
	data.nodes 			= {}
	data.custom_nodes	= {}

	if self.root then
		return data
	end

	--TODO:
end

function behaviorTree:tick(target, blackboard)
	if not blackboard then
		print("The blackboard parameter is obligatory and must be an instance of b3.Blackboard")
	end

	local tick = b3.Tick.new()
	tick.debug 		= self.debug
	tick.target		= target
	tick.blackboard = blackboard
	tick.tree 		= self

	--TICK NODE
	local state = self.root:_execute(tick)

	--CLOSE NODES FROM LAST TICK, IF NEEDED
	local lastOpenNodes = blackboard:get("openNodes", self.id)
	local currOpenNodes = tick._openNodes[0]
	if not lastOpenNodes then
		lastOpenNodes = {}
	end

	if not currOpenNodes then
		currOpenNodes = {}
	end

	local start = 0
	local i
	for i = 0,math.min(table.getn(lastOpenNodes), table.getn(currOpenNodes)) do
		start = i + 1
		if lastOpenNodes[i] ~= currOpenNodes[i] then
			break
		end
	end

	for i = table.getn(lastOpenNodes),0,-1 do
		if lastOpenNodes[i] then
			lastOpenNodes[i]:_close(tick)
		end
	end

	blackboard:set("openNodes", currOpenNodes, self.id)
	blackboard:set("nodeCount", tick._nodeCount, self.id)
end
