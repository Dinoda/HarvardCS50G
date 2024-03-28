Bird = Class{}

function Bird:init()
	self.image = love.graphics.newImage('bird.png')

	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	self.x = VIRTUAL_WIDTH / 4
	self.y = (VIRTUAL_HEIGHT - self.height) / 2
	
	self.speed = INITIAL_SPEED
end

function Bird:bump() 
	self.speed = INITIAL_SPEED
end

function Bird:update(dt)
	self.y = self.y - self.speed * dt
	
	self.speed = self.speed - ACCELERATION * dt

	if love.keyboard.wasPressed('space') then
		bird:bump()
	end
end

function Bird:collides(pipe)
	-- Horizontal collision (In the same vertical area)
	if self.x + self.width > pipe.x and self.x < pipe.x + pipe.width then
		-- Vertical collision
		if self.y + self.height > pipe.y then
			return true
		end
	end

	return false
end

function Bird:collidesWithFloor() 
	if self.y + self.height > GROUND_HEIGHT then
		return true
	end

	return false
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
	love.graphics.draw(self.image, self.x, self.y, 0, 1, -1)
end


