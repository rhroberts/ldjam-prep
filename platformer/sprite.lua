local sprite = {}

function sprite:new(pathToSpriteSheet, width, height, columns, rows)
    self._spriteSheet = love.graphics.newImage(pathToSpriteSheet)
    self.__index = self
    return setmetatable({}, self)
end

function sprite:loadAnimation(animationName)
end

return sprite