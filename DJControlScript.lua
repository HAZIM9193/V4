-- DJ Control Script - Single Server Script for Roblox
-- Place this script in ServerScriptService
-- NOTE: MessagingService only works in Live Server, not Studio unless using Team Test

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local Workspace = workspace
local RunService = game:GetService("RunService")

-- Create RemoteEvents for client-server communication
local remoteEvents = Instance.new("Folder")
remoteEvents.Name = "DJRemoteEvents"
remoteEvents.Parent = ReplicatedStorage

local createGUIRemote = Instance.new("RemoteEvent")
createGUIRemote.Name = "CreateGUI"
createGUIRemote.Parent = remoteEvents

local runCommandRemote = Instance.new("RemoteEvent")
runCommandRemote.Name = "RunCommand"
runCommandRemote.Parent = remoteEvents

-- Variables for DJ state
local djModel = nil
local currentSkybox = nil
local currentAudio = nil
local isPlaying = false
local cleanupConnection = nil

-- Find and setup DJ model on server start
local function setupDJModel()
    djModel = Workspace:FindFirstChild("DJ")
    if djModel then
        -- Make DJ model invisible immediately
        for _, descendant in pairs(djModel:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1
                descendant.CanCollide = false
            elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                descendant.Transparency = 1
            end
        end
        print("DJ model made invisible on server start")
    else
        warn("DJ model not found in Workspace")
    end
end

-- Smooth fade function for DJ model
local function fadeDJModel(fadeIn)
    if not djModel then return end
    
    local targetTransparency = fadeIn and 0 or 1
    local targetCanCollide = fadeIn
    
    for _, descendant in pairs(djModel:GetDescendants()) do
        if descendant:IsA("BasePart") then
            -- Set initial state to ensure tween works properly
            if fadeIn then
                descendant.Transparency = 1 -- Start invisible for fade in
            else
                descendant.Transparency = 0 -- Start visible for fade out
            end
            
            local tween = TweenService:Create(
                descendant,
                TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Transparency = targetTransparency}
            )
            tween:Play()
            descendant.CanCollide = targetCanCollide
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            -- Set initial state for decals/textures too
            if fadeIn then
                descendant.Transparency = 1 -- Start invisible for fade in
            else
                descendant.Transparency = 0 -- Start visible for fade out
            end
            
            local tween = TweenService:Create(
                descendant,
                TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Transparency = targetTransparency}
            )
            tween:Play()
        end
    end
end

-- Apply skybox
local function applySkybox(skyboxId)
    -- Remove existing skybox first
    if currentSkybox then
        currentSkybox:Destroy()
    end
    
    currentSkybox = Instance.new("Sky")
    currentSkybox.SkyboxBk = "rbxassetid://" .. skyboxId
    currentSkybox.SkyboxDn = "rbxassetid://" .. skyboxId
    currentSkybox.SkyboxFt = "rbxassetid://" .. skyboxId
    currentSkybox.SkyboxLf = "rbxassetid://" .. skyboxId
    currentSkybox.SkyboxRt = "rbxassetid://" .. skyboxId
    currentSkybox.SkyboxUp = "rbxassetid://" .. skyboxId
    currentSkybox.Parent = Lighting
end

-- Remove skybox
local function removeSkybox()
    if currentSkybox then
        currentSkybox:Destroy()
        currentSkybox = nil
    end
end

-- Play audio
local function playAudio(audioId)
    -- Stop existing audio first
    if currentAudio then
        currentAudio:Stop()
        currentAudio:Destroy()
    end
    
    currentAudio = Instance.new("Sound")
    currentAudio.SoundId = "rbxassetid://" .. audioId
    currentAudio.Volume = 0.5
    currentAudio.Parent = SoundService
    currentAudio:Play()
end

-- Stop audio
local function stopAudio()
    if currentAudio then
        currentAudio:Stop()
        currentAudio:Destroy()
        currentAudio = nil
    end
end

-- Execute DJ command
local function executeDJCommand()
    if isPlaying then
        print("DJ command already running")
        return
    end
    
    isPlaying = true
    print("Executing DJ command across all servers")
    
    -- Fade in DJ model
    fadeDJModel(true)
    
    -- Apply skybox
    applySkybox("16553683517")
    
    -- Play audio
    playAudio("1835725225")
    
    -- Set timer for 2 minutes 35 seconds (155 seconds)
    task.spawn(function()
        task.wait(155)
        
        -- Cleanup after timer
        print("DJ command timer finished, cleaning up")
        fadeDJModel(false)
        removeSkybox()
        stopAudio()
        isPlaying = false
    end)
end

-- Handle command from client
runCommandRemote.OnServerEvent:Connect(function(player, command)
    if command == "DJ Jhai" then
        print("DJ command received from player:", player.Name)
        
        -- Broadcast to all servers using MessagingService
        local success, errorMessage = pcall(function()
            MessagingService:PublishAsync("DJCommand", {
                command = "DJ Jhai",
                timestamp = tick(),
                player = player.Name
            })
        end)
        
        if success then
            print("DJ command broadcasted to all servers")
            -- Execute locally as well
            task.spawn(executeDJCommand)
        else
            warn("Failed to broadcast DJ command:", errorMessage)
            -- Still execute locally even if broadcast fails
            task.spawn(executeDJCommand)
        end
    end
end)

-- Listen for messages from other servers
local function onMessageReceived(message)
    local data = message.Data
    if data.command == "DJ Jhai" then
        print("Received DJ command from server via MessagingService")
        task.spawn(executeDJCommand)
    end
end

-- Subscribe to MessagingService
local success, connection = pcall(function()
    return MessagingService:SubscribeAsync("DJCommand", onMessageReceived)
end)

if success then
    print("Successfully subscribed to DJ MessagingService")
else
    warn("Failed to subscribe to MessagingService:", connection)
end

-- Create client-side LocalScript for GUI
local function createClientScript(player)
    local localScript = Instance.new("LocalScript")
    localScript.Name = "DJControlGUI"
    
         -- LocalScript source code
     localScript.Source = [[
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Wait for RemoteEvents
local remoteEvents = ReplicatedStorage:WaitForChild("DJRemoteEvents")
local runCommandRemote = remoteEvents:WaitForChild("RunCommand")

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DJControlGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create GX button (left center)
local gxButton = Instance.new("TextButton")
gxButton.Name = "GXButton"
gxButton.Size = UDim2.new(0, 60, 0, 30)
gxButton.Position = UDim2.new(0, 20, 0.5, -15)
gxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
gxButton.BackgroundTransparency = 0.3
gxButton.BorderSizePixel = 0
gxButton.Text = "GX"
gxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
gxButton.TextTransparency = 0.2
gxButton.TextScaled = true
gxButton.Font = Enum.Font.SourceSansBold
gxButton.Parent = screenGui

-- Round corners for GX button
local gxCorner = Instance.new("UICorner")
gxCorner.CornerRadius = UDim.new(0, 6)
gxCorner.Parent = gxButton

-- Create main control frame (initially invisible)
local controlFrame = Instance.new("Frame")
controlFrame.Name = "ControlFrame"
controlFrame.Size = UDim2.new(0, 300, 0, 150)
controlFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
controlFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
controlFrame.BorderSizePixel = 0
controlFrame.Visible = false
controlFrame.Parent = screenGui

-- Round corners for control frame
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = controlFrame

-- Create X button (top-right corner)
local xButton = Instance.new("TextButton")
xButton.Name = "XButton"
xButton.Size = UDim2.new(0, 30, 0, 30)
xButton.Position = UDim2.new(1, -35, 0, 5)
xButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
xButton.BorderSizePixel = 0
xButton.Text = "X"
xButton.TextColor3 = Color3.fromRGB(255, 255, 255)
xButton.TextScaled = true
xButton.Font = Enum.Font.SourceSansBold
xButton.Parent = controlFrame

-- Round corners for X button
local xCorner = Instance.new("UICorner")
xCorner.CornerRadius = UDim.new(0, 15)
xCorner.Parent = xButton

-- Create title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 30)
titleLabel.Position = UDim2.new(0, 5, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "DJ Control Panel"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = controlFrame

-- Create command label
local commandLabel = Instance.new("TextLabel")
commandLabel.Size = UDim2.new(0, 100, 0, 30)
commandLabel.Position = UDim2.new(0, 20, 0, 50)
commandLabel.BackgroundTransparency = 1
commandLabel.Text = "DJ Jhai"
commandLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
commandLabel.TextScaled = true
commandLabel.Font = Enum.Font.SourceSans
commandLabel.TextXAlignment = Enum.TextXAlignment.Left
commandLabel.Parent = controlFrame

-- Create Run button
local runButton = Instance.new("TextButton")
runButton.Size = UDim2.new(0, 80, 0, 30)
runButton.Position = UDim2.new(0, 140, 0, 50)
runButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
runButton.BorderSizePixel = 0
runButton.Text = "Run"
runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
runButton.TextScaled = true
runButton.Font = Enum.Font.SourceSansBold
runButton.Parent = controlFrame

-- Round corners for Run button
local runCorner = Instance.new("UICorner")
runCorner.CornerRadius = UDim.new(0, 6)
runCorner.Parent = runButton

-- Smooth fade in/out functions
local function fadeIn(frame)
    frame.Visible = true
    frame.BackgroundTransparency = 1
    
    local tween = TweenService:Create(
        frame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}
    )
    tween:Play()
    
    -- Fade in children
    for _, child in pairs(frame:GetChildren()) do
        if child:IsA("GuiObject") and not child:IsA("UICorner") then
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                child.TextTransparency = 1
                local textTween = TweenService:Create(
                    child,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {TextTransparency = 0}
                )
                textTween:Play()
            end
            if child.BackgroundTransparency ~= 1 then
                child.BackgroundTransparency = 1
                local bgTween = TweenService:Create(
                    child,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                )
                bgTween:Play()
            end
        end
    end
end

local function fadeOut(frame)
    local tween = TweenService:Create(
        frame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    
    -- Fade out children
    for _, child in pairs(frame:GetChildren()) do
        if child:IsA("GuiObject") and not child:IsA("UICorner") then
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                local textTween = TweenService:Create(
                    child,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {TextTransparency = 1}
                )
                textTween:Play()
            end
            if child.BackgroundTransparency ~= 1 then
                local bgTween = TweenService:Create(
                    child,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                )
                bgTween:Play()
            end
        end
    end
    
    tween:Play()
    tween.Completed:Connect(function()
        frame.Visible = false
    end)
end

-- Button events
gxButton.MouseButton1Click:Connect(function()
    fadeIn(controlFrame)
end)

xButton.MouseButton1Click:Connect(function()
    fadeOut(controlFrame)
end)

runButton.MouseButton1Click:Connect(function()
    -- Send command to server
    runCommandRemote:FireServer("DJ Jhai")
    fadeOut(controlFrame)
end)

print("DJ Control GUI loaded for player:", player.Name)
]]
    
    localScript.Parent = player:WaitForChild("PlayerGui")
end

-- Player joined event to create GUI
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        -- Wait a moment for character to fully load
        task.wait(1)
        createClientScript(player)
    end)
end)

-- Handle players already in game
for _, player in pairs(Players:GetPlayers()) do
    if player.Character then
        createClientScript(player)
    else
        player.CharacterAdded:Connect(function()
            task.wait(1)
            createClientScript(player)
        end)
    end
end

-- Initialize DJ model setup
setupDJModel()

print("DJ Control Script loaded successfully")