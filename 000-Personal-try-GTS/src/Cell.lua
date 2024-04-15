Cell = Class{}

function Cell:init(sheet, quad, passable)
	self.sheet = sheet
	self.quad = quad
	self.passable = passable or false 
	self.over = {}
end

function Cell:appendOver(quad)
	table.insert(self.over, quad)
end

function Cell:clearOver()
	self.over = {}
end

function Cell:setSheet(sheet)
	self.sheet = sheet
end

function Cell:setQuad(quad)
	self.quad = quad
end

function Cell:render(x, y, scale)
	self.sheet:render(self.quad, x, y, scale, scale)

	for _, quad in pairs(self.over) do
		self.sheet:render(quad, x, y, scale, scale)
	end
end
