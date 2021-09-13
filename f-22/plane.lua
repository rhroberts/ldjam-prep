local peachy = require("peachy.peachy")
local f22 = peachy.new("sprites/F-22.json", love.graphics.newImage("sprites/F-22.png"), "Level_Flight")
local br = peachy.new("sprites/F-22.json", love.graphics.newImage("sprites/F-22.png"), "Roll")

Plane = {}

function Plane:load()
	-- Load plane
	self.image = f22				-- Apply Aseprite
	self.x = 100					-- Plane x coordinate
	self.y = 200					-- Plane y coordinate
	self.xVel = 0					-- Plane x velocity
	self.yVel = 0					-- Plane y velocity
	self.mass = 10					-- Plane mass
	self.width = f22:getWidth()		-- Image width
	self.height = f22:getHeight()	-- Image height
	self.v = 5333.3333				-- Air Velocity
	self.cl = 1.2					-- Lift Coefficient CL
	self.cd = 0.0183333				-- Drag Coefficient CD
	self.thr = 98					-- Thrust
	self.maxthr = 1000				-- Max Thrust
	self.alpha = 0					-- Angle of Attack
	-- Load physics
	self.physics = {}
	self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
	self.physics.body:setMass(0, 0, self.mass, 0)
	self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
	-- Density calc: ~20,000 kg / (18.90 m length * 5 m height * 13.56 m wingspan / 2 for triangle shape) = ~30 kg/m^3
	self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape, self.mass)
end

function Plane:update(dt)
	self:syncPhysics()
	self:move(dt)
end

function Plane:draw()
	love.graphics.setColor(255, 255, 255)
	self.image:draw(self.x - self.width/2, self.y - self.height/2, self.alpha*math.pi/180.0)
end

function Plane:move(dt)
	if love.keyboard.isDown("d", "right") then
		self.thr = self.thr + 10
		if self.thr > self.maxthr then
			self.thr = self.maxthr
		end
	elseif love.keyboard.isDown("a", "left") then
		self.thr = self.thr - 10
		if self.thr < 0 then
			self.thr = 0
		end
	end
	if love.keyboard.isDown("w", "up") then
		self.alpha = self.alpha - 0.5
		self.cl = self:liftCoefficient()
		self.cd = self:dragCoefficient()
	elseif love.keyboard.isDown("s", "down") then
		self.alpha = self.alpha + 0.5
		self.cl = self:liftCoefficient()
		self.cd = self:dragCoefficient()
	end
	-- Apply Lift
	self.physics.body:applyForce(0, -self.v * self.cl)
	-- Apply Drag
	self.physics.body:applyForce(-self.v * self.cd, 0)
	-- Apply Thrust
	self.physics.body:applyForce(self.thr, 0)
end

function Plane:syncPhysics()
	self.x, self.y = self.physics.body:getPosition()
end

function Plane:liftCoefficient()
	-- CL = m * alpha + b
	return -1*(0.05/2.0) * self.alpha + 1.2
end

function Plane:dragCoefficient()
	-- CD = a * CL^2 + c
	return 0.0083333333 * (self.cl-0.2)^2.0 + 0.01
end
