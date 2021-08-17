local peachy = require("peachy")
-- Load aseprite animation
local f22 = peachy.new("sprites/F-22.json", love.graphics.newImage("sprites/F-22.png"), "Level_Flight")
local br = peachy.new("sprites/F-22.json", love.graphics.newImage("sprites/F-22.png"), "Roll")

-- Define locals
local x = 0
local y = 0
local lr = 1
local dx = 0
local dir = 1
local anim = false
local anim_time = 0

function love.load()
	love.graphics.setBackgroundColor(0.61, 0.73, 0.97)
	love.graphics.setColor(0, 0, 0)
	plane = f22
end

function love.update(dt)
	
	-- f22:update(dt)
	
	-- Increment Animation Timer
	if anim == true or anim_time < 0.8 then
		anim_time = anim_time + dt
	end

	
	-- Left or Right Depress
	if love.keyboard.isDown("d") then 
		-- if lr == -1 then
			-- dx = -50
		-- else
			-- dx = 0
		-- end
		x = x + 10
		lr = 1
	elseif love.keyboard.isDown("a") then
		-- if lr == 1 then
			-- dx = 50
		-- else
			-- dx = 0
		-- end
		x = x - 10
		lr = -1
	end
	
	-- Up or Down Depress
	if love.keyboard.isDown("w") then 
		y = y - 10
	elseif love.keyboard.isDown("s") then
		y = y + 10
	end
	
	-- Do a barrel roll!
	if anim_time >= 0.8 then
		plane = f22
		anim = false
		anim_time = 0
	elseif love.keyboard.isDown("space") then
		plane = br
		anim = true
	end
	
	plane:update(dt)
	
end

function love.draw()

	-- Draw Clouds
	love.graphics.setColor(1, 1, 1)
	-- Cloud 1
	love.graphics.circle("fill", 300, 100, 50)
	love.graphics.circle("fill", 350, 100, 50)
	love.graphics.circle("fill", 400, 75, 50)
	-- Cloud 2
	love.graphics.circle("fill", 100, 400, 50)
	love.graphics.circle("fill", 150, 400, 50)
	love.graphics.circle("fill", 100, 355, 50)
	-- Cloud 3
	love.graphics.circle("fill", 600, 500, 50)
	love.graphics.circle("fill", 650, 500, 50)
	love.graphics.circle("fill", 700, 450, 50)
	
	-- Marcus made a plane!
	love.graphics.print("WASD Movement! Space to do barrel roll!", 150, 300, 0, 2, 2)
	-- love.graphics.print(100+x-dx, 150, 250, 0, 2, 2)
	-- f22:draw(100+x,100+y,0,2.0,2.0)
	plane:draw(100+x-dx,100+y,0,lr*2.0,2.0)
	
end