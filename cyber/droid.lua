local peachy = require("peachy")
local droid = peachy.new("assets/small_droid.json", love.graphics.newImage("assets/small_droid.png"), "idle_anim")

Droid = {}

function Droid:load()
	self.image = {}
	self.image = droid
	self.image:pause()
	self.x = 0
	self.y = love.graphics.getHeight()-droid:getHeight()-10
	self.width = droid:getWidth()
	self.height = droid:getHeight()
	self.anim_timer = 0
	self:updateHitBox()
end

function Droid:update(dt, bullets)
	self:move(dt)
	if self.x == love.graphics.getWidth() then
		self.x = 0 - self.width
	end
	self.anim_timer = self.anim_timer + dt
	if self.anim_timer > 0.2 then
		self.image:nextFrame()
		self.anim_timer = 0
	end
	self:updateHitBox()
	-- Detect hit
	love.graphics.print(self.hitbox.x, 150, 100)
	hit = false
	-- for _,b in pairs(bullets) do
		-- hit = self.detectHit(b.hitbox.x, b.hitbox.y, b.hitbox.width, b.hitbox.height,
						     -- Droid.hitbox.x, Droid.hitbox.y, Droid.hitbox.width, Droid.hitbox.height)
	-- end
end

function Droid:move(dt)
	self.x = self.x + 1
end

function Droid:draw()
	self.image:draw(self.x, self.y)
	self:drawHitBox()
end

function Droid:updateHitBox()
	-- self.AABB = {}
	-- self.AABB.x = self.x+0.2*self.width/2
	-- self.AABB.y = self.y+0.1*self.height
	-- self.AABB.width = self.width*0.8
	-- self.AABB.height = self.height*0.9
	self.hitbox = {}
	self.hitbox.x = self.x+0.4*self.width/2
	self.hitbox.y = self.y+0.3*self.height/2+2
	self.hitbox.width = self.width*0.6
	self.hitbox.height = self.height*0.7
end

function Droid:drawHitBox()
	-- Draw 
	-- love.graphics.setColor(0, 1, 0, 0.1)
	-- love.graphics.rectangle("fill", self.AABB.x, self.AABB.y, self.AABB.width, self.AABB.height)
	love.graphics.setColor(1, 0, 0, 0.25)
	love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
	love.graphics.setColor(1, 1, 1)
end

function Droid:detectHit(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2+w2 and x2 < x1+w1 and
           y1 < y2+h2 and y2 < y1+h1
end
