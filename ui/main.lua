--- UI

local ui = {}


local state = require 'https://raw.githubusercontent.com/castle-games/share.lua/0862dd46ad68fbd53b6c2d09c65f44444cc295a5/state.lua'
local cjson = (require 'cjson').new()
cjson.encode_sparse_array(true, 1, 0)
local jsEvents = require 'jsEvents'


local root = state.new()
root:__autoSync(true)


local pendingEvents = {}
jsEvents.listen('CASTLE_TOOL_EVENT', function(params)
    if not pendingEvents[params.pathId] then
        pendingEvents[params.pathId] = {}
    end
    table.insert(pendingEvents[params.pathId], params.event)
end)

local lastPendingEventIds = setmetatable({}, { __mode = 'k' }) -- TODO: Move this to `store`

local store = setmetatable({}, {
    __mode = 'k',
    __index = function(t, k)
        local v = {}
        t[k] = v
        return v
    end,
})


root.panes = {}

root.panes.DEFAULT = {
    type = 'pane',
    props = {
        name = 'DEFAULT',
    },
}


local function hash(s)
    if #s <= 22 then
        return s
    end
    return love.data.encode('string', 'base64', love.data.hash('md5', s))
end


local stack = {}

local function push(element, id)
    local top = stack[#stack]
    table.insert(stack, {
        element = element,
        newChildren = { lastId = nil, count = 0 },
        pathId = hash((top and top.pathId or '') .. id)
    })
end

local function addChild(id, needsPathId)
    local top = stack[#stack]
    top.newChildren.count = top.newChildren.count + 1

    -- Canonicalize id, dedup'ing if exists in new
    id = hash(((type(id) == 'string' and id) or (type(id) == 'number' and tostring(id))) or '')
    if top.newChildren[id] then
        id = hash(id .. top.newChildren.count)
    end

    -- Reuse old child if exists, add to new, return
    local oldChild
    if top.element.children and top.element.children[id] then
        oldChild = top.element.children[id]
    end
    local child = oldChild or {}
    top.newChildren[id] = child

    -- Update linked list
    child.prevId = top.newChildren.lastId
    top.newChildren.lastId = id

    -- Add path id if needed
    if needsPathId then
        child.pathId = hash(top.pathId .. id)
        if lastPendingEventIds[child] then
            child.lastReportedEventId = lastPendingEventIds[child]
        end
        local es = pendingEvents[child.pathId]
        if es then
            lastPendingEventIds[child] = es[#es].eventId
        end
    end

    return child, id
end

local function pop()
    local top = table.remove(stack)
    top.element.children = top.newChildren
end

local function enter(element, id, func)
    if type(func) ~= 'function' then
        return
    end
    push(element, id)
    local succeeded, err = pcall(func)
    pop()
    if not succeeded then
        error(err, 0)
    end
end


local function mergeTable(t, u, ...)
    if u == nil then
        return t
    end
    local r = {}
    for k in pairs(t) do
        r[k] = t[k]
    end
    for k in pairs(u) do
        r[k] = u[k]
    end
    return mergeTable(r, ...)
end


function ui.box(id, props, func)
    local c, newId = addChild(id)
    c.type = 'box'
    c.props = ((type(id) == 'table' and id) or (type(props) == 'table' and props)) or nil

    enter(c, newId, ((type(id) == 'function' and id) or (type(props) == 'function' and props)
        or (type(func) == 'function' and func)) or nil)
end


function ui.heading(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))
    local c = addChild(text)
    c.type = 'heading'
    c.props = mergeTable({ text = text }, props)
end

function ui.markdown(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))

    local c = addChild(text)
    c.type = 'markdown'
    c.props = mergeTable({ text = text }, props)
end

function ui.paragraph(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))

    local c = addChild(text)
    c.type = 'paragraph'
    c.props = mergeTable({ text = text }, props)
end

function ui.text(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))

    local c = addChild(text)
    c.type = 'text'
    c.props = mergeTable({ text = text }, props)
end


function ui.section(label, props, func)
    func = (type(func) == 'function' and func) or (type(props) == 'function' and props) or nil
    props = ((type(label) == 'table' and label) or (type(props) == 'table' and props)) or nil
    label = tostring((type(label) ~= 'table' and label) or (type(props) == 'table' and props.label))

    local c, newId = addChild(label, true)
    c.type = 'section'
    c.props = mergeTable({ label = label }, props)

    local active = store[c].active == true
    local es = pendingEvents[c.pathId]
    if es then
        for _, e in ipairs(es) do
            if e.type == 'onActive' then
                active = e.value
            end
        end
    end
    store[c].active = active

    if active then
        enter(c, newId, func)
    end

    return active
end

function ui.button(label, props)
    props = ((type(label) == 'table' and label) or props) or nil
    label = tostring((type(label) ~= 'table' and label) or (type(props) == 'table' and props.label))

    local c = addChild(label, true)
    c.type = 'button'
    c.props = mergeTable({ label = label }, props)

    local es = pendingEvents[c.pathId]
    if es then
        for _, e in ipairs(es) do
            if e.type == 'onClick' then
                return true
            end
        end
    end
    return false
end

function ui.tabs(id, props, func)
    local c, newId = addChild(id)
    c.type = 'tabs'
    c.props = ((type(id) == 'table' and id) or (type(props) == 'table' and props)) or nil

    enter(c, newId, ((type(id) == 'function' and id) or (type(props) == 'function' and props)
        or (type(func) == 'function' and func)) or nil)
end

function ui.tab(title, props, func)
    func = (type(func) == 'function' and func) or (type(props) == 'function' and props) or nil
    props = ((type(title) == 'table' and title) or (type(props) == 'table' and props)) or nil
    title = tostring((type(title) ~= 'table' and title) or (type(props) == 'table' and props.title))

    local c, newId = addChild(title, true)
    c.type = 'tab'
    c.props = mergeTable({ title = title }, props)

    local active = store[c].active == true
    local es = pendingEvents[c.pathId]
    if es then
        for _, e in ipairs(es) do
            if e.type == 'onActive' then
                active = e.value
            end
        end
    end
    store[c].active = active

    -- NOTE: Not doing `if active` for tabs because causes rendering jank
    -- if active then
        enter(c, newId, func)
    -- end

    return active
end


function ui.textInput(label, value, props)
    assert(type(label) == 'string' or type(label) == nil, '`ui.textinput` needs a string or `nil` `label`')
    assert(type(value) == 'string', '`ui.textinput` needs a string `value`')

    local c = addChild(label, true)
    c.type = 'textInput'
    c.props = mergeTable({ label = label, value = value}, props)

    local newValue, changed = value, false
    local es = pendingEvents[c.pathId]
    if es then
        for _, e in ipairs(es) do
            if e.type == 'onChange' then
                newValue, changed = e.value, true
            end
        end
    end
    return newValue, changed
end


function ui.update()
    push(root.panes.DEFAULT, 'DEFAULT')
    castle.uiupdate()
    pop()
    pendingEvents = {}

    local diff = root:__diff(0)
    if diff ~= nil then
        local diffJson = cjson.encode(diff)
        jsEvents.send('CASTLE_TOOLS_UPDATE', diffJson)
        -- print('update: ' .. diffJson)
        -- print('update size: ' .. #diffJson)
        -- io.flush()
    end
    root:__flush()
end

function castle.uiupdate()
end

ui.update()


--- MAIN

local val = 'hai'

local keys = {}

function castle.uiupdate()
    ui.markdown([[
## Hi there!

This is **cool**! Right? [Google](https://www.google.com)...
    ]])

    local blah = false
    local active = ui.section('Keys pressed', function()
        blah = true
        for _, key in ipairs(keys) do
            ui.text(key, {
                color = 'status-critical',
            })
        end
    end)
    ui.text('Section active: ' .. tostring(active))
    ui.text('Blah: ' .. tostring(blah))

    local tab1Active, tab2Active = false, false
    ui.tabs(function()
        tab1Active = ui.tab('Tab 1', function()
            ui.markdown([[
## Welcome to Tab 1

This is tab 1. Hope you like it here. :)
            ]])
        end)
        tab2Active = ui.tab('Tab 2', function()
            ui.markdown([[
## Welcome to Tab 2

This is tab 2. It should be nice in here *too*.
            ]])
        end)
    end)
    ui.text('Tab actives: ' .. tostring(tab1Active) .. ', ' .. tostring(tab2Active))

    val = ui.textInput('Value', val)

    ui.box({
        direction = 'row',
    }, function()
        if ui.button('Woah') then
            print('Woah!!')
        end
        if ui.button('Whee') then
            print('Whee!!')
        end
    end)
end

function love.update()
    ui.update()
end

function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
    love.graphics.print('\n\nval is: ' .. val, 20, 20)
end

function love.keypressed(key)
    if key == 'delete' then
        keys = {}
    elseif key == 'backspace' then
        keys[#keys] = nil
    elseif key == 'c' then
        val = val .. 'c'
    else
        table.insert(keys, math.max(1, #keys / 2), love.timer.getTime())
    end
end