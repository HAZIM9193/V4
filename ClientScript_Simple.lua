-- ClientScript_Simple.lua - Simple and reliable announcement system
-- Place this script in StarterPlayerScripts (inside StarterPlayer)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- Wait for player GUI
local playerGui = player:WaitForChild("PlayerGui")

-- Simple function to show announcement
local function showAnnouncement(text)
    print("[CLIENT] Showing announcement: " .. text)
    
    -- Remove existing announcement
    local existing = playerGui:FindFirstChild("SimpleAnnouncement")
    if existing then existing:Destroy() end
    
    -- Create GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "SimpleAnnouncement"
    gui.Parent = playerGui
    
    -- Create text
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 600, 0, 50)
    label.Position = UDim2.new(0.5, -300, 0, 80)
    label.BackgroundTransparency = 1
    label.Text = ""
    label.TextSize = 28
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Parent = gui
    
    -- Typewriter effect
    spawn(function()
        -- Type out text
        for i = 1, #text do
            label.Text = string.sub(text, 1, i)
            wait(0.06)
        end
        
        -- Wait 7 seconds
        wait(7)
        
        -- Fade out
        for i = 0, 10 do
            label.TextTransparency = i / 10
            label.TextStrokeTransparency = i / 10
            wait(0.1)
        end
        
        -- Remove GUI
        gui:Destroy()
    end)
end

-- Wait for RemoteEvent and connect
spawn(function()
    wait(3) -- Wait for server setup
    
    local success, err = pcall(function()
        local commandEvents = ReplicatedStorage:WaitForChild("CommandEvents", 15)
        local announcementEvent = commandEvents:WaitForChild("ShowAnnouncement", 15)
        
        announcementEvent.OnClientEvent:Connect(showAnnouncement)
        print("[CLIENT] Connected to announcement system!")
    end)
    
    if not success then
        warn("[CLIENT] Failed to connect: " .. tostring(err))
    end
end)

-- Test function (you can remove this later)
spawn(function()
    wait(5)
    print("[CLIENT] Client script loaded for " .. player.Name)
end)