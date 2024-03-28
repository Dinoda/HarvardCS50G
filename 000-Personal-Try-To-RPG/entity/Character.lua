Character = Class{__includes = Entity}

function Character:init(model, x, y, scale)
	-- [[ 
	-- Entity States are created with this machine and this entity given as parameters
	-- ]]
	self.stateMachine = EntityStateMachine({
		['idle'] = function(m, e) return IdleState(m,e) end,
		['walking'] = function(m, e) return WalkingState(m, e) end,
		['running'] = function(m, e) return RunningState(m, e) end,
	}, self)
	self.model = model
	self.x = x
	self.y = y
	self.scale = scale
	self.direction = 0

	self.stateMachine:changeState('idle')
end

function Character:changeState(name, params)
	self.stateMachine:changeState(name, params)
end

function Character:updateState(name, params)
	if self:getState() ~= name then
		self:changeState(name, params)
	end
end

function Character:update(dt)
	self.stateMachine:update(dt)
end

function Character:render()
	self.stateMachine:render()
end

function Character:getState()
	return self.stateMachine:getStateName()
end

function Character:move(x, y)
	self:moveX(x)
	self:moveY(y)
end
function Character:moveX(x)
	self:setX(math.max(0, self:getX() + x))
end

function Character:moveY(y)
	self:setY(math.max(0, self:getY() + y))
end
