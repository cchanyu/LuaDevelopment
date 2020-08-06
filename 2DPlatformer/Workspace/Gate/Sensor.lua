function spike(partTouching)
	if partTouching.Parent:FindFirstChild("Humanoid") then
		local explosion = Instance.new("Explosion", script.Parent)
		explosion.Position = script.Parent.Position
		explosion.BlastPressure = 500
		local Gate = workspace.Traps.Gate
		for key, obj in pairs(Gate:GetChildren()) do
				obj.Anchored = false
			end
		wait(2)
		script.Parent:Destroy()
	end
end

script.Parent.Touched:Connect(spike)