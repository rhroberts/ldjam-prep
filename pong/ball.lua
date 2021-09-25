Ball = {}

function Ball:new(t)
    t = t or {}
    self.x = 0
    self.y = 0
    self.dx = math.random(2) == 1 and -BALL_INIT_SPEED or BALL_INIT_SPEED
    self.dy = math.random(2) == 1 and -math.random(BALL_INIT_SPEED) or
              math.random(BALL_INIT_SPEED)
    self.radius = 10
    -- TODO: actually implement color
    self.color = {1, 1, 1}
    self.__index = self
    setmetatable(t, self)
    return(t)
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:isColliding(player)
    if
        self.x > player:getX() + player.width + self.radius or
        player:getX() > self.x + self.radius then
        return false
    elseif
        self.y > player:getY() + player.height + self.radius or
        player:getY() > self.y + self.radius then
        return false
    else
        return true
    end
end

-- put the ball back
function Ball:set()
    -- I don't like using these globals from main...
    self.x = WINDOW_WIDTH / 2
    self.y = WINDOW_HEIGHT / 2
    self.dx = math.random(2) == 1 and -BALL_INIT_SPEED or BALL_INIT_SPEED
    self.dy = math.random(2) == 1 and -math.random(BALL_INIT_SPEED) or
              math.random(BALL_INIT_SPEED)
end

return(Ball)