function updatePoints()
	script.Parent.Text = "Points: " .. workspace.Points.Value
end

workspace.Points.Changed:Connect(updatePoints)