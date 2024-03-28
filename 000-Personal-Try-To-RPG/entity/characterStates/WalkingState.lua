MODEL_WALKING_X = 0
MODEL_WALKING_Y = 4

WALKING_ANIMATION_FRAMES = 6
WALKING_ANIMATION_SPEED = 0.2

WalkingState = Class{__includes = EntityBaseState}

function WalkingState:init(machine, entity)
	self.machine = machine
	self.entity = entity
	self.model = self.entity:getModel()
	self.t = 0
	self.animation = 0
end

function WalkingState:enter(params)
	params = params or {}
	self.animation = 0
	self.animationSpeed = WALKING_ANIMATION_SPEED / (params.speed or 1)
	self:updateModel()
end

-- Update the model in use to animate
function WalkingState:update(dt)
	self.t = self.t + dt

	if self.t > self.animationSpeed then
		self.animation = (self.animation + 1) % WALKING_ANIMATION_FRAMES
		self.t = self.t % self.animationSpeed
	end

	self:updateModel()
end

function WalkingState:updateModel()
	dir = self.entity:getDirection()

	self.model:update(MODEL_WALKING_X + self.animation, MODEL_WALKING_Y + dir)
end

-- Render the model in the needed position and scale
function WalkingState:render()
	x = self.entity:getX()
	y = self.entity:getY()
	s = self.entity:getScale()

	self.model:render(x, y, s, s)
end
