PlayerEntity = Class{}

function PlayerEntity:init()
end

function PlayerEntity:setting(entity)
end

function PlayerEntity:update(entity, dt)
	entity:move(dt)

	if love.keyboard.isDown('z') or love.keyboard.isDown('up') then
		entity:accelerate(dt)
	elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
		-- We are not in the standard standard coordinate system, as Y goes down
		print(entity:turn(math.pi, dt))
	elseif love.keyboard.isDown('q') or love.keyboard.isDown('left') then
		-- We are not in the standard standard coordinate system, as Y goes down
		print(entity:turn(-math.pi, dt))
	end

	entity:reboundToGameLimit()
end

