local photo

function love.draw()
    if castle.user.isLoggedIn == true then
        local me = castle.user.getMe()
        if me then
            love.graphics.print('userId: ' .. me.userId, 20, 20)
            love.graphics.print('\nusername: ' .. me.username, 20, 20)
            love.graphics.print('\n\nname: ' .. me.name, 20, 20)
            love.graphics.print('\n\n\nphotoUrl: ' .. me.photoUrl, 20, 20)

            if photo then
                love.graphics.draw(photo, 20, 88)
            else
                network.async(function()
                    photo = love.graphics.newImage(me.photoUrl)
                end)
            end
        end
    end
    if castle.user.isLoggedIn == false then
        love.graphics.print('not logged in', 20, 20)
    end
    if castle.user.isLoggedIn == nil then
        print('nil!')
    end
end