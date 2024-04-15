require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/LevelSelectState'
require 'src/states/LevelState'
require 'src/states/MoveState'

StateMachine = Class{}

function StateMachine:init(states)
	self.states = states
	self.current = {
		render = function() end,
		update = function(dt) end,
		enter = function() end,
		exit = function() end
	}
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:render()
	self.current:render()
end

function StateMachine:changeState(name, options)
	assert(self.states[name], "Unknown state for the machine")
	self.current:exit()
	self.current = self.states[name]()
	self.current:enter(options)
end
