# 🌈✨ Roblox Code Executor with Rainbow Background

A beautiful and feature-rich code executor GUI for Roblox with an animated rainbow sparkling background, loadstring support, and modern UI design.

![Version](https://img.shields.io/badge/version-2.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Roblox](https://img.shields.io/badge/platform-Roblox-red.svg)

## 🎯 Features

- **💻 Code Execution**: Execute Lua code with a safe environment
- **🔗 Loadstring Support**: Execute external scripts from URLs using `loadstring(game:HttpGet("url"))()`
- **🗑️ Clear Button**: Instantly clear input with a dedicated button
- **🌈 Rainbow Background**: Beautiful animated gradient that rotates and shimmers
- **✨ Sparkling Effects**: 15 animated particles that float and change colors
- **⌨️ Keyboard Shortcuts**: 
  - `Ctrl+Enter`: Run code
  - `Ctrl+Delete`: Clear input
- **🎨 Modern UI**: Clean, rounded design with smooth animations
- **🖱️ Hover Effects**: Interactive button animations
- **📱 Responsive**: Scales properly on different screen sizes

## 🚀 Installation

### Method 1: Direct Script Execution
1. Open Roblox Studio
2. Create a new Script in `ServerScriptService` or `StarterPlayerScripts`
3. Copy the code from [`RobloxCodeExecutor.lua`](RobloxCodeExecutor.lua)
4. Paste it into your script
5. Run the game

### Method 2: Model Import (Coming Soon)
We're working on creating a Roblox model for easy import!

## 📖 Usage

### Opening the GUI
- Click the **"RQ"** button in the top-left corner of your screen
- The GUI will appear with a beautiful rainbow background

### Running Code
1. Type your Lua code in the input box
2. Click **"Run"** or press `Ctrl+Enter`
3. View the output in the output box

### Using Loadstring
The executor supports external script execution:
```lua
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-player-TrollX-30700"))()
```

### Clearing Input
- Click the yellow **"Clear"** button
- Or press `Ctrl+Delete`

## 🎨 Visual Features

### Rainbow Background
- **7-color gradient**: Pink → Red → Orange → Yellow → Green → Cyan → Purple
- **Continuous rotation**: 360° every 3 seconds
- **Shimmer effect**: Dynamic transparency changes
- **45° angle**: Diagonal flow for visual appeal

### Sparkling Animation
- **15 particles**: Small circular sparkles
- **Random movement**: Smooth floating animation
- **Color cycling**: HSV-based rainbow colors
- **Opacity animation**: Twinkling fade effects

## 🛡️ Security Features

- **Safe Environment**: Restricted execution context for regular code
- **Loadstring Detection**: Smart detection for external script execution
- **Error Handling**: Comprehensive error catching and display
- **Custom Output**: Redirected print functions to GUI

## 🔧 Technical Details

### Services Used
- `Players` - Player management
- `TweenService` - Smooth animations
- `UserInputService` - Keyboard shortcuts
- `HttpService` - External script support

### Compatibility
- **Roblox Studio**: ✅ Full support
- **Live Games**: ✅ Works in published games
- **Mobile**: ✅ Touch-friendly interface
- **All Executors**: ✅ Compatible with most script executors

## 📝 Example Scripts

### Basic Lua Code
```lua
print("Hello, World!")
for i = 1, 5 do
    print("Count:", i)
end
```

### Game Manipulation
```lua
local player = game.Players.LocalPlayer
player.Character.Humanoid.WalkSpeed = 50
print("Speed increased!")
```

### External Script Loading
```lua
-- Load a fly script
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-player-TrollX-30700"))()

-- Load any external script
loadstring(game:HttpGet("YOUR_SCRIPT_URL_HERE"))()
```

## 🎯 Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Enter` | Execute code |
| `Ctrl+Delete` | Clear input |
| `RQ Button` | Toggle GUI |
| `X Button` | Close GUI |

## 🎨 Customization

The script is highly customizable! You can modify:
- **Colors**: Change the rainbow gradient colors
- **Animation Speed**: Adjust tween durations
- **Sparkle Count**: Modify the number of particles
- **Button Positions**: Reposition UI elements
- **Transparency**: Adjust background opacity

## 🐛 Troubleshooting

### Common Issues

**GUI doesn't appear:**
- Make sure the script is in the correct location
- Check if the game allows custom GUIs

**Loadstring not working:**
- Ensure the URL is correct and accessible
- Check if HTTP requests are enabled in the game

**Animation lag:**
- Reduce sparkle count for better performance
- Lower animation frequencies

### Support
If you encounter issues, please:
1. Check the output console for errors
2. Verify script placement
3. Test with simpler code first

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## 📞 Contact

- **GitHub Issues**: [Report bugs or request features](../../issues)
- **Discussions**: [Join the community discussion](../../discussions)

## ⭐ Acknowledgments

- Thanks to the Roblox scripting community
- Inspired by modern code editor designs
- Built with love for the Roblox development community

---

**⭐ If you found this useful, please give it a star!** ⭐