local ui = castle.ui

local fileUrl = nil
local imageUrl = nil
local image

function castle.uiupdate()
    fileUrl = ui.filePicker('fileUrl', fileUrl)
    imageUrl = ui.filePicker('imageUrl', imageUrl, {
        type = 'image',
        onChange = function(newImageUrl)
            if newImageUrl == nil then
                image = nil
            else
                network.async(function()
                    image = love.graphics.newImage(newImageUrl)
                end)
            end
        end,
    })
end

function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)

    love.graphics.print('\n\nfileUrl: ' .. tostring(fileUrl), 20, 20)
    love.graphics.print('\n\n\nimageUrl: ' .. tostring(imageUrl), 20, 20)

    if image then
        love.graphics.draw(image, 20, 120)
    end
end