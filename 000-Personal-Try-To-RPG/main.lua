require 'src/const' 

Class = require 'lib/class'

require 'src/visual/Image'
require 'src/visual/Sheet'

require 'src/StateMachine'
require 'src/entity'
require 'src/level/Level'

require 'src/globals'

function love.load()
	math.randomseed(os.time())

	love.window.setTitle('RPGTry')

	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})

	gameMachine = StateMachine({
		['start'] = function() return StartState() end,
		['levelSelect'] = function() return LevelSelectState() end,
		['level'] = function() return LevelState() end,
		['move'] = function() return MoveState() end,
	})

	gameMachine:changeState('start')

	love.keyboard.pressedKeys = {}
	love.keyboard.holdKeys = {}
end

function love.keypressed(key)
	love.keyboard.pressedKeys[key] = true
	love.keyboard.holdKeys[key] = true

	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyreleased(key)
	love.keyboard.holdKeys[key] = false
end

function love.update(dt)
	gameMachine:update(dt)

	love.keyboard.pressedKeys = {}
end

function love.draw()
	gameMachine:render()
end
