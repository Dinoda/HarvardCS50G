MODEL_WIDTH = 64
MODEL_HEIGHT = MODEL_WIDTH

Model = Class{}

function Model:init(base)
	self.base = love.graphics.newImage(base)
	self.items = {}
	self.itemQuads = {}
	self:update(0, 0)
end

function Model:append(item)
	table.insert(self.items, love.graphics.newImage(item))
end

function Model:clear()
	self.items = {}
	self.itemQuads = {}
end

function Model:update(x, y)
	self.x = x * MODEL_WIDTH
	self.y = y * MODEL_HEIGHT
	self.quad = love.graphics.newQuad(self.x, self.y, MODEL_WIDTH, MODEL_HEIGHT, self.base)

	self.itemQuads = {}
	for k, item in pairs(self.items) do
		table.insert(self.itemQuads, love.graphics.newQuad(self.x, self.y, MODEL_WIDTH, MODEL_HEIGHT, item))
	end
end

function Model:render(xpos, ypos, scalex, scaley)
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
