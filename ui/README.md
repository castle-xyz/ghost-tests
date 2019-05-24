# Castle UI API

![Castle UI API](gif.gif)

The Castle UI API allows you to add user interface elements that allow interaction with your game. Castle manages the laying out of your UI relative to the rest of Castle's UI. Uses can range from simple debug tools while developing games to user-facing level editors or text-based adventure games etc.

## Tutorial

To use the UI API, simply define the `castle.uiupdate` function and put your UI calls in it:

```lua
function castle.uiupdate()
    castle.ui.text('Hello, world!')
end
```

Since using UI elements usually involves a lot of calls to functions in the `castle.ui` module, it helps to make a local variable referencing it:

```lua
local ui = castle.ui

function castle.uiupdate()
    ui.text('Hello, world!')
end
```

Elements that work as inputs usually take an id string (to keep track of which element refers to which value) and the current value, then return the new value:

```lua
local ui = castle.ui

local myString = 'Edit me!'

function castle.uiupdate()
    ui.text('Set myString:')
    myString = ui.textArea('myString', myString)
end

function love.draw()
    love.graphics.print('myString:\n' .. myString, 20, 20)
end
```

A 'range input' (shown as a slider) takes the minimum and maximum of the range along with a 'step' to slide the value by when dragging:

```lua
local ui = castle.ui

local myNumber = 20
local myString = 'Edit me!'

function castle.uiupdate()
    ui.text('Set myNumber:')
    myNumber = ui.rangeInput('myNumber', myNumber, 0, 40, 1)

    ui.text('Set myString:')
    myString = ui.textArea('myString', myString)
end

function love.draw()
    love.graphics.print('myNumber: ' .. myNumber, 20, 20)
    love.graphics.print('\n\nmyString:\n' .. myString, 20, 20)
end
```

`castle.uiupdate`, like `love.draw`, is called repeatedly at a certain frequency. For the UI this is currently 20 times a second, which seems to make for reasonable responsiveness. On each update, you just need to describe the UI for the current state of your game, and don't have to worry about removing or updating the state of 'old' UI elements. Simply don't make a call to have something not be displayed. In this sense, UI calls are like LÖVE draw calls.

```lua
local ui = castle.ui

local shouldShowText = true

function castle.uiupdate()
    shouldShowText = ui.checkBox('Show text', shouldShowText)
    
    if shouldShowText then
        ui.text('The display of this text is toggled by the above checkbox!')
    end
end
```

`inner` arguments are for nesting components -- you just pass a function that makes more UI calls. ids only need to be unique within the parent component. You can also use callbacks for certain events (more docs coming soon!):

```lua
local ui = castle.ui

function castle.uiupdate()
    ui.box({
        pad = 'small',
        gap = 'small',
        border = { color = 'yellow', size = 'large' }
    }, function()
        ui.text('This is some text inside a box!')

        if ui.button('Button 1') then
            print('Button 1 pressed!')
        end

        ui.button('Button 2', {
            onClick = function()
                print('Button 2 pressed!')
            end
        })
    end)
end
```

See the [code for the 'Circles' demo](./circles.lua) for an example of showing UI for many game entities.

## Reference

All functions take some required parameters, and one `props` parameter for additional configuration. All keys in `props` are optional. `props` itself is always optional and defaults to `{}`.

Input components generally have required label and value parameters. Labels are strings shown next to inputs to describe their function, and are also used by the system to distinguish the inputs from each other. Value parameters provide the current value of the input. Input components generally return the new values (which may be equal to the values passed in if no changes were made by the user).

### Button

Allow the user to perform an action by clicking.

```
clicked = ui.button(labelText, props)
```

Arguments:

- `labelText` (*string*, required): The label
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the button should be disabled
    - `big` (*function*): Whether the button should be a bigger variant.
    - `kind` (*string*): One of `'primary'`, `'secondary'`, `'danger'` or `'ghost'`. Is `'secondary'` by default. A 'primary' button is highlighted and meant for important actions. A 'danger' button is meant for dangerous actions (such as deleting something). A 'ghost' button has even less visual dominance than a secondary button.
    - `onClick` (*function*): A function to call when the button is clicked. You can use this instead of using the return value directly if you prefer callbacks.

Returns:

- `clicked` (*boolean*): Whether the button was clicked in this update.

### Checkbox

Allows the user to toggle a boolean value. Checkboxes generally represent one input in a larger flow with a final confirmation step (eg. choosing among many settings then clicking a button to perform an action with those settings). Prefer toggle switches instead if the resulting action immediately affects something in your game without another step.

```
newChecked = ui.checkbox(labelText, checked, props)
```

Arguments:

- `labelText` (*string*, required): The label
- `checked` (*string*, required): Whether currentl checked
- `props` (*table*, optional): The table of props:
    - `indeterminate` (*boolean*): Whether the checkbox is in an 'indeterminate' state between checked and unchecked. This useful when you want to express that the checkbox has a sublist of selections, some selected and some unselected.
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

Returns:

- `newChecked` (*string*): The new checked state. Is equal to `checked` if no change occured in this update.

### Number input

Allows the user to input a number. Contains controls to increase or decrease the number incrementally.

```
newValue = ui.numberInput(label, value, props)
```

Arguments:

- `label` (*string*, required): The label
- `value` (*string*, required): The current value
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `hideLabel` (*boolean*): Whether to hide the label
    - `max` (*number*): The maximum value
    - `max` (*number*): The minimum value
    - `step` (*number*): How much the value should increase or decrease when clicking the up or down button
    - `invalid` (*boolean*): Whether the value is currently invalid
    - `invalidText` (*string*): An error message to display when the value is invalid
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

Returns:

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.

### Text input

Allows the user to input a string.

```
newValue = ui.textInput(labelText, value, props)
```

Arguments:

- `labelText` (*string*, required): The label
- `value` (*string*, required): The current value
- `props` (*table*, optional): The table of props:
    - `disabled` (*boolean*): Whether the input should be disabled
    - `placeholder` (*string*): Text to show when the input is empty. It disappears when the user begins entering data and should not contain crucial information. It does not affect the actual value returned.
    - `hideLabel` (*boolean*): Whether to hide the label
    - `invalid` (*boolean*): Whether the value is currently invalid
    - `invalidText` (*string*): An error message to display when the value is invalid
    - `helperText` (*string*): Text that is used alongside the label for additional help
    - `charCount` (*boolean*): Whether to show the character count
    - `maxLength` (*number*): The maximum allowed value length
    - `onChange` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

Returns:

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.

### Toggle

Allows the user to toggle a boolean state. Toggle switches are generally used if the resulting action immediately affects something in your game without another step. Use a checkbox instead if the input just represents one value in a larger flow that includes a later confirmation step.

```
newToggled = ui.toggle(labelA, labelB, toggled, props)
```

Arguments:

- `labelA` (*string*, required): The label when in on state
- `labelB` (*string*, required): The label when in off state
- `toggled` (*string*, required): Whether currently on
- `props` (*table*, optional): The table of props:
    - `onToggle` (*function*): A function to call with the new value whenever the input is updated. You can use this instead of using the return value directly if you prefer callbacks. If your function returns a value, that value is used as the new value instead.

Returns:

- `newValue` (*string*): The new value input by the user. Is equal to `value` if no change occured in this update.
