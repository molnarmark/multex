function createStore()
	return [[
		return {
			__hooks = {},
			__state = {},
			__events = {},
			__computedProperties = {},

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

			setComputedProperty = function(self, value, callback)
				self.__computedProperties[value] = callback
			end,

			setHook = function(hookName, callback)
				self.__hooks[hookName] = callback
			end,

			dispatch = function(self, name, payload)
				if self.__hooks["beforeAction"] then
					self.__hooks["beforeAction"](name, payload)
				end

				self.__actionHandler(name, payload)

				if self.__hooks["afterAction"] then
					self.__hooks["afterAction"](name, payload)
				end
			end,

			getState = function(self)
				return self.__helpers.shallowCopy(self.__state)
			end,

			setState = function(self, state)
				for fieldName, fieldValue in pairs(state) do
					self.__state[fieldName] = fieldValue

					if self.__computedProperties[fieldName] then
						self.__computedProperties[fieldName]()
						self:emit("computed_update")
					end
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