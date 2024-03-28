Pipe = Class{}

local image = love.graphics.newImage('pipe.png')

function Pipe:init()
	self.x = VIRTUAL_WIDTH
	self.y = math.random(VIRTUAL_HEIGHT/4, VIRTUAL_HEIGHT - 10)

	self.width = image:getWidth()
end

function Pipe:update(dt)
	self.x = self.x - GROUND_SCROLL_SPEED * dt
end

function Pipe:render()
	love.graphics.draw(image, math.floor(self.x + 0.5), math.floor(self.y))
end
