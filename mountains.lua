local peachy = require("peachy")
local mt = peachy.new("sprites/F-22_background.json", love.graphics.newImage("sprites/F-22_background.png"), "Mountains")

Mt = {}

function Mt:load(width, height)
	-- Load Mountains
	self.mt1 = {}
	self.mt1.image = mt		-- Apply Aseprite
	self.mt1.x = 0  		-- Mt x coordinate
	self.mt1.y = 0  		-- Mt y coordinate
	self.mt1.vx = 0			-- Mt x velocity
	self.mt1.vy = 0			-- Mt y velocity
	self.mt2 = {}
	self.mt2.image = mt		-- Apply Aseprite
	self.mt2.x = width  	-- Mt x coordinate
	self.mt2.y = 0  		-- Mt y coordinate
	self.mt2.vx = 0			-- Mt x velocity
	self.mt2.vy = 0			-- Mt y velocity
end

function Mt:update(dt, vx, vy, width)
	self.mt1.vx = vx
	self.mt1.vy = vy
	self.mt2.vx = vx
	self.mt2.vy = vy
	self:move(dt, width)
end

function Mt:move(dt, width)
	self.mt1.x = self.mt1.x + self.mt1.vx*dt
	self.mt1.y = self.mt1.y + self.mt1.vy*dt
	if self.mt1.x < -1*width then
		self.mt1.x = self.mt2.x + width
	end
	self.mt2.x = self.mt2.x + self.mt2.vx*dt
	self.mt2.y = self.mt2.y + self.mt2.vy*dt
	if self.mt2.x < -1*width then
		self.mt2.x = self.mt1.x + width
	end
end

function Mt:draw()
	self.mt1.image:draw(self.mt1.x, self.mt1.y)
	self.mt2.image:draw(self.mt2.x, self.mt2.y)
end