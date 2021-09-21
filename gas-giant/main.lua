flux = require("external.flux")

function love.load()
    windowWidth = 1280
    windowHeight = 720
    fullscreen = true
	love.window.setMode(windowWidth, windowHeight)

    planetSprite = {
        sprite = love.graphics.newImage("assets/planet.png"),
        quadWidth = 300,
        quadHeight = 300,
        currentQuad = 0,
        nextQuad = 1,
        timer = 0,
        animationDelta = 5
    }

    -- tweenAlpha = {
    --     alpha = 1.0
    -- }
    -- flux.to(tweenAlpha, planetSprite.animationDelta / 60, {alpha = 0.0}):ease("linear"):oncomplete()
    love.graphics.setBlendMode("add")
    startTween()

    planetSprite.nQuads = planetSprite.sprite:getWidth() / planetSprite.quadWidth

    quads = {}
    for dw = 0, planetSprite.sprite:getWidth(), planetSprite.quadWidth do
        -- 1-indexing is the source of all evil in the world
        index = dw / planetSprite.quadWidth
        quads[index] = love.graphics.newQuad(
                        dw, 
                        0,
                        planetSprite.quadWidth,
                        planetSprite.quadHeight, 
                        planetSprite.sprite:getDimensions())
    end

    planetSprite.quads = quads
end

function startTween()
    tweenAlpha = {
        alpha = 1.0
    }
    flux.to(tweenAlpha, 0.3, {alpha = 0.0}):ease("linear"):oncomplete(startTween):oncomplete(updateQuads)
end

function updateQuads()
    planetSprite.currentQuad = (planetSprite.currentQuad + 1) % planetSprite.nQuads
    planetSprite.nextQuad = (planetSprite.nextQuad + 1) % planetSprite.nQuads
end



function love.update(dt)
    flux.update(dt)

    -- planetSprite.timer = planetSprite.timer + 1

    -- if planetSprite.timer > planetSprite.animationDelta then 
    --      planetSprite.timer = 0
    --      planetSprite.currentQuad = (planetSprite.currentQuad + 1) % planetSprite.nQuads
    --      planetSprite.nextQuad = (planetSprite.nextQuad + 1) % planetSprite.nQuads
    -- end
end

function love.draw()
    -- print(tweenAlpha.alpha)

    -- tween from current sprite to the next
    love.graphics.setColor(1, 1, 1, tweenAlpha.alpha)
    love.graphics.draw(
        planetSprite.sprite,
        planetSprite.quads[planetSprite.currentQuad],
        (windowWidth - planetSprite.quadWidth) / 2,
        (windowHeight - planetSprite.quadHeight) / 2)

    love.graphics.setColor(1, 1, 1, 1.0 - tweenAlpha.alpha)
    love.graphics.draw(
        planetSprite.sprite,
        planetSprite.quads[planetSprite.nextQuad],
        (windowWidth - planetSprite.quadWidth) / 2,
        (windowHeight - planetSprite.quadHeight) / 2)
end