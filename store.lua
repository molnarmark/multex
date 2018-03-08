function createStore()
	return [[
		return {
			__state = {},
			__events = {},
			__actionHandler = nil,
			__helpers = {
				shallowCopy = function(original)
				    local copy = {}
				    for key, value in pairs(original) do
				        copy[key] = value
				    end
				    return copy
				end,
			},

			onAction = function(self, callback)
				self.__actionHandler = callback
			end,

			dispatch = function(self, name, payload)
				self.__actionHandler(name, payload)
			end,

			getState = function(self)
				return self.__helpers.shallowCopy(self.__state)
			end,

			setState = function(self, state)
				for fieldName, fieldValue in pairs(state) do
					self.__state[fieldName] = fieldValue
				end
				self:emit("update")
			end,

			setInitialState = function(self, initialState)
				self.__state = initialState
				self:emit("initial_state_set")
			end,

			on = function(self, eventName, callback)
				self.__events[eventName] = callback
			end,

			emit = function(self, eventName)
				if self.__events[eventName] then
					self.__events[eventName]()
				end
			end,
		}
	]]
end

-- Testing here

local store = loadstring(createStore())()
store:setInitialState({counter = 0})

store:onAction(function(name, payload)
	if name == "increment" then
		outputChatBox("Increment action called with payload of " .. payload.value)
		local state = store:getState()
		store:setState({counter = state.counter + 1})
	end
end)

store:on("update", function()
	local counter = store:getState().counter
	outputChatBox("State updated. Counter is now " .. counter)
end)

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
actions.increment()