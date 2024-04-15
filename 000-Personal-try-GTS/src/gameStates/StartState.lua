StartState = Class{ __includes = BaseState }

function StartState:init()
	self.grass = Grass().sheet

	self.grid = Grid(50, 30)

	self.grid:cellsInit(
		self.grass,
		function (cell, x, y) 
			local r = math.random() * 100

			if r < 20 then
				cell:setQuad(self.grass:randomClassQuad('grass'))
				return
			end

			cell:setQuad(self.grass:randomClassQuad('clear'))
			
			if r > 90 then
				cell:appendOver(self.grass:randomClassQuad('flower_append'))
			end
		end
		)

	self.t = 0
end

function StartState:update(dt)
	--self.t = self.t + dt
	--self.grid:setXOffset(self.t)
end

function StartState:render()
	self.grid:render()
end
