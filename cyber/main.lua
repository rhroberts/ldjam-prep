require("turret")
local droid = require("droid")
local bump = require("bump/bump")

-- Define locals
local width, height = 720, 300
local layers = {}
-- World creation
local world = bump.newWorld()

function love.load()
	-- -- Set Window size
	love.window.setMode(width, height)
	
	-- Load turret
	Turret:load()
	
	-- Load droid
	Droid:load()
	
end

function love.update(dt)
	Turret:update(dt)
	Droid:update(dt, Turret.bullets)
end

function love.draw()
	-- Show Cursor Location
	love.graphics.print("X: ", 100, 50)
	love.graphics.print(love.mouse.getX(), 150, 50)
	love.graphics.print("Y: ", 100, 25)
	love.graphics.print(love.mouse.getY(), 150, 25)
	love.graphics.print("Alpha: ", 100, 75)
	love.graphics.print(Turret.alpha, 150, 75)
	
	-- Draw Droid
	Droid:draw()
	
	-- Draw Turret
	Turret:draw()
end