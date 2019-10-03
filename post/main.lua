local text = ''
local creator
local initialPost = castle.post.getInitialPost()

local canvas = love.graphics.newCanvas(300, 300)
canvas:renderTo(function()
    love.graphics.clear(1, 0, 0)
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle('fill', 150, 150, 40)
end)

function castle.postopened(post)
    creator = post.creator
    text = post.data.text
end

function love.draw()
    love.graphics.print([[
    press ENTER to make a post

    the text so far is: []] .. text .. [[]
    the time is: ]] .. love.timer.getTime() .. [[

    creator was: ]] .. (creator and creator.username or 'no one') .. [[
    initial post had text: ]] .. (initialPost and initialPost.data.text or 'jk nothing') .. [[
    ]], 20, 20)
end

function love.keypressed(key)
    if key == 'return' then
        network.async(function()
            castle.post.create {
                message = 'hello, world!',
                data = { text = text },
            }
        end)
    end

    if key == 'i' then
        local imagedata = canvas:newImageData()
        network.async(function()
            castle.post.create {
                message = 'woah an `ImageData`!',
                data = { text = text },
                media = imageData,
            }
        end)
    end
end

function love.textinput(t)
    text = text .. t
end