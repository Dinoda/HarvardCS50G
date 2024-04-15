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

	for i=1,spriteNumberHorizontal,1 do
		self.quads[i] = {}

		for j=1,spriteNumberVertical,1 do
			self.quads[i][j] = love.graphics.newQuad(
				spriteWidth*(i-1),
				spriteHeight*(j-1),
				spriteWidth,
				spriteHeight,
				self.img)
		end
	end
end

-- Will render this sheet's quad (x, y) at the given position : (pos_x, pos_y)
function Sheet:render(x, y, pos_x, pos_y, scale_x, scale_y)
	scale_x = scale_x or 1
	scale_y = scale_y or 1

	love.graphics.draw(self.img, self.quads[x][y], pos_x, pos_y, 0, scale_x, scale_y)
end

