local trapPart = script.Parent
local function onPartTouch(otherPart)
	local partParent = otherPart.Parent
	local humanoid = partParent:FindFirstChildWhichIsA("Humanoid")
	if(humanoid) then
		-- Set player's health to 20
		humanoid.Health = humanoid.Health - 10
		wait(5)
	end
end
trapPart.Touched:Connect(onPartTouch)