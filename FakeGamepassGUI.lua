-- Fake Gamepass GUI Script for Roblox
-- Place this in StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Sample gamepass data (replace with actual gamepass IDs from your game)
local gamepasses = {
    {name = "VIP", id = 123456, price = 100},
    {name = "Double XP", id = 234567, price = 250},
    {name = "Speed Boost", id = 345678, price = 150},
    {name = "Premium Tools", id = 456789, price = 300},
    {name = "Extra Lives", id = 567890, price = 200},
    {name = "Rainbow Trail", id = 678901, price = 75},
}

-- Create the main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FakeGamepassGUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Create the toggle button (FG button)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "FG"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = screenGui

-- Add corner rounding to toggle button
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Create the main frame (initially invisible)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Add corner rounding to main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Add shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/dropshadow.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Create header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Fix header corners (only top corners rounded)
local headerMask = Instance.new("Frame")
headerMask.Size = UDim2.new(1, 0, 0, 12)
headerMask.Position = UDim2.new(0, 0, 1, -12)
headerMask.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
headerMask.BorderSizePixel = 0
headerMask.Parent = header

-- Header title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Game Passes"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close button (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Create scroll frame for gamepasses
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "GamepassList"
scrollFrame.Size = UDim2.new(1, -20, 1, -80)
scrollFrame.Position = UDim2.new(0, 10, 0, 70)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.Parent = mainFrame

-- Add UIListLayout to scroll frame
local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 10)
listLayout.Parent = scrollFrame

-- Function to create gamepass entry
local function createGamepassEntry(gamepassData, index)
    local entry = Instance.new("Frame")
    entry.Name = "GamepassEntry"
    entry.Size = UDim2.new(1, -20, 0, 60)
    entry.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    entry.BorderSizePixel = 0
    entry.LayoutOrder = index
    entry.Parent = scrollFrame
    
    local entryCorner = Instance.new("UICorner")
    entryCorner.CornerRadius = UDim.new(0, 8)
    entryCorner.Parent = entry
    
    -- Gamepass name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(0.6, -20, 1, 0)
    nameLabel.Position = UDim2.new(0, 15, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = gamepassData.name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = entry
    
    -- Price label
    local priceLabel = Instance.new("TextLabel")
    priceLabel.Name = "PriceLabel"
    priceLabel.Size = UDim2.new(0, 80, 1, -20)
    priceLabel.Position = UDim2.new(0.6, 0, 0, 10)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = gamepassData.price .. " R$"
    priceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    priceLabel.TextScaled = true
    priceLabel.Font = Enum.Font.Gotham
    priceLabel.Parent = entry
    
    -- Fake Buy button
    local fakeBuyButton = Instance.new("TextButton")
    fakeBuyButton.Name = "FakeBuyButton"
    fakeBuyButton.Size = UDim2.new(0, 100, 0, 35)
    fakeBuyButton.Position = UDim2.new(1, -115, 0.5, -17.5)
    fakeBuyButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    fakeBuyButton.BorderSizePixel = 0
    fakeBuyButton.Text = "Fake Buy"
    fakeBuyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    fakeBuyButton.TextScaled = true
    fakeBuyButton.Font = Enum.Font.GothamBold
    fakeBuyButton.Parent = entry
    
    local buyCorner = Instance.new("UICorner")
    buyCorner.CornerRadius = UDim.new(0, 6)
    buyCorner.Parent = fakeBuyButton
    
    -- Fake buy button functionality
    fakeBuyButton.MouseButton1Click:Connect(function()
        showFakePurchaseDialog(gamepassData)
    end)
    
    return entry
end

-- Function to show fake purchase dialog (old Roblox style)
function showFakePurchaseDialog(gamepassData)
    local purchaseGui = Instance.new("ScreenGui")
    purchaseGui.Name = "FakePurchaseDialog"
    purchaseGui.Parent = playerGui
    
    -- Background overlay
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    overlay.Parent = purchaseGui
    
    -- Dialog frame (old Roblox style)
    local dialogFrame = Instance.new("Frame")
    dialogFrame.Name = "DialogFrame"
    dialogFrame.Size = UDim2.new(0, 400, 0, 300)
    dialogFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    dialogFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    dialogFrame.BorderSizePixel = 1
    dialogFrame.BorderColor3 = Color3.fromRGB(180, 180, 180)
    dialogFrame.Parent = purchaseGui
    
    -- Title bar (old style)
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = dialogFrame
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -60, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "Purchase Game Pass"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextScaled = true
    titleText.Font = Enum.Font.SourceSans
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    -- Close X button
    local dialogCloseButton = Instance.new("TextButton")
    dialogCloseButton.Size = UDim2.new(0, 30, 0, 30)
    dialogCloseButton.Position = UDim2.new(1, -30, 0, 0)
    dialogCloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    dialogCloseButton.BorderSizePixel = 0
    dialogCloseButton.Text = "×"
    dialogCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dialogCloseButton.TextScaled = true
    dialogCloseButton.Font = Enum.Font.SourceSans
    dialogCloseButton.Parent = titleBar
    
    -- Game pass info
    local infoFrame = Instance.new("Frame")
    infoFrame.Size = UDim2.new(1, -20, 0, 150)
    infoFrame.Position = UDim2.new(0, 10, 0, 40)
    infoFrame.BackgroundTransparency = 1
    infoFrame.Parent = dialogFrame
    
    local gamepassNameLabel = Instance.new("TextLabel")
    gamepassNameLabel.Size = UDim2.new(1, 0, 0, 30)
    gamepassNameLabel.Position = UDim2.new(0, 0, 0, 10)
    gamepassNameLabel.BackgroundTransparency = 1
    gamepassNameLabel.Text = gamepassData.name
    gamepassNameLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    gamepassNameLabel.TextScaled = true
    gamepassNameLabel.Font = Enum.Font.SourceSansBold
    gamepassNameLabel.Parent = infoFrame
    
    local priceLabel = Instance.new("TextLabel")
    priceLabel.Size = UDim2.new(1, 0, 0, 25)
    priceLabel.Position = UDim2.new(0, 0, 0, 50)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = "Price: " .. gamepassData.price .. " ROBUX"
    priceLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
    priceLabel.TextScaled = true
    priceLabel.Font = Enum.Font.SourceSans
    priceLabel.Parent = infoFrame
    
    -- Fake robux balance
    local balanceLabel = Instance.new("TextLabel")
    balanceLabel.Size = UDim2.new(1, 0, 0, 25)
    balanceLabel.Position = UDim2.new(0, 0, 0, 85)
    balanceLabel.BackgroundTransparency = 1
    balanceLabel.Text = "Your Balance: 999,999 ROBUX"
    balanceLabel.TextColor3 = Color3.fromRGB(0, 150, 0)
    balanceLabel.TextScaled = true
    balanceLabel.Font = Enum.Font.SourceSans
    balanceLabel.Parent = infoFrame
    
    -- Buttons frame
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Size = UDim2.new(1, -20, 0, 50)
    buttonsFrame.Position = UDim2.new(0, 10, 1, -60)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = dialogFrame
    
    -- Buy button (old style)
    local buyButton = Instance.new("TextButton")
    buyButton.Name = "BuyButton"
    buyButton.Size = UDim2.new(0, 100, 0, 35)
    buyButton.Position = UDim2.new(0.5, -110, 0, 7.5)
    buyButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    buyButton.BorderSizePixel = 1
    buyButton.BorderColor3 = Color3.fromRGB(0, 100, 200)
    buyButton.Text = "Buy Now"
    buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyButton.TextScaled = true
    buyButton.Font = Enum.Font.SourceSans
    buyButton.Parent = buttonsFrame
    
    -- Cancel button
    local cancelButton = Instance.new("TextButton")
    cancelButton.Name = "CancelButton"
    cancelButton.Size = UDim2.new(0, 100, 0, 35)
    cancelButton.Position = UDim2.new(0.5, 10, 0, 7.5)
    cancelButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    cancelButton.BorderSizePixel = 1
    cancelButton.BorderColor3 = Color3.fromRGB(150, 150, 150)
    cancelButton.Text = "Cancel"
    cancelButton.TextColor3 = Color3.fromRGB(100, 100, 100)
    cancelButton.TextScaled = true
    cancelButton.Font = Enum.Font.SourceSans
    cancelButton.Parent = buttonsFrame
    
    -- Button functionality
    buyButton.MouseButton1Click:Connect(function()
        -- Simulate successful purchase
        local successGui = Instance.new("ScreenGui")
        successGui.Name = "SuccessDialog"
        successGui.Parent = playerGui
        
        local successFrame = Instance.new("Frame")
        successFrame.Size = UDim2.new(0, 300, 0, 150)
        successFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
        successFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        successFrame.BorderSizePixel = 1
        successFrame.BorderColor3 = Color3.fromRGB(180, 180, 180)
        successFrame.Parent = successGui
        
        local successText = Instance.new("TextLabel")
        successText.Size = UDim2.new(1, -20, 0, 60)
        successText.Position = UDim2.new(0, 10, 0, 20)
        successText.BackgroundTransparency = 1
        successText.Text = "Purchase Successful!\n" .. gamepassData.name .. " has been added to your account."
        successText.TextColor3 = Color3.fromRGB(0, 150, 0)
        successText.TextScaled = true
        successText.Font = Enum.Font.SourceSans
        successText.Parent = successFrame
        
        local okButton = Instance.new("TextButton")
        okButton.Size = UDim2.new(0, 80, 0, 30)
        okButton.Position = UDim2.new(0.5, -40, 1, -40)
        okButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        okButton.BorderSizePixel = 1
        okButton.BorderColor3 = Color3.fromRGB(0, 100, 200)
        okButton.Text = "OK"
        okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        okButton.TextScaled = true
        okButton.Font = Enum.Font.SourceSans
        okButton.Parent = successFrame
        
        okButton.MouseButton1Click:Connect(function()
            successGui:Destroy()
        end)
        
        purchaseGui:Destroy()
        
        -- Auto close after 3 seconds
        wait(3)
        if successGui.Parent then
            successGui:Destroy()
        end
    end)
    
    cancelButton.MouseButton1Click:Connect(function()
        purchaseGui:Destroy()
    end)
    
    dialogCloseButton.MouseButton1Click:Connect(function()
        purchaseGui:Destroy()
    end)
    
    -- Close when clicking overlay
    overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            purchaseGui:Destroy()
        end
    end)
end

-- Create all gamepass entries
for i, gamepass in ipairs(gamepasses) do
    createGamepassEntry(gamepass, i)
end

-- Update scroll frame size
local function updateScrollSize()
    local totalHeight = (#gamepasses * 70) - 10
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

updateScrollSize()

-- Animation tweens
local fadeInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
)

local fadeOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    {BackgroundTransparency = 1}
)

local scaleInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 600, 0, 450)}
)

local scaleOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    {Size = UDim2.new(0, 0, 0, 0)}
)

-- Function to show the GUI
local function showGUI()
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 1
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    
    fadeInTween:Play()
    scaleInTween:Play()
end

-- Function to hide the GUI
local function hideGUI()
    fadeOutTween:Play()
    scaleOutTween:Play()
    
    scaleOutTween.Completed:Connect(function()
        mainFrame.Visible = false
    end)
end

-- Toggle button functionality
local guiVisible = false
toggleButton.MouseButton1Click:Connect(function()
    if guiVisible then
        hideGUI()
        guiVisible = false
    else
        showGUI()
        guiVisible = true
    end
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    hideGUI()
    guiVisible = false
end)

-- Close GUI when pressing ESC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Escape and guiVisible then
        hideGUI()
        guiVisible = false
    end
end)

print("Fake Gamepass GUI loaded successfully!")