-- Set up table to return to any script that requires this module script
local PlayerStatManager = {}
 
-- Table to hold player information for the current session
local sessionData = {}
 
local AUTOSAVE_INTERVAL = 60
 
-- Function that other scripts can call to change a player's stats
function PlayerStatManager:ChangeStat(player, statName, value)
	assert(typeof(sessionData[playerUserId][statName]) == typeof(value), "ChangeStat error: types do not match")
	local playerUserId = "Player_" .. player.UserId
	if typeof(sessionData[playerUserId][statName]) == "number" then
		sessionData[playerUserId][statName] = sessionData[playerUserId][statName] + value
	else
		sessionData[playerUserId][statName] = value
	end
end
 
-- Function to add player to the 'sessionData' table
local function setupPlayerData(player)
	local playerUserId = "Player_" .. player.UserId
	sessionData[playerUserId] = {Money=0, Experience=0}
end
 
-- Connect 'setupPlayerData()' function to 'PlayerAdded' event
game.Players.PlayerAdded:Connect(setupPlayerData)
 
return PlayerStatManager