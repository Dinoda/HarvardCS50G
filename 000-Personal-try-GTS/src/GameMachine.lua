GameMachine = Class{}

function GameMachine:init(states) 
	self.states = states
	self.current = {
		exit = function () end
	}
end

function GameMachine:change(name, params) 
	assert(self.states[name])
	self.current:exit()
	self.current = self.states[name]()
	self.current:enter(params)
end

function GameMachine:update(dt)
	self.current:update(dt)
end

function GameMachine:render()
	self.current:render()
end
