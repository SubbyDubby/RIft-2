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
local GuiService = game:GetService("GuiService")  -- Added for disconnect handling
local RunService = game:GetService("RunService")  -- For heartbeat

-- Safe execution wrapper function to prevent script termination
local function safeExecute(func, errorMessage)
    local success, result = pcall(func)
    if not success then
        print("ERROR (" .. (errorMessage or "unknown") .. "): " .. tostring(result))
        -- Continue despite the error
        return false
    end
    return true, result
end

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
        LastTeleportAttempt = 0,
        LastActivity = tick(),
        IsRunning = true
    }
    print("Scanner initialized")
else
    _G.RiftScanner.LastTeleportAttempt = _G.RiftScanner.LastTeleportAttempt or 0
    _G.RiftScanner.VisitedServers = _G.RiftScanner.VisitedServers or {}
    _G.RiftScanner.LastActivity = tick()
    _G.RiftScanner.IsRunning = true
end

if not _G.RandomSeeded then
    math.randomseed(tick())
    _G.RandomSeeded = true
end

-- Get job IDs from remote PHP script
local jobIds = {}
local function fetchJobIds()
    local success, response = pcall(function()
        return request({
            Url = endpoint,
            Method = "GET"
        }).Body
    end)

    if not success then
        warn("❌ Failed to fetch job IDs: " .. tostring(response))
        return false
    end

    local successDecode, decoded = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if successDecode and decoded and decoded.lines then
        jobIds = decoded.lines
        print("Successfully fetched " .. #jobIds .. " job IDs from server")
        return true
    else
        warn("❌ Failed to decode job IDs JSON")
        return false
    end
end

-- Initial fetch of job IDs
if not fetchJobIds() then
    print("Using backup job IDs...")
    -- Backup hardcoded job IDs in case the server is down
    jobIds = {
        "35cac887-cc04-4af7-acbd-c00d30962226",
        "f875dd14-0512-411c-aa29-5a0c003103c9",
        "3fe28945-6564-4431-a5f1-5dbe7f16a585"
    }
end

-- Function to get a truly random server (not the current one)
local function getRandomServer()
    if not jobIds or #jobIds == 0 then
        warn("⚠️ No job IDs available, attempting to fetch new ones...")
        if fetchJobIds() and #jobIds > 0 then
            print("✅ Successfully refreshed job IDs")
        else
            warn("⚠️ Still no job IDs available after refresh attempt")
            return nil
        end
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

-- Add this function to handle disconnections
local function setupDisconnectHandler()
    -- Handle disconnection errors
    GuiService.ErrorMessageChanged:Connect(function()
        local errorMessage = GuiService:GetErrorMessage()
        if errorMessage and (errorMessage:find("Connection attempt failed") or errorMessage:find("Disconnected")) then
            print("Detected disconnect, attempting emergency teleport...")
            
            -- Get a random job ID from the script's list
            local randomIndex = math.random(1, #jobIds)
            local targetJobId = jobIds[randomIndex]
            
            print("Emergency teleport to job ID: " .. targetJobId)
            
            -- Try to teleport to a server from our list
            pcall(function()
                game:GetService('TeleportService'):TeleportToPlaceInstance(PLACE_ID, targetJobId, game.Players.LocalPlayer)
            end)
            
            -- Wait a bit in case the first teleport fails
            wait(2)
            
            -- Try alternative teleport methods if still here
            pcall(function()
                TeleportService:TeleportToPlaceInstance(PLACE_ID, targetJobId)
            end)
            
            -- Third attempt with exploit-specific method
            if getgenv().teleport then
                pcall(function()
                    getgenv().teleport(PLACE_ID, targetJobId)
                end)
            end
        end
    end)
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
                safeExecute(function() hopToNextServer() end, "watchdog failsafe")
            end
            
            -- Check if script is still running
            if currentTime - _G.RiftScanner.LastActivity > 300 then
                log("WATCHDOG: Script appears inactive, restarting...")
                _G.RiftScanner.AlreadyScannedServer = true
                safeExecute(function() scanRifts() end, "restart scanning")
            end
        end
    end)
end

-- Heartbeat system to track script activity
local function startHeartbeat()
    spawn(function()
        while wait(120) do -- Check every 2 minutes
            _G.RiftScanner.LastActivity = tick() -- Update timestamp
            log("Heartbeat: Script is running")
            
            -- Refresh job IDs occasionally
            if math.random(1, 5) == 1 then -- 20% chance every 2 minutes
                safeExecute(function() fetchJobIds() end, "refresh job IDs")
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
        safeExecute(function() hopToNextServer() end, "hop after skip")
        return
    end
    
    -- Update activity timestamp
    _G.RiftScanner.LastActivity = tick()
    
    local foundRift = false
    local currentSeen = {}

    -- Look for the rifts folder
    local success, riftFolder = safeExecute(function()
        return Workspace:FindFirstChild("Rendered") and Workspace.Rendered:FindFirstChild("Rifts")
    end, "find rifts folder")
    
    if success and riftFolder then
        -- Loop through all rifts - with error handling
        safeExecute(function()
            for _, rift in pairs(riftFolder:GetChildren()) do
                if not _G.RiftScanner.IsRunning then return end -- Stop if script was terminated
                
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
                        -- Debug output for 25x multipliers
                        print("🌟 25X MULTIPLIER DETECTED! Sending to special webhook...")
                        
                        -- 25x multiplier found - use special webhook
                        safeExecute(function()
                            send25xWebhook("🌈 25x MULTIPLIER RIFT FOUND!", {
                                { name = "Egg", value = name, inline = true },
                                { name = "Multiplier", value = multiplier, inline = true },
                                { name = "Time Left", value = timer, inline = true },
                                { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                                { name = "Join Server", value = "[Click to Join](https://slayervalue.com/roblox/join_game.php?placeId=" .. PLACE_ID .. "&jobId=" .. game.JobId .. ")", inline = false }
                            })
                        end, "send 25x webhook")
                    elseif multiplier then
                        -- Regular multiplier rift
                        safeExecute(function()
                            sendWebhook("🌈 Rift Detected!", {
                                { name = "Egg", value = name, inline = true },
                                { name = "Multiplier", value = multiplier, inline = true },
                                { name = "Time Left", value = timer, inline = true },
                                { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                                { name = "Server ID", value = game.JobId, inline = false }
                            })
                        end, "send regular webhook")
                    else
                        -- Chest rift
                        safeExecute(function()
                            sendWebhook("🎁 Chest Detected!", {
                                { name = "Chest", value = name, inline = true },
                                { name = "Time Left", value = timer, inline = true },
                                { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                                { name = "Server ID", value = game.JobId, inline = false }
                            })
                        end, "send chest webhook")
                    end
                end
            end
        end, "scan rifts loop")

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
    safeExecute(function() hopToNextServer() end, "hop after scan")
end

-- Much simpler continuation script without JSON issues
local CONTINUATION_SCRIPT = [[
-- Initialize simple global state
_G.RiftScanner = {
    SentNotifications = {},
    AlreadyScannedServer = false,
    VisitedServers = {},
    LastTeleportAttempt = 0,
    LastActivity = 0,
    IsRunning = true
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
    -- Make sure we're not already in a teleport process
    if _G.RiftScanner.InTeleportProcess then
        log("Already in teleport process, waiting...")
        return
    end
    
    -- Set flag to indicate we're in teleport process
    _G.RiftScanner.InTeleportProcess = true
    
    -- Record when we last attempted to teleport
    _G.RiftScanner.LastTeleportAttempt = tick()
    _G.RiftScanner.LastActivity = tick()
    
    -- Get a random server
    local nextIndex, nextJobId = getRandomServer()
    
    -- Make sure we got a valid job ID
    if not nextJobId then
        log("Failed to get a valid job ID, retrying...")
        _G.RiftScanner.InTeleportProcess = false
        wait(2)
        safeExecute(function() fetchJobIds() end, "retry fetch")
        wait(1)
        safeExecute(function() hopToNextServer() end, "retry hop")
        return
    end
    
    -- Log teleport attempt
    log("Hopping to server " .. nextIndex .. " with JobID: " .. nextJobId)
    
    -- Update the current index
    _G.RiftScanner.CurrentIndex = nextIndex
    
    -- Add to visited servers
    _G.RiftScanner.VisitedServers[nextJobId] = true
    
    -- Queue script to run after teleport - using simplified script without JSON
    local scriptQueued = false
    if getgenv().queue_on_teleport then
        scriptQueued = pcall(function() getgenv().queue_on_teleport(CONTINUATION_SCRIPT) end)
    elseif queue_on_teleport then
        scriptQueued = pcall(function() queue_on_teleport(CONTINUATION_SCRIPT) end)
    elseif syn and syn.queue_on_teleport then
        scriptQueued = pcall(function() syn.queue_on_teleport(CONTINUATION_SCRIPT) end)
    end
    
    if not scriptQueued then
        log("WARNING: Failed to queue continuation script")
    end
    
    -- Set up a failsafe timer for teleport failure
    local currentJob = game.JobId
    spawn(function()
        wait(10)
        
        -- Check if we're still in the same server
        if game.JobId == currentJob and _G.RiftScanner.IsRunning then
            log("Teleport failed. Trying another server...")
            _G.RiftScanner.InTeleportProcess = false
            
            -- Try a different random server
            safeExecute(function() hopToNextServer() end, "retry after fail")
        end
    end)
    
    -- Dismiss any popups before teleporting
    safeExecute(function()
        for _, gui in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if (gui:IsA("TextButton") and (gui.Text:match("OK") or gui.Text:match("Okay") or gui.Text:match("Close"))) then
                pcall(function() gui.MouseButton1Click:Fire() end)
                pcall(function() gui:Destroy() end)
            end
        end
    end, "dismiss popups")
    
    -- Try all teleport methods with fallbacks
    
    -- First attempt
    local success = safeExecute(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(PLACE_ID, nextJobId, LocalPlayer)
    end, "teleport method 1")
    
    if not success then
        wait(1)
        
        -- Second attempt
        success = safeExecute(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, nextJobId)
        end, "teleport method 2")
        
        if not success then
            wait(1)
            
            -- Third attempt with exploit-specific method
            if getgenv().teleport then
                success = safeExecute(function()
                    getgenv().teleport(PLACE_ID, nextJobId)
                end, "teleport method 3")
            end
        end
    end
    
    -- Reset flag after a delay in case teleport is still processing
    spawn(function()
        wait(8)
        _G.RiftScanner.InTeleportProcess = false
    end)
end

-- Function to recover from errors
local function setupErrorRecovery()
    -- Ensure script keeps running even if there's an error
    spawn(function()
        while wait(60) do -- Check every minute
            if _G.RiftScanner.IsRunning and tick() - _G.RiftScanner.LastActivity > 300 then
                log("ERROR RECOVERY: Script appears stuck, restarting...")
                
                -- Reset state
                _G.RiftScanner.AlreadyScannedServer = true
                _G.RiftScanner.InTeleportProcess = false
                _G.RiftScanner.LastActivity = tick()
                
                -- Try to continue
                safeExecute(function() scanRifts() end, "recovery scan")
            end
        end
    end)
end

-- Function to prevent the script from being terminated
local function preventTermination()
    RunService.Heartbeat:Connect(function()
        _G.RiftScanner.LastActivity = tick()
    end)
end

-- Start all monitoring systems
startWatchdog()
startHeartbeat()
setupErrorRecovery()
preventTermination()
dismissErrorPopups()
setupDisconnectHandler()

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
_G.RiftScanner.LastActivity = tick()

-- Start scanning with error handling
safeExecute(function() scanRifts() end, "initial scan")

-- Final safety net in case the script gets stuck
spawn(function()
    wait(30)
    if not _G.RiftScanner.AlreadyScannedServer then
        log("SAFETY: Script may not have started properly, forcing start...")
        _G.RiftScanner.AlreadyScannedServer = false
        safeExecute(function() scanRifts() end, "safety scan")
    end
end)
