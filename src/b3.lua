_class = {}

b3 = {
	VERSION = "0.2.0",

	--Returning status
	SUCCESS = 1,
	FAILURE = 2,
	RUNNING = 3,
	ERROR 	= 4,

	--Node categories
	COMPOSITE = "composite",
	DECORATOR = "decorator",
	ACTION = "action",
	CONDITION = "condition",

	createUUID = function()
		local seed = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'}
		local tb = {}
		for i =1,32 do
			table.insert(tb, seed[math.random(1,16)])
		end
		return  table.concat(tb)
		-- local sid = table.concat(tb)
		-- return string.format("%s%s%s%s%s",
		-- 	string.sub(sid, 1, 8),
		-- 	string.sub(sid, 9, 12),
		-- 	string.sub(sid, 13, 16),
		-- 	string.sub(sid, 17, 20),
		-- 	string.sub(sid, 21, 32)
		-- )
	end,

	Class = function(super)
		local classType = {}
		classType.ctor = false
		classType.super = super
		classType.new = function(...)
			local obj = {}
			local create
			create = function(c, ...)
				if c.super then
					create(c.super, ...)
				end

				if c.ctor then
					c.ctor(c, ...)
				end
			end
			create(classType, ...)
			setmetatable(obj, {__index = _class[classType]})
			return obj
		end

		local vtbl = {}
		_class[classType] = vtbl

		setmetatable(classType, {__newindex=function(t, k, v)
			vtbl[k] = v
		end})

		if super then
			setmetatable(vtbl, {__index= function(t, k)
				local ret = _class[super][k]
				--vtbl[k] = ret
				return ret
			end
			})
		end

		return classType

	end,
}
