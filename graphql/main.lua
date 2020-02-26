-- test `storageId`: e486b038-883c-420a-be97-36e25f24fcf4

local bridge = require '__ghost__.bridge'

local serpent = require 'https://raw.githubusercontent.com/pkulchenko/serpent/879580fb21933f63eb23ece7d60ba2349a8d2848/src/serpent.lua'

local lastResult = 'press a button!'

function love.draw()
    love.graphics.print(lastResult, 20, 20)
end

local ui = castle.ui

function castle.uiupdate()
    if ui.button('query') then
        network.async(function()
            local result = bridge.js.gqlQuery {
                query = [[
                    query GetGameGlobalStorage {
                      gameGlobalStorage(
                        storageId: "e486b038-883c-420a-be97-36e25f24fcf4"
                        key: "lua-graphql-call-test"
                      ) {
                        value
                      }
                    }
                ]],
                fetchPolicy = 'no-cache',
            }
            lastResult = 'result: \n' .. serpent.block(result)
        end)
    end

    if ui.button('mutation') then
        network.async(function()
            local newValue = 'value-' .. math.random(1, 100)
            local result = bridge.js.gqlMutate {
                mutation = [[
                    mutation SetGameGlobalStorage($value: String) {
                      setGameGlobalStorage(
                        storageId: "e486b038-883c-420a-be97-36e25f24fcf4"
                        key: "lua-graphql-call-test"
                        value: $value
                      )
                    }
                ]],
                variables = {
                    value = newValue,
                },
                fetchPolicy = 'no-cache',
            }
            lastResult = 'newValue: ' .. newValue .. '\nresult: \n' .. serpent.block(result)
        end)
    end
end
