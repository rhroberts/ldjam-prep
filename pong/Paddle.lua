Paddle = {}

function Paddle:new(t)
    t = t or {}
    self.__index = self
    setmetatable(t, self)

    self.width = 20
    self.height = 100
    self.x = 0
    self.y = self.width
    self.velocity = 0
    self.color = {1, 1, 1}

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

function Paddle:setY(y)
    -- TODO: don't hardcode window height in limit
    local ulim = 720 - Paddle:getHeight()
    -- cLaMp WiTh LuA lOgIc
    self.y = y > ulim and ulim or y < 0 and 0 or y
end

function Paddle:getY()
    return(self.y)
end

function Paddle:move(dt)
    Paddle:setY(self.y + self.velocity * dt)
end

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

return(Paddle)