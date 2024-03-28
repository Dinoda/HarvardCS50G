MODEL_RUNNING_X = 0
MODEL_RUNNING_Y = 4

RUNNING_ANIMATION_FRAMES = 6
RUNNING_ANIMATION_SPEED = 0.14

RunningState = Class{__includes = EntityBaseState}

function RunningState:init(machine, entity)
	self.machine = machine
	self.entity = entity
	self.model = self.entity:getModel()
	self.t = 0
	self.animation = 0
end

function RunningState:enter(params)
	params = params or {}
	self.animation = 0
	self.animationSpeed = RUNNING_ANIMATION_SPEED / (params.speed or 1)
	self:updateModel()
end

function RunningState:update(dt)
	self.t = self.t + dt

	if self.t > self.animationSpeed then
		self.animation = (self.animation + 1) % RUNNING_ANIMATION_FRAMES
		self.t = self.t % self.animationSpeed
	end

	self:updateModel()
end

function RunningState:updateModel()
	dir = self.entity:getDirection()

	self.model:update(self:getAnimationXPosition(self.animation), MODEL_RUNNING_Y + dir)
end

function RunningState:getAnimationXPosition()
	if self.animation == 2 then
		return MODEL_RUNNING_X + 6
	elseif self.animation == 5 then
		return MODEL_RUNNING_X + 7
	else
		return MODEL_RUNNING_X + self.animation
	end
end

function RunningState:render()
	x = self.entity:getX()
	y = self.entity:getY()
	s = self.entity:getScale()

	self.model:render(x, y, s, s)
end
