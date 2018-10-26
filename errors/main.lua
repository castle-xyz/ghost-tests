local manyErrorsCounter = 0
local manyErrorsOn = false

function love.draw()
    love.graphics.print([[
    press M to toggle 'many erroring' -- errors once per frame to test what happens when you error
        a lot

    press A to throw an error in an asynchronous block

    press L to throw a Love error (try to load a text file as an image)

    press K to try to require from a non-existent path

    press E to try to require a module that throws an error on loading
    ]], 20, 20)
end

function love.update()
    if manyErrorsOn then
        manyErrorsCounter = manyErrorsCounter + 1
        error('many ' .. manyErrorsCounter)
    end
end

function love.keypressed(k)
    if k == 'm' then
        manyErrorsOn = not manyErrorsOn
    end

    if k == 'a' then
        network.async(function()
            error('async error')
        end)
    end

    if k == 'l' then
        love.graphics.newImage('./main.lua')
    end

    if k == 'k' then
        local k = require 'nope'
    end

    if k == 'e' then
        local k = require 'loadError'
    end
end
