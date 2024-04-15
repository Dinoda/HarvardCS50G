require 'src/const'

Class = require 'lib/class'

require 'src/Game'

game = Game()

function love.load()
	math.randomseed(os.time())

	love.window.setTitle('GTS')

	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})

	game:start()
end

function love.update(dt)
	game:update(dt)
end

function love.keypressed(key) 
	game:keyPressed(key)
end

function love.keyreleased(key) 
	game:keyReleased(key)
end

function love.draw()
	game:render()
end

