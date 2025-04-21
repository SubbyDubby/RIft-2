-- Fully Automatic AWP.GG Rift Scanner
-- Configuration (EDIT THESE)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1363251024210432164/B26f2Tvrl_QuigIZ5AJswcd1hYKPGxIHlYzUUu-cicdhF6kj2i5hrQi16-YK2-R7rk0Y" 
local WEBHOOK_URL_25X = "https://discord.com/api/webhooks/1363451259016712192/OIMNA2MKvtfFW2IZOj5zDyoqhDYFlV-uU1GARyJwWSPSVHQzDAvSThojSOf1n9f5E6de"
local PLACE_ID = 85896571713843
local endpoint = "https://slayervalue.com/serverlist/getservers.php"
-- Services
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Get the appropriate request function
local request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or getgenv().request
if not request then
    print("ERROR: No HTTP request function found!")
    return
end


-- Initialize or restore global state
if not _G.RiftScanner then
    _G.RiftScanner = {
        SentNotifications = {},
        AlreadyScannedServer = false,
        VisitedServers = {},
        LastTeleportAttempt = 0
    }
    print("Scanner initialized")
else
    _G.RiftScanner.LastTeleportAttempt = _G.RiftScanner.LastTeleportAttempt or 0
    _G.RiftScanner.VisitedServers = _G.RiftScanner.VisitedServers or {}
end

if not _G.RandomSeeded then
    math.randomseed(tick())
    _G.RandomSeeded = true
end

-- Get job IDs from remote PHP script
local success, response = pcall(function()
    return request({
        Url = endpoint,
        Method = "GET"
    }).Body
end)

if not success then
    warn("❌ Failed to fetch job IDs: " .. tostring(response))
    return
end

local jobIds
local successDecode, decoded = pcall(function()
    return HttpService:JSONDecode(response)
end)

if successDecode and decoded and decoded.lines then
    jobIds = decoded.lines
else
    warn("❌ Failed to decode job IDs JSON")
    return
end

-- Function to get a truly random server (not the current one)
local function getRandomServer()
    if not jobIds or #jobIds == 0 then
        warn("⚠️ No job IDs available.")
        return nil
    end

    local randomIndex
    local attempts = 0

    repeat
        randomIndex = math.random(1, #jobIds)
        attempts += 1
    until jobIds[randomIndex] ~= game.JobId or attempts >= 5

    return randomIndex, jobIds[randomIndex]
end

-- Example usage
local randomIndex, selectedJobId = getRandomServer()
if selectedJobId then
    print("🎯 Selected job ID:", selectedJobId)
    _G.RiftScanner = _G.RiftScanner or {}
    _G.RiftScanner.CurrentJobId = selectedJobId
    _G.RiftScanner.CurrentIndex = randomIndex  -- Storing the randomIndex
else
    print("❌ No valid job ID found.")
end

-- Simple logger
local function log(message)
    print(message)
end

-- Send webhook function - no console output
local function sendWebhook(title, fields)
    local embed = {
        title = title,
        fields = fields,
        color = 10597128,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local payload = HttpService:JSONEncode({ embeds = { embed } })

    pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = payload
        })
    end)
end

-- Special webhook function for 25x multipliers - no console output
local function send25xWebhook(title, fields)
    local embed = {
        title = title,
        fields = fields,
        color = 16711680, -- Bright red color for emphasis
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local payload = HttpService:JSONEncode({ embeds = { embed } })

    pcall(function()
        request({
            Url = WEBHOOK_URL_25X,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = payload
        })
    end)
end

-- Anti-crash watchdog timer with shorter timeouts
local watchdogActive = false
local function startWatchdog()
    if watchdogActive then return end
    
    watchdogActive = true
    spawn(function()
        while watchdogActive do
            wait(60) -- Check every minute
            
            -- If we've been in the same server for too long (3+ minutes), force a teleport
            local currentTime = tick()
            if currentTime - _G.RiftScanner.LastTeleportAttempt > 180 then
                log("WATCHDOG: Detected potential hang, forcing teleport...")
                _G.RiftScanner.AlreadyScannedServer = true -- Force a teleport
                pcall(function() hopToNextServer() end)
            end
        end
    end)
end

-- Function to auto-dismiss error popups - silent operation
local function dismissErrorPopups()
    spawn(function()
        while wait(1) do
            pcall(function()
                for _, gui in pairs(game:GetService("CoreGui"):GetDescendants()) do
                    if (gui:IsA("TextButton") and (gui.Text:match("OK") or gui.Text:match("Okay") or gui.Text:match("Close"))) then
                        pcall(function() gui.MouseButton1Click:Fire() end)
                        pcall(function() gui:Destroy() end)
                    end
                end
                
                if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
                    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                        if (gui:IsA("TextButton") and (gui.Text:match("OK") or gui.Text:match("Okay") or gui.Text:match("Close"))) then
                            pcall(function() gui.MouseButton1Click:Fire() end)
                        end
                    end
                end
            end)
        end
    end)
end

-- Scan for rifts - minimal console output
local function scanRifts()
    -- Skip scanning if we already scanned this server
    if _G.RiftScanner.AlreadyScannedServer then
        log("Server already scanned, moving to next server...")
        wait(1)
        hopToNextServer()
        return
    end
    
    local foundRift = false
    local currentSeen = {}

    -- Look for the rifts folder
    local riftFolder = Workspace:FindFirstChild("Rendered") and Workspace.Rendered:FindFirstChild("Rifts")
    if not riftFolder then 
        -- Silent failure, no console output
    else
        -- Loop through all rifts - silent operation
        for _, rift in pairs(riftFolder:GetChildren()) do
            if not rift:IsA("Model") then continue end

            local name = rift.Name:lower()
            local gui = rift:FindFirstChild("Display") and rift.Display:FindFirstChild("SurfaceGui")
            if not gui then continue end

            local timerLabel = gui:FindFirstChild("Timer")
            local luckLabel = gui:FindFirstChild("Icon") and gui.Icon:FindFirstChild("Luck")

            local timer = timerLabel and timerLabel.Text or nil
            local multiplier = luckLabel and luckLabel.Text or nil

            if not timer or timer == "" then continue end

            -- Y Position for height
            local y = rift:GetPivot().Position.Y
            local key = name .. "|" .. timer .. "|" .. (multiplier or "n/a") .. "|" .. y
            currentSeen[key] = true
            foundRift = true

            if not _G.RiftScanner.SentNotifications[key] then
                _G.RiftScanner.SentNotifications[key] = true

                -- More robust pattern matching for 25x
                if multiplier and (string.find(tostring(multiplier):lower(), "25%s*x") or string.find(tostring(multiplier), "25")) then
                    -- 25x multiplier found - use special webhook
                    send25xWebhook("🌈 25x MULTIPLIER RIFT FOUND!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Join Server", value = "[Click to Join](https://slayervalue.com/roblox/join_game.php?placeId=" .. PLACE_ID .. "&jobId=" .. game.JobId .. ")", inline = false }
                    })
                elseif multiplier then
                    -- Regular multiplier rift
                    sendWebhook("🌈 Rift Detected!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    })
                else
                    -- Chest rift
                    sendWebhook("🎁 Chest Detected!", {
                        { name = "Chest", value = name, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    })
                end
            end
        end

        -- Clear despawned entries - silent operation
        for key in pairs(_G.RiftScanner.SentNotifications) do
            if not currentSeen[key] then
                _G.RiftScanner.SentNotifications[key] = nil
            end
        end
    end
    
    -- Mark this server as scanned to prevent rescanning
    _G.RiftScanner.AlreadyScannedServer = true
    
    -- After scanning, wait before hopping - reduced wait time
    log("Waiting before moving to next server...")
    wait(5)
    hopToNextServer()
end

-- Much simpler continuation script without JSON issues
local CONTINUATION_SCRIPT = [[
-- Initialize simple global state
_G.RiftScanner = {
    SentNotifications = {},
    AlreadyScannedServer = false,
    VisitedServers = {},
    LastTeleportAttempt = 0
}

-- Wait for game to load
if not game:IsLoaded() then game.Loaded:Wait() end
wait(3)

-- Start auto-dismiss for popups
spawn(function()
    wait(2)
    pcall(function()
        for _, gui in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if (gui:IsA("TextButton") and (gui.Text:match("OK") or gui.Text:match("Okay") or gui.Text:match("Close"))) then
                pcall(function() gui.MouseButton1Click:Fire() end)
                pcall(function() gui:Destroy() end)
            end
        end
    end)
end)

-- Load and execute main script
loadstring(game:HttpGet('https://raw.githubusercontent.com/SubbyDubby/Roblox-Rift-Scanner/main/Rift.lua'))()
]]

-- Hop to next server - simplified for reliability
function hopToNextServer()
    -- Record when we last attempted to teleport
    _G.RiftScanner.LastTeleportAttempt = tick()
    
    -- Get a random server
    local nextIndex, nextJobId = getRandomServer()
    
    -- Log teleport attempt
    log("Hopping to server " .. nextIndex .. " with JobID: " .. nextJobId)
    
    -- Update the current index
    _G.RiftScanner.CurrentIndex = nextIndex
    
    -- Add to visited servers
    _G.RiftScanner.VisitedServers[nextJobId] = true
    
    -- Queue script to run after teleport - using simplified script without JSON
    if getgenv().queue_on_teleport then
        getgenv().queue_on_teleport(CONTINUATION_SCRIPT)
    elseif queue_on_teleport then
        queue_on_teleport(CONTINUATION_SCRIPT)
    elseif syn and syn.queue_on_teleport then
        syn.queue_on_teleport(CONTINUATION_SCRIPT)
    end
    
    -- Set up a failsafe timer for teleport failure
    local currentJob = game.JobId
    spawn(function()
        wait(10)
        
        -- Check if we're still in the same server
        if game.JobId == currentJob then
            log("Teleport failed. Trying another server...")
            
            -- Try a different random server
            hopToNextServer()
        end
    end)
    
    -- Dismiss any popups before teleporting
    pcall(function()
        for _, gui in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if (gui:IsA("TextButton") and (gui.Text:match("OK") or gui.Text:match("Okay") or gui.Text:match("Close"))) then
                pcall(function() gui.MouseButton1Click:Fire() end)
                pcall(function() gui:Destroy() end)
            end
        end
    end)
    
    -- Try all teleport methods
    
    -- First attempt
    pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(PLACE_ID, nextJobId, LocalPlayer)
    end)
    
    wait(1)
    
    -- Second attempt
    pcall(function()
        TeleportService:TeleportToPlaceInstance(PLACE_ID, nextJobId)
    end)
    
    wait(1)
    
    -- Third attempt with exploit-specific method
    if getgenv().teleport then
        pcall(function()
            getgenv().teleport(PLACE_ID, nextJobId)
        end)
    end
end

-- Start anti-crash watchdog
startWatchdog()

-- Start auto-dismiss for popups
dismissErrorPopups()

-- Main execution starts here
print("Rift Scanner started")

-- Wait for game to load completely
if not game:IsLoaded() then
    log("Waiting for game to load...")
    game.Loaded:Wait()
end

-- Wait for player character to load
if not LocalPlayer.Character then
    log("Waiting for character to load...")
    LocalPlayer.CharacterAdded:Wait()
    wait(3)
end

-- Wait a bit for everything to initialize
log("Waiting before starting scan...")
wait(5)

-- Reset AlreadyScannedServer flag for this run
_G.RiftScanner.AlreadyScannedServer = false

-- Start scanning
scanRifts()
