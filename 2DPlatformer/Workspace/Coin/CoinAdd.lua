function coinPickup(partTouching)
	if partTouching.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharscter(partTouching.Parent)
		player.leaderstats.Points.Value = player.leaderstats.Points.Value + 1
		print("Points: " .. player.leaderstats.Points.Value)
		script.Parent:Destroy()		
	end
end

script.Parent.Touched:Connect(coinPickup)