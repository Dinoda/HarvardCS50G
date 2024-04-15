MODEL_WIDTH = 64
MODEL_HEIGHT = MODEL_WIDTH

Model = Class{}

function Model:init(base)
	self.base = base
	self.items = {}
	self:update(0, 0)
end

function Model:append(item)
	table.insert(self.items, item)
end

function Model:clear()
	self.items = {}
end

function Model:update(x, y)
	self.x = x
	self.y = y
end

function Model:render(xpos, ypos, scalex, scaley)
	
	self.base:render(self.x, self.y, xpos, ypos, scalex, scaley)
	love.graphics.draw(self.base, self.quad, xpos, ypos, 0, scalex, scaley)
	for k, item in pairs(self.items) do
		love.graphics.draw(item, self.itemQuads[k], xpos, ypos, 0, scalex, scaley)
	end
end

function Model:getHeight()
	return MODEL_HEIGHT
end

function Model:getWidth()
	return MODEL_WIDTH
end
