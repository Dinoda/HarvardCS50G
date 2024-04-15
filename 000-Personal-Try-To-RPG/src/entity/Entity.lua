Entity = Class{}

--[[
--
-- This class represent a non-immobile entity
--
-- The render method must be overridden by the extending class.
--
-- An entity possess a model, an x and y position and a scale.
--
--]]
function Entity:init(model, x, y, scale) 
	self.model = model
	self.x = x
	self.y = y
	self.scale = scale
end

-- To implement if needed to update the entity
function Entity:update(dt) end

-- To implement to render the entity, must be done
function Entity:render() 
	assert(false, 'This method must be implemented in the inheriting class')
end

--[[
--
-- Basic accessors and mutators
--
-- They can be overriden to manage elements better
--
-- ]]
function Entity:getModel() 
	return self.model
end

function Entity:setX(x)
	self.x = x
end

function Entity:getX()
	return self.x
end

function Entity:setY(y)
	self.y = y
end

function Entity:getY() 
	return self.y
end

function Entity:setScale(s)
	self.scale = s
end

function Entity:getScale()
	return self.scale
end

function Entity:setDirection(value)
	--assert(value >= 0 and value < 4, 'Direction is limited from 0 to 3')
	self.direction = value
end

function Entity:getDirection() 
	return self.direction
end
