BORDER_IMAGE_SCALE = 1.4
PADDING = 100
INTER_LEVEL_PADDING = 70
LevelSelectState = Class{__includes = BaseState}

function LevelSelectState:init()
	self.underState = StartState()
	self.border = love.graphics.newImage('assets/border-elem-09.png')
	self.arrow = love.graphics.newImage('assets/arrow_icon.png')
	self.levels = love.filesystem.getDirectoryItems('level')
	self.levelNumber = #(self.levels) 

	self.border_x = WINDOW_WIDTH / 2 - self.border:getWidth() / BORDER_IMAGE_SCALE
	self.border_y = 20

	self.selection = 0
end

function LevelSelectState:enter()
	self.underState:enter()
end

function LevelSelectState:update(dt)
	if love.keyboard.pressedKeys['return'] then
		love.keyboard.pressedKeys['return'] = false
		-- TODO : Implement level validation
	if love.keyboard.pressedKeys['up'] then
		self.selection = math.max(0, self.selection - 1)
	elseif love.keyboard.pressedKeys['down'] then
		self.selection = math.min(self.levelNumber - 1, self.selection + 1)
	end

	self.underState:update(dt)
end

function LevelSelectState:render()
	self.underState:render()

	love.graphics.draw(self.border, 
		self.border_x, 
		self.border_y,
		0, 
		BORDER_IMAGE_SCALE, 
		BORDER_IMAGE_SCALE)
	
	love.graphics.draw(self.arrow, 
		self.border_x + PADDING - 40,
		self.border_y + PADDING + INTER_LEVEL_PADDING * self.selection - self.arrow:getHeight() * 0.0025,
		0,
		0.01,
		0.01
		)

	for k, level in pairs(self.levels) do
		love.graphics.print(level, 
		gMenuFont,
		self.border_x + PADDING,
		self.border_y + PADDING + INTER_LEVEL_PADDING * (k-1))
	end
end
