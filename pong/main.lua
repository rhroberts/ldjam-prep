-- entry point to game
local Player = require"Player"
local Ball = require"Ball"
local pprint = require"ext.pprint.pprint"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
PADDLE_SPEED = 300  -- px/dt
BALL_INIT_SPEED = 300
WINNING_SCORE = 11

function love.load()
    -- seed the RNG so that calls to random are randomish
    math.randomseed(os.time())

    function DisplayDebugInfo()
        love.graphics.printf(
            {
                {0.3, 0.3, 0.3}, tostring(
                    "Game state: " .. GameState .. ", FPS: " .. love.timer.getFPS()
                )
            },
            Fonts.small, 0, 0, WINDOW_WIDTH,
            "left"
        )
    end

    function DrawScore()
        love.graphics.printf(
                {Player1:getColor(), Player1:getName() .. ": " .. Player1:getScore() .. "\n"}
            ,
            Fonts.small, 0, 0, WINDOW_WIDTH, "center"
        )
        love.graphics.printf(
                {Player2:getColor(), Player2:getName() .. ": " .. Player2:getScore()}
            ,
            Fonts.small, 0, Fonts.small:getHeight(), WINDOW_WIDTH, "center"
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
    -- audio sources
    Sounds = {
        paddle = love.audio.newSource("assets/sounds/paddle.ogg", "static")
    }
    -- game objects
    Player1 = Player:new{name = "Player 1", color = {0.2, 0.2, 0.8}}
    Player2 = Player:new{name = "Player 2", color = {0.2, 0.8, 0.2}}
    Ball = Ball:new{}
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
            "center"            -- align
        )
        love.graphics.printf(
            {{0, 1, 0}, "Press 'Enter' to begin."},
            Fonts.medium,
            0,
            WINDOW_HEIGHT / 2 + Fonts.big:getHeight(),
            WINDOW_WIDTH,
            "center"
        )
        Player1:reset()
        Player2:reset()
    elseif GameState == "serve" then
        -- start of a volley
        DrawScore()
        love.graphics.printf(
            "Press Enter to serve!",
            Fonts.big,
            0,
            WINDOW_HEIGHT / 2,
            WINDOW_WIDTH,
            "center"
        )
        Ball:set()
        Player1:draw()
        Player2:draw()
    elseif GameState == "play" then
        DrawScore()
        Ball:draw()
        Player1:draw()
        Player2:draw()
    elseif GameState == "finished" then
        love.graphics.printf(
            {
                Player1:isWinner() and Player1:getColor() or
                Player2:isWinner() and Player2:getColor(),
                Player1:isWinner() and Player1:getName() .. " wins!" or
                Player2:isWinner() and Player2:getName() .. " wins!"
            },
            Fonts.big, 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, "center"
        )
    end

    -- always show hint for quitting, game state, and fPS
    love.graphics.printf(
        {{1, 0, 0}, "Press 'Esc' to quit."},
        Fonts.small, 0, 0, WINDOW_WIDTH, "right"
    )
    DisplayDebugInfo()
end

function love.update(dt)
    if GameState == "serve" then
        Player1:set("left")
        Player2:set("right")
        return
    elseif GameState == "play" then
        -- check for collisions w/ paddles
        if Ball:isColliding(Player1) or Ball:isColliding(Player2) then
            Sounds.paddle:setPitch(1 + math.random(-10, 10) / 100)
            Sounds.paddle:play()
            Ball:setDx(-Ball:getDx() * 1.1)
            Ball:setDy(Ball:getDy() + math.random(-100, 100))
        end

        -- ball to the walls
        if Ball:getY() < Ball:getRadius() then
            Ball:setY(Ball:getRadius())
            Ball:setDy(-Ball:getDy())
        elseif Ball:getY() > WINDOW_HEIGHT - Ball:getRadius() then
            Ball:setY(WINDOW_HEIGHT - Ball:getRadius())
            Ball:setDy(-Ball:getDy())
        elseif Ball:getX() < Ball:getRadius() then
            -- player2 scores on player1
            Player2:incrementScore()
            Ball:set()
            if Player2:getScore() == WINNING_SCORE then
                GameState = "finished"
                Player2:setWinner(true)
            else
                GameState = "serve"
            end
        elseif Ball:getX() > WINDOW_WIDTH - Ball:getRadius() then
            -- player1 scores on player2
            Player1:incrementScore()
            Ball:set()
            if Player1:getScore() == WINNING_SCORE then
                GameState = "finished"
                Player1:setWinner(true)
            else
                GameState = "serve"
            end
        end
        Ball:move(dt)
    end

    -- paddles can move whenever
    if love.keyboard.isDown("s") then
        Player1:setVelocity(PADDLE_SPEED)
    elseif love.keyboard.isDown("w") then
        Player1:setVelocity(-PADDLE_SPEED)
    else
        Player1:setVelocity(0)
    end

    if love.keyboard.isDown("down") then
        Player2:setVelocity(PADDLE_SPEED)
    elseif love.keyboard.isDown("up") then
        Player2:setVelocity(-PADDLE_SPEED)
    else
        Player2:setVelocity(0)
    end

    Player1:move(dt)
    Player2:move(dt)
end

function love.keypressed(key)
    if key == "enter" or key == "return" then
        if GameState == "start" then
            GameState = "serve"
        elseif GameState == "serve" then
            GameState = "play"
        elseif GameState == "finished" then
            GameState = "start"
        end
    elseif key == "escape" then
        love.event.quit()
    end
end