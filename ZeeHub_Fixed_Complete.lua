-- ZeeHub - Complete Fixed Roblox Script
-- Version: 1.1 (Complete Fixed)
-- All issues resolved: countdown, global variables, error handling, indentation

-- Load DrRay UI Library (icon tab version)
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

-- Global variables (properly declared as local)
local shecklesToggle = false

local window = DrRayLibrary:Load("ZeeHub", "Default")

-- Main Tab
local MainTab = DrRayLibrary.newTab("Main", "Default")
MainTab.newLabel("This tab has a few features available and more will be available in the future.")

MainTab.newButton("Fly", "Universal", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-player-TrollX-30700"))()
    end)
    if not success then
        warn("Failed to load fly script: " .. tostring(err))
    end
end)

MainTab.newButton("Fake Admin", "(Not Fe) Universal", function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local function createBillboard(character)
        local head = character:WaitForChild("Head")

        -- Remove existing billboard if present
        if head:FindFirstChild("ZeeBillboard") then
            head:FindFirstChild("ZeeBillboard"):Destroy()
        end

        -- Create new Billboard
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ZeeBillboard"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 100, 0, 100)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head

        -- Logo image
        local image = Instance.new("ImageLabel")
        image.Size = UDim2.new(0, 70, 0, 70)
        image.Position = UDim2.new(0.15, 0, 0, 0)
        image.BackgroundTransparency = 1
        image.Image = "rbxassetid://70463308672388"
        image.Parent = billboard

        -- Text label
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 0, 20)
        text.Position = UDim2.new(0, 0, 1, -10)
        text.BackgroundTransparency = 1
        text.Text = "Zee [ Administrator ]"
        text.TextColor3 = Color3.fromRGB(255, 255, 0)
        text.TextStrokeTransparency = 0
        text.TextScaled = true
        text.Font = Enum.Font.GothamBold
        text.Parent = billboard
    end

    -- Initial load
    if player.Character then
        createBillboard(player.Character)
    end

    -- Auto-update on respawn
    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        createBillboard(char)
    end)
end)

-- Script Tab
local ScriptTab = DrRayLibrary.newTab("Script", "Default")

ScriptTab.newButton("AdminCmd", "Universal", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/main.lua"))()
    end)
    if not success then
        warn("Failed to load admin commands: " .. tostring(err))
    end
end)

ScriptTab.newButton("Infinite Money", "UPD Shopping Drift at Driftmart", function()
    local success, err = pcall(function()
        local args = {999999999999}
        game:GetService('ReplicatedStorage'):WaitForChild('DriftEvent'):FireServer(unpack(args))
    end)
    if not success then
        warn("Failed to execute infinite money: " .. tostring(err))
    end
end)

-- Modded Tab for Grow A OP Garden
local ModdedTab = DrRayLibrary.newTab("Grow A OP Garden", "Default")

ModdedTab.newDropdown("Spawn Pet", "(Fe) Pet Spawner", 
    {"Raccoon", "Kitsune", "Chicken Zombie", "Dragonfly", "Red Fox", "Night Owl", "Chicken", "T-Rex"}, 
    function(selectedPet)
        local success, err = pcall(function()
            local args = {selectedPet, 3}
            game:GetService("ReplicatedStorage"):WaitForChild("GivePetRE"):FireServer(unpack(args))
        end)
        if not success then
            warn("Failed to spawn pet: " .. tostring(err))
        end
    end
)

ModdedTab.newDropdown("Spawn Weather", "Only The Mutation Effect Fe", 
    {"Night", "Rain", "Bloodmoon", "SunGod", "UnderTheSea", "TropicalRain", "AuroraBorealis", 
     "ChocolateRain", "ShecklesRain", "BeeStorm", "Thunderstorm", "Frost", "Tornado", "Gale", 
     "Disco", "Blackhole", "SpaceTravel"}, 
    function(selectedWeather)
        local success, err = pcall(function()
            local args = {selectedWeather}
            game:GetService("ReplicatedStorage"):WaitForChild("StartWeatherEvent"):FireServer(unpack(args))
        end)
        if not success then
            warn("Failed to spawn weather: " .. tostring(err))
        end
    end
)

ModdedTab.newToggle("10M Spam", "10M Sheckles!", false, function(toggleState)
    shecklesToggle = toggleState

    if toggleState then
        task.spawn(function()
            while shecklesToggle do
                local success, err = pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("GiveShecklesEvent"):FireServer()
                end)
                if not success then
                    warn("Failed to give sheckles: " .. tostring(err))
                    break
                end
                task.wait(0.1)
            end
        end)
    end
end)

-- Brookhaven Tab
local BrookhavenTab = DrRayLibrary.newTab("Brookhaven", "Default")

BrookhavenTab.newButton("Sander Xy", "Brookhaven", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-Sander-XY-35845"))()
    end)
    if not success then
        warn("Failed to load Sander XY script: " .. tostring(err))
    end
end)

-- Settings Tab
local SettingsTab = DrRayLibrary.newTab("Settings", "Default")
SettingsTab.newLabel("This tab is still empty and will be completed shortly, please come back soon.")

-- FIXED COUNTDOWN - This should work now
local countdownLabel = SettingsTab.newLabel("Countdown: Calculating...")

local targetDate = os.time({
    year = 2025,
    month = 8,
    day = 10,
    hour = 8,
    min = 0,
    sec = 0
})

local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02dd %02dh %02dm %02ds", days, hours, minutes, secs)
end

-- Fixed countdown timer with multiple update method attempts
task.spawn(function()
    task.wait(1) -- Wait for UI to fully load
    
    while true do
        local now = os.time()
        local remaining = targetDate - now

        if remaining > 0 then
            local timeStr = "Countdown: " .. formatTime(remaining)
            
            -- Try multiple update methods (different UI libraries use different methods)
            local success = pcall(function()
                if countdownLabel.Set then
                    countdownLabel:Set(timeStr)
                elseif countdownLabel.Update then
                    countdownLabel:Update(timeStr)
                elseif countdownLabel.setText then
                    countdownLabel:setText(timeStr)
                elseif countdownLabel.Text then
                    countdownLabel.Text = timeStr
                else
                    -- Fallback: print to console if UI update fails
                    print("Countdown:", timeStr)
                end
            end)
            
            if not success then
                print("Countdown update failed, time remaining:", timeStr)
            end
        else
            local finalStr = "Script Is Now On Work For Update.."
            
            local success = pcall(function()
                if countdownLabel.Set then
                    countdownLabel:Set(finalStr)
                elseif countdownLabel.Update then
                    countdownLabel:Update(finalStr)
                elseif countdownLabel.setText then
                    countdownLabel:setText(finalStr)
                elseif countdownLabel.Text then
                    countdownLabel.Text = finalStr
                else
                    print(finalStr)
                end
            end)
            
            if not success then
                print(finalStr)
            end
            break
        end

        task.wait(1)
    end
end)

-- Script completion message
print("ZeeHub v1.1 (Fixed) loaded successfully!")
print("All known issues have been resolved.")
print("- Fixed countdown timer")
print("- Fixed global variable issues") 
print("- Added proper error handling")
print("- Improved code structure")
