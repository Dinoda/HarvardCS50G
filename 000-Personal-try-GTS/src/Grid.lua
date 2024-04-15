Grid = Class{}

function Grid:init(width, height, scale, side)
	self.width = width
	self.height = height
	self.scale = scale or 1
	self.side = side or ENV_SPRITE_SIDE
	self.x = 0
	self.y = 0
end

function Grid:cellsInit(sheet, call)
	self.cells = {}
	call = call or function() end

	for i=0,self.width-1,1 do
		self.cells[i] = {}
		for j=0,self.height-1,1 do
			self.cells[i][j] = Cell(sheet)
			call(self.cells[i][j], i, j)
		end
	end
end

function Grid:setSide(side)
	self.side = side
end

function Grid:setXOffset(x)
	self.x = x
end

function Grid:setYOffset(y)
	self.y = y
end

function Grid:render()
	for i=0,self.width-1,1 do
		for j=0,self.height-1,1 do
			self.cells[i][j]:render(self.x + self.side * i, self.y + self.side * j, scale)
		end
	end
end


