Cell = Class{}

function Cell:init(x, y)
	self.x = x
	self.y = y
	self.x_left = self.x
	self.x_right = self.x + CELL_SIDE
	self.y_top = self.y
	self.y_bottom = self.y + CELL_SIDE
end

function Cell:render()
	pos_x = self.x
	pos_y = self.y
	love.graphics.rectangle('fill', pos_x, pos_y, CELL_SIDE, CELL_SIDE)
end

function Cell:collide(entity) 
	radius = entity.radius
	-- Simple rectangle collision process
	if self.x_left - radius > entity.x
		or self.x_right + radius < entity.x
		or self.y_top - radius > entity.y
		or self.y_bottom + radius < entity.y
		then
		return nil
	end

	-- Simple collision management
	--[[
	if entity.x < self.x_left and entity.x > self.x_left - radius then
		return 'right'
	elseif entity.x > self.x_right and entity.x < self.x_right + radius then
		return 'left'
	elseif entity.y < self.y_top and entity.y > self.y_top - radius then
		return 'bottom'
	else
		return 'top'
	end
	--]]

	-- Possibly inside collision bounds
	--[
	-- Rebound with the cell side (top-bottom)
	if entity.x < self.x_right and entity.x > self.x_left then
		if entity.y < self.y_top then 
			entity:rebound('bottom')
		else
			entity:rebound('top')
		end
	-- Rebound with the cell side (left-right)
	elseif entity.y < self.y_bottom and entity.y > self.y_top then
		if entity.x < self.x_left then
			entity:rebound('right')
		else 
			entity:rebound('left')
		end
	-- Rebound with an angle
	else
		if entity:collideWithRadius(self.x_right, self.y_top, 0) then
			entity:hasCollidedWith(self.x_right, self.y_top)
		elseif entity:collideWithRadius(self.x_right, self.y_bottom, 0) then
			entity:hasCollidedWith(self.x_right, self.y_bottom)
		elseif entity:collideWithRadius(self.x_left, self.y_top, 0) then
			entity:hasCollidedWith(self.x_left, self.y_top)
		elseif entity:collideWithRadius(self.x_left, self.y_bottom, 0) then
			entity:hasCollidedWith(self.x_left, self.y_bottom)
		end
	end
	--]]
end
