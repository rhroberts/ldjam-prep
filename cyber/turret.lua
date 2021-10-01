local peachy = require("peachy")
local turret_base = peachy.new("sprites/turret_base.json", love.graphics.newImage("sprites/turret_base.png"), "Static")
local turret = peachy.new("sprites/turret.json", love.graphics.newImage("sprites/turret.png"), "Firing")
local lazer = peachy.new("sprites/bullet.json", love.graphics.newImage("sprites/bullet.png"), "Static")

Turret = {}

function Turret:load()
	-- Load Turret
	self.image = {}
	self.image.head = turret			-- Apply Aseprite
	self.image.head:pause()
	self.anim = false
	self.anim_timer = 0
	self.anim_frame = 0
	self.image.base = turret_base		-- Apply Aseprite
	self.width = turret:getWidth()		-- Image width
	self.height = turret:getHeight()	-- Image height
	self.x = 500						-- Turret x coordinate
	self.y = self.height				-- Turret y coordinate
	self.alpha = 180					-- Angle of Attack
	
	-- Load Bullets
	self.bullets = {}
	self.fire = function()
		bullet = {}
		bullet.image = lazer
		bullet.x = self.x - 28 + (87 + bullet.image:getWidth()/2)*math.cos(self.alpha*math.pi/180.0) + 2*math.sin(self.alpha*math.pi/180.0)
		bullet.y = self.y - 20 + (87 + bullet.image:getWidth()/2)*math.sin(self.alpha*math.pi/180.0) - 2*math.cos(self.alpha*math.pi/180.0)
		bullet.alpha = self.alpha
		table.insert(self.bullets, bullet)
	end
	
end

function Turret:update(dt)
	self:move(dt)
	if love.keyboard.isDown("space") then
		if self.anim == false then
			self.anim = true
		end
	end
	if self.anim == true then
		self.anim_timer = self.anim_timer + dt
	end
	if self.anim_timer > 0.005 then
		self.image.head:nextFrame()
		self.anim_timer = 0
		self.anim_frame = self.anim_frame + 1
	end
	if self.anim_frame > 5 then
		self.fire()
		self.anim_frame = 0
		self.anim = false
	end
	for i, b in pairs(self.bullets) do
		-- Delete if it goes off of screen
		if b.y > 310 then
			table.remove(self.bullets, i)
		end
		if b.y < -10 then
			table.remove(self.bullets, i)
		end
		if b.x <-10 then
			table.remove(self.bullets, i)
		end
		if b.x > 730 then
			table.remove(self.bullets, i)
		end
		-- Give bullet velocity
		vel = 24.0/(0.005 * 5)
		-- vel = 50
		b.x = b.x + vel*math.cos(b.alpha*math.pi/180.0)*dt
		b.y = b.y + vel*math.sin(b.alpha*math.pi/180.0)*dt
	end
end

function Turret:draw()
	self.image.base:draw(self.x, self.y, math.pi)
	self.image.head:draw(self.x-28, self.y-20, self.alpha*math.pi/180.0, 1, 1, 28, 26)
	-- Draw Bullets
	for _,b in pairs(self.bullets) do
		b.image:draw(b.x, b.y, b.alpha*math.pi/180.0)
	end
	-- self.image.head:draw(self.x, self.y, self.alpha*math.pi/180.0)
end

function Turret:move(dt)
	if love.keyboard.isDown("d", "right") then
		self.alpha = self.alpha + 2
	elseif love.keyboard.isDown("a", "left") then
		self.alpha = self.alpha - 2
	end
end