MODEL_IDLE_X = 0
MODEL_IDLE_Y = 0

IdleState = Class{__includes = EntityBaseState}

function IdleState:getAnimationFrames()
	return 1
end

function IdleState:getAnimationSpeed()
	return 1
end

function IdleState:getAnimationXPosition()
	return MODEL_IDLE_X
end

function IdleState:getAnimationYPosition()
	return MODEL_IDLE_Y
end

