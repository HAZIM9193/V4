-- MainScript_Improved.lua - Enhanced main command handler with proper GUI system
-- Place this script in ServerScriptService

local Players = Players or game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Import whitelist module
local WhitelistModule = require(script.Parent.WhitelistModule)

-- Create RemoteEvents for client communication
local remoteEvents = Instance.new("Folder")
remoteEvents.Name = "CommandEvents"
remoteEvents.Parent = ReplicatedStorage

local announcementEvent = Instance.new("RemoteEvent")
announcementEvent.Name = "ShowAnnouncement"
announcementEvent.Parent = remoteEvents

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

-- Function to show announcement to all players
local function showAnnouncement(text)
    announcementEvent:FireAllClients(text)
end

-- Function to apply server luck effect
local function applyServerLuck()
    if ActiveEvents["serverluck"] then return end
    ActiveEvents["serverluck"] = true
    
    print("[EFFECT] Server Luck activated for 3 minutes")
    
    -- Create green atmosphere with enhanced effects
    local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    
    local lightingTween = TweenService:Create(Lighting, tweenInfo, {
        FogColor = Color3.fromRGB(144, 238, 144),
        FogEnd = 400,
        FogStart = 50,
        Ambient = Color3.fromRGB(120, 255, 120),
        ColorShift_Top = Color3.fromRGB(180, 255, 180),
        ColorShift_Bottom = Color3.fromRGB(100, 200, 100),
        Brightness = 2.5
    })
    lightingTween:Play()
    
    -- Create lucky atmosphere part
    local luckyPart = Instance.new("Part")
    luckyPart.Name = "LuckyAtmosphere"
    luckyPart.Size = Vector3.new(2000, 1, 2000)
    luckyPart.Position = Vector3.new(0, 300, 0)
    luckyPart.Anchored = true
    luckyPart.CanCollide = false
    luckyPart.Transparency = 0.8
    luckyPart.BrickColor = BrickColor.new("Bright green")
    luckyPart.Material = Enum.Material.ForceField
    luckyPart.Parent = Workspace
    
    -- Auto expire after 3 minutes
    spawn(function()
        wait(180) -- 3 minutes
        ActiveEvents["serverluck"] = false
        print("[EFFECT] Server Luck expired")
        
        -- Smooth restoration
        local restoreTween = TweenService:Create(Lighting, tweenInfo, {
            FogColor = DefaultLighting.FogColor,
            FogEnd = DefaultLighting.FogEnd,
            FogStart = DefaultLighting.FogStart,
            Ambient = DefaultLighting.Ambient,
            ColorShift_Top = DefaultLighting.ColorShift_Top,
            ColorShift_Bottom = DefaultLighting.ColorShift_Bottom,
            Brightness = DefaultLighting.Brightness
        })
        restoreTween:Play()
        
        if luckyPart and luckyPart.Parent then
            local fadeTween = TweenService:Create(luckyPart, TweenInfo.new(3), {Transparency = 1})
            fadeTween:Play()
            fadeTween.Completed:Connect(function()
                luckyPart:Destroy()
            end)
        end
    end)
end

-- Function to apply night effect
local function applyNight()
    if ActiveEvents["night"] then return end
    ActiveEvents["night"] = true
    
    print("[EFFECT] Night mode activated for 1 minute")
    
    local originalTime = Lighting.ClockTime
    
    -- Enhanced night transition
    local nightTween = TweenService:Create(Lighting, TweenInfo.new(8, Enum.EasingStyle.Sine), {
        ClockTime = 0,
        Brightness = 0.3,
        Ambient = Color3.fromRGB(15, 15, 40),
        ColorShift_Bottom = Color3.fromRGB(5, 5, 20),
        ColorShift_Top = Color3.fromRGB(30, 30, 80),
        FogColor = Color3.fromRGB(20, 20, 40),
        OutdoorAmbient = Color3.fromRGB(10, 10, 30)
    })
    nightTween:Play()
    
    -- Create starry sky effect
    local skyPart = Instance.new("Part")
    skyPart.Name = "NightSky"
    skyPart.Size = Vector3.new(2000, 1, 2000)
    skyPart.Position = Vector3.new(0, 500, 0)
    skyPart.Anchored = true
    skyPart.CanCollide = false
    skyPart.Transparency = 0.9
    skyPart.BrickColor = BrickColor.new("Really black")
    skyPart.Parent = Workspace
    
    -- Auto expire after 1 minute
    spawn(function()
        wait(60) -- 1 minute
        ActiveEvents["night"] = false
        print("[EFFECT] Night mode expired")
        
        -- Smooth transition back to day
        local dayTween = TweenService:Create(Lighting, TweenInfo.new(8, Enum.EasingStyle.Sine), {
            ClockTime = originalTime,
            Brightness = DefaultLighting.Brightness,
            Ambient = DefaultLighting.Ambient,
            ColorShift_Bottom = DefaultLighting.ColorShift_Bottom,
            ColorShift_Top = DefaultLighting.ColorShift_Top,
            FogColor = DefaultLighting.FogColor,
            OutdoorAmbient = DefaultLighting.OutdoorAmbient
        })
        dayTween:Play()
        
        if skyPart and skyPart.Parent then
            local fadeTween = TweenService:Create(skyPart, TweenInfo.new(5), {Transparency = 1})
            fadeTween:Play()
            fadeTween.Completed:Connect(function()
                skyPart:Destroy()
            end)
        end
    end)
end

-- Function to apply rain effect
local function applyRain()
    if ActiveEvents["rain"] then return end
    ActiveEvents["rain"] = true
    
    print("[EFFECT] Rain activated for 50 seconds")
    
    -- Create enhanced rain sound
    local rainSound = Instance.new("Sound")
    rainSound.Name = "RainAmbience"
    rainSound.SoundId = "rbxassetid://131961136" -- Rain sound
    rainSound.Volume = 0.6
    rainSound.Looped = true
    rainSound.Parent = Workspace
    rainSound:Play()
    
    -- Create rain atmosphere
    local rainTween = TweenService:Create(Lighting, TweenInfo.new(3), {
        FogColor = Color3.fromRGB(90, 90, 110),
        FogEnd = 300,
        FogStart = 20,
        Brightness = 1.8,
        Ambient = Color3.fromRGB(70, 70, 90),
        ColorShift_Top = Color3.fromRGB(100, 100, 120)
    })
    rainTween:Play()
    
    -- Create rain cloud effect
    local rainCloud = Instance.new("Part")
    rainCloud.Name = "RainCloud"
    rainCloud.Size = Vector3.new(1500, 50, 1500)
    rainCloud.Position = Vector3.new(0, 400, 0)
    rainCloud.Anchored = true
    rainCloud.CanCollide = false
    rainCloud.Transparency = 0.3
    rainCloud.BrickColor = BrickColor.new("Dark stone grey")
    rainCloud.Material = Enum.Material.ForceField
    rainCloud.Parent = Workspace
    
    -- Auto expire after 50 seconds
    spawn(function()
        wait(50) -- 50 seconds
        ActiveEvents["rain"] = false
        print("[EFFECT] Rain expired")
        
        -- Fade out rain
        local fadeSound = TweenService:Create(rainSound, TweenInfo.new(3), {Volume = 0})
        fadeSound:Play()
        fadeSound.Completed:Connect(function()
            rainSound:Stop()
            rainSound:Destroy()
        end)
        
        -- Restore lighting
        local restoreTween = TweenService:Create(Lighting, TweenInfo.new(5), {
            FogColor = DefaultLighting.FogColor,
            FogEnd = DefaultLighting.FogEnd,
            FogStart = DefaultLighting.FogStart,
            Brightness = DefaultLighting.Brightness,
            Ambient = DefaultLighting.Ambient,
            ColorShift_Top = DefaultLighting.ColorShift_Top
        })
        restoreTween:Play()
        
        if rainCloud and rainCloud.Parent then
            local cloudFade = TweenService:Create(rainCloud, TweenInfo.new(5), {Transparency = 1})
            cloudFade:Play()
            cloudFade.Completed:Connect(function()
                rainCloud:Destroy()
            end)
        end
    end)
end

-- Function to apply rainbow effect
local function applyRainbow()
    if ActiveEvents["rainbow"] then return end
    ActiveEvents["rainbow"] = true
    
    print("[EFFECT] Rainbow sky activated for 1 minute 32 seconds")
    
    local colors = {
        Color3.fromRGB(255, 100, 100),  -- Light Red
        Color3.fromRGB(255, 180, 100),  -- Light Orange
        Color3.fromRGB(255, 255, 100),  -- Light Yellow
        Color3.fromRGB(100, 255, 100),  -- Light Green
        Color3.fromRGB(100, 100, 255),  -- Light Blue
        Color3.fromRGB(150, 100, 200),  -- Light Indigo
        Color3.fromRGB(255, 150, 255)   -- Light Violet
    }
    
    local colorIndex = 1
    local rainbowConnection
    local lastUpdate = 0
    
    rainbowConnection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        if currentTime - lastUpdate >= 0.5 then -- Update every 0.5 seconds
            local currentColor = colors[colorIndex]
            
            -- Smooth color transitions
            local colorTween = TweenService:Create(Lighting, TweenInfo.new(0.4), {
                ColorShift_Top = currentColor,
                Ambient = currentColor * 0.4,
                ColorShift_Bottom = currentColor * 0.6,
                FogColor = currentColor * 0.8
            })
            colorTween:Play()
            
            colorIndex = colorIndex + 1
            if colorIndex > #colors then
                colorIndex = 1
            end
            
            lastUpdate = currentTime
        end
    end)
    
    EventConnections["rainbow"] = rainbowConnection
    
    -- Auto expire after 1 minute 32 seconds
    spawn(function()
        wait(92) -- 1 minute 32 seconds
        ActiveEvents["rainbow"] = false
        print("[EFFECT] Rainbow sky expired")
        
        if EventConnections["rainbow"] then
            EventConnections["rainbow"]:Disconnect()
            EventConnections["rainbow"] = nil
        end
        
        -- Restore lighting smoothly
        local restoreTween = TweenService:Create(Lighting, TweenInfo.new(3), {
            ColorShift_Top = DefaultLighting.ColorShift_Top,
            Ambient = DefaultLighting.Ambient,
            ColorShift_Bottom = DefaultLighting.ColorShift_Bottom,
            FogColor = DefaultLighting.FogColor
        })
        restoreTween:Play()
    end)
end

-- Function to show maze
local function showMaze()
    if ActiveEvents["maze"] then return end
    ActiveEvents["maze"] = true
    
    print("[EFFECT] Maze revealed for 1 minute")
    
    local mazeModel = Workspace:FindFirstChild("MazeModel")
    if mazeModel then
        -- Progressive reveal effect
        local parts = {}
        for _, descendant in pairs(mazeModel:GetDescendants()) do
            if descendant:IsA("BasePart") then
                table.insert(parts, descendant)
                descendant.Transparency = 1 -- Start invisible
            end
        end
        
        -- Reveal parts progressively
        spawn(function()
            for i, part in ipairs(parts) do
                local revealTween = TweenService:Create(part, TweenInfo.new(0.1), {Transparency = 0})
                revealTween:Play()
                wait(0.02) -- Small delay between reveals
            end
        end)
        
        -- Auto expire after 1 minute
        spawn(function()
            wait(60) -- 1 minute
            ActiveEvents["maze"] = false
            print("[EFFECT] Maze hidden")
            
            -- Hide parts progressively
            for i = #parts, 1, -1 do
                local part = parts[i]
                if part and part.Parent then
                    local hideTween = TweenService:Create(part, TweenInfo.new(0.1), {Transparency = 1})
                    hideTween:Play()
                    wait(0.02)
                end
            end
        end)
    else
        print("[WARNING] MazeModel not found in Workspace")
    end
end

-- Function to handle commands
local function handleCommand(player, message)
    local userId = player.UserId
    
    -- Check if message starts with "."
    if not string.sub(message, 1, 1) == "." then
        return
    end
    
    -- Check whitelist with logging
    if not WhitelistModule.checkAndLog(userId, player.Name, message) then
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
            showAnnouncement(text)
            MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "announcement", text = text, player = player.Name})
        end
    end
end

-- Function to handle cross-server messages
local function handleCrossServerMessage(data)
    local command = data.command
    print("[CROSS-SERVER] Received command: " .. command .. " from " .. (data.player or "Unknown"))
    
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
        showAnnouncement(data.text)
    end
end

-- Player detection and setup
local function onPlayerAdded(player)
    print("[PLAYER] " .. player.Name .. " joined (ID: " .. player.UserId .. ")")
    
    -- Check if player is whitelisted
    if WhitelistModule.isWhitelisted(player.UserId) then
        print("[WHITELIST] " .. player.Name .. " has command permissions")
    end
    
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

-- Subscribe to MessagingService with error handling
local success, error = pcall(function()
    MessagingService:SubscribeAsync(MESSAGING_TOPIC, handleCrossServerMessage)
end)

if success then
    print("[MESSAGING] Successfully subscribed to cross-server commands")
else
    print("[ERROR] Failed to subscribe to MessagingService: " .. tostring(error))
end

print("[SYSTEM] Enhanced command system loaded successfully!")
print("[SYSTEM] Whitelisted users: " .. table.concat(WhitelistModule.getWhitelistedUsers(), ", "))