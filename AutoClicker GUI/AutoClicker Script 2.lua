-- Gui to Lua
-- Version: 3.2

for _, gui in pairs(game:GetService("CoreGui").RobloxGui:GetChildren()) do
   if gui:IsA("ScreenGui") and string.match(gui.Name, "_Secretkey101") then
       gui:Destroy()
   end
end

for _, gui in pairs(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
   if gui:IsA("ScreenGui") and string.match(gui.Name, "_Secretkey101") then
       gui:Destroy()
   end
end

-- Instances:

local AutoClicker = Instance.new("ScreenGui")
AutoClicker.Name = tostring(math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9).."_Secretkey101")
local Initial = Instance.new("Frame")
local Open = Instance.new("TextButton")
local Main = Instance.new("Frame")
local Set = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local Reset = Instance.new("TextButton")
local X = Instance.new("TextButton")
local Players = game:GetService("Players")
local mouse = Players.LocalPlayer:GetMouse()

--Properties:

AutoClicker.Name = "AutoClicker"
AutoClicker.Parent = game.Workspace

Initial.Name = "Initial"
Initial.Parent = AutoClicker
Initial.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Initial.Position = UDim2.new(-3.64751926e-08, 0, 0.436115831, 0)
Initial.Size = UDim2.new(0, 183, 0, 49)
Initial.Style = Enum.FrameStyle.DropShadow

Open.Name = "Open"
Open.Parent = Initial
Open.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Open.BackgroundTransparency = 1.000
Open.Position = UDim2.new(-0.0114695244, 0, -0.0454545468, 0)
Open.Size = UDim2.new(0, 171, 0, 38)
Open.Font = Enum.Font.SciFi
Open.Text = "Open"
Open.TextColor3 = Color3.fromRGB(255, 255, 255)
Open.TextSize = 14.000
Open.MouseButton1Down:connect(function()
	Main.Visible = true
	Initial.Visible = false
end)

Main.Name = "Main"
Main.Parent = AutoClicker
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BorderColor3 = Color3.fromRGB(255, 255, 255)
Main.Position = UDim2.new(0.347410381, 0, 0.168654174, 0)
Main.Size = UDim2.new(0, 382, 0, 364)
Main.Visible = false
Main.Style = Enum.FrameStyle.DropShadow
Main.Draggable = true

Set.Name = "Set"
Set.Parent = Main
Set.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Set.BackgroundTransparency = 0.500
Set.BorderColor3 = Color3.fromRGB(255, 255, 255)
Set.Position = UDim2.new(0.226067454, 0, 0.224563345, 0)
Set.Size = UDim2.new(0, 200, 0, 50)
Set.Font = Enum.Font.SciFi
Set.Text = "Set Click Point"
Set.TextColor3 = Color3.fromRGB(255, 255, 255)
Set.TextSize = 14.000
Set.MouseButton1Down:connect(function()
-- ss
end)

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.00273403898, 0, -0.0211751759, 0)
Title.Size = UDim2.new(0, 364, 0, 50)
Title.Font = Enum.Font.SciFi
Title.Text = "Auto Clicker GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000

Reset.Name = "Reset"
Reset.Parent = Main
Reset.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Reset.BackgroundTransparency = 0.500
Reset.BorderColor3 = Color3.fromRGB(255, 255, 255)
Reset.Position = UDim2.new(0.226067454, 0, 0.620167732, 0)
Reset.Size = UDim2.new(0, 200, 0, 50)
Reset.Font = Enum.Font.SciFi
Reset.Text = "Reset"
Reset.TextColor3 = Color3.fromRGB(255, 255, 255)
Reset.TextSize = 14.000
Reset.MouseButton1Down:connect(function()
--ss
end)

X.Name = "X"
X.Parent = Main
X.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
X.BackgroundTransparency = 0.500
X.BorderColor3 = Color3.fromRGB(255, 255, 255)
X.Position = UDim2.new(0.933012605, 0, 0.0162864309, 0)
X.Size = UDim2.new(0, 19, 0, 22)
X.Font = Enum.Font.SciFi
X.Text = "x"
X.TextColor3 = Color3.fromRGB(255, 255, 255)
X.TextSize = 14.000
X.MouseButton1Down:connect(function()
	Main.Visible = false
	Initial.Visible = true
end)