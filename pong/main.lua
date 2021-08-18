local utils = require "utils"

-- entry point to game

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    love.window.setTitle('Pong')
end

function love.draw()
    --[[ love.graphics.printf(
        'Pong!',            -- text
        0,                  -- x
        WINDOW_HEIGHT / 2,  -- y
        WINDOW_WIDTH,       -- limit, or sx ?
        'center'            -- align
    )
    ]]
    utils.printf{ text="testing", x=0, y=WINDOW_HEIGHT / 2, limit=WINDOW_WIDTH,
                  align='center'}
end