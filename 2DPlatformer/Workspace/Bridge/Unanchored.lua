function spike(partTouching)
	if partTouching.Parent:FindFirstChild("Humanoid") then
		script.Parent.Anchored = false
		script.Parent.CanCollide = false
	end
end

script.Parent.Touched:Connect(spike)