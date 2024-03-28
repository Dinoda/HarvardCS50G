push = require 'push'

Class = require 'class'

require 'const'

require 'Bird'

require 'Pipe'

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local spawnTimer = 0

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Birdy bird')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})

	math.randomseed(os.time())

	bird = Bird()

	pipes = {}

	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	else
		love.keyboard.keysPressed[key] = true
	end
end

function love.keyboard.wasPressed(key) 
	local pressed = love.keyboard.keysPressed[key]

	love.keyboard.keysPressed[key] = false

	return pressed
end

function love.update(dt)
	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
	groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

	spawnTimer = spawnTimer - dt

	if spawnTimer <= 0 then
		table.insert(pipes, Pipe())
		spawnTimer = 1.5 + math.random() * 0.5
	end

	local lost = false

	bird:update(dt)

	for k, pipe in pairs(pipes) do
		pipe:update(dt)

		if pipe.x < -pipe.width then
			table.remove(pipes, k)
		else
			lost = lost or bird:collides(pipe)
		end
	end

	lost = lost or bird:collidesWithFloor()

	if lost then 
		love.event.quit()
	end
end

function love.draw()
	push:start()

	-- Background first
	love.graphics.draw(background, -backgroundScroll, 0)


	for k, pipe in pairs(pipes) do
		pipe:render()
	end

	-- Foreground then
	love.graphics.draw(ground, -groundScroll, GROUND_HEIGHT)

	-- Content
	bird:render()

	push:finish()
end
