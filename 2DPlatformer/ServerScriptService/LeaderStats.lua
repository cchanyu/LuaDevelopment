function setup(player)
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local points = Instance.new("IntValue")
	points.Name = "Points"
	points.Parent = leaderstats
	points.Value = 0
end

game.Players.PlayerAdded:Connect(setup)