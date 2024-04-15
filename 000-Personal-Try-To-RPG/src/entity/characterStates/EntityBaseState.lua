IDLE_X = 0
IDLE_Y = 0

WALKING_X = 0
WALKING_Y = 64 * 4

WALKING_ANIMATION = 6

DIRECTION_BOTTOM = 0
DIRECTION_TOP = 64
DIRECTION_RIGHT = 64 * 2
DIRECTION_LEFT = 64 * 3

ENTITY_ANIMATION_SPEED = 0.8

EntityBaseState = Class{__includes = BaseState}

----------------------------
-- Initialisation Methods --
----------------------------

function EntityBaseState:init(machine, entity)
	self.machine = machine
	self.entity = entity
	self.model = self.entity:getModel()
	self.t = 0
	self.animation = 0
	self.animationFrames = self:getAnimationFrames()
	self.animationSpeed = self:getAnimationSpeed()
end

-- Initialisations methods to override
function EntityBaseState:getAnimationFrames()
	assert(false, 'This method or init method should be overridden')
end

function EntityBaseState:getAnimationSpeed()
	assert(false, 'This method or init method should be overridden')
end

function EntityBaseState:enter(params)
	self:updateModel()
end
--------------------
-- Update Methods --
--------------------

function EntityBaseState:update(dt)
	self.t = self.t + dt

	if self.t > self.animationSpeed then
		self:updateAnimation()
		self.t = self.t % self.animationSpeed
	end

	self:updateModel()
end

function EntityBaseState:updateAnimation()
	self.animation = (self.animation + 1) % self.animationFrames
end

function EntityBaseState:updateModel()
	self.model:update(
		self:getAnimationXPosition(),
		self:getAnimationYPosition()
	)
end

function EntityBaseState:getAnimationXPosition()
	assert(false, 'This method or updateModel method should be overridden')
end

function EntityBaseState:getAnimationYPosition()
	assert(false, 'This method or updateModel method should be overridden')
end

--------------------
-- Render methods --
--------------------

function EntityBaseState:render()
	x = self.entity:getX()
	y = self.entity:getY()
	s = self.entity:getScale()

	self.model:render(x, y, s, s)
end
