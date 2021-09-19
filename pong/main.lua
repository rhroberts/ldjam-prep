-- entry point to game
local Paddle = require"Paddle"
local Ball = require"Ball"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
PADDLE_SPEED = 200  -- px/dt

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
    Player1 = Paddle:new{}
    Player1:setX(-20)
    -- center paddle in y
    Player1:setY(WINDOW_HEIGHT / 2 - Player1:getHeight() / 2)
    Player2 = Paddle:new{}
    Player2:setX(WINDOW_WIDTH - Player2:getWidth())
    Player2:setY(WINDOW_HEIGHT / 2 - Player2:getHeight() / 2)
    Ball = Ball:new()
end

function love.draw()
    if GameState == "start" then
    -- title screen
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
    elseif GameState == "serve" then
        -- start of a volley
        Player1:draw()
        Player2:draw()
        Ball:draw(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2)
        DrawGameState()
    end

    -- always show hint for quitting
    love.graphics.printf(
        {{0.3, 0.3, 0.3}, "Press 'Esc' to quit."},
        Fonts.small, 0, 0, WINDOW_WIDTH, "right"
    )

end

function love.update(dt)
    -- if GameState == "start" then
    -- elseif GameState == "serve" then
    -- end

    -- paddles can move whenever
    if love.keyboard.isDown("s") then
        Player1:setVelocity(PADDLE_SPEED)
        print("Player 1 Y: " .. Player1:getY())
    elseif love.keyboard.isDown("d") then
        Player1:setVelocity(-PADDLE_SPEED)
        print("Player 1 Y: " .. Player1:getY())
    else
        Player1:setVelocity(0)
        print("Player 1 Y: " .. Player1:getY())
    end

    -- paddles can move whenever
    if love.keyboard.isDown("j") then
        Player2:setVelocity(PADDLE_SPEED)
    elseif love.keyboard.isDown("k") then
        Player2:setVelocity(-PADDLE_SPEED)
    else
        Player2:setVelocity(0)
    end

    Player1:move(dt)
    Player2:move(dt)
end

function love.keypressed(key)
    if key == "enter" or key == "return" and GameState == "start" then
        GameState = "serve"
        Sounds.paddle:play()
    elseif key == "escape" then
        love.event.quit()
    end
end