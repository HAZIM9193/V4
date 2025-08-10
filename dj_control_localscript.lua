-- DJ Control GUI LocalScript
-- Place this LocalScript in StarterGui for proper client-side execution

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for RemoteEvents to be created by server
local remoteEvents = ReplicatedStorage:WaitForChild("DJRemoteEvents")
local runCommandRemote = remoteEvents:WaitForChild("RunCommand")

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DJControlGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local gxButton = Instance.new("TextButton")
gxButton.Size = UDim2.new(0, 60, 0, 30)
gxButton.Position = UDim2.new(0, 20, 0.5, -15)
gxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
gxButton.Text = "GX"
gxButton.TextColor3 = Color3.new(1,1,1)
gxButton.TextScaled = true
gxButton.Font = Enum.Font.SourceSansBold
gxButton.Parent = screenGui

local gxCorner = Instance.new("UICorner")
gxCorner.CornerRadius = UDim.new(0, 6)
gxCorner.Parent = gxButton

local controlFrame = Instance.new("Frame")
controlFrame.Size = UDim2.new(0, 300, 0, 150)
controlFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
controlFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
controlFrame.Visible = false
controlFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = controlFrame

local xButton = Instance.new("TextButton")
xButton.Size = UDim2.new(0, 30, 0, 30)
xButton.Position = UDim2.new(1, -35, 0, 5)
xButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
xButton.Text = "X"
xButton.TextColor3 = Color3.new(1,1,1)
xButton.TextScaled = true
xButton.Font = Enum.Font.SourceSansBold
xButton.Parent = controlFrame

local xCorner = Instance.new("UICorner")
xCorner.CornerRadius = UDim.new(0, 15)
xCorner.Parent = xButton

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 30)
titleLabel.Position = UDim2.new(0, 5, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "DJ Control Panel"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = controlFrame

local runButton = Instance.new("TextButton")
runButton.Size = UDim2.new(0, 80, 0, 30)
runButton.Position = UDim2.new(0.5, -40, 0.5, -15)
runButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
runButton.Text = "Run"
runButton.TextColor3 = Color3.new(1,1,1)
runButton.TextScaled = true
runButton.Font = Enum.Font.SourceSansBold
runButton.Parent = controlFrame

local runCorner = Instance.new("UICorner")
runCorner.CornerRadius = UDim.new(0, 6)
runCorner.Parent = runButton

-- Animation functions
local function fadeIn(frame)
	frame.Visible = true
	frame.BackgroundTransparency = 1
	local tween = TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 0})
	tween:Play()
end

local function fadeOut(frame)
	local tween = TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1})
	tween:Play()
	task.delay(0.3, function() 
		frame.Visible = false 
		frame.BackgroundTransparency = 0 -- Reset for next time
	end)
end

-- Button connections with error handling
local function connectButton(button, callback)
	local connection
	connection = button.MouseButton1Click:Connect(function()
		local success, err = pcall(callback)
		if not success then
			warn("Button callback error:", err)
		end
	end)
	return connection
end

-- Connect button events
connectButton(gxButton, function()
	fadeIn(controlFrame)
end)

connectButton(xButton, function()
	fadeOut(controlFrame)
end)

connectButton(runButton, function()
	-- Fire the remote event to server
	runCommandRemote:FireServer("DJ Jhai")
	fadeOut(controlFrame)
end)

print("DJ Control GUI Loaded Successfully")