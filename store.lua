local stores = {}

-- TODO Computed values

local function dispatch(name, payload)
	outputDebugString("Dispatching")
end

local function isLocked(id)
	return stores[id].__locked
end

local function getState(id)
	return stores[id].__state
end

local function setState(id, newState)
	local oldState = getState(__getStoreById(id))
	store.__eventEmitter:emit("changed", oldState, "entire")
end

local function setStateField(id, field, value)
	local oldField = __getStateField(__getStoreById(id))
	store.__eventEmitter:emit("changed", oldValue, "field")
end

function createStore(initialState)
	local storeId = #stores + 1

	multexStore = {
		__locked       = true,
		__state        = initialState,
		__eventEmitter = loadstring(Envy:new())(),
	}

	stores[storeId] = multexStore

	-- Multex store is ready to be used
	setTimer(function()
		multexStore.__locked = false
		multexStore.__eventEmitter:emit("created")
	end, 50, 1)

	return [[
		return {
			id = ]]..storeId..[[,
			dispatch = function(self, name, payload)
				exports.multex:dispatch(self.id, name, payload)
			end,

			state = function(self)
				return exports.multex:getState(self.id)
			end,

			on = function(self, eventName, callback)
				multexStore.__eventEmitter:on(eventName, callback)
			end,

			-- helper methods

			helpers = {
				isLocked = function(self)
					return exports.multex:isLocked(self.id)
				end
			}
		}
	]]
end

-- Private methods
function __getStoreById(storeId)
	if stores[storeId] then
		return stores[storeId]
	end

	return false
end

function __getStateField(store)
	return store[field] or false
end