local Remote = game.ReplicatedStorage:WaitForChild("SelectTeam")
local Teams = game:GetService("Teams")

Remote.OnServerEvent:Connect(function(Player, team)
	Player.Team = team
	if Player.Character then
		Player.Character.HumanoidRootPart.Position = game.Workspace.TeamSpawns:FindFirstChild(team.Name).Position + Vector3.new(0, 3, 0)
	end
end)