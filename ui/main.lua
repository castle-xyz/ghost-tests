--- UI

local ui = {}


local state = require 'https://raw.githubusercontent.com/castle-games/share.lua/0862dd46ad68fbd53b6c2d09c65f44444cc295a5/state.lua'
local cjson = (require 'cjson').new()
cjson.encode_sparse_array(true, 1, 0)
local jsEvents = require 'jsEvents'


local root = state.new()
root:__autoSync(true)

root.panes = {}

root.panes.DEFAULT = {
    type = 'pane',
    props = {
        name = 'DEFAULT',
    },
}


local store = setmetatable({}, {
    __mode = 'k',
    __index = function(t, k)
        local v = {}
        t[k] = v
        return v
    end,
})


local pendingEvents = {}
jsEvents.listen('CASTLE_TOOL_EVENT', function(params)
    if not pendingEvents[params.pathId] then
        pendingEvents[params.pathId] = {}
    end
    table.insert(pendingEvents[params.pathId], params.event)
end)


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
        if store[child].lastPendingEventId then
            child.lastReportedEventId = store[child].lastPendingEventId
        end
        local es = pendingEvents[child.pathId]
        if es then
            store[child].lastPendingEventId = es[#es].eventId
        end
    end

    return child, id
end

local function pop()
    local top = table.remove(stack)
    top.element.children = top.newChildren
end

local function enter(element, id, inner)
    if type(inner) ~= 'function' then
        return
    end
    push(element, id)
    local succeeded, err = pcall(inner)
    pop()
    if not succeeded then
        error(err, 0)
    end
end


local function merge(t, u, ...)
    if u == nil then
        return t
    end
    local r = {}
    for k, v in pairs(t) do
        r[k] = v
    end
    for k, v in pairs(u) do
        r[k] = v
    end
    return merge(r, ...)
end

local function without(t, w, ...)
    if w == nil then
        return t
    end
    local r = {}
    for k, v in pairs(t) do
        if k ~= w then
            r[k] = v
        end
    end
    return without(r, ...)
end


-- ui.box(inner)
-- ui.box(props)
-- ui.box(props, inner)
-- ui.box(id, props, inner)
function ui.box(...)
    local id, props, inner
    local nArgs = select('#', ...)
    if nArgs == 1 then
        local arg = ...
        if type(arg) == 'function' then
            inner = arg
        else
            props = arg
        end
    elseif nArgs == 2 then
        props, inner = ...
    elseif nArgs == 3 then
        id, props, inner = ...
    end

    local c, newId = addChild(id)
    c.type = 'box'
    c.props = props

    enter(c, newId, inner)
end


-- ui.heading(text)
-- ui.heading(props)
-- ui.heading(text, props)
function ui.heading(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))
    local c = addChild(text)
    c.type = 'heading'
    c.props = merge({ text = text }, props)
end

-- ui.markdown(text)
-- ui.markdown(props)
-- ui.markdown(text, props)
function ui.markdown(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))

    local c = addChild(text)
    c.type = 'markdown'
    c.props = merge({ text = text }, props)
end

-- ui.paragraph(text)
-- ui.paragraph(props)
-- ui.paragraph(text, props)
function ui.paragraph(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))

    local c = addChild(text)
    c.type = 'paragraph'
    c.props = merge({ text = text }, props)
end

-- ui.text(text)
-- ui.text(props)
-- ui.text(text, props)
function ui.text(text, props)
    props = ((type(text) == 'table' and text) or props) or nil
    text = tostring((type(text) ~= 'table' and text) or (type(props) == 'table' and props.text))

    local c = addChild(text)
    c.type = 'text'
    c.props = merge({ text = text }, props)
end


-- ui.section(label, inner)
-- ui.section(label, props, inner)
function ui.section(...)
    local label, props, inner
    local nArgs = select('#', ...)
    if nArgs == 2 then
        label, inner = ...
    elseif nArgs == 3 then
        label, props, inner = ...
    end

    local c, newId = addChild(label, true)
    c.type = 'section'
    c.props = merge({ label = label }, props)

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

    if c.props.active == nil then
        c.props.active = active
    end

    if c.props.active then
        enter(c, newId, inner)
    end

    return active
end

-- ui.button(label)
-- ui.button(label, props)
function ui.button(label, props)
    props = ((type(label) == 'table' and label) or props) or nil
    label = tostring((type(label) ~= 'table' and label) or (type(props) == 'table' and props.label))

    local c = addChild(label, true)
    c.type = 'button'
    c.props = without(merge({ label = label }, props), 'onClick')

    local clicked = false
    local es = pendingEvents[c.pathId]
    if es then
        for _, e in ipairs(es) do
            if e.type == 'onClick' then
                if props and props.onClick then
                    props.onClick()
                end
                clicked = true
            end
        end
    end
    return clicked
end

-- ui.tabs(inner)
-- ui.tabs(props, inner)
-- ui.tabs(id, props, inner)
function ui.tabs(...)
    local id, props, inner
    local nArgs = select('#', ...)
    if nArgs == 1 then
        inner = ...
    elseif nArgs == 2 then
        props, inner = ...
    elseif nArgs == 3 then
        id, props, inner = ...
    end

    local c, newId = addChild(id)
    c.type = 'tabs'
    c.props = props

    enter(c, newId, inner)
end

-- ui.tab(label, inner)
-- ui.tab(label, props, inner)
function ui.tab(...)
    local label, props, inner
    local nArgs = select('#', ...)
    if nArgs == 2 then
        label, inner = ...
    elseif nArgs == 3 then
        label, props, inner = ...
    end

    local c, newId = addChild(title, true)
    c.type = 'tab'
    c.props = merge({ title = title }, props)

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

    enter(c, newId, inner)

    return active
end


-- ui.textInput(label, value, props)
-- ui.textInput(value, props)
-- ui.textInput(label, value)
-- ui.textInput(props)
function ui.textInput(...)
    local label, value, props
    local nArgs = select('#', ...)
    if nArgs == 3 then
        label, value, props = ...
    elseif nArgs == 2 then
        local arg1, arg2 = ...
        if type(arg2) == 'table' then
            value, props = arg1, arg2
        else
            label, value = arg1, arg2
        end
    elseif nArgs == 1 then
        props = ...
    end

    local c = addChild(label, true)
    c.type = 'textInput'
    c.props = without(merge({ label = label, value = value}, props), 'onChange')

    local newValue = value
    local es = pendingEvents[c.pathId]
    if es then
        for _, e in ipairs(es) do
            if e.type == 'onChange' then
                if props and props.onChange then
                    newValue = props.onChange(e.value) or e.value
                else
                    newValue = e.value
                end
            end
        end
    end
    return newValue
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
        ui.button('Woah', {
            onClick = function()
                print('Woah!!')
            end
        })
        if ui.button('Whee') then
            print('Whee!!')
        end
    end)

    ui.box({
        direction = 'row',
        border = { color = 'brand', size = 'large' },
        pad = 'medium',
    }, function()
        ui.box({ pad = 'small', background = 'dark-3' })
        ui.box({ pad = 'medium', background = 'light-3' })
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