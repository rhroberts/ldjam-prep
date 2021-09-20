Player = {}

function Player:new(t)
    t = t or {}
    self.name = "Player"
    self.width = 20
    self.height = 100
    self.x = 0
    self.y = 0
    self.velocity = 0
    self.color = {1, 1, 1}
    self.points = 0
    self.winner = false
    self.__index = self
    setmetatable(t, self)
    return(t)
end

function Player:setWidth(w)
    -- TODO: check input
    self.width = w
end

function Player:setHeight(h)
    -- TODO: check input
    self.height = h
end

function Player:setVelocity(v)
    self.velocity = v
end

function Player:setX(x)
    local ulim = WINDOW_WIDTH - Player:getWidth()
    self.x = x > ulim and ulim or x < 0 and 0 or x
end

function Player:setY(y)
    local ulim = WINDOW_HEIGHT - Player:getHeight()
    -- cLaMp WiTh LuA lOgIc
    self.y = y > ulim and ulim or y < 0 and 0 or y
end

function Player:setName(name)
    self.name = name
end

function Player:setColor(c)
    -- TODO: check that c is a valid {r, g, b} list
    self.color = c
end

function Player:setScore(n)
    self.points = n
end

function Player:incrementScore()
    self.points = self.points + 1
end

function Player:setWinner(isWinner)
    self.winner = isWinner
end

function Player:isWinner()
    return(self.winner)
end

function Player:getWidth()
    return(self.width)
end

function Player:getHeight()
    return(self.height)
end

function Player:getName()
    return(self.name)
end

function Player:getColor()
    return(self.color)
end

function Player:getX()
    return(self.x)
end

function Player:getY()
    return(self.y)
end

function Player:getVelocity(v)
    return(self.velocity)
end

function Player:getScore()
    return(self.points)
end

function Player:draw()
    love.graphics.setColor(unpack(self:getColor()))
    love.graphics.rectangle(
        "fill", self:getX(), self:getY(), self:getWidth(), self:getHeight(), 4
    )
    love.graphics.setColor({255, 255, 255})
end

function Player:move(dt)
    self:setY(self:getY() + self:getVelocity() * dt)
end

function Player:set(side)
    -- reposition players for next serve
    if side == "left" then
        self:setX(0)
        self:setY(WINDOW_HEIGHT / 2 - Player1:getHeight() / 2)
    elseif side == "right" then
        self:setX(WINDOW_WIDTH - Player2:getWidth())
        self:setY(WINDOW_HEIGHT / 2 - Player2:getHeight() / 2)
    end
end

function Player:reset()
    self:setWinner(false)
    self:setScore(0)
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

return(Player)