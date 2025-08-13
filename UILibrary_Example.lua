--[[
    UI Library Example Script
    This script demonstrates how to use all components of the custom UI library
    
    Usage:
    1. Make sure UILibrary.lua is in the same directory or loadstring it first
    2. Run this script in Roblox to see all components in action
]]

-- Load the UI Library (adjust path as needed)
local UILibrary = loadstring(game:HttpGet("path/to/UILibrary.lua"))() -- For online loading
-- OR
-- local UILibrary = require(script.UILibrary) -- For local module

-- Create main window
local Window = UILibrary:CreateWindow("My Custom UI", UDim2.new(0, 600, 0, 400))

-- Create tabs
local MainTab = UILibrary:CreateTab(Window, "Main", "🏠")
local SettingsTab = UILibrary:CreateTab(Window, "Settings", "⚙️")
local TestingTab = UILibrary:CreateTab(Window, "Testing", "🧪")

-- Variables to store values
local playerSpeed = 16
local isFlying = false
local selectedWeapon = "Sword"
local playerName = ""

print("UI Library Example Started!")

-- MAIN TAB COMPONENTS
-- Basic Button
UILibrary:CreateButton(MainTab, "Print Hello World", function()
    print("Hello World from UI Library!")
end)

-- Speed Slider
local speedSlider = UILibrary:CreateSlider(MainTab, "Player Speed", 1, 100, playerSpeed, function(value)
    playerSpeed = value
    print("Player speed set to:", value)
    
    -- Apply speed to player if in game
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end)

-- Flying Toggle
local flyToggle = UILibrary:CreateToggle(MainTab, "Enable Flying", isFlying, function(state)
    isFlying = state
    print("Flying:", state and "Enabled" or "Disabled")
    
    -- Basic fly script implementation
    local player = game.Players.LocalPlayer
    if player and player.Character then
        if state then
            -- Enable flying (basic implementation)
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = character.HumanoidRootPart
                character:SetAttribute("Flying", true)
                character:SetAttribute("BodyVelocity", bodyVelocity)
            end
        else
            -- Disable flying
            local character = player.Character
            if character:GetAttribute("Flying") then
                local bodyVelocity = character:GetAttribute("BodyVelocity")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
                character:SetAttribute("Flying", false)
                character:SetAttribute("BodyVelocity", nil)
            end
        end
    end
end)

-- Weapon Dropdown
local weaponDropdown = UILibrary:CreateDropdown(MainTab, "Select Weapon", 
    {"Sword", "Bow", "Staff", "Dagger", "Hammer"}, 
    function(selected)
        selectedWeapon = selected
        print("Selected weapon:", selected)
        
        -- You could implement weapon switching logic here
        game.ReplicatedStorage.RemoteEvents.EquipWeapon:FireServer(selected)
    end
)

-- SETTINGS TAB COMPONENTS
-- Player Name Input
local nameInput = UILibrary:CreateInput(SettingsTab, "Player Name", "", function(text)
    playerName = text
    print("Player name set to:", text)
    
    -- You could save this to a datastore or update display name
end)

-- Theme Buttons
UILibrary:CreateButton(SettingsTab, "Dark Theme", function()
    print("Switched to Dark Theme")
    -- Theme switching logic would go here
end)

UILibrary:CreateButton(SettingsTab, "Light Theme", function()
    print("Switched to Light Theme")
    -- Theme switching logic would go here
end)

-- Auto-Save Toggle
UILibrary:CreateToggle(SettingsTab, "Auto Save", true, function(state)
    print("Auto save:", state and "Enabled" or "Disabled")
end)

-- Volume Slider
UILibrary:CreateSlider(SettingsTab, "Master Volume", 0, 100, 50, function(value)
    print("Volume set to:", value .. "%")
    
    -- Apply volume settings
    game.SoundService.Volume = value / 100
end)

-- Graphics Quality Dropdown
UILibrary:CreateDropdown(SettingsTab, "Graphics Quality", 
    {"Low", "Medium", "High", "Ultra"}, 
    function(selected)
        print("Graphics quality:", selected)
        
        -- Apply graphics settings
        local quality = {
            ["Low"] = 1,
            ["Medium"] = 5,
            ["High"] = 10,
            ["Ultra"] = 21
        }
        
        settings().Rendering.QualityLevel = quality[selected] or 10
    end
)

-- TESTING TAB COMPONENTS
-- Test all components with different configurations
UILibrary:CreateButton(TestingTab, "Teleport to Spawn", function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        print("Teleported to spawn!")
    end
end)

-- Health Slider
UILibrary:CreateSlider(TestingTab, "Health", 1, 100, 100, function(value)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = value
        print("Health set to:", value)
    end
end)

-- God Mode Toggle
UILibrary:CreateToggle(TestingTab, "God Mode", false, function(state)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        if state then
            player.Character.Humanoid.MaxHealth = math.huge
            player.Character.Humanoid.Health = math.huge
        else
            player.Character.Humanoid.MaxHealth = 100
            player.Character.Humanoid.Health = 100
        end
        print("God mode:", state and "Enabled" or "Disabled")
    end
end)

-- Game Mode Dropdown
UILibrary:CreateDropdown(TestingTab, "Game Mode", 
    {"Normal", "Creative", "Spectator", "Adventure"}, 
    function(selected)
        print("Game mode:", selected)
    end
)

-- Debug Input
UILibrary:CreateInput(TestingTab, "Debug Command", "", function(text)
    print("Executing debug command:", text)
    
    -- Basic command processor
    if text:lower() == "reset" then
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    elseif text:lower() == "respawn" then
        game.Players.LocalPlayer:LoadCharacter()
    elseif text:lower():match("^tp%s+(%w+)") then
        local targetName = text:lower():match("^tp%s+(%w+)")
        local targetPlayer = game.Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
                targetPlayer.Character.HumanoidRootPart.CFrame
            print("Teleported to", targetPlayer.Name)
        end
    end
end)

-- Advanced Features Demo
UILibrary:CreateButton(TestingTab, "Get All Values", function()
    print("=== Current UI Values ===")
    print("Player Speed:", speedSlider.GetValue())
    print("Flying:", flyToggle.GetState())
    print("Selected Weapon:", weaponDropdown.GetSelected())
    print("Player Name:", nameInput.GetText())
    print("========================")
end)

UILibrary:CreateButton(TestingTab, "Set Random Values", function()
    speedSlider.SetValue(math.random(1, 100))
    flyToggle.SetState(math.random() > 0.5)
    weaponDropdown.SetSelected({"Sword", "Bow", "Staff", "Dagger", "Hammer"}[math.random(1, 5)])
    nameInput.SetText("RandomPlayer" .. math.random(100, 999))
    print("Set random values!")
end)

-- Cleanup function (optional)
game.Players.LocalPlayer.PlayerRemoving:Connect(function()
    if Window and Window.ScreenGui then
        Window.ScreenGui:Destroy()
    end
end)

print("UI Library Example loaded successfully!")
print("All components are ready to use.")

--[[
    USAGE EXAMPLES:
    
    1. Basic Button:
    UILibrary:CreateButton(tab, "Button Name", function()
        -- Your code here
    end)
    
    2. Slider:
    local slider = UILibrary:CreateSlider(tab, "Slider Name", min, max, default, function(value)
        -- Handle value change
    end)
    
    3. Toggle:
    local toggle = UILibrary:CreateToggle(tab, "Toggle Name", defaultState, function(state)
        -- Handle state change
    end)
    
    4. Dropdown:
    local dropdown = UILibrary:CreateDropdown(tab, "Dropdown Name", options, function(selected)
        -- Handle selection
    end)
    
    5. Input:
    local input = UILibrary:CreateInput(tab, "Input Name", defaultText, function(text)
        -- Handle text input
    end)
    
    Get/Set Values:
    - slider.GetValue() / slider.SetValue(value)
    - toggle.GetState() / toggle.SetState(state)
    - dropdown.GetSelected() / dropdown.SetSelected(option)
    - input.GetText() / input.SetText(text)
]]