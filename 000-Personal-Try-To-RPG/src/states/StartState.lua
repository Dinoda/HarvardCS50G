StartState = Class{__includes = BaseState}

function StartState:init()
	self.char = gPlayerCharacter
	self.t = 0
end

function StartState:enter()
	-- Position in the middle of the window horizontally
	self.char:setX(WINDOW_WIDTH / 2 - self.char:getModel():getWidth() * 6)
	-- Position in the middle of the window vertically
	self.char:setY(WINDOW_HEIGHT / 2 - self.char:getModel():getHeight() * 2)
	-- Set char to double side
	self.char:setScale(4)

	self.titleImage = Image('assets/menu/TTRPG_title.png')
end

function StartState:update(dt)
	for key, value in pairs(gButtonToDirection) do
		if love.keyboard.pressedKeys[key] then
			self.char:setDirection(value)
		end
	end

	if love.keyboard.pressedKeys['return'] then
		gameMachine:changeState('levelSelect')	
	end

	if love.keyboard.pressedKeys['a'] then
		local model = self.char:getModel()
		model:clear()
		gPlayerCurrentOutfit = (gPlayerCurrentOutfit + 1) % 4
		model:append(gPlayerOutfits[gPlayerCurrentOutfit])
		model:update(model.x / MODEL_WIDTH, model.y / MODEL_HEIGHT)
	end

	self.char:update(dt)

	if self.char:getState() == 'idle' then
		self.t = self.t + dt

		if self.t > 2 then
			self.char:changeState('walking', { speed = 0.7 })
		end
	end
end

function StartState:render()
	love.graphics.draw(self.titleImage, WINDOW_WIDTH / 2 - self.char:getModel():getWidth() * 2, (WINDOW_HEIGHT - self.titleImage:getHeight()) / 2, -0.2)
	--love.graphics.draw(self.titleImage, WINDOW_WIDTH / 2 + self.char:getModel():getWidth(), WINDOW_HEIGHT / 2 + self.char:getModel():getHeight() + self.titleImage:getWidth(), 0.1, 0.5, 0.5)
	self.char:render()
end
