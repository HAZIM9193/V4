--// Floating Countdown -> Fixed Target Date (EST, UTC-5)
--// Works in most executors (uses CoreGui / gethui if available)

--== helper: safe parent in CoreGui / gethui
local CoreGui = game:GetService("CoreGui")
local parent = (gethui and gethui()) or CoreGui
if syn and syn.protect_gui then
    syn.protect_gui(parent)
end

--== remove old
local OLD = parent:FindFirstChild("ZeeCountdown")
if OLD then OLD:Destroy() end

--== build UI
local sg = Instance.new("ScreenGui")
sg.Name = "ZeeCountdown"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = parent

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(310, 60)
frame.Position = UDim2.fromOffset(80, 80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = sg

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(70, 70, 80)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -10, 0, 20)
title.Position = UDim2.fromOffset(8, 6)
title.BackgroundTransparency = 1
title.Text = "Countdown (EST Target Date)"
title.TextColor3 = Color3.fromRGB(180, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, -16, 0, 28)
timeLabel.Position = UDim2.fromOffset(8, 26)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "-- : -- : -- : --"
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextScaled = true
timeLabel.Parent = frame

local uiPadding = Instance.new("UIPadding", frame)
uiPadding.PaddingLeft = UDim.new(0, 6)
uiPadding.PaddingRight = UDim.new(0, 6)

--== drag (custom; Draggable deprecated)
do
    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.fromOffset(startPos.X + delta.X, startPos.Y + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Vector2.new(frame.Position.X.Offset, frame.Position.Y.Offset)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
end

--== time helpers
local function pad2(n) return string.format("%02d", math.floor(n)) end

--== updater loop
task.spawn(function()
    local TargetDate = os.time({year=2025, month=8, day=10, hour=8, min=0, sec=0}) -- Target tarikh
    
    while sg.Parent do
        local Time = os.date("!*t", os.time() - 5 * 60 * 60) -- UTC-5 (EST)
        local currentDate = os.time(Time)
        local secondLeft = TargetDate - currentDate
        
        if secondLeft <= 0 then
            timeLabel.Text = "00:00:00:00"
        else
            local days = math.floor(secondLeft / (24 * 60 * 60))  
            local hours = math.floor((secondLeft % (24 * 60 * 60)) / (60 * 60))  
            local minutes = math.floor((secondLeft % (60 * 60)) / 60)  
            local seconds = math.floor(secondLeft % 60)
            
            timeLabel.Text = pad2(days)..":"..pad2(hours)..":"..pad2(minutes)..":"..pad2(seconds)
        end
        
        task.wait(0.2)
    end
end)