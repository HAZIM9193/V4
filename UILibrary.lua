--[[
    Custom UI Library - Local Implementation
    Inspired by OrionLib, RayField, and DrRay UI
    Author: AI Assistant
    
    Features:
    - CreateWindow
    - CreateTab
    - CreateButton
    - CreateDropdown
    - CreateInput
    - CreateToggle
    - CreateSlider
]]

local UILibrary = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Library Configuration
local Config = {
    Theme = {
        Background = Color3.fromRGB(30, 30, 46),
        Secondary = Color3.fromRGB(49, 50, 68),
        Accent = Color3.fromRGB(137, 180, 250),
        Text = Color3.fromRGB(205, 214, 244),
        SubText = Color3.fromRGB(166, 173, 200),
        Red = Color3.fromRGB(243, 139, 168),
        Green = Color3.fromRGB(166, 227, 161),
        Yellow = Color3.fromRGB(249, 226, 175)
    },
    Animations = {
        Speed = 0.3,
        Style = Enum.EasingStyle.Quint,
        Direction = Enum.EasingDirection.Out
    }
}

-- Utility Functions
local function CreateTween(object, properties, duration)
    duration = duration or Config.Animations.Speed
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Config.Animations.Style, Config.Animations.Direction),
        properties
    )
    return tween
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Config.Theme.Secondary
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local function CreateGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = colors or ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.Theme.Background),
        ColorSequenceKeypoint.new(1, Config.Theme.Secondary)
    })
    gradient.Rotation = rotation or 90
    gradient.Parent = parent
    return gradient
end

-- Main Window Function
function UILibrary:CreateWindow(title, size)
    title = title or "UI Library"
    size = size or UDim2.new(0, 500, 0, 350)
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "UILibrary_" .. title:gsub(" ", "")
    ScreenGui.Parent = PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = size
    MainFrame.BackgroundColor3 = Config.Theme.Background
    MainFrame.BorderSizePixel = 0
    CreateCorner(MainFrame, 12)
    CreateStroke(MainFrame, Config.Theme.Secondary, 2)
    
    -- Shadow Effect
    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Position = UDim2.new(0.5, 2, 0.5, 2)
    Shadow.Size = UDim2.new(1, 4, 1, 4)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.5
    Shadow.BorderSizePixel = 0
    Shadow.ZIndex = MainFrame.ZIndex - 1
    CreateCorner(Shadow, 12)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Config.Theme.Secondary
    TitleBar.BorderSizePixel = 0
    CreateCorner(TitleBar, 12)
    
    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "TitleText"
    TitleText.Parent = TitleBar
    TitleText.Position = UDim2.new(0, 15, 0, 0)
    TitleText.Size = UDim2.new(1, -60, 1, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = title
    TitleText.TextColor3 = Config.Theme.Text
    TitleText.TextScaled = true
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Font = Enum.Font.GothamBold
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.BackgroundColor3 = Config.Theme.Red
    CloseButton.BackgroundTransparency = 0.3
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.GothamBold
    CreateCorner(CloseButton, 6)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Content Frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.Position = UDim2.new(0, 10, 0, 50)
    ContentFrame.Size = UDim2.new(1, -20, 1, -60)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = ContentFrame
    TabContainer.Position = UDim2.new(0, 0, 0, 0)
    TabContainer.Size = UDim2.new(0, 120, 1, 0)
    TabContainer.BackgroundColor3 = Config.Theme.Secondary
    TabContainer.BorderSizePixel = 0
    CreateCorner(TabContainer, 8)
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.Padding = UDim.new(0, 5)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.FillDirection = Enum.FillDirection.Vertical
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    
    -- Page Container
    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = ContentFrame
    PageContainer.Position = UDim2.new(0, 130, 0, 0)
    PageContainer.Size = UDim2.new(1, -130, 1, 0)
    PageContainer.BackgroundTransparency = 1
    PageContainer.BorderSizePixel = 0
    
    -- Dragging functionality
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Window object
    local Window = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TabContainer = TabContainer,
        PageContainer = PageContainer,
        Tabs = {},
        CurrentTab = nil
    }
    
    return Window
end

-- Tab Function
function UILibrary:CreateTab(window, tabName, icon)
    tabName = tabName or "Tab"
    icon = icon or "📄"
    
    -- Tab Button
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "Tab_" .. tabName:gsub(" ", "")
    TabButton.Parent = window.TabContainer
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Config.Theme.Background
    TabButton.BackgroundTransparency = 0.5
    TabButton.BorderSizePixel = 0
    TabButton.Text = icon .. " " .. tabName
    TabButton.TextColor3 = Config.Theme.SubText
    TabButton.TextScaled = true
    TabButton.Font = Enum.Font.Gotham
    CreateCorner(TabButton, 6)
    
    -- Tab Page
    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Name = "Page_" .. tabName:gsub(" ", "")
    TabPage.Parent = window.PageContainer
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundColor3 = Config.Theme.Secondary
    TabPage.BorderSizePixel = 0
    TabPage.ScrollBarThickness = 4
    TabPage.ScrollBarImageColor3 = Config.Theme.Accent
    TabPage.Visible = false
    CreateCorner(TabPage, 8)
    
    local PageList = Instance.new("UIListLayout")
    PageList.Parent = TabPage
    PageList.Padding = UDim.new(0, 10)
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.FillDirection = Enum.FillDirection.Vertical
    
    local PagePadding = Instance.new("UIPadding")
    PagePadding.Parent = TabPage
    PagePadding.PaddingTop = UDim.new(0, 15)
    PagePadding.PaddingLeft = UDim.new(0, 15)
    PagePadding.PaddingRight = UDim.new(0, 15)
    PagePadding.PaddingBottom = UDim.new(0, 15)
    
    -- Tab functionality
    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(window.Tabs) do
            tab.Button.BackgroundTransparency = 0.5
            tab.Button.TextColor3 = Config.Theme.SubText
            tab.Page.Visible = false
        end
        
        TabButton.BackgroundTransparency = 0
        TabButton.TextColor3 = Config.Theme.Text
        TabPage.Visible = true
        window.CurrentTab = tabName
        
        CreateTween(TabButton, {BackgroundColor3 = Config.Theme.Accent}):Play()
    end)
    
    -- Auto-update canvas size
    PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabPage.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 30)
    end)
    
    local Tab = {
        Button = TabButton,
        Page = TabPage,
        Name = tabName
    }
    
    window.Tabs[tabName] = Tab
    
    -- Select first tab by default
    if #window.Tabs == 1 or window.CurrentTab == nil then
        TabButton.MouseButton1Click()
    end
    
    return Tab
end

-- Button Function
function UILibrary:CreateButton(tab, buttonName, callback)
    buttonName = buttonName or "Button"
    callback = callback or function() end
    
    local Button = Instance.new("TextButton")
    Button.Name = "Button_" .. buttonName:gsub(" ", "")
    Button.Parent = tab.Page
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = Config.Theme.Background
    Button.BorderSizePixel = 0
    Button.Text = buttonName
    Button.TextColor3 = Config.Theme.Text
    Button.TextScaled = true
    Button.Font = Enum.Font.Gotham
    CreateCorner(Button, 8)
    CreateStroke(Button, Config.Theme.Accent, 1)
    
    -- Button animations
    Button.MouseEnter:Connect(function()
        CreateTween(Button, {BackgroundColor3 = Config.Theme.Accent, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        CreateTween(Button, {BackgroundColor3 = Config.Theme.Background, TextColor3 = Config.Theme.Text}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        CreateTween(Button, {Size = UDim2.new(1, -4, 0, 36)}):Play()
        wait(0.1)
        CreateTween(Button, {Size = UDim2.new(1, 0, 0, 40)}):Play()
        callback()
    end)
    
    return Button
end

-- Dropdown Function
function UILibrary:CreateDropdown(tab, dropdownName, options, callback)
    dropdownName = dropdownName or "Dropdown"
    options = options or {"Option 1", "Option 2", "Option 3"}
    callback = callback or function() end
    
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = "Dropdown_" .. dropdownName:gsub(" ", "")
    DropdownFrame.Parent = tab.Page
    DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.BorderSizePixel = 0
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Name = "DropdownButton"
    DropdownButton.Parent = DropdownFrame
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.BackgroundColor3 = Config.Theme.Background
    DropdownButton.BorderSizePixel = 0
    DropdownButton.Text = dropdownName .. ": " .. options[1]
    DropdownButton.TextColor3 = Config.Theme.Text
    DropdownButton.TextScaled = true
    DropdownButton.Font = Enum.Font.Gotham
    CreateCorner(DropdownButton, 8)
    CreateStroke(DropdownButton, Config.Theme.Secondary, 1)
    
    local DropdownIcon = Instance.new("TextLabel")
    DropdownIcon.Name = "DropdownIcon"
    DropdownIcon.Parent = DropdownButton
    DropdownIcon.Position = UDim2.new(1, -30, 0, 0)
    DropdownIcon.Size = UDim2.new(0, 30, 1, 0)
    DropdownIcon.BackgroundTransparency = 1
    DropdownIcon.Text = "▼"
    DropdownIcon.TextColor3 = Config.Theme.SubText
    DropdownIcon.TextScaled = true
    DropdownIcon.Font = Enum.Font.Gotham
    
    local DropdownList = Instance.new("Frame")
    DropdownList.Name = "DropdownList"
    DropdownList.Parent = DropdownFrame
    DropdownList.Position = UDim2.new(0, 0, 1, 5)
    DropdownList.Size = UDim2.new(1, 0, 0, #options * 30)
    DropdownList.BackgroundColor3 = Config.Theme.Secondary
    DropdownList.BorderSizePixel = 0
    DropdownList.Visible = false
    DropdownList.ZIndex = 10
    CreateCorner(DropdownList, 8)
    CreateStroke(DropdownList, Config.Theme.Accent, 1)
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = DropdownList
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.FillDirection = Enum.FillDirection.Vertical
    
    local isOpen = false
    local selectedOption = options[1]
    
    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Name = "Option_" .. tostring(i)
        OptionButton.Parent = DropdownList
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.BackgroundColor3 = Config.Theme.Secondary
        OptionButton.BackgroundTransparency = 0.5
        OptionButton.BorderSizePixel = 0
        OptionButton.Text = option
        OptionButton.TextColor3 = Config.Theme.Text
        OptionButton.TextScaled = true
        OptionButton.Font = Enum.Font.Gotham
        
        OptionButton.MouseEnter:Connect(function()
            CreateTween(OptionButton, {BackgroundTransparency = 0}):Play()
        end)
        
        OptionButton.MouseLeave:Connect(function()
            CreateTween(OptionButton, {BackgroundTransparency = 0.5}):Play()
        end)
        
        OptionButton.MouseButton1Click:Connect(function()
            selectedOption = option
            DropdownButton.Text = dropdownName .. ": " .. option
            DropdownList.Visible = false
            isOpen = false
            CreateTween(DropdownIcon, {Rotation = 0}):Play()
            CreateTween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 40)}):Play()
            callback(option)
        end)
    end
    
    DropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        DropdownList.Visible = isOpen
        if isOpen then
            CreateTween(DropdownIcon, {Rotation = 180}):Play()
            CreateTween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 40 + #options * 30 + 5)}):Play()
        else
            CreateTween(DropdownIcon, {Rotation = 0}):Play()
            CreateTween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 40)}):Play()
        end
    end)
    
    return {
        Frame = DropdownFrame,
        Button = DropdownButton,
        GetSelected = function() return selectedOption end,
        SetSelected = function(option)
            if table.find(options, option) then
                selectedOption = option
                DropdownButton.Text = dropdownName .. ": " .. option
                callback(option)
            end
        end
    }
end

-- Input Function
function UILibrary:CreateInput(tab, inputName, defaultText, callback)
    inputName = inputName or "Input"
    defaultText = defaultText or ""
    callback = callback or function() end
    
    local InputFrame = Instance.new("Frame")
    InputFrame.Name = "Input_" .. inputName:gsub(" ", "")
    InputFrame.Parent = tab.Page
    InputFrame.Size = UDim2.new(1, 0, 0, 60)
    InputFrame.BackgroundTransparency = 1
    InputFrame.BorderSizePixel = 0
    
    local InputLabel = Instance.new("TextLabel")
    InputLabel.Name = "InputLabel"
    InputLabel.Parent = InputFrame
    InputLabel.Position = UDim2.new(0, 0, 0, 0)
    InputLabel.Size = UDim2.new(1, 0, 0, 20)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = inputName
    InputLabel.TextColor3 = Config.Theme.Text
    InputLabel.TextScaled = true
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    InputLabel.Font = Enum.Font.GothamBold
    
    local InputBox = Instance.new("TextBox")
    InputBox.Name = "InputBox"
    InputBox.Parent = InputFrame
    InputBox.Position = UDim2.new(0, 0, 0, 25)
    InputBox.Size = UDim2.new(1, 0, 0, 30)
    InputBox.BackgroundColor3 = Config.Theme.Background
    InputBox.BorderSizePixel = 0
    InputBox.Text = defaultText
    InputBox.PlaceholderText = "Enter " .. inputName:lower() .. "..."
    InputBox.TextColor3 = Config.Theme.Text
    InputBox.PlaceholderColor3 = Config.Theme.SubText
    InputBox.TextScaled = true
    InputBox.Font = Enum.Font.Gotham
    CreateCorner(InputBox, 6)
    CreateStroke(InputBox, Config.Theme.Secondary, 1)
    
    InputBox.Focused:Connect(function()
        CreateTween(InputBox:FindFirstChild("UIStroke"), {Color = Config.Theme.Accent}):Play()
    end)
    
    InputBox.FocusLost:Connect(function(enterPressed)
        CreateTween(InputBox:FindFirstChild("UIStroke"), {Color = Config.Theme.Secondary}):Play()
        if enterPressed then
            callback(InputBox.Text)
        end
    end)
    
    return {
        Frame = InputFrame,
        TextBox = InputBox,
        GetText = function() return InputBox.Text end,
        SetText = function(text) InputBox.Text = text end
    }
end

-- Toggle Function
function UILibrary:CreateToggle(tab, toggleName, defaultState, callback)
    toggleName = toggleName or "Toggle"
    defaultState = defaultState or false
    callback = callback or function() end
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = "Toggle_" .. toggleName:gsub(" ", "")
    ToggleFrame.Parent = tab.Page
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.BorderSizePixel = 0
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleButton.BackgroundColor3 = Config.Theme.Background
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    CreateCorner(ToggleButton, 8)
    CreateStroke(ToggleButton, Config.Theme.Secondary, 1)
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "ToggleLabel"
    ToggleLabel.Parent = ToggleButton
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = toggleName
    ToggleLabel.TextColor3 = Config.Theme.Text
    ToggleLabel.TextScaled = true
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Font = Enum.Font.Gotham
    
    local ToggleSwitch = Instance.new("Frame")
    ToggleSwitch.Name = "ToggleSwitch"
    ToggleSwitch.Parent = ToggleButton
    ToggleSwitch.Position = UDim2.new(1, -45, 0.5, -10)
    ToggleSwitch.Size = UDim2.new(0, 40, 0, 20)
    ToggleSwitch.BackgroundColor3 = defaultState and Config.Theme.Green or Config.Theme.Secondary
    ToggleSwitch.BorderSizePixel = 0
    CreateCorner(ToggleSwitch, 10)
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "ToggleCircle"
    ToggleCircle.Parent = ToggleSwitch
    ToggleCircle.Position = defaultState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.BorderSizePixel = 0
    CreateCorner(ToggleCircle, 8)
    
    local isToggled = defaultState
    
    ToggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        
        if isToggled then
            CreateTween(ToggleSwitch, {BackgroundColor3 = Config.Theme.Green}):Play()
            CreateTween(ToggleCircle, {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            CreateTween(ToggleSwitch, {BackgroundColor3 = Config.Theme.Secondary}):Play()
            CreateTween(ToggleCircle, {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
        
        callback(isToggled)
    end)
    
    return {
        Frame = ToggleFrame,
        Button = ToggleButton,
        GetState = function() return isToggled end,
        SetState = function(state)
            isToggled = state
            if isToggled then
                CreateTween(ToggleSwitch, {BackgroundColor3 = Config.Theme.Green}):Play()
                CreateTween(ToggleCircle, {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
            else
                CreateTween(ToggleSwitch, {BackgroundColor3 = Config.Theme.Secondary}):Play()
                CreateTween(ToggleCircle, {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
            end
        end
    }
end

-- Slider Function
function UILibrary:CreateSlider(tab, sliderName, min, max, defaultValue, callback)
    sliderName = sliderName or "Slider"
    min = min or 0
    max = max or 100
    defaultValue = defaultValue or min
    callback = callback or function() end
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "Slider_" .. sliderName:gsub(" ", "")
    SliderFrame.Parent = tab.Page
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.BorderSizePixel = 0
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "SliderLabel"
    SliderLabel.Parent = SliderFrame
    SliderLabel.Position = UDim2.new(0, 0, 0, 0)
    SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = sliderName
    SliderLabel.TextColor3 = Config.Theme.Text
    SliderLabel.TextScaled = true
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Font = Enum.Font.GothamBold
    
    local SliderValue = Instance.new("TextLabel")
    SliderValue.Name = "SliderValue"
    SliderValue.Parent = SliderFrame
    SliderValue.Position = UDim2.new(0.7, 0, 0, 0)
    SliderValue.Size = UDim2.new(0.3, 0, 0, 20)
    SliderValue.BackgroundTransparency = 1
    SliderValue.Text = tostring(defaultValue)
    SliderValue.TextColor3 = Config.Theme.Accent
    SliderValue.TextScaled = true
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
    SliderValue.Font = Enum.Font.GothamBold
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "SliderTrack"
    SliderTrack.Parent = SliderFrame
    SliderTrack.Position = UDim2.new(0, 0, 0, 30)
    SliderTrack.Size = UDim2.new(1, 0, 0, 20)
    SliderTrack.BackgroundColor3 = Config.Theme.Secondary
    SliderTrack.BorderSizePixel = 0
    CreateCorner(SliderTrack, 10)
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "SliderFill"
    SliderFill.Parent = SliderTrack
    SliderFill.Position = UDim2.new(0, 0, 0, 0)
    SliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Config.Theme.Accent
    SliderFill.BorderSizePixel = 0
    CreateCorner(SliderFill, 10)
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = SliderTrack
    SliderButton.Position = UDim2.new((defaultValue - min) / (max - min), -10, 0.5, -10)
    SliderButton.Size = UDim2.new(0, 20, 0, 20)
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Text = ""
    CreateCorner(SliderButton, 10)
    CreateStroke(SliderButton, Config.Theme.Accent, 2)
    
    local currentValue = defaultValue
    local dragging = false
    
    local function updateSlider(value)
        value = math.clamp(value, min, max)
        value = math.floor(value + 0.5) -- Round to nearest integer
        currentValue = value
        
        local percentage = (value - min) / (max - min)
        SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        SliderButton.Position = UDim2.new(percentage, -10, 0.5, -10)
        SliderValue.Text = tostring(value)
        
        callback(value)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    SliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = Players.LocalPlayer:GetMouse()
            local relativeX = mouse.X - SliderTrack.AbsolutePosition.X
            local percentage = math.clamp(relativeX / SliderTrack.AbsoluteSize.X, 0, 1)
            local value = min + (max - min) * percentage
            updateSlider(value)
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        if dragging then
            local mouse = Players.LocalPlayer:GetMouse()
            local relativeX = mouse.X - SliderTrack.AbsolutePosition.X
            local percentage = math.clamp(relativeX / SliderTrack.AbsoluteSize.X, 0, 1)
            local value = min + (max - min) * percentage
            updateSlider(value)
        end
    end)
    
    return {
        Frame = SliderFrame,
        Track = SliderTrack,
        GetValue = function() return currentValue end,
        SetValue = function(value) updateSlider(value) end
    }
end

return UILibrary