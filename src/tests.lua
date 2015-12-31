require 'b3'
require 'core.Action'
require 'core.BaseNode'
require 'core.BehaviorTree'
require 'core.Blackboard'
require 'core.Composite'
require 'core.Condition'
require 'core.Decorator'
require 'core.Decorator'
require 'core.Tick'

require 'actions.Error'
require 'actions.Failer'
require 'actions.Runner'
require 'actions.Succeeder'
require 'actions.Wait'

require 'composites.MemPriority'
require 'composites.MemSequence'
require 'composites.Priority'
require 'composites.Sequence'

require 'decorators.Inverter'
require 'decorators.Limiter'
require 'decorators.MaxTime'
require 'decorators.Repeater'
require 'decorators.RepeatUntilFailure'
require 'decorators.RepeatUntilSuccess'

local action = b3.Action.new()
print(action.category)

local baseNode = b3.BaseNode.new()
print(baseNode.id)
print(baseNode.name)
print(baseNode.title)
print(baseNode.description)
print(baseNode.parameters)
print(baseNode.properties)

local behaviorTree = b3.BehaviorTree.new()
print(behaviorTree.id)
print(behaviorTree.title)
print(behaviorTree.description)
print(behaviorTree.properties)
print(behaviorTree.root)
print(behaviorTree.debug)

local blackBoard = b3.Blackboard.new()
print(blackBoard._baseMemory)
print(blackBoard._treeMemory)

local composite = b3.Composite.new()
print(composite.children)

local condition = b3.Condition.new()

local decorator = b3.Decorator.new()
print(decorator.child)

local tick = b3.Tick.new()
print(tick.tree)
print(tick.debug)
print(tick.target)
print(tick.blackboard)
print(tick._openNodes)
print(tick._nodeCount)

local error = b3.Error.new()
print(error.name)

local failer = b3.Failer.new()
print(failer.name)

local runner = b3.Runner.new()
print(runner.name)

local succeeder = b3.Succeeder.new()
print(succeeder.name)

local wait = b3.Wait.new()
print(wait.name)
print(wait.id)
print(wait.title)
print(wait.description)

local memPriority = b3.MemPriority.new()
print(memPriority.name)

local memSequence = b3.MemSequence.new()
print(memSequence.name)

local priority = b3.Priority.new()
print(priority.name)

local sequence = b3.Sequence.new()
print(sequence.name)
print(sequence.id)
print(sequence.title)

local inverter = b3.Inverter.new()
print(inverter.name)
print(inverter.id)
print(inverter.title)

local maxTime = b3.MaxTime.new()
print(maxTime.name)
print(maxTime.id)

local repeater = b3.Repeater.new()
print(repeater.name)
print(repeater.id)

local repeatUntilFailure = b3.RepeatUntilFailure.new()
print(repeatUntilFailure.name)
print(repeatUntilFailure.id)

local repeatUntilSuccess = b3.RepeatUntilSuccess.new()
print(repeatUntilSuccess.name)
print(repeatUntilSuccess.id)


local behaviorJson = {
	id ='7c63023d-de92-4400-8ebc-1d60d73dea30',
	title = 'A behavior tree',
	description = '',
	root = 'bd9162f8-92ce-47f5-8ba8-021685e8c4b0',
	properties = {},
	nodes = {
	['bd9162f8-92ce-47f5-8ba8-021685e8c4b0'] = {
			id = 'bd9162f8-92ce-47f5-8ba8-021685e8c4b0',
			name = 'Repeater',
			title = 'Repeat <maxLoop>x',
			description = '',
			properties = {
				maxLoop = 5,
			},
			display = {
				x = -264,
				y = -84
			},
			child = '5b38e656-12cd-4402-88e3-c096eb6849ac'
		},
	['5b38e656-12cd-4402-88e3-c096eb6849ac'] = {
		id = '5b38e656-12cd-4402-88e3-c096eb6849ac',
		name = 'Sequence',
		title = 'Sequence',
		description = '',
		properties = {},
		display = {
			x = -120,
			y = -84
		},
		children = {
			'902870e9-84ad-451d-884b-07557346ca93',
			'32d0c734-b9d0-4db2-8170-7ba13df98d96'
		}
	},
	['902870e9-84ad-451d-884b-07557346ca93'] = {
	id = '902870e9-84ad-451d-884b-07557346ca93',
		name = 'Failer',
		title = 'Failer',
		description = '',
		properties = {},
		display = {
			x = 192,
			y = -60
		}
	},
	['32d0c734-b9d0-4db2-8170-7ba13df98d96'] = {
		id = '32d0c734-b9d0-4db2-8170-7ba13df98d96',
		name = 'Succeeder',
		title = 'Succeeder',
		description = '',
		properties = {},
		display = {
			x = 168,
			y = 24
		}
	}
},
	display = {
		camera_x = 960,
		camera_y = 477.5,
		camera_z = 1,
		x = -396,
		y = -84},
	custom_nodes = {}
}
print("------------------------------------------------")
behaviorTree:load(behaviorJson, {})
print("------------------------------------------------")
behaviorTree:tick(nil, blackBoard)
