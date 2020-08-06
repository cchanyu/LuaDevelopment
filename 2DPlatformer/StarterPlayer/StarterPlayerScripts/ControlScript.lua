local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
 
local jumping = false
local leftValue, rightValue = 0, 0
 
local function onLeft(actionName, inputState)
	if inputState == Enum.UserInputState.Begin then	
		leftValue = 1
	elseif inputState == Enum.UserInputState.End then
		leftValue = 0
	end
end
 
local function onRight(actionName, inputState)
	if inputState == Enum.UserInputState.Begin then
		rightValue = 1
	elseif inputState == Enum.UserInputState.End then
		rightValue = 0
	end
end
 
local function onJump(actionName, inputState)
	if inputState == Enum.UserInputState.Begin then
		jumping = true
	elseif inputState == Enum.UserInputState.End then
		jumping = false
	end
end
 
local function onUpdate()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		if jumping then
			player.Character.Humanoid.Jump = true
		end
		local moveDirection = rightValue - leftValue
		player.Character.Humanoid:Move(Vector3.new(moveDirection,0,0), false)
	end
end
 
RunService:BindToRenderStep("Control", Enum.RenderPriority.Input.Value, onUpdate)
 
ContextActionService:BindAction("Left", onLeft, true, Enum.KeyCode.A, Enum.KeyCode.Left, Enum.KeyCode.DPadLeft)
ContextActionService:BindAction("Right", onRight, true, Enum.KeyCode.D, Enum.KeyCode.Right, Enum.KeyCode.DPadRight)
ContextActionService:BindAction("Jump", onJump, true, Enum.KeyCode.Space, Enum.KeyCode.Up, Enum.KeyCode.DPadUp, Enum.KeyCode.ButtonA)