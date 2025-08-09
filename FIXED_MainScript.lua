-- FIXED_MainScript.lua - Complete fixed main script
-- Place this script in ServerScriptService

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
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

-- Default lighting settings
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
    print("[SERVER] Sending announcement: " .. text)
    announcementEvent:FireAllClients(text)
end

-- Server Luck Effect
local function applyServerLuck()
    if ActiveEvents["serverluck"] then return end
    ActiveEvents["serverluck"] = true
    print("[EFFECT] Server Luck activated for 3 minutes")
    
    -- Green atmosphere
    local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine)
    local lightingTween = TweenService:Create(Lighting, tweenInfo, {
        FogColor = Color3.fromRGB(144, 238, 144),
        FogEnd = 400,
        FogStart = 50,
        Ambient = Color3.fromRGB(120, 255, 120),
        ColorShift_Top = Color3.fromRGB(180, 255, 180),
        Brightness = 2.5
    })
    lightingTween:Play()
    
    -- Lucky atmosphere part
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
        wait(180)
        ActiveEvents["serverluck"] = false
        print("[EFFECT] Server Luck expired")
        
        local restoreTween = TweenService:Create(Lighting, tweenInfo, DefaultLighting)
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

-- Night Effect
local function applyNight()
    if ActiveEvents["night"] then return end
    ActiveEvents["night"] = true
    print("[EFFECT] Night mode activated for 1 minute")
    
    local originalTime = Lighting.ClockTime
    
    local nightTween = TweenService:Create(Lighting, TweenInfo.new(5, Enum.EasingStyle.Sine), {
        ClockTime = 0,
        Brightness = 0.3,
        Ambient = Color3.fromRGB(15, 15, 40),
        ColorShift_Bottom = Color3.fromRGB(5, 5, 20),
        ColorShift_Top = Color3.fromRGB(30, 30, 80),
        FogColor = Color3.fromRGB(20, 20, 40)
    })
    nightTween:Play()
    
    -- Auto expire after 1 minute
    spawn(function()
        wait(60)
        ActiveEvents["night"] = false
        print("[EFFECT] Night mode expired")
        
        local dayTween = TweenService:Create(Lighting, TweenInfo.new(5, Enum.EasingStyle.Sine), {
            ClockTime = originalTime,
            Brightness = DefaultLighting.Brightness,
            Ambient = DefaultLighting.Ambient,
            ColorShift_Bottom = DefaultLighting.ColorShift_Bottom,
            ColorShift_Top = DefaultLighting.ColorShift_Top,
            FogColor = DefaultLighting.FogColor
        })
        dayTween:Play()
    end)
end

-- Rain Effect
local function applyRain()
    if ActiveEvents["rain"] then return end
    ActiveEvents["rain"] = true
    print("[EFFECT] Rain activated for 50 seconds")
    
    -- Rain sound
    local rainSound = Instance.new("Sound")
    rainSound.Name = "RainSound"
    rainSound.SoundId = "rbxassetid://131961136"
    rainSound.Volume = 0.6
    rainSound.Looped = true
    rainSound.Parent = Workspace
    rainSound:Play()
    
    -- Rain atmosphere
    local rainTween = TweenService:Create(Lighting, TweenInfo.new(3), {
        FogColor = Color3.fromRGB(90, 90, 110),
        FogEnd = 300,
        FogStart = 20,
        Brightness = 1.8,
        Ambient = Color3.fromRGB(70, 70, 90),
        ColorShift_Top = Color3.fromRGB(100, 100, 120)
    })
    rainTween:Play()
    
    -- Auto expire after 50 seconds
    spawn(function()
        wait(50)
        ActiveEvents["rain"] = false
        print("[EFFECT] Rain expired")
        
        rainSound:Stop()
        rainSound:Destroy()
        
        local restoreTween = TweenService:Create(Lighting, TweenInfo.new(3), {
            FogColor = DefaultLighting.FogColor,
            FogEnd = DefaultLighting.FogEnd,
            FogStart = DefaultLighting.FogStart,
            Brightness = DefaultLighting.Brightness,
            Ambient = DefaultLighting.Ambient,
            ColorShift_Top = DefaultLighting.ColorShift_Top
        })
        restoreTween:Play()
    end)
end

-- Rainbow Effect
local function applyRainbow()
    if ActiveEvents["rainbow"] then return end
    ActiveEvents["rainbow"] = true
    print("[EFFECT] Rainbow sky activated for 1 minute 32 seconds")
    
    local colors = {
        Color3.fromRGB(255, 100, 100),
        Color3.fromRGB(255, 180, 100),
        Color3.fromRGB(255, 255, 100),
        Color3.fromRGB(100, 255, 100),
        Color3.fromRGB(100, 100, 255),
        Color3.fromRGB(150, 100, 200),
        Color3.fromRGB(255, 150, 255)
    }
    
    local colorIndex = 1
    local lastUpdate = 0
    
    local rainbowConnection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        if currentTime - lastUpdate >= 0.5 then
            local currentColor = colors[colorIndex]
            
            local colorTween = TweenService:Create(Lighting, TweenInfo.new(0.4), {
                ColorShift_Top = currentColor,
                Ambient = currentColor * 0.4,
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
        wait(92)
        ActiveEvents["rainbow"] = false
        print("[EFFECT] Rainbow sky expired")
        
        if EventConnections["rainbow"] then
            EventConnections["rainbow"]:Disconnect()
            EventConnections["rainbow"] = nil
        end
        
        local restoreTween = TweenService:Create(Lighting, TweenInfo.new(3), {
            ColorShift_Top = DefaultLighting.ColorShift_Top,
            Ambient = DefaultLighting.Ambient,
            FogColor = DefaultLighting.FogColor
        })
        restoreTween:Play()
    end)
end

-- Maze Effect
local function showMaze()
    if ActiveEvents["maze"] then return end
    ActiveEvents["maze"] = true
    print("[EFFECT] Maze revealed for 1 minute")
    
    local mazeModel = Workspace:FindFirstChild("MazeModel")
    if mazeModel then
        local parts = {}
        for _, descendant in pairs(mazeModel:GetDescendants()) do
            if descendant:IsA("BasePart") then
                table.insert(parts, descendant)
                descendant.Transparency = 1
            end
        end
        
        -- Progressive reveal
        spawn(function()
            for i, part in ipairs(parts) do
                local revealTween = TweenService:Create(part, TweenInfo.new(0.1), {Transparency = 0})
                revealTween:Play()
                wait(0.02)
            end
        end)
        
        -- Auto expire after 1 minute
        spawn(function()
            wait(60)
            ActiveEvents["maze"] = false
            print("[EFFECT] Maze hidden")
            
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

-- Command Handler
local function handleCommand(player, message)
    local userId = player.UserId
    
    if not string.sub(message, 1, 1) == "." then
        return
    end
    
    if not WhitelistModule.isWhitelisted(userId) then
        print("[WHITELIST] ✗ " .. player.Name .. " (" .. userId .. ") attempted: " .. message .. " - DENIED")
        return
    end
    
    print("[WHITELIST] ✓ " .. player.Name .. " (" .. userId .. ") executed: " .. message)
    
    local command = string.lower(message)
    
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
        local text = string.sub(message, 6)
        if text and text ~= "" then
            showAnnouncement(text)
            MessagingService:PublishAsync(MESSAGING_TOPIC, {command = "announcement", text = text, player = player.Name})
        end
    end
end

-- Cross-server message handler
local function handleCrossServerMessage(data)
    local command = data.command
    print("[CROSS-SERVER] Received: " .. command)
    
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

-- Player setup
local function onPlayerAdded(player)
    print("[PLAYER] " .. player.Name .. " joined (ID: " .. player.UserId .. ")")
    
    if WhitelistModule.isWhitelisted(player.UserId) then
        print("[WHITELIST] " .. player.Name .. " has command permissions")
    end
    
    player.Chatted:Connect(function(message)
        handleCommand(player, message)
    end)
end

-- Connect events
Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Subscribe to MessagingService
local success, error = pcall(function()
    MessagingService:SubscribeAsync(MESSAGING_TOPIC, handleCrossServerMessage)
end)

if success then
    print("[MESSAGING] Cross-server commands enabled")
else
    print("[ERROR] MessagingService failed: " .. tostring(error))
end

print("[SYSTEM] ✅ FIXED Command System Loaded!")
print("[SYSTEM] Whitelisted users: " .. table.concat(WhitelistModule.getWhitelistedUsers(), ", "))