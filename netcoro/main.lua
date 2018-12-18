local text, img

local A, S, Z, X = false, false, false, false

function love.load()
    text = network.fetch(portal.basePath .. '/text.txt')
    img = love.graphics.newImage('avatar2.png')
end

function love.draw()
    love.graphics.draw(img, 20, 20)
    love.graphics.print(text or 'no text', 20, 168)

    love.graphics.print([[
`network.fetch` and `love.graphics.newImage` were already called in `love.load` to fetch the image
and text shown on the left

press 1 to do a `network.fetch` in a `network.async`
press 2 to do a `love.graphics.newImage` in a `network.async`

press Q to do a `network.fetch` directly in `love.keypressed`
press W to do a `love.graphics.newImage` directly in `love.keypressed`

press A to do a `network.fetch` once in `love.update`
press S to do a `love.graphics.newImage` once in `love.update`

press Z to do a `network.fetch` once in `love.draw`
press X to do a `love.graphics.newImage` once in `love.draw`
]], 168, 20)

    if Z then
        Z = false
        text = network.fetch(portal.basePath .. '/text.txt')
    end
    if X then
        X = false
        img = love.graphics.newImage('avatar2.png')
    end
end

function love.update(dt)
    if A then
        A = false
        text = network.fetch(portal.basePath .. '/text.txt')
    end
    if S then
        S = false
        img = love.graphics.newImage('avatar2.png')
    end
end

function love.keypressed(key)
    if key == '1' then
        network.async(function()
            text = network.fetch(portal.basePath .. '/text.txt')
            print('1 success')
        end)
    end
    if key == '2' then
        network.async(function()
            img = love.graphics.newImage('avatar2.png')
            print('2 success')
        end)
    end

    if key == 'q' then
        text = network.fetch(portal.basePath .. '/text.txt')
        print('1 success')
    end
    if key == 'w' then
        img = love.graphics.newImage('avatar2.png')
        print('2 success')
    end

    if key == 'a' then
        A = true
    end
    if key == 's' then
        S = true
    end

    if key == 'z' then
        Z = true
    end
    if key == 'x' then
        X = true
    end
end
