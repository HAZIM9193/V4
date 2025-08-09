-- MainScript.lua - Main command handler and effects script
-- Place this script in ServerScriptService

local Players = Players or game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local MessagingService = game:GetService("MessagingService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Import whitelist module
local WhitelistModule = require(script.Parent.WhitelistModule)

-- Active events tracking
local ActiveEvents = {}
local EventConnections = {}

-- MessagingService topic
local MESSAGING_TOPIC = "ServerCommands"

-- Default lighting settings for restoration
local DefaultLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogColor = Lighting.FogColor,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    Ambient = Lighting.Ambient,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    ColorShift_Top = Lighting.ColorShift_Top,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ShadowColor = Lighting.ShadowColor
}

-- Function to create GUI announcement
local function createAnnouncement(text)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AnnouncementGui"
    screenGui.Parent = game:GetService("StarterGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 800, 0, 100)
    frame.Position = UDim2.new(0.5, -400, 0, 50)
    frame.BackgroundTransparency = 1
    frame.Parent = screenGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = ""
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = frame
    
    -- Typewriter effect
    spawn(function()
        for i = 1, #text do
            textLabel.Text = string.sub(text, 1, i)
            wait(0.05)
        end
        
        -- Fade out after 7 seconds
        wait(7)
        local fadeOut = TweenService:Create(textLabel, TweenInfo.new(1), {TextTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
    
    return screenGui
end

-- Function to apply server luck effect
local function applyServerLuck()
    if ActiveEvents["serverluck"] then return end
    ActiveEvents["serverluck"] = true
    
    -- Green cloudy sky with lucky effects
    local originalSkybox = Lighting.SkyboxBk
    
    -- Create green atmosphere
    Lighting.FogColor = Color3.fromRGB(144, 238, 144)
    Lighting.FogEnd = 500
    Lighting.Ambient = Color3.fromRGB(100, 255, 100)
    Lighting.ColorShift_Top = Color3.fromRGB(150, 255, 150)
    
    -- Add particle effects (simplified representation)
    local part = Instance.new("Part")
    part.Name = "LuckyCloudEffect"
    part.Size = Vector3.new(1000, 1, 1000)
    part.Position = Vector3.new(0, 200, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Parent = Workspace
    
    -- Auto expire after 3 minutes
    spawn(function()
        wait(180) -- 3 minutes
        ActiveEvents["serverluck"] = false
        
        -- Restore default lighting
        Lighting.FogColor = DefaultLighting.FogColor
        Lighting.FogEnd = DefaultLighting.FogEnd
        Lighting.Ambient = DefaultLighting.Ambient
        Lighting.ColorShift_Top = DefaultLighting.ColorShift_Top
        
        if part and part.Parent then
            part:Destroy()
        end
    end)
end

-- Function to apply night effect
local function applyNight()
    if ActiveEvents["night"] then return end
    ActiveEvents["night"] = true
    
    local originalTime = Lighting.ClockTime
    
    -- Smooth transition to night
    local nightTween = TweenService:Create(Lighting, TweenInfo.new(5), {
        ClockTime = 0,
        Brightness = 0.5,
        Ambient = Color3.fromRGB(25, 25, 50),
        ColorShift_Bottom = Color3.fromRGB(0, 0, 25),
        ColorShift_Top = Color3.fromRGB(50, 50, 100)
    })
    nightTween:Play()
    
    -- Auto expire after 1 minute
    spawn(function()
        wait(60) -- 1 minute
        ActiveEvents["night"] = false
        
        -- Smooth transition back to day
        local dayTween = TweenService:Create(Lighting, TweenInfo.new(5), {
            ClockTime = originalTime,
            Brightness = DefaultLighting.Brightness,
            Ambient = DefaultLighting.Ambient,
            ColorShift_Bottom = DefaultLighting.ColorShift_Bottom,
            ColorShift_Top = DefaultLighting.ColorShift_Top
        })
        dayTween:Play()
    end)
end

-- Function to apply rain effect
local function applyRain()
    if ActiveEvents["rain"] then return end
    ActiveEvents["rain"] = true
    
    -- Create rain sound
    local rainSound = Instance.new("Sound")
    rainSound.Name = "RainSound"
    rainSound.SoundId = "rbxassetid://131961136" -- Rain sound ID
    rainSound.Volume = 0.5
    rainSound.Looped = true
    rainSound.Parent = Workspace
    rainSound:Play()
    
    -- Create rain particles (simplified)
    local rainPart = Instance.new("Part")
    rainPart.Name = "RainEffect"
    rainPart.Size = Vector3.new(1000, 1, 1000)
    rainPart.Position = Vector3.new(0, 300, 0)
    rainPart.Anchored = true
    rainPart.CanCollide = false
    rainPart.Transparency = 1
    rainPart.Parent = Workspace
    
    -- Adjust lighting for rain
    Lighting.FogColor = Color3.fromRGB(100, 100, 120)
    Lighting.Brightness = 1.5
    Lighting.Ambient = Color3.fromRGB(80, 80, 100)
    
    -- Auto expire after 50 seconds
    spawn(function()
        wait(50) -- 50 seconds
        ActiveEvents["rain"] = false
        
        rainSound:Stop()
        rainSound:Destroy()
        
        if rainPart and rainPart.Parent then
            rainPart:Destroy()
        end
        
        -- Restore lighting
        Lighting.FogColor = DefaultLighting.FogColor
        Lighting.Brightness = DefaultLighting.Brightness
        Lighting.Ambient = DefaultLighting.Ambient
    end)
end

-- Function to apply rainbow effect
local function applyRainbow()
    if ActiveEvents["rainbow"] then return end
    ActiveEvents["rainbow"] = true
    
    local colors = {
        Color3.fromRGB(255, 0, 0),    -- Red
        Color3.fromRGB(255, 165, 0),  -- Orange
        Color3.fromRGB(255, 255, 0),  -- Yellow
        Color3.fromRGB(0, 255, 0),    -- Green
        Color3.fromRGB(0, 0, 255),    -- Blue
        Color3.fromRGB(75, 0, 130),   -- Indigo
        Color3.fromRGB(238, 130, 238) -- Violet
    }
    
    local colorIndex = 1
    local rainbowConnection
    
    rainbowConnection = RunService.Heartbeat:Connect(function()
        Lighting.ColorShift_Top = colors[colorIndex]
        Lighting.Ambient = colors[colorIndex] * 0.3
        
        colorIndex = colorIndex + 1
        if colorIndex > #colors then
            colorIndex = 1
        end
        
        wait(0.2) -- Color change interval
    end)
    
    EventConnections["rainbow"] = rainbowConnection
    
    -- Auto expire after 1 minute 32 seconds
    spawn(function()
        wait(92) -- 1 minute 32 seconds
        ActiveEvents["rainbow"] = false
        
        if EventConnections["rainbow"] then
            EventConnections["rainbow"]:Disconnect()
            EventConnections["rainbow"] = nil
        end
        
        -- Restore lighting
        Lighting.ColorShift_Top = DefaultLighting.ColorShift_Top
        Lighting.Ambient = DefaultLighting.Ambient
    end)
end

-- Function to show maze
local function showMaze()
    if ActiveEvents["maze"] then return end
    ActiveEvents["maze"] = true
    
    -- This assumes you have a maze model in the workspace
    -- You'll need to replace this with your actual maze model
    local mazeModel = Workspace:FindFirstChild("MazeModel")
    if mazeModel then
        mazeModel.Parent = Workspace
        
        -- Make maze visible
        for _, part in pairs(mazeModel:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
    
    -- Auto expire after 1 minute
    spawn(function()
        wait(60) -- 1 minute
        ActiveEvents["maze"] = false
        
        if mazeModel then
            -- Hide maze
            for _, part in pairs(mazeModel:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
        end
    end)
end

-- Function to handle commands
local function handleCommand(player, message)
    local userId = player.UserId
    
    -- Check if message starts with "."
    if not string.sub(message, 1, 1) == "." then
        return
    end
    
    -- Check whitelist
    if not WhitelistModule.isWhitelisted(userId) then
        return -- Silently ignore non-whitelisted users
    end
    
    local command = string.lower(message)
    
    -- Parse commands
    if command == ".event serverluck" then
        applyServerLuck()
        MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "serverluck", player = player.Name})
        
    elseif command == ".event night" then
        applyNight()
        MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "night", player = player.Name})
        
    elseif command == ".event rain" then
        applyRain()
        MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "rain", player = player.Name})
        
    elseif command == ".event rainbow" then
        applyRainbow()
        MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "rainbow", player = player.Name})
        
    elseif command == ".maze" then
        showMaze()
        MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "maze", player = player.Name})
        
    elseif string.sub(command, 1, 5) == ".ann " then
        local text = string.sub(message, 6) -- Get text after ".ann "
        if text and text ~= "" then
            createAnnouncement(text)
            MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "announcement", text = text, player = player.Name})
        end
    end
end

-- Function to handle cross-server messages
local function handleCrossServerMessage(data)
    local command = data.command
    
    if command == "serverluck" then
        applyServerLuck()
    elseif command == "night" then
        applyNight()
    elseif command == "rain" then
        applyRain()
    elseif command == "rainbow" then
        applyRainbow()
    elseif command == "maze" then
        showMaze()
    elseif command == "announcement" then
        createAnnouncement(data.text)
    end
end

-- Player detection and setup
local function onPlayerAdded(player)
    print("Player joined: " .. player.Name .. " (ID: " .. player.UserId .. ")")
    
    -- Connect to player's chatted event
    player.Chatted:Connect(function(message)
        handleCommand(player, message)
    end)
end

-- Connect events
Players.PlayerAdded:Connect(onPlayerAdded)

-- Handle players already in game
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Subscribe to MessagingService
MessagingService:SubscribeAsync(MESSAGING_TOPIC, handleCrossServerMessage)

print("Main script loaded successfully!")