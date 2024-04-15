MODEL_PUSHING_X = 1
MODEL_PUSHING_Y = 0

PUSHING_ANIMATION_FRAMES = 2
PUSHING_ANIMATION_SPEED = 0.2

PushingState = Class{__includes = PushingState}

function PushingState:getAnimationFrames()
	return PUSHING_ANIMATION_FRAMES
end

function PushingState:getAnimationSpeed()
	return PUSHING_ANIMATION_SPEED
end

function PushingState:getAnimationXPosition()
	return MODEL_PUSHING_X + self.animation
end

function PushingState:getAnimationYPosition()
	return MODEL_PUSHING_Y + self.entity:getDirection()
end
