-- Data Store Access
local DataStoreService = game:GetService("DataStoreService")
local experienceStore = DataStoreService:GetDataStore("PlayerExperience")
local nicknameStore = DataStoreService:GetDataStore("Nicknames")
local levelStore = DataStoreService:GetDataStore("PlayerLevel")

-- Data Store Events
local connection

local function onLevelUpdate(newLevel)
	if newLevel == 50 then
		print("Player has reached max level!")
		-- Disconnect connection when player reaches max level
		connection:Disconnect()
	end
end

connection = experienceStore:OnUpdate("Player_1234", onLevelUpdate)

-- Setting Data
local success, err = pcall(function()
	return experienceStore:SetAsync("Player_1234", 50)
end)

if success then 
	print("Success!")
end

-- Reading Data
local success2, currentExperience = pcall(function()
	return experienceStore:GetAsync("Player_1234")
end)

if success2 then 
	print("Current Experience:", currentExperience)
end

-- Incrementing Data
local success3, newExperience = pcall(function()
	return experienceStore:IncrementAsync("Player_1234", 1)
end)

if success3 then 
	print("New Experience:", newExperience)
end

-- Updating Data
local function makeNameUpper(currentName)
	local newName = string.upper(currentName)
	return newName
end

local success4, newName = pcall(function()
	return nicknameStore:UpdateAsync("Player_1234", makeNameUpper)
end)

if success4 then
	print("Uppercase Name:", newName)
end

-- Removing Data
local success5, nickname = pcall(function()
	return nicknameStore:RemoveAsync("Player_1234")
end)

if success then
	print("Removed Nickname:", nickname)
end

-- Ordered Data Stores
while true do
	-- Get the current (first) page
	local data = pages:GetCurrentPage()
	-- Iterate through all key-value pairs on page
	for _, entry in pairs(data) do
		print(entry.key .. ":" .. tostring(entry.value))
	end
	-- Check if last page has been reached
	if pages,IsFinished then
		break
	else
		print("---------------")
		-- Advance to Next Page
		pages:AdvanceToNextPageAsync()
	end
	
end




