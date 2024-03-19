--[[
  GD50 Personal trial aligned with Pong 
]]

require 'const'

Class = require 'class'

require 'Cell'
require 'Entity'
require 'Board'

function love.load()
	math.randomseed(os.time())

	board = Board()

	myFont = love.graphics.newFont('font.ttf', TEXT_HEIGHT)

	love.graphics.setFont(myFont)

	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})

	love.window.setTitle('Escape THEM !!')
end

function love.update(dt)
	board:update(dt)
end

function love.draw()
	love.graphics.clear(190/255, 45/255, 200/255, 1)

	love.graphics.setColor(0, 0, 0)

	love.graphics.printf(
		'Escape THEM !!',
		0,
		6,
		WINDOW_WIDTH,
		'center'
	)

	board:render()

	displayFPS()
end

function love.keypressed(key) 
	if key == 'escape' then
		love.event.quit()
	end
end

function displayFPS()
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

