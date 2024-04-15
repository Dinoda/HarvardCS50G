Grass = Class{}

function Grass:init()
	print('Initialisation of the sheet')
	self.sheet = Sheet('assets/environment/Island_24x24.png', ENV_SPRITE_SIDE, ENV_SPRITE_SIDE, ENV_SPRITE_SHEET_WIDTH, ENV_SPRITE_SHEET_HEIGHT)

	print('Before classify')
	self:classify('grass', {
		{0, 0},
		{0, 1},
		{0, 2},
		{1, 0},
		{1, 2},
		{2, 0},
		{2, 1},
		{2, 2}
	})

	self:classify('clear', {
		{7, 0}
	})

	self:classify('flower_append', {
		{8, 0},
		{8, 1},
		{8, 2}
	})
	print('After classify')
end

function Grass:classify(class, table)
	for k, vals in pairs(table) do
		self.sheet:classify(class, vals[1], vals[2])
	end
end

