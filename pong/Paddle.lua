Paddle = {}

function Paddle:new(t)
    t = t or {}
    self.width = 20
    self.height = 100
    self.x = 0
    self.y = 0
    self.velocity = 0
    self.color = {1, 1, 1}
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

function Paddle:setVelocity(v)
    self.velocity = v
end

function Paddle:setX(x)
    local ulim = WINDOW_WIDTH - Paddle:getWidth()
    self.x = x > ulim and ulim or x < 0 and 0 or x
end

function Paddle:setY(y)
    local ulim = WINDOW_HEIGHT - Paddle:getHeight()
    -- cLaMp WiTh LuA lOgIc
    self.y = y > ulim and ulim or y < 0 and 0 or y
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

function Paddle:getX()
    return(self.x)
end

function Paddle:getY()
    return(self.y)
end

function Paddle:getVelocity(v)
    return(self.velocity)
end

function Paddle:draw()
    love.graphics.setColor(unpack(self:getColor()))
    love.graphics.rectangle(
        "fill", self:getX(), self:getY(), self:getWidth(), self:getHeight(), 4
    )
    love.graphics.setColor({255, 255, 255})
end

function Paddle:move(dt)
    self:setY(self:getY() + self:getVelocity() * dt)
end

function Paddle:set(side)
    if side == "left" then
        self:setX(0)
        self:setY(WINDOW_HEIGHT / 2 - Player1:getHeight() / 2)
    elseif side == "right" then
        self:setX(WINDOW_WIDTH - Player2:getWidth())
        self:setY(WINDOW_HEIGHT / 2 - Player2:getHeight() / 2)
    end

end

--[[
-- FIXME
function Paddle:tostring()
    local t = self.__index or self
    local attrs = ""
    for k, v in pairs(t) do
        if
          type(k) ~= "number" and
          type(v) ~= "table" and
          type(v) ~= "function" then
            attrs = attrs .. "\n" .. k .. "\t" .. tostring(v)
        elseif
          type(k) == "number" and
          type(v) ~= "table" and
          type(v) ~= "function" then
            attrs = attrs .. tostring(v) .. " "
        elseif type(v) == "table" and k ~= "__index" then
            print(k, v)
            attrs = attrs .. "\n" .. k .. "\t{ " .. pprint(v) .. "}"
        end
    end
    return(attrs)
end
--]]

return(Paddle)