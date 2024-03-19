Board = Class{}

function Board:init()
	self.cells = {}

	for i = 1,CELL_NUMBER do
		x = math.random(GAME_WIDTH / CELL_SIDE) - 1
		y = math.random(GAME_HEIGHT / CELL_SIDE) - 1
		self.cells[i] = Cell(GAME_PADDING_LEFT + x * CELL_SIDE,  GAME_PADDING_TOP + y * CELL_SIDE)
	end

	self.enemies = {}

	for i = 1, ENEMY_NUMBER do
		self.enemies[i] = Entity(math.random(GAME_WIDTH) + GAME_PADDING_LEFT, math.random(GAME_HEIGHT) + GAME_PADDING_TOP)
	end
end

function Board:update(dt)
	for i = 1, ENEMY_NUMBER do
		self.enemies[i]:update(dt)
	end

	self:collision()
end

function Board:collision()
	for i = 1, ENEMY_NUMBER do
		for j = 1, CELL_NUMBER do
			local col = self.cells[j]:collide(self.enemies[i])

			if col ~= nil then
				self.enemies[i]:collide(col)
			end
		end
	end

	for i = 2, ENEMY_NUMBER do
		for j = 1, ENEMY_NUMBER do
			if i ~= j then
				enemy1 = self.enemies[i]
				enemy2 = self.enemies[j]
				if enemy1:collideWithEntity(enemy2) then
					enemy1:hasCollidedWith(enemy2.x, enemy2.y)
				end
			end
		end
	end
end

function Board:render()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', GAME_PADDING_LEFT, GAME_PADDING_TOP, GAME_WIDTH, GAME_HEIGHT)

	love.graphics.setColor(0,0,0)

	for i = 1,CELL_NUMBER do
		self.cells[i]:render()
	end

	love.graphics.setColor(0,255,0)

	for i = 1, ENEMY_NUMBER do
		self.enemies[i]:render()
	end
end

