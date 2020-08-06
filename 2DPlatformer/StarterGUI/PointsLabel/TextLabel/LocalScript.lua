local player = game.Players.LocalPlayer

function updatePoints()
	script.Parent.Text = "Points: " .. player.leaderstats.Points.Value
end

player.leaderstats.Points.Changed:Connect(updatePoints)