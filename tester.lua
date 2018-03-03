local mainStore = loadstring(createStore({}))()

mainStore:on("created",
	function()
		outputChatBox("Multex store is ready.")
	end
)
