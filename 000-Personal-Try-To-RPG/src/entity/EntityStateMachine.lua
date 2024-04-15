EntityStateMachine = Class{}

function EntityStateMachine:init(states, entity)
	self.entity = entity
	self.states = states
	self.currentName = ""
	self.current = {
		render = function() end,
		update = function(dt) end,
		enter = function(e) end,
		exit = function() end
	}
end

function EntityStateMachine:getStateName()
	return self.currentName
end

function EntityStateMachine:update(dt)
	self.current:update(dt)
end

function EntityStateMachine:render()
	self.current:render()
end

function EntityStateMachine:changeState(name, params)
	print('From "' .. self.currentName .. '" to "' .. name)
	assert(self.states[name], "Unknown state for the entity state machine")
	self.current:exit()
	self.current = self.states[name](self, self.entity)
	self.currentName = name
	self.current:enter(params)
end
