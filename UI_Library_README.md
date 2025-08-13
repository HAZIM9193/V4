# Custom UI Library for Roblox

A modern, feature-rich UI library inspired by OrionLib, RayField, and DrRay UI. Designed for local/caller usage with beautiful animations and clean design.

## Features

- 🪟 **Window Management** - Draggable windows with customizable titles and sizes
- 📑 **Tab System** - Organized content with icon support
- 🎛️ **7 UI Components** - All essential UI elements
- 🎨 **Modern Design** - Dark theme with smooth animations
- 📱 **Responsive** - Automatic sizing and scrolling
- 🎯 **Easy to Use** - Simple function calls with callbacks

## Components

### 1. CreateWindow
Creates the main window container.

```lua
local Window = UILibrary:CreateWindow(title, size)
```

**Parameters:**
- `title` (string, optional): Window title (default: "UI Library")
- `size` (UDim2, optional): Window size (default: 500x350)

### 2. CreateTab
Creates a new tab in the window.

```lua
local Tab = UILibrary:CreateTab(window, tabName, icon)
```

**Parameters:**
- `window`: The window object
- `tabName` (string, optional): Tab name (default: "Tab")
- `icon` (string, optional): Tab icon (default: "📄")

### 3. CreateButton
Creates a clickable button.

```lua
UILibrary:CreateButton(tab, buttonName, callback)
```

**Parameters:**
- `tab`: The tab object
- `buttonName` (string, optional): Button text (default: "Button")
- `callback` (function, optional): Function to call when clicked

### 4. CreateSlider
Creates a value slider with draggable handle.

```lua
local slider = UILibrary:CreateSlider(tab, sliderName, min, max, defaultValue, callback)
```

**Parameters:**
- `tab`: The tab object
- `sliderName` (string, optional): Slider label (default: "Slider")
- `min` (number, optional): Minimum value (default: 0)
- `max` (number, optional): Maximum value (default: 100)
- `defaultValue` (number, optional): Starting value (default: min)
- `callback` (function, optional): Function called with new value

**Methods:**
- `slider.GetValue()`: Returns current value
- `slider.SetValue(value)`: Sets the slider value

### 5. CreateToggle
Creates an on/off switch.

```lua
local toggle = UILibrary:CreateToggle(tab, toggleName, defaultState, callback)
```

**Parameters:**
- `tab`: The tab object
- `toggleName` (string, optional): Toggle label (default: "Toggle")
- `defaultState` (boolean, optional): Starting state (default: false)
- `callback` (function, optional): Function called with new state

**Methods:**
- `toggle.GetState()`: Returns current state (boolean)
- `toggle.SetState(state)`: Sets the toggle state

### 6. CreateDropdown
Creates a dropdown menu with options.

```lua
local dropdown = UILibrary:CreateDropdown(tab, dropdownName, options, callback)
```

**Parameters:**
- `tab`: The tab object
- `dropdownName` (string, optional): Dropdown label (default: "Dropdown")
- `options` (table, optional): Array of option strings (default: {"Option 1", "Option 2", "Option 3"})
- `callback` (function, optional): Function called with selected option

**Methods:**
- `dropdown.GetSelected()`: Returns currently selected option
- `dropdown.SetSelected(option)`: Sets the selected option

### 7. CreateInput
Creates a text input field.

```lua
local input = UILibrary:CreateInput(tab, inputName, defaultText, callback)
```

**Parameters:**
- `tab`: The tab object
- `inputName` (string, optional): Input label (default: "Input")
- `defaultText` (string, optional): Starting text (default: "")
- `callback` (function, optional): Function called when Enter is pressed

**Methods:**
- `input.GetText()`: Returns current text
- `input.SetText(text)`: Sets the input text

## Quick Start Example

```lua
-- Load the library
local UILibrary = loadstring(game:HttpGet("YOUR_URL_HERE"))()

-- Create window and tab
local Window = UILibrary:CreateWindow("My Script")
local Tab = UILibrary:CreateTab(Window, "Main", "🏠")

-- Add components
UILibrary:CreateButton(Tab, "Click Me", function()
    print("Hello World!")
end)

local speedSlider = UILibrary:CreateSlider(Tab, "Speed", 1, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

local flyToggle = UILibrary:CreateToggle(Tab, "Flying", false, function(state)
    -- Add flying logic here
    print("Flying:", state)
end)
```

## Installation

### Method 1: LoadString (Recommended)
```lua
local UILibrary = loadstring(game:HttpGet("YOUR_URL_HERE"))()
```

### Method 2: Local Module
1. Create a ModuleScript named "UILibrary"
2. Copy the `UILibrary.lua` content into it
3. Require the module:
```lua
local UILibrary = require(script.UILibrary)
```

## Theme Colors

The library uses a modern dark theme with these colors:
- **Background**: RGB(30, 30, 46)
- **Secondary**: RGB(49, 50, 68)
- **Accent**: RGB(137, 180, 250) - Blue
- **Text**: RGB(205, 214, 244)
- **SubText**: RGB(166, 173, 200)
- **Red**: RGB(243, 139, 168)
- **Green**: RGB(166, 227, 161)
- **Yellow**: RGB(249, 226, 175)

## Features

### Animations
- Smooth tweening for all interactions
- Hover effects on buttons and dropdowns
- Sliding animations for toggles and dropdowns
- Button press feedback

### Window Features
- Draggable title bar
- Close button functionality
- Shadow effects
- Rounded corners with modern design

### Tab System
- Automatic tab switching
- Icon support with emojis
- Smooth color transitions
- Scrollable content areas

### Responsive Design
- Auto-sizing scroll areas
- Proper padding and margins
- Consistent spacing throughout
- Mobile-friendly touch targets

## Advanced Usage

### Getting All Values
```lua
-- Store references to components
local speedSlider = UILibrary:CreateSlider(...)
local flyToggle = UILibrary:CreateToggle(...)
local weaponDropdown = UILibrary:CreateDropdown(...)

-- Get current values
local currentSpeed = speedSlider.GetValue()
local isFlying = flyToggle.GetState()
local selectedWeapon = weaponDropdown.GetSelected()
```

### Setting Values Programmatically
```lua
-- Set values without triggering callbacks
speedSlider.SetValue(50)
flyToggle.SetState(true)
weaponDropdown.SetSelected("Sword")
```

### Multiple Windows
```lua
local MainWindow = UILibrary:CreateWindow("Main Script")
local SettingsWindow = UILibrary:CreateWindow("Settings", UDim2.new(0, 400, 0, 300))

-- Each window operates independently
local MainTab = UILibrary:CreateTab(MainWindow, "Home")
local SettingsTab = UILibrary:CreateTab(SettingsWindow, "Config")
```

## Best Practices

1. **Error Handling**: Always check if player/character exists before applying changes
2. **Performance**: Don't create too many UI elements at once
3. **User Experience**: Provide clear labels and logical grouping
4. **Cleanup**: Destroy windows when script ends to prevent memory leaks

## Troubleshooting

### Common Issues

**"UILibrary is nil"**
- Check that the library loaded correctly
- Verify the URL or module path

**"attempt to index nil value"**
- Ensure the tab/window exists before adding components
- Check that references are stored correctly

**"Components not visible"**
- Make sure the tab is selected
- Check that the window size is appropriate

### Performance Tips

- Limit to 1-2 windows per script
- Use tabs to organize content instead of multiple windows
- Avoid creating components in loops without delays

## License

This library is provided as-is for educational and personal use. Feel free to modify and distribute.

## Credits

Inspired by:
- OrionLib
- RayField
- DrRay UI Library

Created with modern Roblox UI best practices and smooth animations for the best user experience.