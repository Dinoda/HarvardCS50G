Level = Class{}

function Level:init(filename)
	self.file = love.filesystem.read('level/' .. filename .. '.ttrpg')

	self:load()
end

function Level:load()
	self.lines = {}
	for line in string.gmatch(self.file, '([^\n]+)') do
		table.insert(self.lines, line)
	end
end
