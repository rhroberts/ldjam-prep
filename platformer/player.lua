local animation = require"animation"

Player = {
    x = 0,
    y = 0,
    xVel = 100,
    yVel = 100,
    animation = animation("assets/small_droid.png", 64, 64, 6)
}

function Player:load()
    self.animation.load()
end

function Player:draw()
    self.animation.draw(self.x, self.y)
end

function Player:update(dt)
    self:move(dt)
    self.animation.update(1, dt)
end

function Player:move(dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.xVel * dt
    end
    if love.keyboard.isDown("left") then
        self.x = self.x - self.xVel * dt
    end
    if love.keyboard.isDown("up") then
        self.y = self.y - self.yVel * dt
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + self.yVel * dt
    end

end

return Player