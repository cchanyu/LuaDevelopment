-- Function to periodically save player data
local function autoSave()
	while wait(AUTOSAVE_INTERVAL) do
		for playerUserId, data in pairs(sessionData) do
			savePlayerData(playerUserId)
		end
	end
end
 
-- Start running 'autoSave()' function in the background
spawn(autoSave)
 
-- Connect 'setupPlayerData()' function to 'PlayerAdded' event
game.Players.PlayerAdded:Connect(setupPlayerData)