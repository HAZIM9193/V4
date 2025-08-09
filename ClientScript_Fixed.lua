-- ClientScript_Fixed.lua - Fixed client-side GUI handler for announcements
-- Place this script in StarterPlayerScripts (inside StarterPlayer)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for RemoteEvents to be created
wait(2) -- Give server time to create RemoteEvents
local commandEvents = ReplicatedStorage:WaitForChild("CommandEvents", 10)
if not commandEvents then
    warn("[CLIENT] CommandEvents folder not found!")
    return
end

local announcementEvent = commandEvents:WaitForChild("ShowAnnouncement", 10)
if not announcementEvent then
    warn("[CLIENT] ShowAnnouncement RemoteEvent not found!")
    return
end

-- Function to create and display announcement
local function createAnnouncement(text)
    print("[CLIENT] Creating announcement: " .. text)
    
    -- Remove any existing announcement
    local existingGui = playerGui:FindFirstChild("AnnouncementGui")
    if existingGui then
        existingGui:Destroy()
    end
    
    -- Create new announcement GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AnnouncementGui"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 100 -- High priority
    screenGui.Parent = playerGui
    
    -- Create text label (simple and direct approach)
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "AnnouncementText"
    textLabel.Size = UDim2.new(0, 800, 0, 80)
    textLabel.Position = UDim2.new(0.5, -400, 0, 100) -- Top center of screen
    textLabel.BackgroundTransparency = 1
    textLabel.Text = ""
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 32
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextStrokeThickness = 1
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.TextTransparency = 1 -- Start invisible
    textLabel.Parent = screenGui
    
    -- Fade in the text first
    local fadeInTween = TweenService:Create(textLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        TextTransparency = 0,
        TextStrokeTransparency = 0
    })
    fadeInTween:Play()
    
    -- Start typewriter effect after fade in
    fadeInTween.Completed:Connect(function()
        -- Typewriter effect
        spawn(function()
            for i = 1, #text do
                textLabel.Text = string.sub(text, 1, i)
                wait(0.05) -- Typewriter speed
            end
            
            -- Hold the complete text for 7 seconds
            wait(7)
            
            -- Fade out effect
            local fadeOutTween = TweenService:Create(textLabel, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            })
            fadeOutTween:Play()
            
            fadeOutTween.Completed:Connect(function()
                screenGui:Destroy()
                print("[CLIENT] Announcement removed")
            end)
        end)
    end)
end

-- Connect to RemoteEvent
announcementEvent.OnClientEvent:Connect(function(text)
    print("[CLIENT] Received announcement request: " .. tostring(text))
    if text and text ~= "" then
        createAnnouncement(text)
    else
        warn("[CLIENT] Empty or nil text received for announcement")
    end
end)

print("[CLIENT] Fixed announcement system loaded for " .. player.Name)