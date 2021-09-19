

function love.load()
    -- animation = newAnimation(love.graphics.newImage("bouncing_ball.png"), 32, 32, 1)

    sprites = {}

    sprites.ball = ballAnimation(love.graphics.newImage("bouncing_ball.png"), 32, 32, 1)

    -- state = "falling"
    -- x_pos = 0
    -- y_pos = 0
    -- velocity = 1
    -- acceleration = 1
    -- ceiling = 40
    -- floor = 200
    -- test = math.sin(100)
    -- spriteNum = 1
    -- bounc_anim_current = 0
    -- bounc_anim_time = 1
end

function love.update(dt)

    sprites.ball.updateState(sprites.ball, dt) -- no bound methods? pretty sure not...

    -- animation.currentTime = animation.currentTime + dt
    -- if animation.currentTime >= animation.duration then
    --     animation.currentTime = animation.currentTime - animation.duration
    -- end

    -- if state == "falling" then
    --     animateFalling(dt)
    -- elseif state == "bouncing" then
    --     animateBouncing(dt)
    -- else 
    --     animateRising(dt)
    -- end
end



function love.draw()
    -- local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    -- x y orientation_rads scale_x scale_y origin_offset_x origin_offset_y
    -- love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], x_pos, y_pos, 0, 2, 2)

    sprites.ball.draw(sprites.ball)
end

-- function newAnimation(image, width, height, duration)
--     local animation = {}
--     animation.spriteSheet = image;
--     animation.quads = {};

--     for y = 0, image:getHeight() - height, height do
--         for x = 0, image:getWidth() - width, width do
--             table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
--         end
--     end

--     animation.duration = duration or 1
--     animation.currentTime = 0

--     return animation
-- end


function ballAnimation(image, width, height, duratio)
    local ball = {}
    ball.spriteSheet = image
    ball.quads = {}

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(ball.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    ball.updateState = ballUpdateState
    ball.draw = ballDraw
    ball.animateFalling = ballAnimateFalling
    ball.animateRising = ballAnimateRising
    ball.animateBounce = ballAnimateBounce

    ball.spriteNum = 1
    ball.state = "falling"
    ball.x_pos = 0
    ball.y_pos = 0
    ball.y_max = 200
    ball.y_min = 40
    ball.velocity = 1
    ball.acceleration = 1
    ball.bounceCount = 0
    ball.bounceMax = 0.1
    ball.bounceSequence = {1, 2, 3, 4, 3, 2, 1}
    ball.bounceIdx = 1
    return ball
end

function ballUpdateState(ball, dt)
    if ball.state == "falling" then
        ball.animateFalling(ball, dt)
    elseif ball.state == "bouncing" then
        ball.animateBounce(ball, dt)
    elseif ball.state == "rising" then
        ball.animateRising(ball, dt)
    end
end


function ballDraw(ball) 
    love.graphics.draw(ball.spriteSheet, ball.quads[ball.spriteNum], ball.x_pos, ball.y_pos, 0, 2, 2)
end


function ballAnimateFalling(ball, dt)

    ball.velocity = ball.velocity + (ball.acceleration * dt)
    ball.y_pos = ball.y_pos + ball.velocity

    if ball.y_pos >= ball.y_max then

        ball.y_pos = ball.y_max
        ball.velocity = 0
        ball.state = "bouncing"
        -- spriteNum = math.min(4, spriteNum + 1)
    end
end


function ballAnimateBounce(ball, dt)

    ball.bounceCount = ball.bounceCount + dt
    ball.spriteNum = ball.bounceSequence[ball.bounceIdx]
    if ball.bounceCount > ball.bounceMax then
        ball.bounceCount = ball.bounceCount - ball.bounceMax
        ball.bounceIdx = ball.bounceIdx + 1
    end

    if ball.bounceIdx > #ball.bounceSequence then
        ball.spriteNum = 1
        ball.acceleration = ball.acceleration * -1
        ball.state = "rising"
    end
end

function ballAnimateRising(ball, dt)
    ball.velocity = ball.velocity + (ball.acceleration * dt)
    ball.y_pos = ball.y_pos + ball.velocity

    if ball.y_pos <= ball.y_min then
        ball.y_pos = ball.y_min
        ball.state = "falling"
        -- spriteNum = math.min(4, spriteNum + 1)
    end
end
