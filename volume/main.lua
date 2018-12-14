local source = love.audio.newSource('./ambience.mp3', 'static')
source:setLooping(true)
source:play()

function love.draw()
    love.graphics.print([[
    volume is ]] .. love.audio.getVolume().. [[
    press UP or DOWN to increase or decrease the volume by increments of 0.1

    you should be able to mute / unmute the game from the containing app while
        having the game's volume be maintained

    the audio used here is by Jason (@schazers)
    ]], 20, 20)
end

function love.keypressed(k)
    if k == 'up' then
        love.audio.setVolume(math.max(0, math.min(love.audio.getVolume() + 0.1, 1)))
    end
    if k == 'down' then
        love.audio.setVolume(math.max(0, math.min(love.audio.getVolume() - 0.1, 1)))
    end
end
