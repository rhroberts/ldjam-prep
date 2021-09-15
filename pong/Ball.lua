Ball = {
    radius = 10,
    color = {1, 1, 1}
}

function Ball:new(t)
    t = t or {}
    self.__index = self
    setmetatable(t, self)
    return(t)
end

function Ball:setRadius(r)
    -- TODO: check input
    self.radius = r
end

function Ball:setColor(c)
    -- TODO: check that c is a valid {r, g, b} list
    self.color = c
end

function Ball:getRadius()
    return(self.radius)
end

function Ball:getColor()
    return(self.color)
end

function Ball:draw(x, y)
    love.graphics.circle("fill", x, y, self.radius)
end

return(Ball)