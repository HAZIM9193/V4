local countdownText = script.Parent
local targetTime = DateTime.fromLocalTime(2025, 8, 8, 21, 0, 0)

local function pad(n)
    return n < 10 and ("0" .. n) or tostring(n)
end

while task.wait(1) do
    local now = DateTime.now()
    local secondsBetween = math.floor(targetTime.UnixTimestamp - now.UnixTimestamp)

    if secondsBetween <= 0 then
        countdownText.Text = "Event Started!"
        break
    end

    local days  = math.floor(secondsBetween / 86400)
    local hours = math.floor((secondsBetween % 86400) / 3600)
    local mins  = math.floor((secondsBetween % 3600) / 60)
    local secs  = secondsBetween % 60

    local str
    if days > 0 then
        str = days .. ":" .. pad(hours) .. ":" .. pad(mins) .. ":" .. pad(secs)
    elseif hours > 0 then
        str = hours .. ":" .. pad(mins) .. ":" .. pad(secs)
    elseif mins > 0 then
        str = mins .. ":" .. pad(secs)
    else
        str = secs .. "s"
    end

    countdownText.Text = str
end