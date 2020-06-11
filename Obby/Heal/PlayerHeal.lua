-- Assigning healing to parent script
local Healing = script.Parent
-- When you touch the part this runs
local function onPartTouch(otherPart)
	-- Assigning that part to parent
	local partParent = otherPart.Parent
	-- Finds the human model from parent class
	local humanoid = partParent:FindFirstChildWhichIsA("Humanoid")
	-- If it is humanoid then
	if(humanoid) then
		-- Set player's health to 100
		humanoid.Health = humanoid.Health + 50
		wait(5)
	end
end
-- heals when player touches it.
Healing.Touched:Connect(onPartTouch)