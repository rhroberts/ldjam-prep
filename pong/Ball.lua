Ball = {}

function Ball:new(t)
    t = t or {}
    self.x = 0
    self.y = 0
    self.dx = math.random(2) == 1 and -BALL_INIT_SPEED or BALL_INIT_SPEED
    self.dy = math.random(2) == 1 and math.random(0, -BALL_INIT_SPEED) or
              math.random(0, BALL_INIT_SPEED)
    self.radius = 10
    -- TODO: actually implement color
    self.color = {1, 1, 1}
    self.__index = self
    setmetatable(t, self)
    return(t)
end

function Ball:setColor(c)
    -- TODO: check that c is a valid {r, g, b} list
    self.color = c
end

function Ball:setRadius(r)
    -- TODO: check input
    self.radius = r
end

function Ball:setX(x)
    self.x = x
end

function Ball:setDx(dx)
    self.dx = dx
end

function Ball:setY(y)
    self.y = y
end

function Ball:setDy(dy)
    self.dy = dy
end

function Ball:getColor()
    return(self.color)
end

function Ball:getRadius()
    return(self.radius)
end

function Ball:getX()
    return(self.x)
end

function Ball:getDx()
    return(self.dx)
end

function Ball:getY()
    return(self.y)
end

function Ball:getDy()
    return(self.dy)
end

function Ball:draw()
    love.graphics.circle("fill", self:getX(), self:getY(), self:getRadius())
end

function Ball:move(dt)
    self:setX(self:getX() + self:getDx() * dt)
    self:setY(self:getY() + self:getDy() * dt)
end

function Ball:isColliding(paddle)
    if
        self:getX() > paddle:getX() + paddle:getWidth() + self:getRadius() or
        paddle:getX() > self:getX() + self:getRadius() then
        return false
    elseif
        self:getY() > paddle:getY() + paddle:getHeight() + self:getRadius() or
        paddle:getY() > self:getY() + self:getRadius() then
        return false
    else
        return true
    end
end

-- put the ball back
function Ball:set()
    -- I don't like using these globals from main...
    self:setX(WINDOW_WIDTH / 2)
    self:setY(WINDOW_HEIGHT / 2)
    self:setDx(math.random(2) == 1 and -BALL_INIT_SPEED or BALL_INIT_SPEED)
    self:setDy(math.random(2) == 1 and math.random(0, -BALL_INIT_SPEED) or
               math.random(0, BALL_INIT_SPEED))
end

return(Ball)