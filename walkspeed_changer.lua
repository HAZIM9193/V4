-- Roblox Walkspeed Changer Script
-- This script creates a GUI in the middle left of the screen to change walkspeed

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WalkspeedChanger"
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 150)
mainFrame.Position = UDim2.new(0, 20, 0.5, -75) -- Middle left position
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Walkspeed Changer"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Title corner
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleLabel

-- Current Speed Label
local currentSpeedLabel = Instance.new("TextLabel")
currentSpeedLabel.Name = "CurrentSpeedLabel"
currentSpeedLabel.Size = UDim2.new(1, -20, 0, 25)
currentSpeedLabel.Position = UDim2.new(0, 10, 0, 40)
currentSpeedLabel.BackgroundTransparency = 1
currentSpeedLabel.Text = "Current Speed: 16"
currentSpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
currentSpeedLabel.TextScaled = true
currentSpeedLabel.Font = Enum.Font.Gotham
currentSpeedLabel.Parent = mainFrame

-- Speed Input TextBox
local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(1, -20, 0, 25)
speedInput.Position = UDim2.new(0, 10, 0, 75)
speedInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
speedInput.BorderSizePixel = 0
speedInput.Text = "16"
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextScaled = true
speedInput.Font = Enum.Font.Gotham
speedInput.PlaceholderText = "Enter speed..."
speedInput.Parent = mainFrame

-- Input corner
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 4)
inputCorner.Parent = speedInput

-- Set Speed Button
local setSpeedButton = Instance.new("TextButton")
setSpeedButton.Name = "SetSpeedButton"
setSpeedButton.Size = UDim2.new(1, -20, 0, 25)
setSpeedButton.Position = UDim2.new(0, 10, 0, 110)
setSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
setSpeedButton.BorderSizePixel = 0
setSpeedButton.Text = "Set Speed"
setSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
setSpeedButton.TextScaled = true
setSpeedButton.Font = Enum.Font.GothamBold
setSpeedButton.Parent = mainFrame

-- Button corner
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 4)
buttonCorner.Parent = setSpeedButton

-- Functions
local function updateCurrentSpeedLabel()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local currentSpeed = player.Character.Humanoid.WalkSpeed
        currentSpeedLabel.Text = "Current Speed: " .. tostring(currentSpeed)
    end
end

local function setWalkSpeed(speed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
        updateCurrentSpeedLabel()
        
        -- Visual feedback - button flash
        local originalColor = setSpeedButton.BackgroundColor3
        setSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        wait(0.1)
        setSpeedButton.BackgroundColor3 = originalColor
    end
end

-- Button click event
setSpeedButton.MouseButton1Click:Connect(function()
    local speedText = speedInput.Text
    local speed = tonumber(speedText)
    
    if speed and speed >= 0 and speed <= 100 then
        setWalkSpeed(speed)
    else
        -- Error feedback - button flash red
        local originalColor = setSpeedButton.BackgroundColor3
        setSpeedButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        wait(0.1)
        setSpeedButton.BackgroundColor3 = originalColor
    end
end)

-- Enter key support for TextBox
speedInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        setSpeedButton.MouseButton1Click:Fire()
    end
end)

-- Update current speed when character spawns
player.CharacterAdded:Connect(function()
    wait(1) -- Wait for humanoid to load
    updateCurrentSpeedLabel()
end)

-- Initial update
if player.Character then
    updateCurrentSpeedLabel()
end

-- Button hover effects
setSpeedButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(setSpeedButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 235)})
    tween:Play()
end)

setSpeedButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(setSpeedButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 215)})
    tween:Play()
end)

print("Walkspeed Changer GUI loaded successfully!")