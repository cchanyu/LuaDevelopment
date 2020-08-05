local player = game.Players.LocalPlayer
local camera = workspace.currentCamera

player.CharacterAdded:Wait()
player.Character:WaitForChild("Head")

camera.CameraSubject = player.Character.HumanoidRootPart
camera.CameraType = Enum.CameraType.Attach
camera.FieldOfView = 40

local RunService = game:GetService("RunService")

RunService.Stepped:Connect(function()
	camera.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.new(0,0,30)
end)