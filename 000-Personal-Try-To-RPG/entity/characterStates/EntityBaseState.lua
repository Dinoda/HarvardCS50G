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

function EntityBaseState:init(machine, entity)
	self.machine = machine
	self.entity = entity
	self.model = self.entity:getModel()
end

function EntityBaseState:render()
	self.model:render()
end
