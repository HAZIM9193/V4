local countdownText = script.Parent
local RunService    = game:GetService("RunService")

-- set the initial future moment here
local targetTime = DateTime.fromLocalTime(2025, 8, 8, 21, 30, 0)

local function pad(n)
    return n < 10 and ("0" .. n) or tostring(n)
end

local conn
conn = RunService.RenderStepped:Connect(function()
    local now            = DateTime.now()
    local secondsBetween = targetTime.UnixTimestamp - now.UnixTimestamp

    if secondsBetween <= 0 then
        countdownText.Text = "Update Started!"
        conn:Disconnect()
        return
    end

    local days  = math.floor(secondsBetween / 86400)
    local hours = math.floor((secondsBetween % 86400) / 3600)
    local mins  = math.floor((secondsBetween % 3600) / 60)
    local secs  = secondsBetween % 60

    local text
    if days > 0 then
        text = days .. ":" .. pad(hours) .. ":" .. pad(mins) .. ":" .. pad(secs)
    elseif hours > 0 then
        text = hours .. ":" .. pad(mins) .. ":" .. pad(secs)
    elseif mins > 0 then
        text = mins .. ":" .. pad(secs)
    else
        text = secs .. "s"
    end

    countdownText.Text = text
end)