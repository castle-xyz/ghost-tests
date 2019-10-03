local bridge = require '__ghost__.bridge'

function love.draw()
    love.graphics.print('press any key other than SPACE to trigger a JS call for that key', 20, 20)
    love.graphics.print('\npress SPACE to trigger an unknown JS call', 20, 20)
end

function love.keypressed(key)
    if key ~= 'space' then
        network.async(function()
            print(key .. ': ' .. bridge.js.sayHello { name = key })
        end)
    else
        network.async(function()
            print(key .. ': ' .. bridge.js.noSuchMethod { name = key })
        end)
    end
end

function love.mousepressed()
    love.keypressed('a')
end