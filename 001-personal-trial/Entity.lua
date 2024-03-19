Entity = Class{}

function Entity:init(x, y)
	self.x = x
	self.y = y
	self.t = 0
	self.targetAngle = math.random() * math.pi * 2
	self.radius = ENTITY_RADIUS
	self.angle = self.targetAngle
	self.angleChange = 0
	self.speed = 0
	self.acceleration = ENTITY_ACCELERATION
	self.situation = 0
end

-- [[
-- Initial update method called each update
-- ]]
function Entity:update(dt)
	self.t = self.t + dt

	self.x = self.x + self.speed * math.cos(self.angle)
	self.y = self.y + self.speed * math.sin(self.angle)

	if self.situation == ENTITY_SITUATION_RUNNING then
		self.speed = math.min(self.speed + self.acceleration * dt, ENTITY_MAX_SPEED)
		if self.t > 2 then
			if math.random() + self.t - 2 > 1 then
				self:updateSituation(ENTITY_SITUATION_TURNING)
				self.angleChange = (math.random() * 2 - 1) * math.pi
			end
		end
	elseif self.situation == ENTITY_SITUATION_TURNING then
		self:turn(dt)
	end

	self:reboundToGameLimit()
end

function Entity:turn(dt)
	-- We are turning, decelerate
	self.speed = math.max(self.speed * (1 - (self.acceleration * dt)), self.acceleration)

	change = self:getAngularSpeed() * dt

	-- Turn left or right ?
	if self.angleChange > 0 then
		change = math.min(change, self.angleChange)
	else
		change = math.max(-change, self.angleChange)
	end

	self.angleChange = self.angleChange - change
	self.angle = (self.angle + change) % CIRCLE

	if self.angleChange == 0 then
		self:updateSituation(ENTITY_SITUATION_RUNNING)
	end
end

--[[ ====================
--   Collision management 
--   ==================== ]]

-- Collide with another entity (calls "collideWithRadius")
function Entity:collideWithEntity(ent) 
	return self:collideWithRadius(ent.x, ent.y, ent.radius)
end

-- Collide with another element at given position with given radius (may be 0)
function Entity:collideWithRadius(x, y, radius)
	x = self.x - x
	y = self.y - y

	dist = x*x + y*y

	collisionDistance = self.radius + radius

	return dist <= collisionDistance * collisionDistance
end

-- Has collided with an element at given position, this is to be used with "collideWithRadius"
function Entity:hasCollidedWith(x, y)
	v = y - self.y
	h = x - self.x

	ang = math.atan2(v, h)

	self.angle = ang + math.pi
end

--[[ ==================
--   Rebound management
--   ================== ]]

-- Check if the element rebound on a limit of the game
function Entity:reboundToGameLimit()
	if self.x < LEFT_REBOUND then
		self:rebound('left')
	elseif self.x > RIGHT_REBOUND then
		self:rebound('right')
	elseif self.y < TOP_REBOUND then
		self:rebound('top')
 	elseif self.y > BOTTOM_REBOUND then
		self:rebound('bottom')
	end
end

-- Make the entity rebound in a direction (game limit, or cell side)
function Entity:rebound(direction)
	if direction == 'top' then
		if self.angle > math.pi then
			self:reboundVertically()
		end
	elseif direction == 'bottom' then
		if self.angle < math.pi then
			self:reboundVertically()
		end
	elseif direction == 'left' then
		if self.angle > math.pi / 2 and self.angle < math.pi * 3 / 2 then
			self:reboundHorizontally()
		end
	elseif direction == 'right' then
		if self.angle < math.pi / 2 or self.angle > math.pi * 3 / 2 then
			self:reboundHorizontally()
		end
	end
end


function Entity:reboundHorizontally()
	self.angle = (math.pi - self.angle) % CIRCLE
end

function Entity:reboundVertically()
	self.angle = (-self.angle) % CIRCLE
end

--[[ ============================
--   General Accessors / Mutators 
--   ============================ ]] 
function Entity:updateSituation(situation)
	self.t = 0
	self.situation = situation
end

function Entity:getAngularSpeed()
	return math.pi * self.acceleration
end

--[[ ===============
--   Love2D Renderer 
--   =============== ]]
function Entity:render()
	love.graphics.circle('fill', self.x, self.y, 10)
end

