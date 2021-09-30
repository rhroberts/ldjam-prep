-- an example platformer based on
-- https://github.com/Jeepzor/Platformer-tutorial/

local sti = require"3rd/sti/sti"

-- globals defined in conf.lua
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

function love.load()
    Background = love.graphics.newImage("assets/background.png")
    Map = sti("assets/maps/level1.lua", {"box2d"})
    World = love.physics.newWorld(0, 0)
    Map:box2d_init(World)
end

function love.update(dt)
    Map:update(dt)
end

function love.draw()
    love.graphics.draw(Background)
    love.graphics.setColor(1, 1, 1)
    Map:draw(0, 0, 2, 2)
end
