-- nothing super useful here, just trying to figure out how modules work in lua

local utils = {}

function utils.printf(t)
    love.graphics.printf(t.text, t.x, t.y, t.limit, t.align)
end

return utils