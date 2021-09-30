require("plane")
require("mountains")

-- Define locals
local width, height = 1280, 720
local m = 64
local camera = {x=0, y=0, zoom = .55}
local zoomrange = {min = 0.1, max = 4.0}
local layers = {}

function love.load()
	-- -- Set Window size
	love.window.setMode(width, height)
	
	-- Define physics
	love.physics.setMeter(m)
	World = love.physics.newWorld(0, 10*m, true)
	World:setCallbacks(beginContact, endContact)
	love.graphics.setBackgroundColor(0.61, 0.73, 0.97)
	
	-- Load plane
	Plane:load()
	
	-- Load Background
	Mt:load(width, height)
	
end

function love.update(dt)
	World:update(dt)
	Plane:update(dt)
	Mt:update(dt, Plane.vx*-0.25, Plane.vy*-0.25, width)
end

function love.draw()
	-- Show Cursor Location
	love.graphics.print("X: ", 1000, 50)
	love.graphics.print(love.mouse.getX(), 1025, 50)
	love.graphics.print("Y: ", 1000, 25)
	love.graphics.print(love.mouse.getY(), 1025, 25)
	
	love.graphics.push()
	-- Draw Background
	Mt:draw()
	-- Draw Plane
	love.graphics.scale(2, 2)
	love.graphics.translate(Plane.dx, Plane.dy)
	Plane:draw()
	love.graphics.pop()
	
	-- Print Flight Characteristics
	love.graphics.print("Lift: ", 25, 25)
	love.graphics.print(Plane.v*Plane.cl, 85, 25)
	love.graphics.print("Weight: ", 25, 45)
	love.graphics.print(Plane.physics.body:getMass()*10*m, 85, 45)
	love.graphics.print("Thrust: ", 25, 65)
	love.graphics.print(Plane.thr, 85, 65)
	love.graphics.print("Drag: ", 25, 85)
	love.graphics.print(Plane.v*Plane.cd, 85, 85)
	love.graphics.print("AoA: ", 25, 105)
	love.graphics.print(-1*Plane.alpha, 85, 105)
	love.graphics.print("Velocity: ", 25, 125)
	love.graphics.print(Plane.vx, 85, 125)
	
	love.graphics.print(Plane.dx, 25, 150)
	love.graphics.print(Plane.dy, 25, 175)
end