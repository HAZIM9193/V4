-- PlayerJoinGUI.lua - Roblox Script
-- A GUI for joining any player by username with fade animations

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerJoinGUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Create main toggle button (YI button)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "YI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Parent = screenGui

-- Add corner rounding to toggle button
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Create main GUI frame (initially hidden)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Add corner rounding to main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Add shadow effect
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = mainFrame.ZIndex - 1
shadow.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Create close button (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Create title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -60, 0, 40)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Join Player"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Create username input box
local usernameInput = Instance.new("TextBox")
usernameInput.Name = "UsernameInput"
usernameInput.Size = UDim2.new(0, 300, 0, 40)
usernameInput.Position = UDim2.new(0.5, -150, 0.5, -20)
usernameInput.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
usernameInput.BorderSizePixel = 0
usernameInput.Text = ""
usernameInput.PlaceholderText = "Enter username..."
usernameInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
usernameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
usernameInput.TextScaled = true
usernameInput.Font = Enum.Font.SourceSans
usernameInput.ClearTextOnFocus = false
usernameInput.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = usernameInput

-- Create join button
local joinButton = Instance.new("TextButton")
joinButton.Name = "JoinButton"
joinButton.Size = UDim2.new(0, 100, 0, 35)
joinButton.Position = UDim2.new(0.5, -50, 0.7, 0)
joinButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
joinButton.BorderSizePixel = 0
joinButton.Text = "Join"
joinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
joinButton.TextScaled = true
joinButton.Font = Enum.Font.SourceSansBold
joinButton.Parent = mainFrame

local joinCorner = Instance.new("UICorner")
joinCorner.CornerRadius = UDim.new(0, 8)
joinCorner.Parent = joinButton

-- Create notification label
local notificationLabel = Instance.new("TextLabel")
notificationLabel.Name = "NotificationLabel"
notificationLabel.Size = UDim2.new(1, -20, 0, 30)
notificationLabel.Position = UDim2.new(0, 10, 1, -40)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Text = ""
notificationLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
notificationLabel.TextScaled = true
notificationLabel.Font = Enum.Font.SourceSans
notificationLabel.TextXAlignment = Enum.TextXAlignment.Center
notificationLabel.Parent = mainFrame

-- Animation tweens
local fadeInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
)

local fadeOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {BackgroundTransparency = 1}
)

local scaleInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 400, 0, 250)}
)

local scaleOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
    {Size = UDim2.new(0, 0, 0, 0)}
)

-- Function to show notification
local function showNotification(message, isError)
    notificationLabel.Text = message
    if isError then
        notificationLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    else
        notificationLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
    
    -- Fade in notification
    local notifTween = TweenService:Create(
        notificationLabel,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
        {TextTransparency = 0}
    )
    notifTween:Play()
    
    -- Fade out after 3 seconds
    wait(3)
    local fadeNotifTween = TweenService:Create(
        notificationLabel,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
        {TextTransparency = 1}
    )
    fadeNotifTween:Play()
end

-- Function to open GUI with fade in animation
local function openGUI()
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 1
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    
    -- Set all child elements to transparent
    for _, child in pairs(mainFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            child.BackgroundTransparency = 1
            child.TextTransparency = 1
        elseif child:IsA("Frame") then
            child.BackgroundTransparency = 1
        end
    end
    
    -- Animate main frame
    fadeInTween:Play()
    scaleInTween:Play()
    
    -- Animate children with slight delay
    wait(0.1)
    for _, child in pairs(mainFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            if child.Name ~= "NotificationLabel" then
                local childTween = TweenService:Create(
                    child,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = child.Name == "TitleLabel" and 1 or 0, TextTransparency = 0}
                )
                childTween:Play()
            end
        elseif child:IsA("Frame") and child.Name == "Shadow" then
            local shadowTween = TweenService:Create(
                child,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {BackgroundTransparency = 0.7}
            )
            shadowTween:Play()
        end
    end
end

-- Function to close GUI with fade out animation
local function closeGUI()
    -- Animate children first
    for _, child in pairs(mainFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            local childTween = TweenService:Create(
                child,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {BackgroundTransparency = 1, TextTransparency = 1}
            )
            childTween:Play()
        elseif child:IsA("Frame") and child.Name == "Shadow" then
            local shadowTween = TweenService:Create(
                child,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {BackgroundTransparency = 1}
            )
            shadowTween:Play()
        end
    end
    
    wait(0.1)
    
    -- Animate main frame
    fadeOutTween:Play()
    scaleOutTween:Play()
    
    fadeOutTween.Completed:Connect(function()
        mainFrame.Visible = false
    end)
end

-- Function to join player
local function joinPlayer()
    local username = usernameInput.Text:gsub("%s+", "") -- Remove whitespace
    
    if username == "" then
        spawn(function()
            showNotification("Please enter a username!", true)
        end)
        return
    end
    
    joinButton.Text = "Joining..."
    joinButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    -- Get user ID from username
    local success, userId = pcall(function()
        return Players:GetUserIdFromNameAsync(username)
    end)
    
    if not success then
        joinButton.Text = "Join"
        joinButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        spawn(function()
            showNotification("Username not found!", true)
        end)
        return
    end
    
    -- Try to get the player's current game
    local success2, result = pcall(function()
        local playerData = Players:GetPlayerByUserId(userId)
        if playerData then
            -- Player is in the same game
            spawn(function()
                showNotification("Player is in this game!", true)
            end)
            return
        end
        
        -- Try to join the player's game
        return "attempt_join"
    end)
    
    if result == "attempt_join" then
        -- Simulate joining process (in a real scenario, you'd use TeleportService)
        spawn(function()
            showNotification("Attempting to join " .. username .. "...", false)
        end)
        
        -- Note: Actual joining would require TeleportService and proper permissions
        -- This is a demonstration of the UI flow
        wait(2)
        joinButton.Text = "Join"
        joinButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        spawn(function()
            showNotification("Unable to join player's game!", true)
        end)
    else
        joinButton.Text = "Join"
        joinButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    end
end

-- Event connections
toggleButton.MouseButton1Click:Connect(function()
    if mainFrame.Visible then
        closeGUI()
    else
        openGUI()
    end
end)

closeButton.MouseButton1Click:Connect(function()
    closeGUI()
end)

joinButton.MouseButton1Click:Connect(function()
    joinPlayer()
end)

-- Allow Enter key to trigger join
usernameInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        joinPlayer()
    end
end)

-- Hover effects for buttons
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundColor3 = hoverColor}
        )
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local normalTween = TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundColor3 = normalColor}
        )
        normalTween:Play()
    end)
end

-- Apply hover effects
addHoverEffect(toggleButton, Color3.fromRGB(65, 65, 65), Color3.fromRGB(45, 45, 45))
addHoverEffect(closeButton, Color3.fromRGB(240, 70, 70), Color3.fromRGB(220, 50, 50))
addHoverEffect(joinButton, Color3.fromRGB(70, 170, 70), Color3.fromRGB(50, 150, 50))

print("PlayerJoinGUI loaded successfully!")