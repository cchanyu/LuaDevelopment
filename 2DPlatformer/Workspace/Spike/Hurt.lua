function spike(partTouching)
	if partTouching.Parent:FindFirstChild("Humanoid") then
		partTouching.Parent.Humanoid.Health = 0
	end
end

script.Parent.Touched:Connect(spike)