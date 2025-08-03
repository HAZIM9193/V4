-- Enhanced Roblox Code Executor GUI Script with Rainbow, Shine, Glow Effects
-- Place this in StarterPlayerScripts or StarterGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CodeExecutorGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create animated background frame
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "AnimatedBackground"
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
backgroundFrame.BorderSizePixel = 0
backgroundFrame.ZIndex = -1
backgroundFrame.Parent = screenGui

-- Create rainbow gradient background
local rainbowGradient = Instance.new("UIGradient")
rainbowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),    -- Red
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)), -- Orange
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)), -- Yellow
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),   -- Green
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 255)), -- Cyan
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(0, 0, 255)),   -- Blue
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))     -- Magenta
}
rainbowGradient.Transparency = NumberSequence.new(0.85)
rainbowGradient.Rotation = 45
rainbowGradient.Parent = backgroundFrame

-- Create shine effect overlay
local shineFrame = Instance.new("Frame")
shineFrame.Name = "ShineEffect"
shineFrame.Size = UDim2.new(0.3, 0, 1.5, 0)
shineFrame.Position = UDim2.new(-0.3, 0, -0.25, 0)
shineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shineFrame.BorderSizePixel = 0
shineFrame.ZIndex = 0
shineFrame.Parent = backgroundFrame

local shineGradient = Instance.new("UIGradient")
shineGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
shineGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.7),
    NumberSequenceKeypoint.new(1, 1)
}
shineGradient.Rotation = 20
shineGradient.Parent = shineFrame

-- Create particle effect frames
local particles = {}
for i = 1, 15 do
    local particle = Instance.new("Frame")
    particle.Name = "Particle" .. i
    particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
    particle.BorderSizePixel = 0
    particle.ZIndex = 1
    particle.Parent = backgroundFrame
    
    local particleCorner = Instance.new("UICorner")
    particleCorner.CornerRadius = UDim.new(1, 0)
    particleCorner.Parent = particle
    
    table.insert(particles, particle)
end

-- Create the toggle button (RQ button) with glow effect
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 35)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "RQ"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.ZIndex = 10
toggleButton.Parent = screenGui

-- Add glow effect to toggle button
local toggleGlow = Instance.new("Frame")
toggleGlow.Name = "GlowEffect"
toggleGlow.Size = UDim2.new(1, 20, 1, 20)
toggleGlow.Position = UDim2.new(0, -10, 0, -10)
toggleGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
toggleGlow.BackgroundTransparency = 0.8
toggleGlow.BorderSizePixel = 0
toggleGlow.ZIndex = 9
toggleGlow.Parent = toggleButton

local toggleGlowCorner = Instance.new("UICorner")
toggleGlowCorner.CornerRadius = UDim.new(0, 15)
toggleGlowCorner.Parent = toggleGlow

-- Add rounded corners to toggle button
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Create the main GUI frame with enhanced styling
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 450)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ZIndex = 5
mainFrame.Parent = screenGui

-- Add main frame glow
local mainGlow = Instance.new("Frame")
mainGlow.Name = "MainGlow"
mainGlow.Size = UDim2.new(1, 30, 1, 30)
mainGlow.Position = UDim2.new(0, -15, 0, -15)
mainGlow.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
mainGlow.BackgroundTransparency = 0.7
mainGlow.BorderSizePixel = 0
mainGlow.ZIndex = 4
mainGlow.Parent = mainFrame

local mainGlowCorner = Instance.new("UICorner")
mainGlowCorner.CornerRadius = UDim.new(0, 25)
mainGlowCorner.Parent = mainGlow

-- Add rainbow border to main frame
local rainbowBorder = Instance.new("Frame")
rainbowBorder.Name = "RainbowBorder"
rainbowBorder.Size = UDim2.new(1, 6, 1, 6)
rainbowBorder.Position = UDim2.new(0, -3, 0, -3)
rainbowBorder.BorderSizePixel = 0
rainbowBorder.ZIndex = 4
rainbowBorder.Parent = mainFrame

local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
}
borderGradient.Parent = rainbowBorder

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 15)
borderCorner.Parent = rainbowBorder

-- Add rounded corners to main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Create the close button (X) with enhanced styling
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -45, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.ZIndex = 6
closeButton.Parent = mainFrame

-- Add rounded corners to close button
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Create title label with rainbow effect
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -55, 0, 45)
titleLabel.Position = UDim2.new(0, 15, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "✨ Rainbow Code Executor ✨"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 6
titleLabel.Parent = mainFrame

-- Create input section label
local inputLabel = Instance.new("TextLabel")
inputLabel.Name = "InputLabel"
inputLabel.Size = UDim2.new(1, -30, 0, 25)
inputLabel.Position = UDim2.new(0, 15, 0, 60)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "💻 Code Input:"
inputLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
inputLabel.TextScaled = true
inputLabel.Font = Enum.Font.Gotham
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.ZIndex = 6
inputLabel.Parent = mainFrame

-- Create the input text box with glow
local inputBox = Instance.new("TextBox")
inputBox.Name = "InputBox"
inputBox.Size = UDim2.new(1, -30, 0, 160)
inputBox.Position = UDim2.new(0, 15, 0, 90)
inputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
inputBox.BorderSizePixel = 0
inputBox.Text = 'print("🌈 Hello Rainbow World! 🌈")'
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextSize = 14
inputBox.Font = Enum.Font.Code
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.TextYAlignment = Enum.TextYAlignment.Top
inputBox.MultiLine = true
inputBox.ClearTextOnFocus = false
inputBox.ZIndex = 6
inputBox.Parent = mainFrame

-- Add input box glow
local inputGlow = Instance.new("Frame")
inputGlow.Name = "InputGlow"
inputGlow.Size = UDim2.new(1, 10, 1, 10)
inputGlow.Position = UDim2.new(0, -5, 0, -5)
inputGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
inputGlow.BackgroundTransparency = 0.9
inputGlow.BorderSizePixel = 0
inputGlow.ZIndex = 5
inputGlow.Parent = inputBox

local inputGlowCorner = Instance.new("UICorner")
inputGlowCorner.CornerRadius = UDim.new(0, 12)
inputGlowCorner.Parent = inputGlow

-- Add rounded corners to input box
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputBox

-- Create the clear button with rainbow styling
local clearButton = Instance.new("TextButton")
clearButton.Name = "ClearButton"
clearButton.Size = UDim2.new(0, 90, 0, 35)
clearButton.Position = UDim2.new(1, -200, 0, 260)
clearButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
clearButton.BorderSizePixel = 0
clearButton.Text = "🗑️ Clear"
clearButton.TextColor3 = Color3.fromRGB(0, 0, 0)
clearButton.TextScaled = true
clearButton.Font = Enum.Font.GothamBold
clearButton.ZIndex = 6
clearButton.Parent = mainFrame

-- Add rounded corners to clear button
local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = clearButton

-- Create the run button with enhanced styling
local runButton = Instance.new("TextButton")
runButton.Name = "RunButton"
runButton.Size = UDim2.new(0, 90, 0, 35)
runButton.Position = UDim2.new(1, -100, 0, 260)
runButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
runButton.BorderSizePixel = 0
runButton.Text = "▶️ Run"
runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
runButton.TextScaled = true
runButton.Font = Enum.Font.GothamBold
runButton.ZIndex = 6
runButton.Parent = mainFrame

-- Add rounded corners to run button
local runCorner = Instance.new("UICorner")
runCorner.CornerRadius = UDim.new(0, 8)
runCorner.Parent = runButton

-- Create output section label
local outputLabel = Instance.new("TextLabel")
outputLabel.Name = "OutputLabel"
outputLabel.Size = UDim2.new(1, -30, 0, 25)
outputLabel.Position = UDim2.new(0, 15, 0, 305)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "📤 Output:"
outputLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
outputLabel.TextScaled = true
outputLabel.Font = Enum.Font.Gotham
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.ZIndex = 6
outputLabel.Parent = mainFrame

-- Create the output text box with glow
local outputBox = Instance.new("TextBox")
outputBox.Name = "OutputBox"
outputBox.Size = UDim2.new(1, -30, 0, 90)
outputBox.Position = UDim2.new(0, 15, 0, 335)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 25, 15)
outputBox.BorderSizePixel = 0
outputBox.Text = "✨ Rainbow output will appear here... ✨"
outputBox.TextColor3 = Color3.fromRGB(150, 255, 150)
outputBox.TextSize = 12
outputBox.Font = Enum.Font.Code
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.MultiLine = true
outputBox.TextEditable = false
outputBox.ZIndex = 6
outputBox.Parent = mainFrame

-- Add output box glow
local outputGlow = Instance.new("Frame")
outputGlow.Name = "OutputGlow"
outputGlow.Size = UDim2.new(1, 10, 1, 10)
outputGlow.Position = UDim2.new(0, -5, 0, -5)
outputGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
outputGlow.BackgroundTransparency = 0.9
outputGlow.BorderSizePixel = 0
outputGlow.ZIndex = 5
outputGlow.Parent = outputBox

local outputGlowCorner = Instance.new("UICorner")
outputGlowCorner.CornerRadius = UDim.new(0, 12)
outputGlowCorner.Parent = outputGlow

-- Add rounded corners to output box
local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 8)
outputCorner.Parent = outputBox

-- Animation tweens with enhanced effects
local fadeInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
)

local fadeOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    {BackgroundTransparency = 1}
)

local scaleInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 650, 0, 450)}
)

local scaleOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
    {Size = UDim2.new(0, 0, 0, 0)}
)

-- Variables
local isGUIOpen = false

-- Animation functions
local function startBackgroundAnimations()
    -- Rainbow gradient rotation
    spawn(function()
        while true do
            local rotateTween = TweenService:Create(
                rainbowGradient,
                TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
                {Rotation = rainbowGradient.Rotation + 360}
            )
            rotateTween:Play()
            wait(3)
        end
    end)
    
    -- Border gradient rotation
    spawn(function()
        while true do
            local borderRotateTween = TweenService:Create(
                borderGradient,
                TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
                {Rotation = borderGradient.Rotation + 360}
            )
            borderRotateTween:Play()
            wait(2)
        end
    end)
    
    -- Shine effect movement
    spawn(function()
        while true do
            local shineTween = TweenService:Create(
                shineFrame,
                TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Position = UDim2.new(1, 0, -0.25, 0)}
            )
            shineTween:Play()
            shineTween.Completed:Wait()
            shineFrame.Position = UDim2.new(-0.3, 0, -0.25, 0)
            wait(2)
        end
    end)
    
    -- Particle animations
    spawn(function()
        while true do
            for _, particle in pairs(particles) do
                spawn(function()
                    local moveTween = TweenService:Create(
                        particle,
                        TweenInfo.new(math.random(3, 8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        {
                            Position = UDim2.new(math.random(), 0, math.random(), 0),
                            BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
                        }
                    )
                    moveTween:Play()
                end)
            end
            wait(1)
        end
    end)
    
    -- Glow effects pulsing
    spawn(function()
        while true do
            local glowTween = TweenService:Create(
                toggleGlow,
                TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {BackgroundTransparency = 0.5}
            )
            glowTween:Play()
            wait(3)
        end
    end)
    
    -- Main glow color cycling
    spawn(function()
        while true do
            local colors = {
                Color3.fromRGB(255, 100, 255),
                Color3.fromRGB(100, 255, 255),
                Color3.fromRGB(255, 255, 100),
                Color3.fromRGB(100, 255, 100),
                Color3.fromRGB(255, 100, 100)
            }
            for _, color in pairs(colors) do
                local colorTween = TweenService:Create(
                    mainGlow,
                    TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {BackgroundColor3 = color}
                )
                colorTween:Play()
                colorTween.Completed:Wait()
            end
        end
    end)
end

-- Function to show GUI with enhanced animations
local function showGUI()
    if not isGUIOpen then
        isGUIOpen = true
        mainFrame.Visible = true
        mainFrame.BackgroundTransparency = 1
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        
        -- Animate all child elements
        for _, child in pairs(mainFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.BackgroundTransparency = 1
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                    child.TextTransparency = 1
                end
            end
        end
        
        -- Start animations
        scaleInTween:Play()
        fadeInTween:Play()
        
        -- Animate children with stagger
        spawn(function()
            wait(0.2)
            for i, child in pairs(mainFrame:GetChildren()) do
                if child:IsA("GuiObject") then
                    spawn(function()
                        wait(i * 0.05)
                        local childFadeTween = TweenService:Create(
                            child,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                            {BackgroundTransparency = child.Name:find("Label") and 1 or 0}
                        )
                        childFadeTween:Play()
                        
                        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                            local textFadeTween = TweenService:Create(
                                child,
                                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                                {TextTransparency = 0}
                            )
                            textFadeTween:Play()
                        end
                    end)
                end
            end
        end)
    end
end

-- Function to hide GUI with enhanced animations
local function hideGUI()
    if isGUIOpen then
        isGUIOpen = false
        
        -- Animate children first
        for i, child in pairs(mainFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                spawn(function()
                    wait(i * 0.02)
                    local childFadeTween = TweenService:Create(
                        child,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    )
                    childFadeTween:Play()
                    
                    if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                        local textFadeTween = TweenService:Create(
                            child,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                            {TextTransparency = 1}
                        )
                        textFadeTween:Play()
                    end
                end)
            end
        end
        
        wait(0.1)
        scaleOutTween:Play()
        fadeOutTween:Play()
        
        scaleOutTween.Completed:Connect(function()
            mainFrame.Visible = false
        end)
    end
end

-- Function to execute code safely with loadstring support
local function executeCode(code)
    outputBox.Text = ""
    
    -- Create a custom print function that outputs to our GUI
    local function customPrint(...)
        local args = {...}
        local output = ""
        for i, arg in ipairs(args) do
            output = output .. tostring(arg)
            if i < #args then
                output = output .. "\t"
            end
        end
        outputBox.Text = outputBox.Text .. output .. "\n"
    end
    
    -- Create a safe environment for code execution with expanded access
    local env = {
        print = customPrint,
        warn = function(...) customPrint("⚠️ WARN:", ...) end,
        error = function(...) customPrint("❌ ERROR:", ...) end,
        tostring = tostring,
        tonumber = tonumber,
        type = type,
        pairs = pairs,
        ipairs = ipairs,
        next = next,
        math = math,
        string = string,
        table = table,
        coroutine = coroutine,
        loadstring = loadstring,
        pcall = pcall,
        xpcall = xpcall,
        -- Add game services for loadstring compatibility
        game = game,
        workspace = workspace,
        wait = wait,
        spawn = spawn,
        delay = delay,
        -- Add Instance for creating objects
        Instance = Instance,
        -- Add common Roblox globals
        Vector3 = Vector3,
        Vector2 = Vector2,
        UDim2 = UDim2,
        UDim = UDim,
        Color3 = Color3,
        CFrame = CFrame,
        Ray = Ray,
        -- Add Enum
        Enum = Enum,
        -- Add more safe functions as needed
    }
    
    -- Check if the code contains loadstring with HttpGet pattern
    local isLoadstringHttp = string.find(code, "loadstring") and string.find(code, "HttpGet")
    
    -- Try to execute the code
    local success, result = pcall(function()
        local func, err
        
        if isLoadstringHttp then
            -- For loadstring with HttpGet, execute in the global environment
            func, err = loadstring(code)
            if func then
                -- Set environment to allow access to game services
                setfenv(func, setmetatable(env, {__index = _G}))
                return func()
            else
                error(err)
            end
        else
            -- For regular code, use restricted environment
            func, err = loadstring(code)
            if func then
                setfenv(func, env)
                return func()
            else
                error(err)
            end
        end
    end)
    
    if not success then
        outputBox.Text = outputBox.Text .. "❌ Error: " .. tostring(result) .. "\n"
    elseif result ~= nil then
        outputBox.Text = outputBox.Text .. "✅ " .. tostring(result) .. "\n"
    end
    
    if outputBox.Text == "" then
        outputBox.Text = "✨ Code executed successfully (no output) ✨"
    end
end

-- Function to clear input
local function clearInput()
    inputBox.Text = ""
    outputBox.Text = "🗑️ Input cleared successfully! ✨"
end

-- Connect button events
toggleButton.MouseButton1Click:Connect(function()
    if isGUIOpen then
        hideGUI()
    else
        showGUI()
    end
end)

closeButton.MouseButton1Click:Connect(function()
    hideGUI()
end)

runButton.MouseButton1Click:Connect(function()
    local code = inputBox.Text
    if code and code ~= "" then
        executeCode(code)
    else
        outputBox.Text = "⚠️ No code to execute!"
    end
end)

clearButton.MouseButton1Click:Connect(function()
    clearInput()
end)

-- Add enhanced hover effects for buttons
local function addHoverEffect(button, hoverColor, normalColor, glowColor)
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = hoverColor, Size = button.Size + UDim2.new(0, 5, 0, 2)}
        )
        hoverTween:Play()
        
        if glowColor then
            -- Add temporary glow effect
            local tempGlow = Instance.new("Frame")
            tempGlow.Name = "TempGlow"
            tempGlow.Size = UDim2.new(1, 15, 1, 15)
            tempGlow.Position = UDim2.new(0, -7.5, 0, -7.5)
            tempGlow.BackgroundColor3 = glowColor
            tempGlow.BackgroundTransparency = 0.8
            tempGlow.BorderSizePixel = 0
            tempGlow.ZIndex = button.ZIndex - 1
            tempGlow.Parent = button
            
            local tempGlowCorner = Instance.new("UICorner")
            tempGlowCorner.CornerRadius = UDim.new(0, 10)
            tempGlowCorner.Parent = tempGlow
        end
    end)
    
    button.MouseLeave:Connect(function()
        local normalTween = TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = normalColor, Size = button.Size - UDim2.new(0, 5, 0, 2)}
        )
        normalTween:Play()
        
        -- Remove temporary glow
        local tempGlow = button:FindFirstChild("TempGlow")
        if tempGlow then
            tempGlow:Destroy()
        end
    end)
end

-- Apply enhanced hover effects
addHoverEffect(toggleButton, Color3.fromRGB(65, 65, 85), Color3.fromRGB(45, 45, 45), Color3.fromRGB(0, 255, 255))
addHoverEffect(closeButton, Color3.fromRGB(240, 73, 89), Color3.fromRGB(220, 53, 69), Color3.fromRGB(255, 0, 0))
addHoverEffect(runButton, Color3.fromRGB(60, 187, 89), Color3.fromRGB(40, 167, 69), Color3.fromRGB(0, 255, 0))
addHoverEffect(clearButton, Color3.fromRGB(255, 213, 27), Color3.fromRGB(255, 193, 7), Color3.fromRGB(255, 255, 0))

-- Keyboard shortcuts (Ctrl+Enter to run code)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and isGUIOpen then
        if input.KeyCode == Enum.KeyCode.Return and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            runButton.MouseButton1Click:Fire()
        elseif input.KeyCode == Enum.KeyCode.Delete and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            clearButton.MouseButton1Click:Fire()
        end
    end
end)

-- Start all background animations
startBackgroundAnimations()

print("🌈✨ Rainbow Code Executor GUI loaded successfully! ✨🌈")
print("🎨 Features:")
print("   - 🌈 Animated rainbow background")
print("   - ✨ Shine and glow effects")
print("   - 🎊 Floating particles")
print("   - 💫 Smooth animations")
print("   - 📝 Execute regular Lua code")
print("   - 🌐 Execute loadstring scripts from URLs")
print("   - 🗑️ Clear button to instantly clear input")
print("   - ⌨️ Keyboard shortcuts: Ctrl+Enter (Run), Ctrl+Delete (Clear)")
print("   - 🎪 Enhanced visual effects and styling")