--[[
    Complete Dropdown Demonstration
    Shows all types of dropdown behaviors you asked about
]]

local UILibrary = loadstring(game:HttpGet("YOUR_URL_HERE"))() -- Replace with your URL

-- Create window and tabs
local Window = UILibrary:CreateWindow("Dropdown Types Demo", UDim2.new(0, 650, 0, 500))

local MainTab = UILibrary:CreateTab(Window, "Main", "🏠")
local SettingsTab = UILibrary:CreateTab(Window, "Settings", "⚙️")
local WeaponsTab = UILibrary:CreateTab(Window, "Weapons", "⚔️")
local PlayersTab = UILibrary:CreateTab(Window, "Players", "👥")

print("=== DROPDOWN TYPES DEMO ===")

-- 1. REGULAR DROPDOWN (Standard behavior)
print("1. Creating regular dropdown...")
UILibrary:CreateDropdown(MainTab, "Regular Options", 
    {"Option A", "Option B", "Option C"}, 
    function(selected)
        print("✓ Regular dropdown selected:", selected)
    end
)

-- 2. TAB SWITCHER DROPDOWN
print("2. Creating tab switcher dropdown...")
local tabSwitcher = UILibrary:CreateDropdown(MainTab, "Go To Tab", 
    {"Main", "Settings", "Weapons", "Players"}, 
    function(selected)
        print("✓ Switching to tab:", selected)
        
        -- Actually switch the tab
        if selected == "Main" then
            MainTab.Button.MouseButton1Click()
        elseif selected == "Settings" then
            SettingsTab.Button.MouseButton1Click()
        elseif selected == "Weapons" then
            WeaponsTab.Button.MouseButton1Click()
        elseif selected == "Players" then
            PlayersTab.Button.MouseButton1Click()
        end
    end
)

-- 3. SMART DROPDOWN (Updates options based on current tab)
print("3. Creating smart dropdown with dynamic options...")
local smartDropdown = UILibrary:CreateDropdown(MainTab, "Smart Options", 
    {"Loading..."}, 
    function(selected)
        print("✓ Smart dropdown selected:", selected, "in tab:", Window.CurrentTab)
    end
)

-- Function to update smart dropdown based on current tab
local function updateSmartDropdown()
    local currentTab = Window.CurrentTab
    local newOptions = {}
    
    if currentTab == "Main" then
        newOptions = {"Main Action 1", "Main Action 2", "Main Action 3"}
    elseif currentTab == "Settings" then
        newOptions = {"Graphics", "Audio", "Controls", "Gameplay"}
    elseif currentTab == "Weapons" then
        newOptions = {"Equip Sword", "Equip Bow", "Equip Staff", "Unequip All"}
    elseif currentTab == "Players" then
        newOptions = {"Kick Player", "Mute Player", "Teleport To", "Give Admin"}
    else
        newOptions = {"No Options Available"}
    end
    
    smartDropdown.UpdateOptions(newOptions)
    print("→ Smart dropdown updated for tab:", currentTab)
end

-- Button to manually update smart dropdown
UILibrary:CreateButton(MainTab, "Update Smart Dropdown", function()
    updateSmartDropdown()
end)

-- 4. CROSS-TAB DROPDOWN (Exists in multiple tabs with shared state)
print("4. Creating cross-tab dropdown...")
local sharedValue = "Default"

local function createSharedDropdown(tab, name)
    return UILibrary:CreateDropdown(tab, name, 
        {"Default", "Value 1", "Value 2", "Value 3"}, 
        function(selected)
            sharedValue = selected
            print("✓ Shared value changed to:", selected, "from tab:", Window.CurrentTab)
        end
    )
end

local mainShared = createSharedDropdown(MainTab, "Shared Setting")
local settingsShared = createSharedDropdown(SettingsTab, "Shared Setting")

-- 5. PLAYER LIST DROPDOWN (Dynamic content)
print("5. Creating player list dropdown...")
local function getPlayerList()
    local players = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(players, player.Name)
    end
    return #players > 0 and players or {"No Players"}
end

local playerDropdown = UILibrary:CreateDropdown(PlayersTab, "Select Player", 
    getPlayerList(), 
    function(selected)
        print("✓ Player selected:", selected)
        
        -- Example player actions
        local targetPlayer = game.Players:FindFirstChild(selected)
        if targetPlayer and targetPlayer.Character then
            print("→ Target player found:", targetPlayer.Name)
            -- You could teleport to them, spectate, etc.
        end
    end
)

-- Button to refresh player list
UILibrary:CreateButton(PlayersTab, "Refresh Players", function()
    playerDropdown.UpdateOptions(getPlayerList())
    print("→ Player list refreshed")
end)

-- 6. CONTEXT-SENSITIVE DROPDOWN
print("6. Creating context-sensitive dropdown...")
local contextDropdown = UILibrary:CreateDropdown(MainTab, "Context Actions", 
    {"Action 1", "Action 2"}, 
    function(selected)
        local currentTab = Window.CurrentTab
        print("✓ Context action:", selected, "in", currentTab)
        
        -- Different behavior based on current tab
        if currentTab == "Main" then
            print("→ Executing main context action:", selected)
        elseif currentTab == "Settings" then
            print("→ Executing settings context action:", selected)
        elseif currentTab == "Weapons" then
            print("→ Executing weapon context action:", selected)
        elseif currentTab == "Players" then
            print("→ Executing player context action:", selected)
        end
    end
)

-- ADD CONTENT TO OTHER TABS

-- Settings Tab
UILibrary:CreateButton(SettingsTab, "Apply Settings", function()
    updateSmartDropdown() -- Update when switching to settings
    print("Settings applied!")
end)

UILibrary:CreateDropdown(SettingsTab, "Graphics Quality", 
    {"Low", "Medium", "High", "Ultra"}, 
    function(selected)
        print("Graphics quality set to:", selected)
    end
)

-- Weapons Tab
UILibrary:CreateButton(WeaponsTab, "Refresh Weapons", function()
    updateSmartDropdown() -- Update when switching to weapons
    print("Weapons refreshed!")
end)

UILibrary:CreateDropdown(WeaponsTab, "Weapon Category", 
    {"Melee", "Ranged", "Magic", "Special"}, 
    function(selected)
        print("Weapon category:", selected)
        
        -- Update weapon-specific options based on category
        local weaponOptions = {
            ["Melee"] = {"Sword", "Axe", "Hammer", "Dagger"},
            ["Ranged"] = {"Bow", "Crossbow", "Gun", "Throwing Knife"},
            ["Magic"] = {"Staff", "Wand", "Orb", "Tome"},
            ["Special"] = {"Boomerang", "Whip", "Chain", "Gauntlets"}
        }
        
        -- You could create another dropdown here with category-specific weapons
        print("Available weapons for", selected, ":", table.concat(weaponOptions[selected], ", "))
    end
)

-- Players Tab  
UILibrary:CreateButton(PlayersTab, "Auto-Update Players", function()
    -- Auto-update player list every 5 seconds
    spawn(function()
        while true do
            wait(5)
            playerDropdown.UpdateOptions(getPlayerList())
            print("→ Auto-refreshed player list")
        end
    end)
end)

-- Advanced example: Tab-aware dropdown that remembers selections per tab
local tabMemory = {}

local memoryDropdown = UILibrary:CreateDropdown(MainTab, "Memory Dropdown", 
    {"Choice 1", "Choice 2", "Choice 3"}, 
    function(selected)
        local currentTab = Window.CurrentTab
        tabMemory[currentTab] = selected
        print("✓ Saved", selected, "for tab", currentTab)
        print("→ Tab memory:", game:GetService("HttpService"):JSONEncode(tabMemory))
    end
)

-- Function to restore dropdown selection when switching tabs
local function restoreMemoryDropdown()
    local currentTab = Window.CurrentTab
    local savedSelection = tabMemory[currentTab]
    if savedSelection then
        memoryDropdown.SetSelected(savedSelection)
        print("→ Restored selection:", savedSelection, "for tab:", currentTab)
    end
end

-- Override tab clicks to update smart dropdown automatically
local originalMainClick = MainTab.Button.MouseButton1Click
MainTab.Button.MouseButton1Click:Connect(function()
    wait(0.1) -- Small delay to ensure tab is switched
    updateSmartDropdown()
    restoreMemoryDropdown()
end)

local originalSettingsClick = SettingsTab.Button.MouseButton1Click  
SettingsTab.Button.MouseButton1Click:Connect(function()
    wait(0.1)
    updateSmartDropdown()
    restoreMemoryDropdown()
end)

local originalWeaponsClick = WeaponsTab.Button.MouseButton1Click
WeaponsTab.Button.MouseButton1Click:Connect(function()
    wait(0.1)
    updateSmartDropdown()
    restoreMemoryDropdown()
end)

local originalPlayersClick = PlayersTab.Button.MouseButton1Click
PlayersTab.Button.MouseButton1Click:Connect(function()
    wait(0.1)
    updateSmartDropdown()
    restoreMemoryDropdown()
end)

print("=== DEMO READY ===")
print("Try switching tabs and using different dropdowns!")

--[[
    EXPLANATION OF DROPDOWN TYPES:
    
    1. REGULAR DROPDOWN:
       - Basic dropdown that stays in its tab
       - Options don't change
       - Standard behavior
    
    2. TAB SWITCHER DROPDOWN:
       - Dropdown can switch to different tabs
       - The dropdown itself stays in original tab
       - But it changes which tab is visible
    
    3. SMART DROPDOWN:
       - Options change based on current tab
       - Updates automatically or manually
       - Context-aware behavior
    
    4. CROSS-TAB DROPDOWN:
       - Same dropdown exists in multiple tabs
       - Shares state between tabs
       - Synchronized selections
    
    5. PLAYER LIST DROPDOWN:
       - Dynamic content that updates
       - Reflects real-time game state
       - Can be refreshed on demand
    
    6. CONTEXT-SENSITIVE:
       - Same options, different actions per tab
       - Behavior changes based on context
       - Smart action handling
    
    Answer to your question:
    - Dropdowns DON'T need to be written once per tab
    - Each dropdown belongs to the specific tab you create it in
    - But you CAN make dropdowns that switch tabs or affect other tabs
    - You CAN create the same dropdown in multiple tabs if needed
]]