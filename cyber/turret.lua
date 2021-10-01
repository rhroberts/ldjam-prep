-- Load Sprites
local peachy = require("peachy")
local turret_base = peachy.new("assets/turret_base.json", love.graphics.newImage("assets/turret_base.png"), "Static")
local turret = peachy.new("assets/turret.json", love.graphics.newImage("assets/turret.png"), "Firing")
local lazer = peachy.new("assets/bullet.json", love.graphics.newImage("assets/bullet.png"), "Static")
-- Load Sounds
pew = love.audio.newSource("assets/pew.mp3", "stream")
pew:setPitch(3)
pew:setVolume(0.7)
bang = love.audio.newSource("assets/bang.mp3", "stream")
bang:setPitch(3)
bang:setVolume(0.7)

Turret = {}

local function sign(x)
  if x > 0 then return 1 end
  if x == 0 then return 0 end
  return -1
end

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
		bullet.hitbox = {}
		bullet.hitbox.x = self.x - 28 + (87 + bullet.image:getWidth()/2)*math.cos(self.alpha*math.pi/180.0) + 2*math.sin(self.alpha*math.pi/180.0)
		bullet.hitbox.y = self.y - 20 + (87 + bullet.image:getWidth()/2)*math.sin(self.alpha*math.pi/180.0) - 2*math.cos(self.alpha*math.pi/180.0)
		bullet.hitbox.width = lazer:getWidth()
		bullet.hitbox.height = lazer:getHeight()
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
		pew:stop()
		pew:play()
		self.anim_frame = 0
		self.anim = false
	end
	for i, b in pairs(self.bullets) do
		-- Delete if it goes off of screen
		if b.y > love.graphics.getHeight()+10 then
			table.remove(self.bullets, i)
		end
		if b.y < -10 then
			table.remove(self.bullets, i)
		end
		if b.x <-10 then
			table.remove(self.bullets, i)
		end
		if b.x > love.graphics.getWidth()+10 then
			table.remove(self.bullets, i)
		end
		-- Give bullet velocity
		-- vel = 24.0/(0.005 * 5)
		vel = 50
		b.x = b.x + vel*math.cos(b.alpha*math.pi/180.0)*dt
		b.y = b.y + vel*math.sin(b.alpha*math.pi/180.0)*dt
		b.hitbox.x = b.hitbox.x + vel*math.cos(b.alpha*math.pi/180.0)*dt
		b.hitbox.y = b.hitbox.y + vel*math.sin(b.alpha*math.pi/180.0)*dt
	end
end

function Turret:draw()
	self.image.base:draw(self.x, self.y, math.pi)
	self.image.head:draw(self.x-28, self.y-20, self.alpha*math.pi/180.0, 1, 1, 28, 26)
	-- Draw Bullets
	for _,b in pairs(self.bullets) do
		b.image:draw(b.x, b.y, b.alpha*math.pi/180.0)
		love.graphics.setColor(1, 0, 0, 0.5)
		if sign(math.cos(b.alpha*math.pi/180.0)) == 1 then
			wshift = b.hitbox.width*math.cos(b.alpha*math.pi/180.0)
			hshift = b.hitbox.height*math.cos(b.alpha*math.pi/180.0)
		else
			wshift = 0
			hshift = 0
		end
		love.graphics.rectangle("fill",
								b.hitbox.x+b.hitbox.width*math.cos(b.alpha*math.pi/180.0)-b.hitbox.height*math.sin(b.alpha*math.pi/180.0)-wshift,
								b.hitbox.y+b.hitbox.height*math.cos(b.alpha*math.pi/180.0)-hshift,
								math.abs(b.hitbox.width*math.cos(b.alpha*math.pi/180.0))+math.abs(b.hitbox.height*math.sin(b.alpha*math.pi/180.0)),
								math.abs(b.hitbox.width*math.sin(b.alpha*math.pi/180.0))+math.abs(b.hitbox.height*math.cos(b.alpha*math.pi/180.0)))
		love.graphics.setColor(1, 1, 1)
	end
end

function Turret:move(dt)
	if love.keyboard.isDown("d", "right") then
		self.alpha = self.alpha + 2
	elseif love.keyboard.isDown("a", "left") then
		self.alpha = self.alpha - 2
	end
end
