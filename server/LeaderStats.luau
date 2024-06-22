
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("DataPoints") 



game.Players.PlayerAdded:Connect(function(Player)
	local Leaderstats = Instance.new("Folder", Player)
	Leaderstats.Name = "leaderstats"
	local Currency = Instance.new("IntValue", Leaderstats)
	Currency.Name = "Exp"
	Currency.Value = 0

	local Data = DataStore:GetAsync(Player.UserId)
	if Data then
		Currency.Value = Data 
	end
end)




game.Players.PlayerRemoving:Connect(function(Player)
	DataStore:SetAsync(Player.UserId, Player.leaderstats.Exp.Value) 
end)

