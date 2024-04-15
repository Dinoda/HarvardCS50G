MODEL_RUNNING_X = 0
MODEL_RUNNING_Y = 4

RUNNING_ANIMATION_FRAMES = 6
RUNNING_ANIMATION_SPEED = 0.14

RunningState = Class{__includes = EntityBaseState}

function RunningState:enter(params)
	params = params or {}
	self.animationSpeed = self.animationSpeed / (params.speed or 1)
	self:updateModel()
end

function RunningState:getAnimationFrames()
	return RUNNING_ANIMATION_FRAMES
end

function RunningState:getAnimationSpeed()
	return RUNNING_ANIMATION_SPEED
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

function RunningState:getAnimationYPosition()
	return MODEL_RUNNING_Y + self.entity:getDirection()
end
