Envy = {}
Envy.__index = Envy

-- EnvyLayer Implementation

function Envy:new()
  return [[
    return {
    	events = {},

  		__register = function(self, name)
  			self.events[name] = "envy" .. tostring(getTickCount()) .. name
    	end,

    	on = function(self, name, callback)
    		self.__register(self, name)
  	  	addEvent(self.events[name], true)
  	  	addEventHandler(self.events[name], root, callback)
    	end,

    	emit = function(self, name, payload)
    		if self.events[name] then
  				triggerEvent(self.events[name], root, payload)
    			return true
    		end
    		return false
    	end,

    	once = function(self, name, payload)
    		if self.events[name] then
    			triggerEvent(self.events[name], root, payload)
    			self.events[name] = nil
    			return true
    		end

    		return false
    	end
    }
  ]]
end