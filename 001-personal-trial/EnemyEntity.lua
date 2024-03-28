EnemyEntity = Class{}

function EnemyEntity:init()
end

function EnemyEntity:setting(entity)
	entity.situation = ENTITY_SITUATION_RUNNING
end

function EnemyEntity:update(entity, dt)
	entity:move(dt)

	if entity.situation == ENTITY_SITUATION_RUNNING then
		self:run(entity, dt)
	elseif entity.situation == ENTITY_SITUATION_TURNING then
		self:turn(entity, dt)
	end

	entity:reboundToGameLimit()
end

function EnemyEntity:run(entity, dt)
	entity:accelerate(dt)

	local t = entity.t - 2

	if t > 0 and math.random() + t > 1 then
		entity:updateSituation(ENTITY_SITUATION_TURNING)
		entity.angleChange = (math.random() * 2 - 1) * math.pi
	end
end

function EnemyEntity:turn(entity, dt) 
	change = entity:turn(entity.angleChange, dt)

	entity.angleChange = entity.angleChange - change

	if entity.angleChange == 0 then
		entity:updateSituation(ENTITY_SITUATION_RUNNING)
	end
end
