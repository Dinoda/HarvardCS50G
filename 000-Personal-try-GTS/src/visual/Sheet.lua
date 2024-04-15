Sheet = Class{}

--[[
--
-- Load the sprite sheet and create the quads from the sprite data given
--
--]]
function Sheet:init(file, spriteWidth, spriteHeight, spriteNumberHorizontal, spriteNumberVertical)
	self.file = file
	self.img = love.graphics.newImage(file)
	self.quads = {}

	for i=0,spriteNumberHorizontal-1,1 do
		self.quads[i] = {}

		for j=0,spriteNumberVertical-1,1 do
			self.quads[i][j] = love.graphics.newQuad(
				spriteWidth*i,
				spriteHeight*j,
				spriteWidth,
				spriteHeight,
				self.img)
		end
	end

	self.classes = {}
end

-- Will render this sheet's quad (x, y) at the given position : (pos_x, pos_y)
function Sheet:render(quad, pos_x, pos_y, scale_x, scale_y)
	scale_x = scale_x or 1
	scale_y = scale_y or 1

	love.graphics.draw(self.img, quad, pos_x, pos_y, 0, scale_x, scale_y)
end

function Sheet:randomClassQuad(class)
	local idx = #(self.classes[class])

	local rand = math.random(idx)

	return self.classes[class][rand]
end

function Sheet:classify(class, x, y)
	if self.classes[class] then
		table.insert(self.classes[class], self.quads[x][y])
	else
		self.classes[class] = {self.quads[x][y]}
	end
end
