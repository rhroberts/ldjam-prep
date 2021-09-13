require("plane")

-- Define locals
local m = 64
-- local lr = 1
-- local dx = 0
-- local dir = 1
-- local anim = false
-- local anim_time = 0
-- local count = 0
-- local buffer = true
-- local bullets = {}

function love.load()
	-- -- Set Window size
	love.window.setMode(1280, 720)
	
	-- Define physics
	love.physics.setMeter(m)
	World = love.physics.newWorld(0, 10*m, true)
	World:setCallbacks(beginContact, endContact)
	love.graphics.setBackgroundColor(0.61, 0.73, 0.97)
	
	-- Load plane
	Plane:load()
	
	
	-- -- Load skys
	-- bg1 = sky
	-- bg2 = sky
	-- bg3 = sky
	
	-- -- Load Plane
	-- plane = f22
	
	-- -- Define player
	-- player = {}
	-- player.x = 100
	-- player.y = 300
	-- player.bullets = {}
	
	-- -- Fire bullets
	-- player.fire = function()
		-- bullet = {}
		-- bullet.x = 100 + 1.5*plane:getWidth()
		-- bullet.y = 300 + plane:getHeight()
		-- table.insert(player.bullets, bullet)
	-- end
	-- -- love.graphics.setBackgroundColor(0.61, 0.73, 0.97)
	-- -- love.graphics.setColor(0, 0, 0)
end

function love.update(dt)
	World:update(dt)
	Plane:update(dt)
	
	-- -- f22:update(dt)
	
	-- -- Increment Animation Timer
	-- if anim == true or anim_time < 0.8 then
		-- anim_time = anim_time + dt
	-- end
	
	-- -- Fire bullets
	-- if love.mouse.isDown(1) then
		-- player.fire()
	-- end

	-- -- Left or Right Depress
	-- if love.keyboard.isDown("d") then 
		-- player.x = player.x + 10
	-- elseif love.keyboard.isDown("a") then
		-- player.x = player.x - 10
	-- end
	
	-- -- Up or Down Depress
	-- if love.keyboard.isDown("w") then 
		-- player.y = player.y - 10
		-- for i,b in ipairs(player.bullets) do
			-- b.y = b.y - 50
		-- end
	-- elseif love.keyboard.isDown("s") then
		-- player.y = player.y + 10
		-- for i,b in ipairs(player.bullets) do
			-- b.y = b.y + 50
		-- end
	-- end
	
	-- -- Do a barrel roll!
	-- if anim_time >= 0.8 then
		-- plane = f22
		-- anim = false
		-- anim_time = 0
	-- elseif love.keyboard.isDown("space") then
		-- plane = br
		-- anim = true
	-- end
	
	-- if player.x % 1080 > 1080 then
		-- if buffer then
			-- count = count + 1
			-- buffer = false
		-- end
	-- else
		-- buffer = true
	-- end
	
	-- -- Update bullets
	-- for i,b in ipairs(player.bullets) do
		-- -- Remove bullet from table if no longer on screen
		-- if b.x > player.x + 1080 then
			-- table.remove(player.bullets, i)
		-- end
		-- b.x = b.x + 20
		-- -- b.y = b.y - 10
	-- end
	
	-- plane:update(dt)
	
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(2, 2)
	Plane:draw()
	love.graphics.pop()
	-- love.graphics.print("X: ", 25, 50)
	-- love.graphics.print(love.mouse.getX(), 50, 50)
	-- love.graphics.print("Y: ", 25, 25)
	-- love.graphics.print(love.mouse.getY(), 50, 25)
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
	
	-- love.graphics.setColor(255, 255, 255)
	-- -- Draw backgrounds!
	-- love.graphics.draw(bg1, -player.x+6400*(count-1), -3000+player.y-100, 0, 1.0, 1.0)
	-- love.graphics.draw(bg2, -player.x+6400*count, -3000+player.y-100, 0, 1.0, 1.0)
	-- love.graphics.draw(bg3, -player.x+6400*(count+1), -3000+player.y-100, 0, 1.0, 1.0)
	
	-- -- Marcus made a plane!
	-- love.graphics.print("WASD Movement! Space to do barrel roll!", 50, 300, 0, 2, 2)
	-- -- love.graphics.print(player.x, 50, 150, 0, 2, 2)
	-- plane:draw(100,300,0,2.0,2.0)
	-- love.graphics.print(player.x, 50, 150, 0, 2, 2)
	
	-- -- Draw bullets
	-- for _,b in pairs(player.bullets) do
		-- love.graphics.setColor(255, 255, 0)
		-- love.graphics.rectangle("fill", b.x, b.y, 5, 5)
		-- love.graphics.print(b.y, 100, 400, 0, 2, 2)
	-- end
end