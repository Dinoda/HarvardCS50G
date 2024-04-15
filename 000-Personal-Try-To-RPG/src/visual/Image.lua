Image = Class{}

function Image:init(file)
	self.file = file
	self.img = love.graphics.newImage(file)
end

function Image:render(pos_x, pos_y, scale_x, scale_y)
	scale_x = scale_x or 1
	scale_y = scale_y or 1

	love.graphics.draw(self.img, pos_x, pos_y, 0, scale_x, scale_y)
end
