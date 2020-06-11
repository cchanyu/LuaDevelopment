-- Function to add player to the 'sessionData' table
local function setupPlayerData(player)
	local playerUserId = "Player_" .. player.UserId
	local data = playerData:GetAsync(playerUserId)
	if data then
		-- Data exists for this player
		sessionData[playerUserId] = data
	else
		-- Data store is working, but no current data for this player
		sessionData[playerUserId] = {Money=0, Experience=0}
	end
end
 
-- Connect 'setupPlayerData()' function to 'PlayerAdded' event
game.Players.PlayerAdded:Connect(setupPlayerData)