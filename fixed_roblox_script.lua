local TargetDate = os.time({year=2025, month=8, day=8, hour=22, min=0, sec=0}) -- Tarikh/hari target

local counting = true -- kawal bila nak berhenti
local kickSetupDone = false -- Flag to ensure kick logic only runs once

-- Set up the PlayerAdded connection once at the start
local Players = game:GetService("Players")
local playerAddedConnection

while counting do
    local Time = os.date("!*t", os.time() + 8 * 60 * 60) 
    local currentDate = os.time(Time)
    local secondLeft = TargetDate - currentDate

    if secondLeft <= 0 then
        -- Kalau dah sampai / melebihi tarikh target
        game.Workspace.CountPart.SurfaceGui.CountText.Text = "Event Started🔥"
        counting = false -- stop loop
        break
    end

    local days = math.floor(secondLeft / (24 * 60 * 60))
    local hours = math.floor((secondLeft % (24 * 60 * 60)) / (60 * 60))
    local minutes = math.floor((secondLeft % (60 * 60)) / 60)
    local seconds = math.floor(secondLeft % 60)

    game.Workspace.CountPart.SurfaceGui.CountText.Text = string.format("%dD %02dH %02dM %02dS", days, hours, minutes, seconds)
    
    -- Bahagian auto kick bila countdown dah sampai 01 saat
    if days == 0 and hours == 0 and minutes == 0 and seconds == 1 and not kickSetupDone then
        kickSetupDone = true -- Ensure this only runs once
        
        task.wait(6) -- tunggu 6 saat

        -- Kick semua player yang ada sekarang
        for _, player in pairs(Players:GetPlayers()) do
            player:Kick("Game Is Processing To being Update..")
        end

        -- Auto kick bila ada player baru join selagi text masih Event Started🔥
        playerAddedConnection = Players.PlayerAdded:Connect(function(player)
            if game.Workspace.CountPart.SurfaceGui.CountText.Text == "Event Started🔥" then
                player:Kick("Game Is Processing To being Update..")
            end
        end)

        -- Loop untuk kick semua player dalam server setiap 1 saat selagi text masih Event Started🔥
        task.spawn(function()
            while game.Workspace.CountPart.SurfaceGui.CountText.Text == "Event Started🔥" do
                for _, player in pairs(Players:GetPlayers()) do
                    player:Kick("Game Is Processing To being Update..")
                end
                task.wait(1)
            end
            -- Clean up connection when done
            if playerAddedConnection then
                playerAddedConnection:Disconnect()
            end
        end)
    end
    
    task.wait(1) -- Wait 1 second before next iteration
end