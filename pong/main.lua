-- entry point to game
local Paddle = require"Paddle"
local Ball = require"Ball"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()

    function DrawGameState()
        love.graphics.printf(
            {{1, 0, 0}, GameState}, Fonts.small, 0, 0, WINDOW_WIDTH
        )
    end

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    love.window.setTitle('Pong')
    GameState = GameState or "start"
    Fonts = {
        small = love.graphics.newFont("assets/fonts/heavydata.ttf", 24),
        medium = love.graphics.newFont("assets/fonts/heavydata.ttf", 36),
        big = love.graphics.newFont("assets/fonts/heavydata.ttf", 48)
    }
    Sounds = {
        paddle = love.audio.newSource("assets/sounds/paddle.ogg", "static")
    }
    Player1 = Paddle:new()
    Player2 = Paddle:new()
    Ball = Ball:new()
end

function love.draw()

    -- always show hint for quitting
    love.graphics.printf(
        {{0.3, 0.3, 0.3}, "Press 'Esc' to quit."},
        Fonts.small, 0, 0, WINDOW_WIDTH, "right"
    )

    -- use goto to keep state machine logic clear
    -- this is pretty silly.. just trying to figure out how gotos work
    if GameState == "start" then
        goto start
    elseif GameState == "serve" then
        goto serve
    else
        goto endFrame
    end

    -- title screen
    ::start:: do
        love.graphics.printf(
            "Let's Pong!",      -- text
            Fonts.big,          -- font
            0,                  -- x
            WINDOW_HEIGHT / 2,  -- y
            WINDOW_WIDTH,       -- sx
            'center'            -- align
        )
        love.graphics.printf(
            {{0, 1, 0}, "Press 'Enter' to begin."},
            Fonts.medium,
            0,
            WINDOW_HEIGHT / 2 + Fonts.big:getHeight(),
            WINDOW_WIDTH,
            'center'
        )
        DrawGameState()
        goto endFrame
    end

    -- start of a volley
    ::serve:: do
        Player1:draw(0, 0 + Player1:getHeight())
        Player2:draw(
            WINDOW_WIDTH - Player2:getWidth(),
            WINDOW_HEIGHT - Player2:getHeight() * 2
        )
        Ball:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2)
        DrawGameState()
        goto endFrame
    end

    ::endFrame:: do
    end

end

function love.update(dt)
    -- use goto to keep state machine logic clear
    -- this is pretty silly.. just trying to figure out how gotos work
    if GameState == "start" then
        goto start
    elseif GameState == "serve" then
        goto serve
    else
        goto last
    end

    -- title screen
    ::start:: do
        -- TODO: Animate title screen
        goto last
    end

    -- start of a volley
    ::serve:: do
    end

    ::last:: do
    end
end

function love.keypressed(key)
    if key == "enter" or key == "return" and GameState == "start" then
        GameState = "serve"
        Sounds.paddle:play()
    elseif key == "escape" then
        love.event.quit()
    end
end