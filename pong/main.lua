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
    GameState = GameState or "start"
    Fonts = {
        small = love.graphics.newFont("assets/fonts/heavydata.ttf", 24),
        medium = love.graphics.newFont("assets/fonts/heavydata.ttf", 36),
        big = love.graphics.newFont("assets/fonts/heavydata.ttf", 48)
    }
    Sounds = {
        paddle = love.audio.newSource("assets/sounds/paddle.ogg", "static")
    }
end

function love.draw()

    -- always show hint for quitting
    love.graphics.printf(
        {{0.3, 0.3, 0.3}, "Press 'Esc' to quit."},
        Fonts.small, 0, 0, WINDOW_WIDTH, "right"
    )

    -- use goto to keep state machine logic clear
    if GameState == "start" then
        goto start
    elseif GameState == "serve" then
        goto serve
    end

    -- title screen
    ::start:: do
        love.graphics.printf(
            "Let's Pong!",      -- text
            Fonts.big,            -- font
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
        love.graphics.printf({{1, 0, 0}, GameState}, Fonts.small, 0, 0, WINDOW_WIDTH)
    end

    -- start of a volley
    ::serve:: do
        love.graphics.printf({{1, 0, 0}, GameState}, Fonts.small, 0, 0, WINDOW_WIDTH)
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