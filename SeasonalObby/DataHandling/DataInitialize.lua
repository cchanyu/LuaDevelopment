-- Set up table to return to any script that requires this module script
local PlayerStatManager = {}
 
local DataStoreService = game:GetService("DataStoreService")
local playerData = DataStoreService:GetDataStore("PlayerData")
 
-- Table to hold player information for the current session
local sessionData = {}
 
local AUTOSAVE_INTERVAL = 60