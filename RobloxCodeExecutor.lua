-- Roblox Code Executor GUI Script
-- Place this in StarterPlayerScripts or StarterGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CodeExecutorGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create the toggle button (RQ button)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "RQ"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = screenGui

-- Add rounded corners to toggle button
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Create the main GUI frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Add rounded corners to main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Create the close button (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

-- Add rounded corners to close button
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Create title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -50, 0, 40)
titleLabel.Position = UDim2.new(0, 10, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Code Executor"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Create input section label
local inputLabel = Instance.new("TextLabel")
inputLabel.Name = "InputLabel"
inputLabel.Size = UDim2.new(1, -20, 0, 25)
inputLabel.Position = UDim2.new(0, 10, 0, 50)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "Input:"
inputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
inputLabel.TextScaled = true
inputLabel.Font = Enum.Font.Gotham
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = mainFrame

-- Create the input text box
local inputBox = Instance.new("TextBox")
inputBox.Name = "InputBox"
inputBox.Size = UDim2.new(1, -20, 0, 150)
inputBox.Position = UDim2.new(0, 10, 0, 80)
inputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
inputBox.BorderSizePixel = 0
inputBox.Text = 'print("Hello World!")'
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextSize = 14
inputBox.Font = Enum.Font.Code
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.TextYAlignment = Enum.TextYAlignment.Top
inputBox.MultiLine = true
inputBox.ClearTextOnFocus = false
inputBox.Parent = mainFrame

-- Add rounded corners to input box
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputBox

-- Create the clear button
local clearButton = Instance.new("TextButton")
clearButton.Name = "ClearButton"
clearButton.Size = UDim2.new(0, 80, 0, 30)
clearButton.Position = UDim2.new(1, -180, 0, 240)
clearButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
clearButton.BorderSizePixel = 0
clearButton.Text = "Clear"
clearButton.TextColor3 = Color3.fromRGB(0, 0, 0)
clearButton.TextScaled = true
clearButton.Font = Enum.Font.GothamBold
clearButton.Parent = mainFrame

-- Add rounded corners to clear button
local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 6)
clearCorner.Parent = clearButton

-- Create the run button
local runButton = Instance.new("TextButton")
runButton.Name = "RunButton"
runButton.Size = UDim2.new(0, 80, 0, 30)
runButton.Position = UDim2.new(1, -90, 0, 240)
runButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
runButton.BorderSizePixel = 0
runButton.Text = "Run"
runButton.TextColor3 = Color3.fromRGB(255, 255, 255)
runButton.TextScaled = true
runButton.Font = Enum.Font.GothamBold
runButton.Parent = mainFrame

-- Add rounded corners to run button
local runCorner = Instance.new("UICorner")
runCorner.CornerRadius = UDim.new(0, 6)
runCorner.Parent = runButton

-- Create output section label
local outputLabel = Instance.new("TextLabel")
outputLabel.Name = "OutputLabel"
outputLabel.Size = UDim2.new(1, -20, 0, 25)
outputLabel.Position = UDim2.new(0, 10, 0, 280)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "Output:"
outputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
outputLabel.TextScaled = true
outputLabel.Font = Enum.Font.Gotham
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = mainFrame

-- Create the output text box
local outputBox = Instance.new("TextBox")
outputBox.Name = "OutputBox"
outputBox.Size = UDim2.new(1, -20, 0, 80)
outputBox.Position = UDim2.new(0, 10, 0, 310)
outputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
outputBox.BorderSizePixel = 0
outputBox.Text = "Output will appear here..."
outputBox.TextColor3 = Color3.fromRGB(150, 255, 150)
outputBox.TextSize = 12
outputBox.Font = Enum.Font.Code
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.MultiLine = true
outputBox.TextEditable = false
outputBox.Parent = mainFrame

-- Add rounded corners to output box
local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 8)
outputCorner.Parent = outputBox

-- Animation tweens
local fadeInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
)

local fadeOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    {BackgroundTransparency = 1}
)

local scaleInTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 600, 0, 400)}
)

local scaleOutTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
    {Size = UDim2.new(0, 0, 0, 0)}
)

-- Variables
local isGUIOpen = false

-- Function to show GUI with fade in animation
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
        
        -- Animate children
        wait(0.1)
        for _, child in pairs(mainFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                local childFadeTween = TweenService:Create(
                    child,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundTransparency = child.Name == "TitleLabel" and 1 or 0}
                )
                childFadeTween:Play()
                
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                    local textFadeTween = TweenService:Create(
                        child,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {TextTransparency = 0}
                    )
                    textFadeTween:Play()
                end
            end
        end
    end
end

-- Function to hide GUI with fade out animation
local function hideGUI()
    if isGUIOpen then
        isGUIOpen = false
        
        -- Animate children first
        for _, child in pairs(mainFrame:GetChildren()) do
            if child:IsA("GuiObject") then
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
        warn = function(...) customPrint("WARN:", ...) end,
        error = function(...) customPrint("ERROR:", ...) end,
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
        outputBox.Text = outputBox.Text .. "Error: " .. tostring(result) .. "\n"
    elseif result ~= nil then
        outputBox.Text = outputBox.Text .. tostring(result) .. "\n"
    end
    
    if outputBox.Text == "" then
        outputBox.Text = "Code executed successfully (no output)"
    end
end

-- Function to clear input
local function clearInput()
    inputBox.Text = ""
    outputBox.Text = "Input cleared."
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
        outputBox.Text = "No code to execute!"
    end
end)

clearButton.MouseButton1Click:Connect(function()
    clearInput()
end)

-- Add hover effects for buttons
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = hoverColor}
        )
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local normalTween = TweenService:Create(
            button,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = normalColor}
        )
        normalTween:Play()
    end)
end

-- Apply hover effects
addHoverEffect(toggleButton, Color3.fromRGB(65, 65, 65), Color3.fromRGB(45, 45, 45))
addHoverEffect(closeButton, Color3.fromRGB(240, 73, 89), Color3.fromRGB(220, 53, 69))
addHoverEffect(runButton, Color3.fromRGB(60, 187, 89), Color3.fromRGB(40, 167, 69))
addHoverEffect(clearButton, Color3.fromRGB(255, 213, 27), Color3.fromRGB(255, 193, 7))

-- Keyboard shortcut (Ctrl+Enter to run code)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and isGUIOpen then
        if input.KeyCode == Enum.KeyCode.Return and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            runButton.MouseButton1Click:Fire()
        elseif input.KeyCode == Enum.KeyCode.Delete and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            clearButton.MouseButton1Click:Fire()
        end
    end
end)

print("Code Executor GUI loaded successfully!")
print("Features:")
print("- Execute regular Lua code")
print("- Execute loadstring scripts from URLs")
print("- Clear button to instantly clear input")
print("- Keyboard shortcuts: Ctrl+Enter (Run), Ctrl+Delete (Clear)")