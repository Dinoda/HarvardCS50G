MODEL_IDLE_X = 0
MODEL_IDLE_Y = 0

IdleState = Class{__includes = EntityBaseState}

function IdleState:enter()
	self.model:update(MODEL_IDLE_X, MODEL_IDLE_Y)
end

function IdleState:update(dt)
	local dir = self.entity:getDirection()

	self.model:update(MODEL_IDLE_X, MODEL_IDLE_Y + dir)
end

function IdleState:render()
	x = self.entity:getX()
	y = self.entity:getY()
	s = self.entity:getScale()

	self.model:render(x, y, s, s)
end
