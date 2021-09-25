Player = {}

function Player:new(t)
    t = t or {}
    self.name = "Player"
    self.width = 20
    self.height = 100
    self._x = 0
    self._y = 0
    self.velocity = 0
    self.color = {1, 1, 1}
    self.score = 0
    self.winner = false
    self.__index = self
    setmetatable(t, self)
    return(t)
end

function Player:setX(x)
    local ulim = WINDOW_WIDTH - Player.width
    self._x = x > ulim and ulim or x < 0 and 0 or x
end

function Player:getX()
    return self._x
end

function Player:setY(y)
    local ulim = WINDOW_HEIGHT - Player.height
    -- cLaMp WiTh LuA lOgIc
    self._y = y > ulim and ulim or y < 0 and 0 or y
end

function Player:getY()
    return self._y
end

function Player:incrementScore()
    self.score = self.score + 1
end

function Player:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle(
        "fill", self._x, self._y, self.width, self.height, 4
    )
    love.graphics.setColor({255, 255, 255})
end

function Player:move(dt)
    self:setY(self._y + self.velocity * dt)
end

function Player:set(side)
    -- reposition players for next serve
    if side == "left" then
        self:setX(0)
        self:setY(WINDOW_HEIGHT / 2 - Player1.height / 2)
    elseif side == "right" then
        self:setX(WINDOW_WIDTH - Player2.width)
        self:setY(WINDOW_HEIGHT / 2 - Player2.height / 2)
    end
end

function Player:reset()
    self.winner = false
    self.score = 0
end

return(Player)