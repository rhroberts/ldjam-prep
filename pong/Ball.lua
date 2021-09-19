Ball = {}

function Ball:new(t)
    t = t or {}
    self.x = 0
    self.y = 0
    self.radius = 10
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

function Ball:setY(y)
    self.y = y
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

function Ball:getY()
    return(self.y)
end

function Ball:draw()
    love.graphics.circle("fill", self:getX(), self:getY(), self:getRadius())
end

return(Ball)