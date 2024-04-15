require 'src/gameStates/BaseState'
require 'src/gameStates/StartState'

require 'src/GameMachine'

require 'src/Cell'
require 'src/Grid'

require 'src/visual/Sheet'

require 'src/sheets/Grass'


Game = Class{}

function Game:init()
	self.machine = GameMachine({
		['start'] = function() return StartState() end
	})

	self.pressed = {}
	self.held = {}
end

function Game:start()
	self.machine:change('start')
end

function Game:keyPressed(key)
	self.pressed[key] = true
	self.held[key] = true
end

function Game:keyReleased(key)
	self.held[key] = false
end

function Game:wasPressed(key)
	return self.pressed[key]
end

function Game:isHeld(key)
	return self.held[key]
end

function Game:update(dt)
	if self:wasPressed('escape') then
		love.event.quit()
	end

	self.machine:update(dt)

	self.pressed = {}
end

function Game:render()
	self.machine:render()
end

