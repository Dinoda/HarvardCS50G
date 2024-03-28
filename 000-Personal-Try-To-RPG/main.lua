require 'const' 

Class = require 'class'

require 'StateMachine'
require 'states/BaseState'
require 'states/StartState'
require 'states/LevelSelectState'
require 'states/MoveState'

require 'entity'

gDirectionToYSpeed = {
	[0] = 1,
	[1] = -1,
	[2] = 0,
	[3] = 0
}

gDirectionToXSpeed = {
	[0] = 0,
	[1] = 0,
	[2] = 1,
	[3] = -1
}

gButtonToDirection = {
	['down'] = 0,
	['up'] = 1,
	['right'] = 2,
	['left'] = 3
}

gPlayerOutfits = {
	[0] = 'assets/char_a_p1/1out/char_a_p1_1out_boxr_v01.png',
	[1] = 'assets/char_a_p1/1out/char_a_p1_1out_fstr_v04.png',
	[2] = 'assets/char_a_p1/1out/char_a_p1_1out_pfpn_v04.png',
	[3] = 'assets/char_a_p1/1out/char_a_p1_1out_undi_v01.png'
}

gPlayerCurrentOutfit = 0

gPlayerModel = Model('assets/char_a_p1/char_a_p1_0bas_humn_v01.png')

gPlayerModel:append(gPlayerOutfits[0])

gPlayerCharacter = Character(gPlayerModel)

gMenuFont = love.graphics.newFont('assets/Roboto-Medium.ttf', 20)

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
