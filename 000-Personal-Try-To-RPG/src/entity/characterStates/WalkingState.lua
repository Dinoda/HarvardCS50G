MODEL_WALKING_X = 0
MODEL_WALKING_Y = 4

WALKING_ANIMATION_FRAMES = 6
WALKING_ANIMATION_SPEED = 0.2

WalkingState = Class{__includes = EntityBaseState}

function WalkingState:enter(params)
	params = params or {}
	self.animationSpeed = self.animationSpeed / (params.speed or 1)
	self:updateModel()
end

function WalkingState:getAnimationFrames()
	return WALKING_ANIMATION_FRAMES
end

function WalkingState:getAnimationSpeed()
	return WALKING_ANIMATION_SPEED
end

function WalkingState:getAnimationXPosition()
	return MODEL_WALKING_X + self.animation
end

function WalkingState:getAnimationYPosition()
	return MODEL_WALKING_Y + self.entity:getDirection()
end
