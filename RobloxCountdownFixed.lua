-- Fixed Roblox Lua Countdown Script with Malaysian Timezone (UTC+8)
-- Create target date in UTC, then add Malaysian timezone offset
local TargetDateUTC = os.time({year=2025, month=8, day=8, hour=14, min=0, sec=0}) -- 22:00 Malaysian = 14:00 UTC
local MalaysianOffset = 8 * 60 * 60 -- +8 hours in seconds
local TargetDate = TargetDateUTC + MalaysianOffset -- Target time in Malaysian timezone

local counting = true -- Control when to stop
local eventStarted = false -- Flag to track if event has started
local kickSetupDone = false -- Flag to ensure kick logic only runs once

-- Set up the PlayerAdded connection once at the start
local Players = game:GetService("Players")
local playerAddedConnection

while counting do
    -- Get current UTC time and convert to Malaysian time (UTC+8)
    local currentUTC = os.time()
    local currentMalaysianTime = currentUTC + MalaysianOffset
    local secondLeft = TargetDate - currentMalaysianTime

    if secondLeft <= 0 and not eventStarted then
        -- Show 00 seconds first
        game.Workspace.CountPart.SurfaceGui.CountText.Text = "0D 00H 00M 00S"
        task.wait(1) -- Wait 1 second to show 00 seconds
        
        -- Then show Event Started message
        game.Workspace.CountPart.SurfaceGui.CountText.Text = "Event Started🔥"
        eventStarted = true
        counting = false -- stop countdown loop
        
        -- Wait 3 seconds after showing "Event Started🔥"
        task.wait(3)
        
        -- Now start the kick logic
        if not kickSetupDone then
            kickSetupDone = true
            
            -- Kick semua player yang ada sekarang
            for _, player in pairs(Players:GetPlayers()) do
                pcall(function()
                    player:Kick("Game Is Processing To being Update..")
                end)
            end

            -- Auto kick bila ada player baru join selagi text masih Event Started🔥
            playerAddedConnection = Players.PlayerAdded:Connect(function(player)
                if game.Workspace.CountPart.SurfaceGui.CountText.Text == "Event Started🔥" then
                    pcall(function()
                        player:Kick("Game Is Processing To being Update..")
                    end)
                end
            end)

            -- Loop untuk kick semua player dalam server setiap 1 saat selagi text masih Event Started🔥
            task.spawn(function()
                while game.Workspace.CountPart.SurfaceGui.CountText.Text == "Event Started🔥" do
                    for _, player in pairs(Players:GetPlayers()) do
                        pcall(function()
                            player:Kick("Game Is Processing To being Update..")
                        end)
                    end
                    task.wait(1)
                end
                -- Clean up connection when done
                if playerAddedConnection then
                    playerAddedConnection:Disconnect()
                end
            end)
        end
        break
    end

    -- Only update countdown if event hasn't started
    if not eventStarted then
        local days = math.floor(secondLeft / (24 * 60 * 60))
        local hours = math.floor((secondLeft % (24 * 60 * 60)) / (60 * 60))
        local minutes = math.floor((secondLeft % (60 * 60)) / 60)
        local seconds = math.floor(secondLeft % 60)

        game.Workspace.CountPart.SurfaceGui.CountText.Text = string.format("%dD %02dH %02dM %02dS", days, hours, minutes, seconds)
    end
    
    task.wait(1) -- Wait 1 second before next iteration
end