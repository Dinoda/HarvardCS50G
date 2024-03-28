Entity = Class{}

function Entity:init(x, y, mm)
	self.moveManager = mm

	-- General information
	self.x = x
	self.y = y

	self.angle = math.random() * math.pi * 2

	-- Movement information
	self.speed = 0
	self.angleChange = 0

	-- Decision information
	self.situation = 0
	self.t = 0

	-- Basic characteristics
	self.radius = ENTITY_RADIUS
	self.acceleration = ENTITY_ACCELERATION

	-- Setup by the manager
	if self.moveManager then
		self.moveManager:setting(self)
	end
end

-- [[
-- Initial update method called each update
-- ]]
function Entity:update(dt)
	if self.moveManager then
		self.moveManager:update(self, dt)
	end
end

function Entity:move(dt)
	self.t = self.t + dt
	self.x = self.x + self.speed * math.cos(self.angle)
	self.y = self.y + self.speed * math.sin(self.angle)
end

function Entity:accelerate(dt)
	self.speed = math.min(self.speed + self.acceleration * dt, ENTITY_MAX_SPEED)
end

function Entity:turn(angle, dt)
	self.speed = math.max(self.speed * (1 - self.acceleration * dt), self.acceleration)
	
	change = self:getAngularSpeed() * dt

	if angle > 0 then
		change = math.min(change, angle)
	else
		change = math.max(-change, angle)
	end

	self.angle = (self.angle + change) % CIRCLE

	return change
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
		-- We are not in the standard standard coordinate system, as Y goes down
		if self.angle > math.pi then
			self:reboundVertically()
		end
	elseif direction == 'bottom' then
		-- We are not in the standard standard coordinate system, as Y goes down
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

