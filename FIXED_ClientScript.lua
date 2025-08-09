-- FIXED_ClientScript.lua - Completely fixed announcement system
-- Place this script in StarterPlayerScripts (inside StarterPlayer)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Function to show announcement
local function showAnnouncement(text)
    print("[CLIENT] Creating announcement: " .. text)
    
    -- Remove any existing announcement
    local existing = playerGui:FindFirstChild("AnnouncementGUI")
    if existing then
        existing:Destroy()
    end
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AnnouncementGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Create TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "AnnouncementText"
    textLabel.Size = UDim2.new(0, 700, 0, 60)
    textLabel.Position = UDim2.new(0.5, -350, 0, 100) -- Top center
    textLabel.BackgroundTransparency = 1
    textLabel.Text = ""
    textLabel.TextSize = 30
    textLabel.TextColor3 = Color3.new(1, 1, 1) -- White
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0) -- Black outline
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.Parent = screenGui
    
    -- Typewriter effect
    spawn(function()
        -- Type each character
        for i = 1, #text do
            textLabel.Text = string.sub(text, 1, i)
            wait(0.05) -- Typing speed
        end
        
        -- Wait 7 seconds
        wait(7)
        
        -- Fade out
        for transparency = 0, 1, 0.1 do
            textLabel.TextTransparency = transparency
            textLabel.TextStrokeTransparency = transparency
            wait(0.1)
        end
        
        -- Clean up
        screenGui:Destroy()
        print("[CLIENT] Announcement finished")
    end)
end

-- Connect to RemoteEvent
spawn(function()
    -- Wait for server to create RemoteEvents
    wait(3)
    
    local success = pcall(function()
        local commandEvents = ReplicatedStorage:WaitForChild("CommandEvents", 20)
        local announcementEvent = commandEvents:WaitForChild("ShowAnnouncement", 20)
        
        -- Connect the function
        announcementEvent.OnClientEvent:Connect(showAnnouncement)
        print("[CLIENT] ✅ Announcement system connected!")
    end)
    
    if not success then
        warn("[CLIENT] ❌ Failed to connect to announcement system")
    end
end)

print("[CLIENT] Fixed announcement script loaded for " .. player.Name)