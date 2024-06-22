-- This script creates the sounds for crouching and proning

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stance = ReplicatedStorage.GunSys.Evt.MedSys.Stance
local StanceRequest = Instance.new("RemoteEvent",ReplicatedStorage)
StanceRequest.Name = "StanceRequestEvent"
local SoundEvt = Instance.new("RemoteEvent",ReplicatedStorage)
SoundEvt.Name = "CrouchSoundEvent"

local ClientScript = script.CrouchSoundClient
Players.PlayerAdded:Connect(function(newPlayer)
	newPlayer.CharacterAppearanceLoaded:Connect(function(newChar)
		ClientScript:Clone().Parent = newChar
	end)
end)

Stance.OnServerEvent:Connect(function(player,newStance, Vir)
	StanceRequest:FireClient(player,newStance, Vir)
end)

StanceRequest.OnServerEvent:Connect(function(player,stance, Vir)
	for _, cPlayer in pairs(Players:GetPlayers()) do
		if cPlayer ~= player and cPlayer.Character then
			SoundEvt:FireClient(cPlayer,cPlayer.Character,stance)
		end
	end
end)