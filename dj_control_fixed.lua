-- DJ Control Script - Fixed Version
-- Place this script in ServerScriptService

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = workspace

--// RemoteEvents
local remoteEvents = Instance.new("Folder")
remoteEvents.Name = "DJRemoteEvents"
remoteEvents.Parent = ReplicatedStorage

local runCommandRemote = Instance.new("RemoteEvent")
runCommandRemote.Name = "RunCommand"
runCommandRemote.Parent = remoteEvents

--// DJ State
local djModel
local currentSkybox
local currentAudio
local isPlaying = false
local lastCommandTime = 0
local COMMAND_COOLDOWN = 2 -- seconds

--// Configuration
local SKYBOX_ID = "16553683517"
local AUDIO_ID = "1835725225"
local EFFECT_DURATION = 155

--// Functions
local function setupDJModel()
	djModel = Workspace:FindFirstChild("DJ")
	if djModel then
		for _, d in pairs(djModel:GetDescendants()) do
			if d:IsA("BasePart") then
				d.Transparency = 1
				d.CanCollide = false
			elseif d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 1
			end
		end
		print("DJ model hidden on server start")
	else
		warn("DJ model not found in Workspace")
	end
end

local function fadeDJModel(fadeIn)
	if not djModel then 
		warn("DJ model not found for fading")
		return false
	end
	
	local targetTransparency = fadeIn and 0 or 1
	local targetCollide = fadeIn
	
	for _, d in pairs(djModel:GetDescendants()) do
		if d:IsA("BasePart") then
			local tween = TweenService:Create(d, TweenInfo.new(1), {Transparency = targetTransparency})
			tween:Play()
			d.CanCollide = targetCollide
		elseif d:IsA("Decal") or d:IsA("Texture") then
			local tween = TweenService:Create(d, TweenInfo.new(1), {Transparency = targetTransparency})
			tween:Play()
		end
	end
	return true
end

local function applySkybox(id)
	local success, err = pcall(function()
		if currentSkybox then 
			currentSkybox:Destroy() 
		end
		currentSkybox = Instance.new("Sky")
		for _, face in ipairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do
			currentSkybox["Skybox"..face] = "rbxassetid://"..id
		end
		currentSkybox.Parent = Lighting
	end)
	
	if not success then
		warn("Failed to apply skybox:", err)
		return false
	end
	return true
end

local function removeSkybox()
	if currentSkybox then
		local success, err = pcall(function()
			currentSkybox:Destroy()
			currentSkybox = nil
		end)
		if not success then
			warn("Failed to remove skybox:", err)
		end
	end
end

local function playAudio(id)
	local success, err = pcall(function()
		if currentAudio then
			currentAudio:Stop()
			currentAudio:Destroy()
		end
		currentAudio = Instance.new("Sound")
		currentAudio.SoundId = "rbxassetid://"..id
		currentAudio.Volume = 0.5
		currentAudio.Parent = SoundService
		currentAudio:Play()
	end)
	
	if not success then
		warn("Failed to play audio:", err)
		return false
	end
	return true
end

local function stopAudio()
	if currentAudio then
		local success, err = pcall(function()
			currentAudio:Stop()
			currentAudio:Destroy()
			currentAudio = nil
		end)
		if not success then
			warn("Failed to stop audio:", err)
		end
	end
end

local function cleanupEffects()
	fadeDJModel(false)
	removeSkybox()
	stopAudio()
	isPlaying = false
end

local function executeDJCommand()
	-- Check cooldown
	local currentTime = tick()
	if currentTime - lastCommandTime < COMMAND_COOLDOWN then
		return false
	end
	
	if isPlaying then 
		return false
	end
	
	lastCommandTime = currentTime
	isPlaying = true
	
	-- Apply effects with error handling
	local djFaded = fadeDJModel(true)
	local skyboxApplied = applySkybox(SKYBOX_ID)
	local audioPlayed = playAudio(AUDIO_ID)
	
	-- If any effect failed, cleanup and abort
	if not djFaded or not skyboxApplied or not audioPlayed then
		warn("One or more effects failed to apply")
		cleanupEffects()
		return false
	end
	
	-- Schedule cleanup
	task.delay(EFFECT_DURATION, function()
		cleanupEffects()
	end)
	
	return true
end

--// RemoteEvent from client
runCommandRemote.OnServerEvent:Connect(function(player, command)
	if not player or not player.Parent then
		return -- Player disconnected
	end
	
	if command == "DJ Jhai" then
		local commandSuccess = executeDJCommand()
		
		if commandSuccess then
			-- Try to publish to MessagingService
			local ok, err = pcall(function()
				MessagingService:PublishAsync("DJCommand", {
					command = "DJ Jhai", 
					player = player.Name,
					timestamp = tick()
				})
			end)
			if not ok then 
				warn("MessagingService failed:", err) 
			end
		end
	end
end)

--// MessagingService listener
local messagingSuccess, messagingErr = pcall(function()
	MessagingService:SubscribeAsync("DJCommand", function(msg)
		if msg.Data and msg.Data.command == "DJ Jhai" then
			executeDJCommand()
		end
	end)
end)

if not messagingSuccess then
	warn("Failed to subscribe to MessagingService:", messagingErr)
end

--// Cleanup on server shutdown
game:BindToClose(function()
	cleanupEffects()
end)

--// Player join - Use StarterGui instead of injecting LocalScripts
Players.PlayerAdded:Connect(function(player)
	-- The LocalScript should be placed in StarterGui instead of being injected
	-- This is the recommended approach for client-side scripts
end)

--// Alternative: Create the GUI elements on server side for better reliability
local function createServerGUI(player)
	local playerGui = player:WaitForChild("PlayerGui")
	
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
	
	-- Note: Button functionality would need to be handled by a LocalScript
	-- The server cannot directly handle GUI events
end

--// Initialize for existing players
for _, plr in ipairs(Players:GetPlayers()) do
	if plr.Character then
		createServerGUI(plr)
	else
		plr.CharacterAdded:Connect(function()
			task.wait(1)
			createServerGUI(plr)
		end)
	end
end

--// Setup DJ model
setupDJModel()
print("DJ Control Script Loaded - Fixed Version")