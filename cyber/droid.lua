local peachy = require("peachy")
local droid = peachy.new("sprites/small_droid.json", love.graphics.newImage("sprites/small_droid.png"), "idle_anim")

Droid = {}

function Droid:load()
	self.image = {}
	self.image = droid
	self.image:pause()
	self.x = 0
	self.y = 300-droid:getHeight()-10
	self.width = droid:getWidth()
	self.height = droid:getHeight()
	self.anim_timer = 0
end

function Droid:update(dt)
	self:move(dt)
	if self.x == 720 then
		self.x = 0 - self.width
	end
	self.anim_timer = self.anim_timer + dt
	if self.anim_timer > 0.2 then
		self.image:nextFrame()
		self.anim_timer = 0
	end
end

function Droid:move(dt)
	self.x = self.x + 1
end

function Droid:draw()
	self.image:draw(self.x, self.y)
end