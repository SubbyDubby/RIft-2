-- Fully Automatic AWP.GG Rift Scanner

-- Configuration
local WEBHOOK_URL = "https://discord.com/api/webhooks/1363251024210432164/B26f2Tvrl_QuigIZ5AJswcd1hYKPGxIHlYzUUu-cicdhF6kj2i5hrQi16-YK2-R7rk0Y"
local WEBHOOK_25X = "https://discord.com/api/webhooks/PUT-YOUR-25X-WEBHOOK-HERE"
local PLACE_ID = 85896571713843

local jobIds = {
    "938bde92-e9ce-49d8-a670-754a19d644c0",
    "586fb4bb-6004-4ac8-b16c-7ec03a6436c7",
    "d69ea861-d3e9-4389-bb3a-a15a1c507e81",
    "4d371ef5-e88f-465d-82c4-02c4031c2965",
    "bd27f9ad-b882-41a8-a821-36bc8a27f5ae",
    "ae0ea311-9d14-4b51-a73a-ddb79fbed6a2",
    "8e4cec64-5425-43c8-9bf1-e7bb97ceea03",
    "d8a09f99-0786-4db2-bd08-d4c72b34a87a",
    "de58e942-03d7-478d-b5ca-79753fe759ef",
    "9def3f34-ba3d-41cf-89ff-dda3efa772c4",
    "36a8660b-9099-4ae1-b4d5-04f93d8cbf85",
    "178ffd2a-1759-46b0-aeb4-3fedf54bcb65",
    "29534952-86aa-4c11-a0d4-c29307c83091",
    "cc777f7f-f3c3-4c3a-bc07-a3eba897d635",
    "34c4b94e-5fc2-44f1-a327-996126dcfe34",
    "92be4c2a-1cc7-4939-b92b-7917f331f4ec",
    "85c5bbf8-2cfa-4320-ab4e-09402d8f1e12",
    "5cc97fb2-0c53-4dbd-90f3-db19d7526380",
    "12e93878-464c-413c-87a0-4eba6ebc22e1",
    "6a8a2019-318c-43cc-8a11-be570c0e2f58",
    "dd9b48c5-c247-4368-94b0-61f65c889172",
    "45a8e48c-4909-41f4-bb6f-f3cf4b85d6f1",
    "76c68253-4cb0-42b8-86de-8216f5715346",
    "3fb8c4a9-3958-432a-9714-ab31d057999a",
    "f9e31c72-d1a6-4b43-8786-8e2ab073e0b7",
    "39b9559c-ceac-488a-b0e4-12d2ec4c6a57",
    "6dafeaeb-351f-4eaa-997a-071ca0847b00",
    "fcf35300-4e24-4713-b976-0085e0079c62",
    "427050a0-9717-477c-b169-f51ccd97de77",
    "085b9599-ab49-4c94-b0b1-28f866044fda",
    "5a09af3f-c9e8-41fb-a63b-55f6350af751",
    "c51cbb61-e857-4e0e-98da-cae3707c0bad",
    "bea338fb-0e03-49bf-842a-ec4447b0f3d0",
    "bb36344a-76c7-42e7-9686-f08d4b189232",
    "1199657d-5861-47e0-b2f1-da50d9bd5c1d",
    "0ede8ae4-7554-4a11-a2f0-e520763b34b2",
    "fefaddcb-91f7-42ce-a136-155be5210005",
    "872ef65e-224c-4249-8fd3-0d9e34679f38",
    "d38677f1-4986-45b7-8e1b-92cc06291a50",
    "a8d09c3e-0bfe-4f44-b450-503449a5db88",
    "e8aba58d-a9ca-4ee9-a0d9-7e880695adfa",
    "3c3379be-babb-435a-a9e5-a5c722b8a6dc",
    "6958c399-52d9-4cfc-9aaa-5af0563bf619",
    "2e211af6-9403-4350-b0f5-0fea91df47e6",
    "ae4180e5-03f0-4f09-94b8-a92232a440de",
    "70f8c86e-7071-4197-88ab-8d150b02ae6c",
    "24590b99-6484-4f56-852b-4154d6e9669d",
    "b604a000-9c77-4fc2-beeb-1246b08391f6",
    "90063cf5-41e7-41ba-b184-cafe17593d07",
    "0deb9daa-8b8c-4239-b417-c1318c1553b2",
    "cd5892b0-b822-43b4-a2c7-c092be567373",
    "acab5929-1864-4edf-95c8-7f2763d16019",
    "1f039011-9f66-49b1-a7be-055827b5783d",
    "c458eb90-1183-4b6f-9e6f-ab12d6d373b0",
    "a36372f7-ab1a-454c-906a-d014b477f24f",
    "c362b26b-fb92-4546-b540-d7b0ee7fb720",
    "174672ec-f3fa-4890-9339-e2c4d3dadae8",
    "ff319087-6b16-4423-8fa1-03602039bee0",
    "03731fbe-6cca-4be1-b542-d7c1842d423f",
    "f9fef9db-7ac4-4282-af94-f5901088ed91",
    "315bd567-23f2-4dac-afc1-c3f99ccc89af",
    "614f7906-bdef-4cdb-95ef-f888a070d551",
    "ace15a42-8bbe-413b-bd84-61bdd2ec3d18",
    "1e96676e-4e50-4779-a57e-7a2e4a9403f9",
    "3372bff4-b1d6-497a-9a00-9aa57ce94bf3",
    "d40222b5-dd85-4f8e-8c46-a77988e4315b",
    "c83df413-ac46-4f14-b1b3-f34403ee2a37",
    "eb56f151-c687-4aa0-8b2c-4b87d9b5dd04",
    "00f5d20e-ab6e-451c-8ad8-a78b5e4552ba",
    "7d91afd8-3557-4c89-b93e-9fa93bb1eb47",
    "cb917682-d693-4276-85a6-76f01edc5cd6",
    "0a5a9a2f-8edf-496e-88ec-f53e7e4ec67f",
    "e71aa26c-0440-440f-9f3d-ba819275c913",
    "192695f9-d9c9-4142-a935-50b99ab0a192",
    "d8ce8acb-286d-4f1d-ac01-59bb4798c865",
    "2f7251ad-b96b-4856-9e47-9c6a35b39160",
    "d090b9a2-3bde-411b-852c-acc504b4d327",
    "f37889ec-e205-49c3-b7e6-47a6b56f19bf",
    "5014e425-9e55-4620-b1c9-1c7d57fd78bc",
    "9ec76e7a-18f5-41a8-9e1e-a31bc0ff9516",
    "d5109cf7-91de-40b2-acde-863406827cca",
    "c090838d-4aa7-4681-b583-15048818566c",
    "794e6cbb-35ca-4daa-a0d2-4809fdf5722e",
    "368c86ea-f399-4f86-add6-f8787f1e308f",
    "d8bcfb66-d626-4968-a477-09a0835f1120",
    "48ba812d-d87b-4df4-981c-fa16f2481187",
    "15042873-5c2f-41fb-93c7-e536fed4c64a",
    "e80a0935-6dc9-4cc2-8963-dc9516c96c40",
    "d964858f-4214-4ec0-8bd0-f2c3e0744db6",
    "e3c241b8-616d-4cc1-86a0-17c46ccf36ba",
    "af543e47-d547-4240-87a5-2fb1dc5b3d2a",
    "18aebc86-000c-4da5-be24-9dae35624852",
    "b4b8c5b4-16ad-489c-bcee-a5539e7e0228",
    "b47c2af0-446a-4da1-a07a-809b898d99b7",
    "0df555c1-aaa1-4a51-853e-2a7c029058f4",
    "c27083c1-fe3c-4365-8e76-942c5b4d1b2b",
    "7c97c269-df57-433d-9614-982d7e477773",
    "bf750e48-395d-48af-b9fe-0fb58f33c83c",
    "17a05cb5-2404-4f51-8da7-d3a101d3c0dc",
    "7ea92a5d-79cd-4172-a3fa-306c3957197e"
}

_G.RiftScanner = _G.RiftScanner or {
    CurrentIndex = 1,
    SentNotifications = {}
}

local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or getgenv().request
if not request then
    print("ERROR: No HTTP request function found!")
    return
end

local function sendWebhook(title, fields)
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
            Url = WEBHOOK_URL,
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

    -- 25x extra webhook post
    local multiplier = ""
    for _, f in ipairs(fields) do
        if f.name:lower() == "multiplier" then
            multiplier = f.value:lower()
        end
    end

    if multiplier == "25x" and WEBHOOK_25X and WEBHOOK_25X ~= "" then
        print("🎯 Sending 25x Rift to secondary webhook")

        -- Add join link to 25x webhook
        table.insert(fields, {
            name = "🔗 Join Server",
            value = string.format("[Click to Join](https://slayervalue.com/roblox/join_game.php?placeId=%s&jobId=%s)", PLACE_ID, game.JobId),
            inline = false
        })

        local payload25x = HttpService:JSONEncode({
            embeds = {
                {
                    title = title,
                    fields = fields,
                    color = 10597128,
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }
            }
        })

        pcall(function()
            request({
                Url = WEBHOOK_25X,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = payload25x
            })
        end)
    end
end

local function scanRifts()
    print("Scanning for rifts...")
    local foundRift = false
    local currentSeen = {}

    local riftFolder = Workspace:FindFirstChild("Rendered") and Workspace.Rendered:FindFirstChild("Rifts")
    if not riftFolder then
        print("Rifts folder not found")
    else
        print("Rifts folder found, checking for rifts...")

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

            local y = rift:GetPivot().Position.Y
            local key = name .. "|" .. timer .. "|" .. (multiplier or "n/a") .. "|" .. y
            currentSeen[key] = true
            foundRift = true

            if not _G.RiftScanner.SentNotifications[key] then
                _G.RiftScanner.SentNotifications[key] = true

                if multiplier then
                    print("Found rift: " .. name .. " with " .. multiplier .. " luck")
                    sendWebhook("🌈 Rift Detected!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    })
                else
                    print("Found chest: " .. name)
                    sendWebhook("🎁 Chest Detected!", {
                        { name = "Chest", value = name, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    })
                end
            end
        end

        for key in pairs(_G.RiftScanner.SentNotifications) do
            if not currentSeen[key] then
                _G.RiftScanner.SentNotifications[key] = nil
            end
        end
    end

    if not foundRift then
        print("No rifts found in this server")
    end

    print("Waiting 15 seconds before moving to next server...")
    wait(15)
    hopToNextServer()
end

local CONTINUATION_SCRIPT = [[
_G.RiftScanner = _G.RiftScanner or {}
_G.RiftScanner.CurrentIndex = %d
_G.RiftScanner.SentNotifications = {}
if not game:IsLoaded() then game.Loaded:Wait() end
wait(5)
loadstring(game:HttpGet('https://raw.githubusercontent.com/SubbyDubby/Roblox-Rift-Scanner/main/Rift.lua'))()
]]

function hopToNextServer()
    local nextIndex = _G.RiftScanner.CurrentIndex + 1
    if nextIndex <= #jobIds then
        local nextJobId = jobIds[nextIndex]
        print("Hopping to server " .. nextIndex .. " with JobID: " .. nextJobId)
        _G.RiftScanner.CurrentIndex = nextIndex
        local scriptToQueue = string.format(CONTINUATION_SCRIPT, nextIndex)

        if getgenv().queue_on_teleport then
            getgenv().queue_on_teleport(scriptToQueue)
        elseif queue_on_teleport then
            queue_on_teleport(scriptToQueue)
        elseif syn and syn.queue_on_teleport then
            syn.queue_on_teleport(scriptToQueue)
        end

        wait(1)

        spawn(function()
            wait(15)
            if game.JobId == game.JobId then
                print("Teleport likely failed, retrying...")
                loadstring(game:HttpGet('https://raw.githubusercontent.com/SubbyDubby/Roblox-Rift-Scanner/main/Rift.lua'))()
            end
        end)

        pcall(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, nextJobId, LocalPlayer)
        end)

        wait(3)
        pcall(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, nextJobId)
        end)

        wait(3)
        if getgenv().teleport then
            pcall(function()
                getgenv().teleport(PLACE_ID, nextJobId)
            end)
        end
    else
        print("Finished scanning all servers. Restarting.")
        _G.RiftScanner.CurrentIndex = 0
        hopToNextServer()
    end
end

print("Rift Scanner started")
print("Current server index: " .. _G.RiftScanner.CurrentIndex)

if not game:IsLoaded() then
    print("Waiting for game to load...")
    game.Loaded:Wait()
end

if not LocalPlayer.Character then
    print("Waiting for character to load...")
    LocalPlayer.CharacterAdded:Wait()
end

print("Waiting 10 seconds before starting scan...")
wait(10)
scanRifts()
