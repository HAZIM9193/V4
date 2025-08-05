-- Load DrRay UI Library (icon tab version)
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

local window = DrRayLibrary:Load("ZeeHub", "Default")

-- Buat Tab Baru (guna ikon default)
local MainTab = DrRayLibrary.newTab("Main", "Default")
MainTab.newLabel("This tab is A few are available and more will be available in the future..")
MainTab.newButton("Fly", "Universal", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-player-TrollX-30700"))()
end)

local ScriptTab = DrRayLibrary.newTab("Script", "Default")
ScriptTab.newButton("AdminCmd", "Universal", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/main.lua"))()
end)

ScriptTab.newButton("Infinite Money", "UPD Shopping Drift at Driftmart", function()
    local args = {
        999999999999
    }
    
    game:GetService('ReplicatedStorage'):WaitForChild('DriftEvent'):FireServer(unpack(args))
end)

ScriptTab.newButton("Fake Admin", "(Not Fe) Universal", function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local function createBillboard(character)
        local head = character:WaitForChild("Head")

        -- Buang jika dah ada
        if head:FindFirstChild("ZeeBillboard") then
            head:FindFirstChild("ZeeBillboard"):Destroy()
        end

        -- Buat Billboard baru
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ZeeBillboard"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 100, 0, 100)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head

        -- Logo imej
        local image = Instance.new("ImageLabel")
        image.Size = UDim2.new(0, 70, 0, 70)
        image.Position = UDim2.new(0.15, 0, 0, 0)
        image.BackgroundTransparency = 1
        image.Image = "rbxassetid://90950982856922"
        image.Parent = billboard

        -- Label teks
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 0, 20)
        text.Position = UDim2.new(0, 0, 1, -10)
        text.BackgroundTransparency = 1
        text.Text = "Zee [ Admin ]"
        text.TextColor3 = Color3.fromRGB(255, 255, 0)
        text.TextStrokeTransparency = 0
        text.TextScaled = true
        text.Font = Enum.Font.GothamBold
        text.Parent = billboard
    end

    -- Pertama kali load
    if player.Character then
        createBillboard(player.Character)
    end

    -- Auto-update bila respawn
    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        createBillboard(char)
    end)
end)

local SettingsTab = DrRayLibrary.newTab("Settings", "Default")
SettingsTab.newLabel("This tab is still empty and will be completed shortly, please come back soon.")