-- WhitelistModule.lua - Whitelist management module
-- Place this script as a ModuleScript in ServerScriptService

local WhitelistModule = {}

-- Whitelisted User IDs
local WhitelistedUsers = {
    [8285389779] = true, -- Owner ID
    -- Add more user IDs here as needed
    -- [123456789] = true,
    -- [987654321] = true,
}

-- Function to check if a user is whitelisted
function WhitelistModule.isWhitelisted(userId)
    return WhitelistedUsers[userId] == true
end

-- Function to add a user to whitelist (for future expansion)
function WhitelistModule.addUser(userId)
    WhitelistedUsers[userId] = true
    print("Added user " .. tostring(userId) .. " to whitelist")
end

-- Function to remove a user from whitelist (for future expansion)
function WhitelistModule.removeUser(userId)
    WhitelistedUsers[userId] = nil
    print("Removed user " .. tostring(userId) .. " from whitelist")
end

-- Function to get all whitelisted users (for debugging)
function WhitelistModule.getWhitelistedUsers()
    local users = {}
    for userId, _ in pairs(WhitelistedUsers) do
        table.insert(users, userId)
    end
    return users
end

-- Function to check whitelist status and log attempts
function WhitelistModule.checkAndLog(userId, playerName, command)
    local isWhitelisted = WhitelistModule.isWhitelisted(userId)
    
    if isWhitelisted then
        print("[WHITELIST] ✓ " .. playerName .. " (" .. userId .. ") executed: " .. command)
    else
        print("[WHITELIST] ✗ " .. playerName .. " (" .. userId .. ") attempted: " .. command .. " - DENIED")
    end
    
    return isWhitelisted
end

return WhitelistModule