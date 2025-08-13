--[[
    Enhanced Dropdown System
    Shows different types of dropdowns including tab-switching dropdowns
]]

local UILibrary = loadstring(game:HttpGet("YOUR_URL_HERE"))() -- Replace with your URL

-- Create window and multiple tabs
local Window = UILibrary:CreateWindow("Enhanced Dropdown Demo", UDim2.new(0, 600, 0, 450))

local MainTab = UILibrary:CreateTab(Window, "Main", "🏠")
local SettingsTab = UILibrary:CreateTab(Window, "Settings", "⚙️")
local WeaponsTab = UILibrary:CreateTab(Window, "Weapons", "⚔️")
local MapsTab = UILibrary:CreateTab(Window, "Maps", "🗺️")

-- Regular dropdown (stays in same tab)
UILibrary:CreateDropdown(MainTab, "Regular Options", 
    {"Option 1", "Option 2", "Option 3"}, 
    function(selected)
        print("Regular dropdown selected:", selected)
    end
)

-- TAB SWITCHER DROPDOWN (Enhanced Feature)
-- This dropdown changes which tab is active
local tabDropdown = UILibrary:CreateDropdown(MainTab, "Switch Tab", 
    {"Main", "Settings", "Weapons", "Maps"}, 
    function(selected)
        print("Switching to tab:", selected)
        
        -- Switch to the selected tab
        if selected == "Main" then
            MainTab.Button.MouseButton1Click()
        elseif selected == "Settings" then
            SettingsTab.Button.MouseButton1Click()
        elseif selected == "Weapons" then
            WeaponsTab.Button.MouseButton1Click()
        elseif selected == "Maps" then
            MapsTab.Button.MouseButton1Click()
        end
    end
)

-- CONTENT-AWARE DROPDOWN
-- This dropdown changes content based on current tab
local contentDropdown = UILibrary:CreateDropdown(MainTab, "Context Options", 
    {"Context Option 1", "Context Option 2"}, 
    function(selected)
        print("Context option selected:", selected)
        
        -- Different actions based on current tab
        if Window.CurrentTab == "Main" then
            print("Main tab action:", selected)
        elseif Window.CurrentTab == "Settings" then
            print("Settings tab action:", selected)
        elseif Window.CurrentTab == "Weapons" then
            print("Weapons tab action:", selected)
        elseif Window.CurrentTab == "Maps" then
            print("Maps tab action:", selected)
        end
    end
)

-- Add content to other tabs
UILibrary:CreateButton(SettingsTab, "Settings Button", function()
    print("Settings button clicked!")
end)

UILibrary:CreateDropdown(SettingsTab, "Graphics Quality", 
    {"Low", "Medium", "High", "Ultra"}, 
    function(selected)
        print("Graphics set to:", selected)
    end
)

UILibrary:CreateButton(WeaponsTab, "Equip Weapon", function()
    print("Weapon equipped!")
end)

UILibrary:CreateDropdown(WeaponsTab, "Weapon Type", 
    {"Sword", "Bow", "Staff", "Dagger", "Hammer"}, 
    function(selected)
        print("Weapon selected:", selected)
    end
)

UILibrary:CreateButton(MapsTab, "Load Map", function()
    print("Map loaded!")
end)

UILibrary:CreateDropdown(MapsTab, "Map Selection", 
    {"Forest", "Desert", "Snow", "Volcano", "Space"}, 
    function(selected)
        print("Map selected:", selected)
    end
)

-- SMART DROPDOWN that updates options based on current tab
local smartOptions = {
    ["Main"] = {"Main Option 1", "Main Option 2", "Main Option 3"},
    ["Settings"] = {"Setting A", "Setting B", "Setting C"},
    ["Weapons"] = {"Sword", "Bow", "Staff"},
    ["Maps"] = {"Forest", "Desert", "Snow"}
}

-- You would need to modify the dropdown to support dynamic options
-- Here's a conceptual example:
UILibrary:CreateButton(MainTab, "Update Smart Dropdown", function()
    local currentTab = Window.CurrentTab or "Main"
    local newOptions = smartOptions[currentTab]
    
    print("Current tab:", currentTab)
    print("Available options:", table.concat(newOptions, ", "))
    
    -- This would require modifying the dropdown to support option updates
    -- contentDropdown.UpdateOptions(newOptions)
end)

print("Enhanced dropdown demo loaded!")
print("Try the 'Switch Tab' dropdown to see tab switching in action!")

--[[
    EXPLANATION:
    
    1. REGULAR DROPDOWN:
       - Stays in the same tab
       - Just selects from predefined options
       - Standard behavior
    
    2. TAB SWITCHER DROPDOWN:
       - Can switch between different tabs
       - Uses tab button clicks to change active tab
       - Dropdown stays in original tab but changes the view
    
    3. CONTEXT-AWARE DROPDOWN:
       - Same dropdown, different actions based on current tab
       - Checks Window.CurrentTab to determine behavior
    
    4. SMART DROPDOWN (concept):
       - Options change based on current tab
       - Would need enhanced dropdown with UpdateOptions method
]]