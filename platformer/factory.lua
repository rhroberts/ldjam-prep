-- Welcome to the object factory

local function newPlayer(spriteSheet)
    local self = {
        x = 0,                      -- x-position in pixels
        y = 0,                      -- y-position in pixels
        xVel = 0,                   -- x-velocity in pixels/second
        yVel = 0,                   -- y-velocity in pixels/second
        spriteSheet = spriteSheet,  -- love.graphics.Image
        animation = {               -- table of various player animations
        --[[
            <animationName> = {
                quads = {},  -- sequence of quads (love.graphics.Quad)
                rate = num,  -- rate of animation in seconds
                current = num, -- which quad is currently being drawn
            }
        --]]
        }
    }

    local getX = function()
        return self.x
    end

    local setX = function (x)
        self.x = x
    end

    local getY = function ()
        return self.y
    end

    local setY = function (y)
        self.y = y
    end

    local setImage = function (newImage)
        self.image = newImage
    end

    local loadAnimation = function (animationName, width, height, num)
        --[[
            width: width of each quad in pixels
            height: height of each quad in pixels
            num: number of quads in self.image
        ]]
        local quads = {}
        for i = 0, num do
            quads[i + 1] = love.graphics.newQuad(
                width*i, height*i, width, height, self.image:getDimensions()
            )
        end
        self.animation[animationName].quads = quads
    end

    local drawAnimation = function (animationName, dt)
        for _, quad in ipairs(self.animation[animationName]) do
            love.graphics.draw(self.image, quad, self.x, self.y)
        end
    end

    -- public functions
    return {
        getX = getX,
        setX = setX,
        getY = getY,
        setY = setY,
        setImage = setImage,
        loadAnimation = loadAnimation,
        drawAnimation = drawAnimation
    }

end

return {
    newPlayer = newPlayer
}
