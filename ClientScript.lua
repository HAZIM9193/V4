-- ClientScript.lua - Client-side GUI handler for announcements
-- Place this script in StarterPlayerScripts (inside StarterPlayer)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for RemoteEvents to be created
local commandEvents = ReplicatedStorage:WaitForChild("CommandEvents")
local announcementEvent = commandEvents:WaitForChild("ShowAnnouncement")

-- Function to create and display announcement
local function createAnnouncement(text)
    -- Remove any existing announcement
    local existingGui = playerGui:FindFirstChild("AnnouncementGui")
    if existingGui then
        existingGui:Destroy()
    end
    
    -- Create new announcement GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AnnouncementGui"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui
    
    -- Create main frame
    local frame = Instance.new("Frame")
    frame.Name = "AnnouncementFrame"
    frame.Size = UDim2.new(0, 1000, 0, 120)
    frame.Position = UDim2.new(0.5, -500, 0, 80)
    frame.BackgroundTransparency = 1
    frame.Parent = screenGui
    
    -- Create background with subtle styling
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 20, 1, 20)
    background.Position = UDim2.new(0, -10, 0, -10)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.Parent = frame
    
    -- Add rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = background
    
    -- Add subtle glow effect
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.7
    stroke.Parent = background
    
    -- Create text label
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "AnnouncementText"
    textLabel.Size = UDim2.new(1, -40, 1, -20)
    textLabel.Position = UDim2.new(0, 20, 0, 10)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = ""
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextStrokeThickness = 2
    textLabel.Parent = frame
    
    -- Add text size constraint
    local textSizeConstraint = Instance.new("UITextSizeConstraint")
    textSizeConstraint.MaxTextSize = 48
    textSizeConstraint.MinTextSize = 24
    textSizeConstraint.Parent = textLabel
    
    -- Initial fade in
    frame.Position = UDim2.new(0.5, -500, 0, -150)
    local fadeInTween = TweenService:Create(frame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -500, 0, 80)
    })
    fadeInTween:Play()
    
    -- Typewriter effect
    spawn(function()
        wait(0.5) -- Wait for fade in to start
        
        for i = 1, #text do
            textLabel.Text = string.sub(text, 1, i)
            wait(0.04) -- Typewriter speed
        end
        
        -- Hold the text for 7 seconds
        wait(7)
        
        -- Fade out effect
        local fadeOutTween = TweenService:Create(frame, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -500, 0, -150)
        })
        
        local transparencyTween = TweenService:Create(textLabel, TweenInfo.new(1.2), {
            TextTransparency = 1
        })
        
        local backgroundTween = TweenService:Create(background, TweenInfo.new(1.2), {
            BackgroundTransparency = 1
        })
        
        local strokeTween = TweenService:Create(stroke, TweenInfo.new(1.2), {
            Transparency = 1
        })
        
        fadeOutTween:Play()
        transparencyTween:Play()
        backgroundTween:Play()
        strokeTween:Play()
        
        fadeOutTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

-- Connect to RemoteEvent
announcementEvent.OnClientEvent:Connect(function(text)
    createAnnouncement(text)
end)

print("[CLIENT] Announcement system loaded for " .. player.Name)