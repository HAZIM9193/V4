# Roblox Command System Setup Guide

## Overview
This system provides a comprehensive command system for Roblox with player detection, whitelisting, and various visual/environmental effects that work across all servers using MessagingService.

## Files Included
1. **MainScript.lua** - Main command handler and effects script
2. **WhitelistModule.lua** - User ID whitelist management module

## Installation Instructions

### Step 1: Setup the WhitelistModule
1. In Roblox Studio, go to **ServerScriptService**
2. Create a new **ModuleScript** (NOT a regular Script)
3. Rename it to **"WhitelistModule"**
4. Copy and paste the contents of `WhitelistModule.lua` into this ModuleScript
5. Save the script

### Step 2: Setup the MainScript
1. In **ServerScriptService**, create a new **Script** (regular server script)
2. Rename it to **"MainScript"** or any name you prefer
3. Copy and paste the contents of `MainScript.lua` into this Script
4. Save the script

### Step 3: Enable MessagingService (Important!)
1. Go to **Game Settings** in Roblox Studio
2. Navigate to **Security** tab
3. Make sure **Enable Studio Access to API Services** is checked
4. Publish your game (MessagingService only works in published games)

### Step 4: Setup Maze Model (Optional)
If you want to use the `.maze` command:
1. Create or import your maze model in the Workspace
2. Rename it to **"MazeModel"**
3. The script will automatically handle showing/hiding it

## Available Commands

### Event Commands
- **`.event serverluck`** - Creates green cloudy sky with lucky atmosphere (3 minutes)
- **`.event Night`** - Smooth transition to night with stars and moon (1 minute)
- **`.event Rain`** - Light rain with sound effects (50 seconds)
- **`.event Rainbow`** - Rainbow sky effect cycling through colors (1 minute 32 seconds)

### Other Commands
- **`.maze`** - Shows/hides the maze model (1 minute)
- **`.ann <text>`** - Creates typewriter announcement at top of screen (7 seconds fade)

### Command Examples
```
.event serverluck
.event Night
.event Rain
.event Rainbow
.maze
.ann Welcome to our server!
.ann This is a test announcement
```

## Whitelist Management

### Current Whitelisted Users
- **8285389779** (Owner - you)

### Adding More Users
To add more users to the whitelist:
1. Open the **WhitelistModule** script
2. Find the `WhitelistedUsers` table
3. Add new user IDs like this:
```lua
local WhitelistedUsers = {
    [8285389779] = true, -- Owner ID
    [123456789] = true,  -- Add new user ID here
    [987654321] = true,  -- Add another user ID here
}
```

## Features

### Security
- ✅ Only whitelisted users can execute commands
- ✅ All command attempts are logged
- ✅ Silent rejection for non-whitelisted users
- ✅ User ID validation on every command

### Cross-Server Synchronization
- ✅ Commands work across all servers in the game
- ✅ Uses MessagingService for real-time synchronization
- ✅ All players in all servers see the same effects

### Visual Effects
- ✅ Smooth lighting transitions
- ✅ Automatic effect expiration
- ✅ Professional GUI announcements
- ✅ Sound effects for immersion

### Player Detection
- ✅ Automatic detection of joining players
- ✅ User ID logging
- ✅ Chat message monitoring
- ✅ Handles players already in game

## Troubleshooting

### Commands Not Working
1. Check that you're using the correct User ID (8285389779)
2. Make sure both scripts are in ServerScriptService
3. Verify the WhitelistModule is a ModuleScript, not a regular Script
4. Check the output window for error messages

### Effects Not Showing
1. Ensure the game is published (MessagingService requirement)
2. Check that API Services are enabled in Game Settings
3. Look for any script errors in the output window

### Maze Command Not Working
1. Make sure you have a model named "MazeModel" in Workspace
2. The model should contain parts that can be made transparent/visible

## Customization

### Changing Effect Durations
Edit the wait times in MainScript.lua:
- Server Luck: Line with `wait(180)` (currently 3 minutes)
- Night: Line with `wait(60)` (currently 1 minute)
- Rain: Line with `wait(50)` (currently 50 seconds)
- Rainbow: Line with `wait(92)` (currently 1 minute 32 seconds)

### Adding New Commands
1. Add command parsing in the `handleCommand` function
2. Create a new effect function
3. Add MessagingService publishing for cross-server sync
4. Add handling in `handleCrossServerMessage` function

### Customizing Visual Effects
- Modify lighting values in each effect function
- Change colors in the rainbow effect
- Adjust fog settings for different atmospheres
- Replace sound IDs with your preferred sounds

## Support
If you encounter any issues:
1. Check the Output window in Roblox Studio for error messages
2. Verify all setup steps were completed correctly
3. Make sure your User ID (8285389779) is correctly added to the whitelist
4. Test in a published game, not just Studio

## Security Notes
- Never share your User ID with untrusted players
- Regularly review the whitelist for unauthorized additions
- Monitor the output logs for suspicious command attempts
- Consider adding additional security measures for sensitive commands