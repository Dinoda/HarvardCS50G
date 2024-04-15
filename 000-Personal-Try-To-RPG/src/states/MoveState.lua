CHARACTER_SPEED = 1
CHARACTER_RUNNING_SPEED = 1.4

MoveState = Class{__includes = BaseState}

function MoveState:init()
	self.char = gPlayerCharacter
	self.model = self.char:getModel()
	self.t = 0
end

function MoveState:enter()
	self.char:setX((WINDOW_WIDTH - self.char:getModel():getWidth()) / 2)
	self.char:setY((WINDOW_HEIGHT - self.char:getModel():getHeight()) / 2)
	self.char:setScale(1)
end

function MoveState:update(dt)
	-- Directional keys, moving
	if love.keyboard.holdKeys['up'] or 
		love.keyboard.holdKeys['down'] or
		love.keyboard.holdKeys['left'] or
		love.keyboard.holdKeys['right'] then

		local speed = CHARACTER_SPEED

		local dir

		for key, value in pairs(gButtonToDirection) do
			if love.keyboard.holdKeys[key] then
				self.char:setDirection(value)
				dir = value
			end
		end
		-- Running

		if love.keyboard.holdKeys['lshift'] or love.keyboard.holdKeys['rshift'] then
			self.char:updateState('running')
			speed = CHARACTER_RUNNING_SPEED
			-- Walking
		else
			self.char:updateState('walking')
		end

		x_mov = gDirectionToXSpeed[dir] * speed
		y_mov = gDirectionToYSpeed[dir] * speed

		self.char:move(x_mov, y_mov)
		-- No directional keys, stay idle
	else
		if self.char:getState() ~= 'idle' then
			self.char:updateState('idle')
		end
	end

	self.char:update(dt)
end

function MoveState:render()
	self.char:render()
end
