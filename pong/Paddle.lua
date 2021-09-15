Paddle = {
    width = 20,
    height = 100,
    color = {1, 1, 1}
}

function Paddle:new(t)
    t = t or {}
    self.__index = self
    setmetatable(t, self)
    return(t)
end

function Paddle:setWidth(w)
    -- TODO: check input
    self.width = w
end

function Paddle:setHeight(h)
    -- TODO: check input
    self.height = h
end

function Paddle:setColor(c)
    -- TODO: check that c is a valid {r, g, b} list
    self.color = c
end

function Paddle:getWidth()
    return(self.width)
end

function Paddle:getHeight()
    return(self.height)
end

function Paddle:getColor()
    return(self.color)
end

function Paddle:draw(x, y)
    love.graphics.rectangle("fill", x, y, self.width, self.height, 4)
end

return(Paddle)