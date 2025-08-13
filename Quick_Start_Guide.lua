--[[
    UI Library - Quick Start Guide
    Minimal examples for each component
]]

-- Load the library
local UILibrary = loadstring(game:HttpGet("YOUR_URL_HERE"))() -- Replace with your URL
-- OR for local: local UILibrary = require(script.UILibrary)

-- 1. CREATE WINDOW
local Window = UILibrary:CreateWindow("My UI")

-- 2. CREATE TAB
local Tab = UILibrary:CreateTab(Window, "Main", "🏠")

-- 3. CREATE BUTTON
UILibrary:CreateButton(Tab, "Click Me", function()
    print("Button clicked!")
end)

-- 4. CREATE SLIDER
local slider = UILibrary:CreateSlider(Tab, "Speed", 1, 100, 16, function(value)
    print("Speed:", value)
    -- Set player speed
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

-- 5. CREATE TOGGLE
local toggle = UILibrary:CreateToggle(Tab, "Flying", false, function(state)
    print("Flying:", state)
    -- Add your flying code here
end)

-- 6. CREATE DROPDOWN
local dropdown = UILibrary:CreateDropdown(Tab, "Weapon", {"Sword", "Bow", "Staff"}, function(selected)
    print("Selected:", selected)
    -- Handle weapon selection
end)

-- 7. CREATE INPUT
local input = UILibrary:CreateInput(Tab, "Name", "", function(text)
    print("Name entered:", text)
    -- Handle name input
end)

-- GET/SET VALUES (Optional)
print("Current speed:", slider.GetValue())
print("Flying state:", toggle.GetState())
print("Selected weapon:", dropdown.GetSelected())
print("Entered name:", input.GetText())

-- SET VALUES
slider.SetValue(50)
toggle.SetState(true)
dropdown.SetSelected("Bow")
input.SetText("MyName")

print("Quick start setup complete!")