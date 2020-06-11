-- Function to save player's data
local function savePlayerData(playerUserId)
	if sessionData[playerUserId] then
		playerData:SetAsync(playerUserId, sessionData[playerUserId])
	end
end
 
-- Function to save player data on exit
local function saveOnExit(player)
	local playerUserId = "Player_" .. player.UserId
	savePlayerData(playerUserId)
end
 
-- Connect 'setupPlayerData()' function to 'PlayerAdded' event
game.Players.PlayerAdded:Connect(setupPlayerData)
 
-- Connect 'saveOnExit()' function to 'PlayerRemoving' event
game.Players.PlayerRemoving:Connect(saveOnExit)