# Multex
[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://github.com/ellerbrock/open-source-badge/)
[![Open Source Love](https://badges.frapsoft.com/os/mit/mit.svg?v=102)](https://github.com/ellerbrock/open-source-badge/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Introduction
Multex is an implementation of the `Flux` Architecture by [Facebook](http://facebook.com) for the [Multi Theft Auto](http://mtasa.com) modification.\
You can learn more about how `Flux` works [here](https://facebook.github.io/flux/).

### Getting Started
Create a store by calling the exported createStore function:
```lua
local store = loadstring(createStore())()
```
You can set the initial state of a store by calling `setInitialState` on it:
```lua
store:setInitialState({counter = 0})
```

### Events
You can also subscribe to various events that happen on the store main ones being:
- update
- computed_update

### Computed Properties
Computed properties introduced in `Vuex` are also available in Multex.\
You can subscribe to a property change like so:
```lua
store:setComputedProperty("counter", function()
  outputChatBox("Counter has changed. Let's do something.")
end)
```
### Hooks
Multex also offers you two very simple hooks you can use, those being `beforeAction` and `afterAction`.\
You can use them like so:
```lua
store:setHook("beforeAction", function()
  outputChatBox("An action is about to take place.")
end)
```

### Practical Example
Multex uses the traditional action handlers with a simple dispatch method.\
Here is a little practical example showing you the power of `Multex`.

```lua
local store = loadstring(createStore())()
store:setInitialState({counter = 0})

-- You can subscribe to the change of a property.
store:setComputedProperty("counter", function()
  outputChatBox("Counter has changed.")
end)

-- Let's handle some actions!
store:onAction(function(name, payload)
  if name == "increment" then
    outputChatBox("Increment action called with payload of " .. payload.value)
    local state = store:getState()
    store:setState({counter = state.counter + 1})
  end
end)

-- The update event is emitted whenever the state changes via setState()
store:on("update", function()
  local counter = store:getState().counter
  outputChatBox("State updated. Counter is now " .. counter)
end)

-- Let's create some actions for our store
local actions = {
  increment = function()
    store:dispatch("increment", {value = 1})
  end,
}

actions.increment()
actions.increment()
actions.increment()
actions.increment()
actions.increment()
-- counter is now 5
```

### Fancy buying me a beer?
If this project was helpful to you, you can buy me a beer if you feel like doing so. 🙂

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YM7E34E2LT4D8)