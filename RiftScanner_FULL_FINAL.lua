-- Fully Automatic AWP.GG Rift Scanner
-- Configuration (EDIT THESE)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1363251024210432164/B26f2Tvrl_QuigIZ5AJswcd1hYKPGxIHlYzUUu-cicdhF6kj2i5hrQi16-YK2-R7rk0Y" 
-- New webhook for 25x multiplier rifts (ONLY NEW LINE ADDED)
local WEBHOOK_URL_25X = "https://discord.com/api/webhooks/1363251024210432164/B26f2Tvrl_QuigIZ5AJswcd1hYKPGxIHlYzUUu-cicdhF6kj2i5hrQi16-YK2-R7rk0Y" -- Replace with your special webhook for 25x rifts
local PLACE_ID = 85896571713843
local jobIds = {
    "d69ea861-d3e9-4389-bb3a-a15a1c507e81",
    "938bde92-e9ce-49d8-a670-754a19d644c0",
    "d8794842-41ed-4fcc-9ee2-940efdaa8470",
    "a8d09c3e-0bfe-4f44-b450-503449a5db88",
    "a1502835-3b22-4852-b9de-49e35e092f9d",
    "d98d3868-b5af-4644-b799-d05ef6932fad",
    "47eb275e-8f9a-47e0-803e-a25fdaf8c234",
    "aa7ea7c2-fdab-4972-8964-2552a44aec57",
    "f047b9a7-a0de-49f8-8ca9-9dd998dafb61",
    "8cd17512-5895-4a4d-a6b7-5e3e61789d14",
    "e395bdde-2d8b-4937-bc4b-34dfd95acbb1",
    "b3f43f8a-131e-4e6c-a2ce-aafc97b6ae4f",
    "5d30b454-ae0a-4cd1-99a7-c381ec74eed3",
    "2736aab2-54ad-42ec-9799-043824ff47bf",
    "0a04d9ad-c41d-467c-92dd-431067bd10ee",
    "c5c0a716-f08d-4acf-861c-e1aa0e094b29",
    "fe7bb08d-a457-4330-a52f-2a5f68e34abb",
    "db783145-d050-460f-b4b2-5800d44ae81b",
    "be9d7a63-430f-41ae-b39c-2932da13d513",
    "95d15fe4-4804-406d-8a4b-d89d826e133a",
    "ebc1d7ab-c655-4faf-902d-cb662cdd217a",
    "6f03041f-6cc6-4798-b82a-6b1aa9b06f92",
    "e20a0ce1-6c49-431c-8511-ee72b1b2a140",
    "bff1817e-192a-42aa-815e-ec34888a564a",
    "cf78a12d-7d1f-42cb-a99c-2fbf2d7f7a98",
    "8d55eea0-6eb0-4f9f-a070-fc6fc546dc1c",
    "dbf6c7a2-e6ac-489a-84af-64b692ff3705",
    "511f2299-eaea-47d8-838e-b3e082bb96c0",
    "b78da1c7-81ab-4f71-bedf-51eb4b9414f9",
    "60b6cda7-967c-470d-b17c-c4482be490a8",
    "c68731a2-8f64-4999-b92a-35b5806d5b5b",
    "7a6390a6-7173-46fb-a6db-4da73adf80d9",
    "2a99d903-ffa5-405b-bf35-28db82b3e747",
    "f6d6d76d-b2b2-4b65-a681-45629bfecb1a",
    "92be4c2a-1cc7-4939-b92b-7917f331f4ec",
    "fe89d943-6a1e-43a7-a409-c697eccaeb5a",
    "45a8e48c-4909-41f4-bb6f-f3cf4b85d6f1",
    "7607482e-756f-47f3-a665-7cd9b3a6aff7",
    "77f9a846-5eb1-41e4-bda0-52e9c8492d0b",
    "4600d3b9-9854-4527-9d8e-edd148c9b0c2",
    "518637e2-4a01-4758-ad5d-7ffd11b14653",
    "931284d0-b24a-475c-accb-ffb4c8d1d1f5",
    "47ac6200-4a66-42ce-84be-02c2db68fab0",
    "09588e90-a275-427b-8ffe-4cbb1fa99892",
    "64db9dee-428a-48cc-91dd-9c70733ebd16",
    "fcf35300-4e24-4713-b976-0085e0079c62",
    "b3c6c735-b8bf-4d57-8f50-ef15219e3b4f",
    "92aec09e-d142-45c4-bb99-3b512e3a4588",
    "d50fa5e1-18b8-48cc-9fbb-68641285d36a",
    "c0778c9f-933a-4f7f-a5e5-4dddb83cd5fc",
    "c5809de0-95c3-4227-bcf3-104a8350b4f1",
    "c51cbb61-e857-4e0e-98da-cae3707c0bad",
    "1a786e97-ef27-4711-9f5d-cccd74ec46d7",
    "f5f77b30-6bb3-4d9e-a492-e7df6960664e",
    "59d0a505-c1dd-4407-a41b-f94472783caf",
    "1dd3829b-d13d-496c-8b2a-7b3e584889e7",
    "fbaf51a1-6df2-42c0-8617-6f372dcc3308",
    "a9879cd4-1ef1-4d38-9d89-b3b66ecf4a7a",
    "e4c3b20a-0bd9-4f2e-8d9b-6a6135472e5b",
    "e1d22614-62bf-4eec-a9bd-987794863b32",
    "21559f14-8a4e-49d0-b162-482667d13f7e",
    "0c214fdd-922b-4b7e-ba11-597acebc8eaa",
    "360d3572-ab92-4e8b-93c5-076ebaf6c312",
    "fc112d71-95bd-43b9-bec3-5a7d7847b529",
    "b604a000-9c77-4fc2-beeb-1246b08391f6",
    "e91eda21-d132-46cd-93e0-85490901dcc8",
    "aee1152c-cae1-41bf-88a4-9c20b35584b8",
    "83e840e1-b85d-409a-80dc-20ede671a466",
    "62d6d55c-ee1a-4cd6-a6ec-b88f9e50d034",
    "3b30c9c9-420a-4a02-8fcd-a15761b0ab48",
    "7d91afd8-3557-4c89-b93e-9fa93bb1eb47",
    "d055c74d-a4de-4afa-bbd9-5f7b28559ce4",
    "ae64d7c9-b0e8-42e4-a643-8fd03d0b83ad",
    "8f54fdf6-cb83-4288-9d73-70394c960b51",
    "533f9124-3377-44bd-aa9c-2697b3760ae8",
    "ba1b905f-020e-4561-829c-508bcf61ff36",
    "f809feb6-b5c5-4796-aecd-5ad96d771083",
    "589d3d56-cd97-44f4-b518-953069ebc317",
    "3de35df2-4d19-46c0-9930-93bc6519f247",
    "d3fbf716-02fc-4f01-a6d1-68870c048026",
    "6c0b9571-0e85-4c8a-9377-2f16c59d18ca",
    "11163f80-51de-488a-8938-1785eaf49db7",
    "fb10df28-30e1-499a-837d-fccf31fb3bd5",
    "58167a5d-0345-4901-8a95-97fd9af7aee5",
    "e0c50f02-2eb4-4036-bce2-6682c2d74a5b",
    "661d54a8-bce8-4a92-9477-aed7cf96279d",
    "e83de9d7-34e1-4ea7-a7e2-383617b51bd0",
    "e9a4d062-873d-421b-a445-0c0b07e5ccb7",
    "94cc2de1-c54e-4c52-99dc-5cae42a09798",
    "fa097135-64ba-48c7-9cb8-fddc789d24f8",
    "4bc99a98-4056-405c-8de4-4261f402eea0",
    "c64b0456-4d0a-43cb-a39f-22473f9aba39",
    "0a5a1bb5-da81-4157-9b34-427ca93927ca",
    "52682413-fcd7-455e-b710-ff16941e7281",
    "35cac887-cc04-4af7-acbd-c00d30962226",
    "c2b2dcb8-5086-40ef-a387-ccb67fd3ffb8",
    "ee5387e4-937b-43d7-9872-64f802c742dc",
    "cc8fe4b1-08c0-446b-9d67-c887dda8bdb5",
    "0eef22bd-09ab-45f7-9aa7-0a38fcdf3954",
    "f174d91c-8c38-4da0-a37d-9d583f199f6d"
}

-- Initialize or restore global state
_G.RiftScanner = _G.RiftScanner or {
    CurrentIndex = 1,
    SentNotifications = {}
}

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

-- MODIFIED FUNCTION: Added webhookUrl parameter
local function sendWebhook(title, fields, webhookUrl)
    print("Sending webhook: " .. title)
    
    local embed = {
        title = title,
        fields = fields,
        color = 10597128,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local payload = HttpService:JSONEncode({ embeds = { embed } })

    local success, response = pcall(function()
        return request({
            Url = webhookUrl,  -- Now uses the passed webhook URL
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = payload
        })
    end)
    
    if success then
        print("Webhook sent successfully!")
    else
        print("Failed to send webhook: " .. tostring(response))
    end
end

-- Scan for rifts
local function scanRifts()
    print("Scanning for rifts...")
    local foundRift = false
    local currentSeen = {}

    -- Look for the rifts folder
    local riftFolder = Workspace:FindFirstChild("Rendered") and Workspace.Rendered:FindFirstChild("Rifts")
    if not riftFolder then 
        print("Rifts folder not found")
    else
        print("Rifts folder found, checking for rifts...")
        
        -- Loop through all rifts
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

                -- MODIFIED SECTION: Check for 25x multiplier
                if multiplier and multiplier:find("25x") then
                    -- 25x multiplier found - use special webhook and format
                    print("Found 25x multiplier rift: " .. name)
                    
                    sendWebhook("🌈 25x MULTIPLIER RIFT FOUND!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Join Server", value = "[Click to Join](https://slayervalue.com/roblox/join_game.php?placeId=" .. PLACE_ID .. "&jobId=" .. game.JobId .. ")", inline = false }
                    }, WEBHOOK_URL_25X)  -- Use 25x webhook
                elseif multiplier then
                    -- Regular multiplier - use standard webhook and format
                    print("Found rift: " .. name .. " with " .. multiplier .. " luck")
                    sendWebhook("🌈 Rift Detected!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    }, WEBHOOK_URL)  -- Use standard webhook
                else
                    -- Chest - use standard webhook and format
                    print("Found chest: " .. name)
                    sendWebhook("🎁 Chest Detected!", {
                        { name = "Chest", value = name, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    }, WEBHOOK_URL)  -- Use standard webhook
                end
            end
        end

        -- Clear despawned entries
        for key in pairs(_G.RiftScanner.SentNotifications) do
            if not currentSeen[key] then
                _G.RiftScanner.SentNotifications[key] = nil
            end
        end
    end

    if not foundRift then
        print("No rifts found in this server")
    end
    
    -- After scanning, wait 15 seconds before hopping
    print("Waiting 15 seconds before moving to next server...")
    wait(15)
    hopToNextServer()
end

-- Auto-continuation script for the next server
local CONTINUATION_SCRIPT = [[
-- Initialize global variables
_G.RiftScanner = _G.RiftScanner or {}
_G.RiftScanner.CurrentIndex = %d
_G.RiftScanner.SentNotifications = {}

-- Wait for game to load
if not game:IsLoaded() then game.Loaded:Wait() end
wait(5) -- Additional wait to ensure everything loads properly

-- Load and execute main script
loadstring(game:HttpGet('https://raw.githubusercontent.com/SubbyDubby/Roblox-Rift-Scanner/main/Rift.lua'))()
]]

-- In the hopToNextServer function, replace the teleport section with this:

-- Hop to next server (SIMPLIFIED)
function hopToNextServer()
    local nextIndex = _G.RiftScanner.CurrentIndex + 1
    
    if nextIndex <= #jobIds then
        local nextJobId = jobIds[nextIndex]
        print("Hopping to server " .. nextIndex .. " with JobID: " .. nextJobId)
        
        -- Update the current index immediately
        _G.RiftScanner.CurrentIndex = nextIndex
        
        -- Create continuation script
        local scriptToQueue = string.format(CONTINUATION_SCRIPT, nextIndex)
        
        -- Queue script to run after teleport
        if queue_on_teleport then
            queue_on_teleport(scriptToQueue)
            print("Using queue_on_teleport")
        elseif syn and syn.queue_on_teleport then
            syn.queue_on_teleport(scriptToQueue)
            print("Using Synapse queue_on_teleport")
        end
        
        -- Wait for queue_on_teleport to register
        wait(1)
        
        -- Simple direct teleport
        print("Teleporting to server " .. nextIndex)
        local success = pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(PLACE_ID, nextJobId, LocalPlayer)
        end)
        
        if not success then
            print("Teleport failed, trying next server...")
            wait(5)
            _G.RiftScanner.CurrentIndex = nextIndex
            hopToNextServer()
        end
    else
        print("Finished scanning all servers in the list. Restarting from the beginning...")
        _G.RiftScanner.CurrentIndex = 0
        hopToNextServer()
    end
end

-- Main execution starts here
print("Rift Scanner started")
print("Current server index: " .. _G.RiftScanner.CurrentIndex)

-- Wait for game to load completely
if not game:IsLoaded() then
    print("Waiting for game to load...")
    game.Loaded:Wait()
end

-- Wait for player character to load
if not LocalPlayer.Character then
    print("Waiting for character to load...")
    LocalPlayer.CharacterAdded:Wait()
end

-- Wait a bit for everything to initialize
print("Waiting 10 seconds before starting scan...")
wait(10)

-- Start scanning
scanRifts()
